package com.emy.entity;
//utf-8


/**
 * 易买网-商品分类类
 * @author Kinlon
 * @version 1.0.0
 */
public class ProductCategory {
    //编号
    private int id;
    //名字
    private String name;
    //父分类
    private int parentId;
    //类型
    private int type;

    //构造方法
    public ProductCategory() {
    }

    public ProductCategory(int id, String name, int parentId, int type) {
        this.id = id;
        this.name = name;
        this.parentId = parentId;
        this.type = type;
    }

    //get set方法    S
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    //get set方法    E

}