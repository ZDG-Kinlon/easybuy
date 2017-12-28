package com.emy.entity;
//utf-8


/**
 * 易买网-用户类
 * @author Kinlon
 * @version 1.0.0
 */
public class User {
    //用户名
    private int id;
    //用户真实姓名
    private String userName;
    //用户登录用户名
    private String loginName;
    //密码
    private String password;
    //性别
    private int sex;
    //身份证号，可选
    private String identityCode;
    //电子邮箱，可选
    private String email;
    //手机，可选
    private String mobile;
    //用户类型
    private int type;

    public User() {
    }

    public User(int id, String userName, String loginName, String password, int sex, int type) {
        this.id = id;
        this.userName = userName;
        this.loginName = loginName;
        this.password = password;
        this.sex = sex;
        this.type = type;
    }

    //get set方法    S
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getIdentityCode() {
        return identityCode;
    }

    public void setIdentityCode(String identityCode) {
        this.identityCode = identityCode;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    //get set方法    E


}