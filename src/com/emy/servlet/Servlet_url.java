package com.emy.servlet;

import com.emy.service.impl.MethodImpl_url;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doServlet(request, response);
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
        doServlet(request, response);
    }

    private void doServlet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取请求的目标方法
        String method = request.getParameter("act");
        if (method == null) {
            //空请求返回参数无效页面
            response.sendRedirect("/404.jsp");
        } else {
            //创建Service对象，处理操作
            MethodImpl_url act = new MethodImpl_url(method, request, response);
            try {
                //执行请求
                act.run();
            } catch (Exception e) {
                //请求的方法不存在
                e.printStackTrace();
                toInfoPage(request, response, "参数act的值不存在");
            }
        }
    }

    public void toInfoPage(HttpServletRequest request, HttpServletResponse response, String msg) {
        try {
            request.setAttribute("msg", msg);
            request.getRequestDispatcher("infoPage.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

}
