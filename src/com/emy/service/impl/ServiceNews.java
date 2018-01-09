package com.emy.service.impl;

import com.emy.dao.news.NewsDao;
import com.emy.dao.news.impl.NewsDaoImpl;
import com.emy.entity.News;
import com.emy.util.Log;
import com.emy.util.MathUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 资讯业务的请求实现类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public class ServiceNews
        extends PublicService {
    private News news = new News();
    private NewsDao newsDao = new NewsDaoImpl();

    /**
     * 构造方法，不允许无参数
     */
    public ServiceNews(HttpServletRequest req, HttpServletResponse res) {
        super(req, res);
    }

    /**
     * 添加资讯
     */
    public void addNews() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "添加资讯");
                if (checkIsAdmin() == 0) {
                    //获取添加的资讯
                    this.news.setTitle(getStr("title"));
                    this.news.setContent(getStr("content"));
                    //非空检测
                    if (this.news.check()) {
                        //写入数据库
                        this.newsDao.add(this.news);
                        flushPage();
                    } else {
                        toPage("manager.jsp");
                    }
                } else {
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

    /**
     * 修改资讯信息
     */
    public void setNews() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "修改资讯");
                if (checkIsAdmin() == 0) {
                    int newsId = MathUtils.stringToInteger(getStr("newsId"));
                    if (newsId != 0) {
                        this.news.setId(newsId);
                        this.news.setTitle(getStr("title"));
                        this.news.setContent(getStr("content"));
                        if (this.news.check() && this.newsDao.set(this.news) == 1) {
                            toInfoPage("修改成功");
                        } else {
                            toInfoPage("参数异常");
                        }
                    } else {
                        toInfoPage("参数异常");
                    }
                } else {
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

    /**
     * 删除资讯
     */
    public void deleteNews() {
        switch (checkIsLogin()) {
            case 0:
                Log.logToConsole("请求", "删除资讯");
                if (checkIsAdmin() == 0) {
                    int newsId = MathUtils.stringToInteger(getStr("newsId"));
                    if (newsId != 0 && this.newsDao.del(newsId) == 1) {
                        toPage("manager.jsp");
                    } else {
                        toInfoPage("参数异常");
                    }
                } else {
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
