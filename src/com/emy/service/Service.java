package com.emy.service;

import com.emy.service.impl.ServiceAddressImpl;
import com.emy.service.impl.ServiceNewsImpl;
import com.emy.service.impl.ServiceUserImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.function.BiConsumer;
import java.util.function.Consumer;

public class Service {
    /**
     * 处理Servlet请求的总调度
     *
     * @param request
     * @param response
     */
    public void doServlet(HttpServletRequest request, HttpServletResponse response) {
        //1.获取请求的类型
        String obj = request.getParameter("obj");
        String act = request.getParameter("act");
        //2.判断请求存在
        if (obj != null && act != null) {
            //3.业务请求的调度
            switch (obj) {
                case "user":
                    //使用Lambda表达式实现分发用户业务的函数式接口
                    BiConsumer<ServiceUser, String> serviceUser = (_obj, _act) -> {
                        Consumer<ServiceUser> lambda;
                        switch (_act) {
                            case "regist":// 注册
                                lambda = ServiceUser::regist;
                                break;
                            case "registCheckLoginName":// 账户存在检测
                                lambda = ServiceUser::registCheckLoginName;
                                break;
                            case "login":// 登录
                                lambda = ServiceUser::login;
                                break;
                            case "logout":// 登出
                                lambda = ServiceUser::logout;
                                break;
                            case "setUser":// 修改用户信息
                                lambda = ServiceUser::setUser;
                                break;
                            default:
                                return;
                        }
                        lambda.accept(_obj);
                    };
                    serviceUser.accept(new ServiceUserImpl(request, response), act);
                    break;
                case "address":
                    //使用Lambda表达式实现分发收货地址业务的函数接口
                    BiConsumer<ServiceAddress, String> serviceAddress = (_obj, _act) -> {
                        Consumer<ServiceAddress> lambda;
                        switch (_act) {
                            case "addAddress":// 添加收货地址
                                lambda = ServiceAddress::addAddress;
                                break;
                            case "setDefaultAddress":// 设置默认收货地址
                                lambda = ServiceAddress::setDefaultAddress;
                                break;
                            case "deleteAddress":// 删除收货地址
                                lambda = ServiceAddress::deleteAddress;
                                break;
                            case "setAddress":// 修改收货地址
                                lambda = ServiceAddress::setAddress;
                                break;
                            default:
                                return;
                        }
                        lambda.accept(_obj);
                    };
                    serviceAddress.accept(new ServiceAddressImpl(request, response), act);
                    break;
                case "news":
                    //使用Lambda表达式实现分发资讯业务的函数接口
                    BiConsumer<ServiceNews, String> serviceNews = (_obj, _act) -> {
                        Consumer<ServiceNews> lambda;
                        switch (_act) {
                            case "addNews": //添加资讯
                                lambda = ServiceNews::addNews;
                                break;
                            case "setNews":
                                lambda = ServiceNews::setNews;
                                break;
                            case "deleteNews":
                                lambda = ServiceNews::deleteNews;
                                break;
                            default:
                                return;
                        }
                        lambda.accept(_obj);
                    };
                    serviceNews.accept(new ServiceNewsImpl(request, response), act);
                    break;
                default:
            }
        }
    }
}
