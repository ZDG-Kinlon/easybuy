<%@ page import="com.emy.service.Service" %>
<%@ page import="com.emy.service.impl.ServiceImpl" %>
<%@ page import="com.emy.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/2
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--主页部分    开始-->
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>
    <meta charset="UTF-8">
    <meta name="Generator" content="WebStorm 2017.3.2">
    <meta name="Keywords" content="易买网,购物">
    <meta name="Description" content="易买网是一家购物网站，用户可以在线浏览商品，选购商品">
    <meta name="Author" content="Kinlon">
    <meta name="Version" content="1.0.0.1">
    <title>::易买网::买东西就是这么容易</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css"/>
    <link rel="stylesheet" type="text/css" href="css/html.css"/>
</head>
<body>
<!--欢迎信息    开始-->
<div class="welcome">
    <%
    User user = (User) session.getAttribute("user");
    Service service = new ServiceImpl();
    if (user != null && service.checkUserPwd(user.getId(), user.getLoginName(), user.getPassword())) {
        //S    已登录
        %><!--已登录    开始-->
    <span class="wc_span">
            您好，欢迎<a href="#">【<%=user.getUserName()%>】</a>来到易买网！&nbsp;&nbsp;<a
            href="<%=request.getContextPath()%>/url?act=logout&sessionId=<%=session.getId()%>&loginName=<%=user.getLoginName()%>&password=<%=user.getPassword()%>">【退出】</a>
        </span>
    <!--已登录    结束--><%
        //E    已登录
    } else {
        //S    没有登录
        %><!--没有登录    开始-->
    <span class="wc_span">
            还没加入我们？<a href="regist.jsp">【注册】</a>&nbsp;&nbsp;已经有帐号？<a href="login.jsp">【登录】</a>
        </span>
    <!--没有登录    结束--><%
        //E    没有登录
    }
%></div>
<!--欢迎信息    结束-->


</body>
</html>
