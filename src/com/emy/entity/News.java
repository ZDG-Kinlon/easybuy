package com.emy.entity;
//utf-8

import java.util.Date;

import com.emy.util.Log;

/**
 * 易买网-资讯类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class News {
    //编号
    private int id;
    //标题
    private String title;
    //内容
    private String content;
    //录入日期
    private Date creatTime;

    //构造方法
    public News() {
    }

    /**
     * 变量未赋值检测
     *
     * @return
     */
    public boolean check() {
        if (this.title == null) {
            return false;
        } else if (this.content ==null) {
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatTime() {
        return creatTime;
    }

    public void setCreatTime(Date creatTime) {
        this.creatTime = creatTime;
    }
    //get set方法    E
}
