package com.emy.servlet;

import com.emy.service.Service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet类
 * 处理网页的跳转请求
 *
 * @author Kinlon
 * @version 1.0.0
 */
@WebServlet(urlPatterns = {"/url"}, name = "urlServlet")
public class Servlet_url extends HttpServlet {
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    /**
     * post方式发送的请求
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        new Service().doServlet(request, response);
    }

    /**
     * get方式发送的请求
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        new Service().doServlet(request, response);
    }


}
