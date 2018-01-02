package com.emy.service;

/**
 * Service业务入口类，负责调度Servlet的请求
 *
 * @author Kinlon
 * @version 1.0.0
 */
@FunctionalInterface
public interface Method_url {
    /**
     * 执行Servlet请求
     * 不存在的请求抛出异常
     */
    public void run() throws Exception;
}
