package com.emy.entity;
//utf-8

import java.util.Date;

/**
 * 易买网-用户地址类
 * @author Kinlon
 * @version 1.0.0
 */
public class UserAddress {
    //主键
    private int id;
    //地址
    private String address;
    //创建时间
    private Date createTime;
    //用户主键
    private int userID;
    //默认地址
    private int isDefault;
    //备注，可选
    private String remark;

    public UserAddress() {
    }

    public UserAddress(int id, String address, Date createTime, int userID, int isDefault) {
        this.id = id;
        this.address = address;
        this.createTime = createTime;
        this.userID = userID;
        this.isDefault = isDefault;
    }
    //get set方法    S

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(int isDefault) {
        this.isDefault = isDefault;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    //get set方法    E

}
