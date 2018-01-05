package com.emy.servlet;

import com.emy.service.Service;
import com.emy.service.impl.ServiceAddressImpl;
import com.emy.service.impl.ServiceNewsImpl;
import com.emy.service.impl.ServiceUserImpl;
import com.emy.util.Log;

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

    /**
     * 处理Servlet请求的总调度
     *
     * @param request
     * @param response
     */
    private void doServlet(HttpServletRequest request, HttpServletResponse response) {

        //使用Lambda表达式实现用户业务的函数接口
        Service<ServiceUserImpl> serviceUser = (obj) -> {
            switch (obj.getActive()) {
                case "isLogin"://登录检测，方法公开
                    break;
                case "regist":// 注册
                    obj.regist();
                    break;
                case "registCheckLoginName":// 账户存在检测
                    obj.registCheckLoginName();
                    break;
                case "login":// 登录
                    obj.login();
                    break;
                case "logout":// 登出
                    obj.logout();
                    break;
                case "setUser":// 修改用户信息
                    obj.setUser();
                    break;
                default:
                    // 参数方法不存在
                    Log.logToConsole("结果", obj.getActive() + "请求不存在");
                    obj.toInfoPage(obj.getActive() + "请求不存在");
                    break;
            }
        };

        //使用Lambda表达式实现收货地址业务的函数接口
        Service<ServiceAddressImpl> serviceAddress = (obj) -> {
            switch (obj.getActive()) {
                case "addAddress":// 添加收货地址
                    obj.addAddress();
                    break;
                case "setDefaultAddress":// 设置默认收货地址
                    obj.setDefaultAddress();
                    break;
                case "deleteAddress":// 删除收货地址
                    obj.deleteAddress();
                    break;
                case "getAddressById":// 通过id获取收货地址
                    obj.getAddressById();
                    break;
                case "setAddress":// 修改收货地址
                    obj.setAddress();
                    break;
                default:
                    // 参数方法不存在
                    Log.logToConsole("结果", obj.getActive() + "请求不存在");
                    obj.toInfoPage(obj.getActive() + "请求不存在");
                    break;
            }
        };

        //使用Lambda表达式实现资讯业务的函数接口
        Service<ServiceNewsImpl> serviceNews = (obj) -> {
            switch (obj.getActive()) {
                case "addNews":
                    obj.addNews();
                    break;
                default:
                    // 参数方法不存在
                    Log.logToConsole("结果", obj.getActive() + "请求不存在");
                    obj.toInfoPage(obj.getActive() + "请求不存在");
                    break;
            }
        };

        //1.获取请求的类型
        String obj = request.getParameter("obj");
        //2.判断请求存在
        if (obj == null) {
            toInfoPage(request, response, "obj参数缺少");
        } else {
            String act = request.getParameter("act");
            if (act == null) {
                toInfoPage(request, response, "act参数缺少");
            } else {
                //3.执行Lambda表达式
                switch (obj) {
                    case "user":
                        serviceUser.run(new ServiceUserImpl(act, request, response));
                        break;
                    case "address":
                        serviceAddress.run(new ServiceAddressImpl(act, request, response));
                        break;
                    case "news":
                        serviceNews.run(new ServiceNewsImpl(act, request, response));
                        break;
                    default:
                        try {
                            response.sendRedirect("/404.jsp");
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                        break;
                }
            }
        }
    }

    /**
     * 输出信息到页面显示
     *
     * @param request
     * @param response
     * @param msg      输出消息
     */
    public void toInfoPage(HttpServletRequest request, HttpServletResponse response,
                           String msg) {
        try {
            request.setAttribute("msg", msg);
            request.getRequestDispatcher("infoPage.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }
}
