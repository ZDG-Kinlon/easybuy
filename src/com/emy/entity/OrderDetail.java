package com.emy.entity;
//utf-8


/**
 * 易买网-订单详情类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class OrderDetail {
    //编号
    private int id;
    //订单ID
    private int orderId;
    //商品ID
    private int productId;
    //数量
    private int quantity;
    //金额
    private double cost;

    //构造方法
    public OrderDetail() {
    }

    /**
     * 变量未赋值检测
     *
     * @return
     */
    public boolean check() {
        if (this.orderId == 0) {
            return false;
        } else if (this.productId == 0) {
            return false;
        } else if (this.quantity == 0) {
            return false;
        } else if (this.cost == 0.0) {
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

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }
    //get set方法    E
}
