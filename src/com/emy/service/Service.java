package com.emy.service;

/**
 * 负责调度url的Servlet的请求
 *
 * @author Kinlon
 * @version 1.0.0
 * @param <T> 请求的实现类
 */
@FunctionalInterface
public interface Service<T> {
    /**
     * 执行Servlet请求
     */
    public void run(T obj);
}
