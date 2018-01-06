package com.emy.service.impl;

import com.emy.service.ServiceUser;
import com.emy.util.Log;
import com.emy.entity.User;
import com.emy.util.MathUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * 用户业务的请求实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class ServiceUserImpl
        extends PublicService
        implements ServiceUser {

    /**
     * 构造方法，不允许无参数
     *
     */
    public ServiceUserImpl(HttpServletRequest req, HttpServletResponse res) {
        super(req, res);
    }

    /**
     * 修改用户信息
     */
    @Override
    public void setUser() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "用户信息修改");
                String value;
                //修改密码
                value = getStr("passwordNew");
                if (value != null && !value.equals("")) this.user.setPassword(value);
                //修改姓名
                value = getStr("userName");
                if (value != null && !value.equals("")) this.user.setUserName(value);
                //修改性别
                this.user.setSex(MathUtils.stringToInteger(getStr("sex")));
                //修改身份证
                value = getStr("identityCode");
                if (value != null) this.user.setIdentityCode(value);
                //修改邮箱
                value = getStr("email");
                if (value != null) this.user.setEmail(value);
                //修改手机号
                value = getStr("mobile");
                if (value != null) this.user.setMobile(value);
                //修改用户类型
                this.user.setType(MathUtils.stringToInteger(getStr("type")));
                //写入数据库
                if (this.user.check()&&this.userDao.set(this.user) == 1) {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", this.user);
                    toInfoPage(this.user.getLoginName() + "用户信息修改，成功");
                } else {
                    toInfoPage(this.user.getLoginName() + "用户信息修改，失败");
                }
                break;
            case 1:
                toInfoPage("退出失败，参数异常");
                break;
            case 2:
                toInfoPage("退出失败，请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 帐号登出
     */
    @Override
    public void logout() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "退出");
                HttpSession session = req.getSession();
                session.invalidate();
                Log.logToConsole("结果", this.user.getLoginName() + "已退出");
                flushPage();
                break;
            case 1:
                toInfoPage("退出失败，参数异常");
                break;
            case 2:
                toInfoPage("退出失败，请先登录");
                break;
            default:
                break;
        }
    }

    /**
     * 帐号登陆
     */
    @Override
    public void login() {
        //1.获取登录信息
        Log.logToConsole("请求", "登录");
        String loginName = getStr("loginName");
        String password = getStr("password");
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
                toInfoPage(loginName + " 密码错误");
                break;
            case 2:
                Log.logToConsole("结果", loginName + " 不存在");
                toInfoPage(loginName + " 帐号不存在");
                break;
            default:
                break;
        }
    }

    /**
     * 注册帐号
     */
    @Override
    public void regist() {
        //1.获取注册信息
        Log.logToConsole("请求", "注册");
        User user = new User();
        user.setLoginName(getStr("loginName"));
        user.setPassword(getStr("password"));
        user.setUserName(getStr("userName"));
        user.setSex(MathUtils.stringToInteger(getStr("sex")));
        user.setIdentityCode(getStr("identityCode"));
        user.setEmail(getStr("email"));
        user.setMobile(getStr("mobile"));
        user.setType(MathUtils.stringToInteger(getStr("type")));
        if (user.check()&&this.userDao.add(user)==1) {
            //全部参数获取到值
            Log.logToConsole("结果", user.getLoginName() + " 注册成功");
            toInfoPage("注册成功");
        } else {
            //存在未赋值的参数
            Log.logToConsole("结果", user.getLoginName() + " 注册失败");
            toInfoPage("参数不完整");
        }
    }

    /**
     * 注册_帐号可用性检测
     */
    @Override
    public void registCheckLoginName() {
        //1.获取待检测的帐号
        String loginName = getStr("loginName");
        //2.检查帐号的存在性
        int i = this.userDao.getByField("loginName", loginName).size();
        Log.logToConsole("结果", loginName + " " + i);
        //3.回传结果
        PrintWriter out;
        try {
            out = this.res.getWriter();
            out.write(String.valueOf(i));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}