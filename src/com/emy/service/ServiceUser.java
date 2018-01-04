package com.emy.service;

/**
 * 用户业务的请求接口类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public interface ServiceUser {
    /**
     * 修改用户信息
     */
    public void setUser();

    /**
     * 帐号登出
     */
    public void logout();

    /**
     * 帐号登陆
     */
    public void login();

    /**
     * 注册帐号
     */
    public void regist();

    /**
     * 注册_帐号可用性检测
     */
    public void registCheckLoginName();

}
