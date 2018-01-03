package com.emy.service.impl;

import com.emy.dao.user.UserAddressDao;
import com.emy.dao.user.UserDao;
import com.emy.dao.user.impl.UserAddressDaoImpl;
import com.emy.dao.user.impl.UserDaoImpl;
import com.emy.entity.UserAddress;
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

    private void setVal(String key, Object val) {
        req.setAttribute(key, val);
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

    /**
     * 刷新递交请求前的页面
     */
    private void flushPage() {
        toPage(res, req.getHeader("Referer"));
    }

    /**
     * 帐号的密码正确性检测
     *
     * @param loginName 帐号
     * @param password  密码
     * @return 0正常
     */
    private int checkPassword(String loginName, String password) {
        Log.logToConsole("执行", loginName + " 帐号检测");
        UserDao userDao = new UserDaoImpl();
        List<User> list = userDao.getByField("loginName", loginName);
        if (list.size() == 1) {
            //帐号存在
            this.user = list.get(0);
            if (this.user.getPassword().equals(password)) {
                Log.logToConsole("结果", "帐号密码正确");
                return 0;//密码正确
            } else {
                Log.logToConsole("结果", "密码错误");
                return 1;//密码错误
            }
        } else {
            Log.logToConsole("结果", "帐号数量异常");
            return 2;//帐号不存在
            //帐号不存在
        }
    }

    /**
     * 判断用户已经登录且登录信息正确
     *
     * @return 0正常
     */
    private int checkIsLogin() {
        Log.logToConsole("执行", "登录检测");
        //1.获取数据
        HttpSession session = req.getSession();
        User sUser = (User) session.getAttribute("user");
        String sLoginName = sUser.getLoginName();
        String sPassword = sUser.getPassword();
        //2.数据比对
        if (sLoginName != null && sPassword != null && checkPassword(sLoginName, sPassword) == 0) {
            if (req.getHeader("Referer") != null) {
                Log.logToConsole("结果", "成功");
                return 0;//正常
            } else {
                Log.logToConsole("结果", "直链接");
                return 1;//错误
            }
        } else {
            Log.logToConsole("结果", "未登录");
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
        Log.logToConsole("请求", this.functions);
        switch (this.functions) {
            // 用户表功能 开始
            case "regist":// 注册
                regist();
                break;
            case "registCheckLoginName":// 账户存在检测
                registCheckLoginName();
                break;
            case "login":// 登录
                login();
                break;
            case "logout":// 登出
                logout();
                break;
            case "setUser":// 修改用户信息
                setUser();
                break;
            // 用户表功能 结束
            // 收货地址表功能 开始
            case "addAddress":// 添加收货地址
                addAddress();
                break;
            case "setDefaultAddress":// 设置默认收货地址
                setDefaultAddress();
                break;
            // 收货地址表功能 结束
            default:
                // 参数方法不存在
                Log.logToConsole("结果", this.functions + "请求不存在");
                toInfoPage(req, res, this.functions + "请求不存在");
        }
    }

    /**
     * 设置默认收货地址
     */
    private void setDefaultAddress() {    	
        switch (checkIsLogin()) {
            case 0:
                //参数传入
                int userId = this.user.getId();
                int addressId = MathUtils.stringToInteger(getVal("addressId"));
                Log.logToConsole("请求", addressId + " 设置为默认地址");
                //检测id
                UserAddressDao userAddressDao = new UserAddressDaoImpl();
                UserAddress userAddress = userAddressDao.getById(addressId);
                if (userId == userAddress.getUserId()) {
                    userAddressDao.setDefaultAddress(userId, addressId);
                    flushPage();
                    Log.logToConsole("结果", addressId + " 设置成功");
                } else {
                    //不是当前用户的地址
                    toInfoPage(req, res, "修改的地址不属于当前用户");
                    Log.logToConsole("结果", addressId + " 设置失败");
                }
                break;
            case 1:
                toInfoPage(req, res, "参数异常");
                break;
            case 2:
                toInfoPage(req, res, "请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 添加收货地址
     */
    private void addAddress() {
        switch (checkIsLogin()) {
            case 0:
                //参数传入
                Log.logToConsole("请求", "添加收货地址");
                UserAddress userAddress = new UserAddress();                
                userAddress.setAddress(getVal("address"));
                userAddress.setCreateTime(Log.getTimeByFormat("yyyy-MM-dd HH:mm:ss"));
                userAddress.setUserId(this.user.getId());
                userAddress.setIsDefault(1);
                userAddress.setRemark(getVal("remark"));
                if (userAddress.check()) {
                    UserAddressDao userAddressDao = new UserAddressDaoImpl();
                    userAddressDao.add(userAddress);
                    flushPage();
                } else {
                    //存在未赋值的参数
                    Log.logToConsole("结果", getVal("address") + " 添加失败");
                    toInfoPage(req, res, "参数不完整");
                }
                break;
            case 1:
                toInfoPage(req, res, "参数异常");
                break;
            case 2:
                toInfoPage(req, res, "请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 修改用户信息
     */
    private void setUser() {        
        switch (checkIsLogin()) {
            case 0:
            	Log.logToConsole("请求", "用户信息修改");
                String value;
                //修改密码
                value = getVal("passwordNew");
                if (value != null) this.user.setPassword(value);
                //修改姓名
                value = getVal("userName");
                if (value != null) this.user.setUserName(value);
                //修改性别
                this.user.setSex(MathUtils.stringToInteger(getVal("sex")));
                //修改身份证
                value = getVal("identityCode");
                if (value != null) this.user.setIdentityCode(value);
                //修改邮箱
                value = getVal("email");
                if (value != null) this.user.setEmail(value);
                //修改手机号
                value = getVal("mobile");
                if (value != null) this.user.setMobile(value);
                //修改用户类型
                this.user.setType(MathUtils.stringToInteger(getVal("type")));
                //写入数据库
                UserDao userDao = new UserDaoImpl();
                if (userDao.set(this.user) == 1) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", this.user);
                    toInfoPage(req, res, this.user.getLoginName() + "用户信息修改，成功");
                } else {
                    toInfoPage(req, res, this.user.getLoginName() + "用户信息修改，失败");
                }
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
        switch (checkIsLogin()) {
            case 0:
            	Log.logToConsole("请求", "退出");
                HttpSession session = req.getSession();
                session.invalidate();
                Log.logToConsole("结果", this.user.getLoginName() + "已退出");
                flushPage();
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
    	Log.logToConsole("请求", "登录");
        String loginName = getVal("loginName");
        String password = getVal("password");
        switch (checkPassword(loginName, password)) {
            case 0:
                HttpSession session = req.getSession();
                session.setAttribute("user", this.user);
                session.setMaxInactiveInterval(1800);//30分钟后失效
                Log.logToConsole("结果", loginName + " 登录成功");
                flushPage();
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
    	Log.logToConsole("请求", "注册");
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
            Log.logToConsole("结果", user.getLoginName() + " 注册成功");
            toInfoPage(req, res, "注册成功");
        } else {
            //存在未赋值的参数
            Log.logToConsole("结果", user.getLoginName() + " 注册失败");
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

}