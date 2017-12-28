package com.emy.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet类
 * 处理网页的操作请求
 * @author Kinlon
 * @version 1.0.0
 */
@WebServlet(urlPatterns = {"/url"}, name = "urlServlet") //Servlet3.0的配置
public class Servlet_url extends HttpServlet {
    /**
     * post方式发送的请求
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    /**
     * get方式发送的请求
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
