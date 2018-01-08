package com.emy.entity;
//utf-8


/**
 * 易买网-商品分类类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class ProductCategory {
    //编号
    private int id;
    //名字
    private String name;
    //分类编号
    private int id1;
    private int id2;
    private int id3;
    //构造方法
    public ProductCategory() {
    }

    /**
     * 变量未赋值检测
     *
     * @return
     */
    public boolean check() {
        if (this.name == null) {
            return false;
        } else if (this.id1 == 0) {
            return false;
        } else if (this.id2 == 0) {
            return false;
        } else if (this.id3 == 0) {
            return false;
        }else {
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId1() {
        return id1;
    }

    public void setId1(int id1) {
        this.id1 = id1;
    }

    public int getId2() {
        return id2;
    }

    public void setId2(int id2) {
        this.id2 = id2;
    }

    public int getId3() {
        return id3;
    }

    public void setId3(int id3) {
        this.id3 = id3;
    }

    //get set方法    E

}
