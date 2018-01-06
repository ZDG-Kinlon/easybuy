package com.emy.service;

/**
 * 资讯业务的请求接口类
 *
 * @author Kinlon
 * @version 1.0.0
 */
public interface ServiceNews {
    /**
     * 添加资讯
     */
    public void addNews();

    /**
     * 根据资讯id获取资讯
     */
    public void getNewsById();

    /**
     * 修改资讯信息
     */
    public void setNews();
    
    /**
     * 删除资讯
     */
    public void deleteNews();

}
