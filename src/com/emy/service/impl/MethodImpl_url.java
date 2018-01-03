package com.emy.service.impl;

import com.emy.dao.user.UserDao;
import com.emy.dao.user.impl.UserDaoImpl;
import com.emy.util.Log;
import com.emy.entity.User;
import com.emy.service.Method_url;
import com.emy.servlet.Servlet_url;
import com.emy.util.MathUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * 页面act指向的操作请求实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class MethodImpl_url
        extends Servlet_url
        implements Method_url {
    private String functions;
    private HttpServletRequest req;
    private HttpServletResponse res;
    private User user;

    /**
     * 构造方法
     *
     * @param functions
     */
    public MethodImpl_url(String functions, HttpServletRequest req, HttpServletResponse res) {
        this.functions = functions;
        this.req = req;
        this.res = res;
    }


    private String getVal(String key) {
        return req.getParameter(key);
    }

    private void setVal(String key,Object val){
        req.setAttribute(key,val);
    }

    /**
     * 帐号的密码正确性检测
     *
     * @param loginName 帐号
     * @param password 密码
     * @return 0正常
     */
    private int checkPassword(String loginName, String password) {
        UserDao userDao = new UserDaoImpl();
        List<User> list = userDao.getByField("loginName", loginName);
        if (list.size() == 1) {
            //帐号存在
            this.user = list.get(0);
            if (this.user.getPassword().equals(password)) {
                return 0;//密码正确
            } else {
                return 1;//密码错误
            }
        } else {
            return 2;//帐号不存在
            //帐号不存在
        }
    }

    /**
     * 判断用户已经登录
     *
     * @return 0正常
     */
    private int checkIsLogin() {
        //1.获取数据
        HttpSession session = req.getSession();
        String sId = session.getId();
        User sUser = (User) session.getAttribute("user");
        String sLoginName = sUser.getLoginName();
        String sPassword = sUser.getPassword();
        String id = getVal("sessionId");
        String loginName = getVal("loginName");
        String password = getVal("password");
        //2.数据比对
        if (sId != null && id != null && sId.equals(id) &&
                sLoginName != null && loginName != null && sLoginName.equals(loginName) &&
                sPassword != null && password != null && sPassword.equals(password) &&
                checkPassword(loginName, password)==0) {
            if (req.getHeader("Referer") != null) {
                return 0;//正常
            } else {
                return 1;//异常
            }
        } else {
            return 2;//没有登录
        }
    }

    /**
     * 处理Servlet请求的总调度
     *
     * @throws Exception
     */
    @Override
    public void run() {
        switch (this.functions) {
            case "regist"://注册
                regist();
                break;
            case "registCheckLoginName"://账户存在检测
                registCheckLoginName();
                break;
            case "login"://登录
                login();
                break;
            case "logout"://登出
                logout();
                break;
            case "setUser"://修改用户信息
                setUser();
                break;
            default:
                //参数方法不存在
                toInfoPage(req, res, this.functions + "请求不存在");
        }
    }

    /**
     * 修改用户信息
     */
    private void setUser() {
        Log.logToConsole("请求", "用户信息修改");
        switch (checkIsLogin()) {
            case 0:
                /*
                HttpSession session = req.getSession();
                Log.logToConsole("结果", loginName + "已修改");
                */
                break;
            case 1:
                toInfoPage(req, res, "退出失败，参数异常");
                break;
            case 2:
                toInfoPage(req, res, "退出失败，请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 帐号登出
     */
    private void logout() {
        Log.logToConsole("请求", "退出");
        switch (checkIsLogin()) {
            case 0:
                HttpSession session = req.getSession();
                session.invalidate();
                Log.logToConsole("结果", getVal("loginName") + "已退出");
                toPage(res, req.getHeader("Referer"));
                break;
            case 1:
                toInfoPage(req, res, "退出失败，参数异常");
                break;
            case 2:
                toInfoPage(req, res, "退出失败，请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 帐号登陆
     */
    private void login() {
        //1.获取登录信息
        String loginName = getVal("loginName");
        String password = getVal("password");
        switch (checkPassword(loginName, password)) {
            case 0:
                HttpSession session = req.getSession();
                session.setAttribute("user", this.user);
                session.setMaxInactiveInterval(1800);//30分钟后失效
                Log.logToConsole("结果", loginName + " 登录成功");
                toInfoPage(req, res, loginName + " 登录成功");
                break;
            case 1:
                Log.logToConsole("结果", loginName + " 密码错误");
                toInfoPage(req, res, loginName + " 密码错误");
                break;
            case 2:
                Log.logToConsole("结果", loginName + " 不存在");
                toInfoPage(req, res, loginName + " 帐号不存在");
                break;
            default:
                break;
        }
    }

    /**
     * 注册帐号
     */
    private void regist() {
        //1.获取注册信息
        User user = new User();
        user.setLoginName(getVal("loginName"));
        user.setPassword(getVal("password"));
        user.setUserName(getVal("userName"));
        user.setSex(MathUtils.stringToInteger(getVal("sex")));
        user.setIdentityCode(getVal("identityCode"));
        user.setEmail(getVal("email"));
        user.setMobile(getVal("mobile"));
        user.setType(MathUtils.stringToInteger(getVal("type")));
        if (user.check()) {
            //全部参数获取到值
            UserDao userDao = new UserDaoImpl();
            userDao.add(user);
            Log.logToConsole("结果", user.getLoginName() + " 添加成功");
            toInfoPage(req, res, "注册成功");
        } else {
            //存在未赋值的参数
            Log.logToConsole("结果", user.getLoginName() + " 添加失败");
            toInfoPage(req, res, "参数不完整");
        }
    }

    /**
     * 注册_帐号可用性检测
     */
    private void registCheckLoginName() {
        //1.获取待检测的帐号
        String loginName = getVal("loginName");
        //2.检查帐号的存在性
        UserDao userDao = new UserDaoImpl();
        int i = userDao.getByField("loginName", loginName).size();
        Log.logToConsole("结果", loginName + " " + i);
        //3.回传结果
        PrintWriter out;
        try {
            out = res.getWriter();
            out.write(String.valueOf(i));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    /**
     * 转发至页面
     *
     * @param request  请求
     * @param response 响应
     * @param tag      消息键
     * @param msg      消息值
     */
    private void rePage(HttpServletRequest request, HttpServletResponse response,
                        String tag, String msg) {
        try {
            request.setAttribute(tag, msg);
            request.getRequestDispatcher(tag).forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    /**
     * 页面跳转
     *
     * @param response 响应
     * @param url      页面地址
     */
    private void toPage(HttpServletResponse response, String url) {
        try {
            response.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}