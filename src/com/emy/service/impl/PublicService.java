package com.emy.service.impl;

import com.emy.dao.user.UserDao;
import com.emy.dao.user.impl.UserDaoImpl;
import com.emy.entity.User;
import com.emy.util.Log;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 业务请求的公共方法类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class PublicService {
    public HttpServletRequest req;
    public HttpServletResponse res;
    public User user;
    public UserDao userDao = new UserDaoImpl();

    public PublicService(HttpServletRequest req, HttpServletResponse res) {
        this.req = req;
        this.res = res;
    }

    //=========================================
    //页面参数传递    开始
    //=========================================
    public String getStr(String key) {
        return req.getParameter(key);
    }

    public void setStr(String key, String val) {
        req.setAttribute(key, val);
    }

    public Object getObj(String key) {
        return req.getAttribute(key);
    }

    public void setObj(String key, Object obj) {
        req.setAttribute(key, obj);
    }
    //=========================================
    //页面参数传递    结束
    //=========================================

    //=========================================
    //页面动作    开始
    //=========================================

    /**
     * 转发至页面
     *
     * @param tag 消息键
     * @param msg 消息值
     */
    public void rePage(String tag, String msg) {
        try {
            this.req.setAttribute(tag, msg);
            this.req.getRequestDispatcher(this.req.getHeader("Referer")).forward(this.req, this.res);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    /**
     * 页面跳转
     *
     * @param url      页面地址
     */
    public void toPage(String url) {
        try {
            this.res.sendRedirect(url);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 页面跳转，附带对象
     * @param url    页面地址
     * @param key    键
     * @param obj    对象
     */
    public void rePageObj(String url, String key, Object obj) {
        try {
            this.req.setAttribute(key, obj);
            this.req.getRequestDispatcher(url).forward(this.req, this.res);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    /**
     * 刷新递交请求前的页面
     */
    public void flushPage() {
        toPage(this.req.getHeader("Referer"));
    }

    /**
     * 输出信息到页面显示
     *
     * @param msg      输出消息
     */
    public void toInfoPage(String msg) {
        rePageObj("infoPage.jsp", "msg", msg);
    }
    //=========================================
    //页面动作    结束
    //=========================================

    //=========================================
    //账户有效性检测    开始
    //=========================================
    /**
     * 判断用户已经登录且登录信息正确
     *
     * @return 0正常
     */
    public int checkIsLogin() {
        Log.logToConsole("执行", "登录检测");
        //1.获取数据
        HttpSession session = req.getSession();
        User sUser = (User) session.getAttribute("user");
        if (sUser == null) {
            Log.logToConsole("结果", "未登录");
            return 2;//没有登录
        } else {
            //2.数据比对
            String sLoginName = sUser.getLoginName();
            String sPassword = sUser.getPassword();
            if (checkPassword(sLoginName, sPassword) == 0) {
                if (req.getHeader("Referer") != null) {
                    Log.logToConsole("结果", "成功");
                    return 0;//正常
                } else {
                    Log.logToConsole("结果", "直链接");
                    return 1;//错误
                }
            } else {
                Log.logToConsole("结果", "帐号或密码错误");
                return 1;//错误
            }
        }
    }

    /**
     * 帐号的密码正确性检测
     *
     * @param loginName 帐号
     * @param password  密码
     * @return 0正常
     */
    public int checkPassword(String loginName, String password) {
        Log.logToConsole("执行", loginName + " 帐号检测");
        List<User> list = this.userDao.getByField("loginName", loginName);
        if (list.size() == 1) {
            //帐号存在
            this.user = list.get(0);
            if (this.user.getPassword().equals(password)) {
                Log.logToConsole("结果", "帐号密码正确");
                return 0;//密码正确
            } else {
                this.user = null;
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
     * 判断用户是否为管理员，必须前置至判断登录或密码检测
     *
     * @return 0是，1不是，2缺前置执行任务
     */
    public int checkIsAdmin() {
        Log.logToConsole("执行", "管理员检测");
        if (this.user != null) {
            if (this.user.getType() == 2) {
                //管理员
                Log.logToConsole("结果", this.user.getLoginName() + "是管理员");
                return 0;
            } else {
                Log.logToConsole("结果", this.user.getLoginName() + "是买家");
                return 1;
            }
        }else{
            return 2;
        }
    }
    //=========================================
    //账户有效性检测    结束
    //=========================================
}
