package com.emy.service.impl;

import com.emy.dao.news.NewsDao;
import com.emy.dao.news.impl.NewsDaoImpl;
import com.emy.entity.News;
import com.emy.service.ServiceNews;
import com.emy.util.Log;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * 资讯业务的请求实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class ServiceNewsImpl
        extends PublicService
        implements ServiceNews {
    private String active;
    private News news=new News();
    private NewsDao newsDao=new NewsDaoImpl();


    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public ServiceNewsImpl(String active,HttpServletRequest req, HttpServletResponse res) {
        super(req, res);
        this.active=active;
    }

    /**
     * 添加资讯
     */
    @Override
    public void addNews() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "添加资讯");
                if(checkIsAdmin()==0){
                    //获取添加的资讯
                    this.news.setTitle(getStr("titile"));
                    this.news.setContent(getStr("content"));
                    //非空检测
                    if(this.news.check()){
                        //写入数据库
                        this.newsDao.add(this.news);
                        flushPage();
                    }else{
                        toPage("manager.jsp");
                    }
                }else{
                    toPage("user.jsp");
                }
                break;
            case 1:
                toInfoPage("参数异常");
                break;
            case 2:
                toInfoPage("请先登录");
                break;
            default:
                break;
        }
    }
}
