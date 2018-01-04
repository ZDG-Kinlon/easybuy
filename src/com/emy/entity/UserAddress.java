package com.emy.entity;
//utf-8

import java.util.Date;

/**
 * 易买网-用户地址类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class UserAddress {
    //主键
    private int id;
    //地址
    private String address;
    //创建时间
    private String createTime;
    //用户主键
    private int userId;
    //默认地址
    private int isDefault;
    //备注，可选
    private String remark;

    public UserAddress() {
    }

    /**
     * 变量未赋值检测
     *
     * @return
     */
    public boolean check() {
        if (this.address == null) {
            return false;
        } else if (this.createTime == null) {
            return false;
        } else if (this.userId == 0) {
            return false;
        } else if (this.isDefault == 0) {
            return false;
        } else {
            return true;
        }
    }

    //get set方法    S

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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
