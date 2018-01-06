<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.entity.UserAddress" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/4
  Time: 12:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--主页部分    开始-->
    <link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="image/x-icon"/>
    <meta charset="UTF-8">
    <meta name="Generator" content="WebStorm 2017.3.2">
    <meta name="Keywords" content="易买网,购物">
    <meta name="Description" content="易买网是一家购物网站，用户可以在线浏览商品，选购商品">
    <meta name="Author" content="Kinlon">
    <meta name="Version" content="1.0.0.1">
    <title>::易买网::修改收货地址</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css"/>
    <link rel="stylesheet" type="text/css" href="css/html.css"/>
    <link rel="stylesheet" type="text/css" href="css/rl.css">
    <!--JQuery-UI样式 -->
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.theme.css">
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/themes/sunny/theme.css">
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/themes/sunny/jquery-ui.css">
    <!--主页部分    结束-->
</head>
<%
    User user = (User) session.getAttribute("user");
    UserAddress userAddress;
    if (user != null) {
        UserDao userDao = new UserDaoImpl();
        User userD = userDao.getById(user.getId());
        if (userD != null && user.getPassword().equals(userD.getPassword())) {
            session.setAttribute("user", userD);
            userAddress = (UserAddress) request.getAttribute("getAddressById");
            if (userAddress == null) {
                userAddress = new UserAddress();
                request.setAttribute("msg", "参数不正确");
                request.getRequestDispatcher("user.jsp").forward(request, response);
            }
        } else {
            userAddress = new UserAddress();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    } else {
        userAddress = new UserAddress();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
<body>
<form action="<%=request.getContextPath()%>/url" method="post">
    <input type="hidden" name="obj" value="address">
    <input type="hidden" name="act" value="setAddress">
    <input type="hidden" name="addressId" value="<%=userAddress.getId()%>">
    <table class="rl_table" border="0" cellspacing="0" cellpadding="0">
        <thead>
        <!--页面跳转导航    S-->
        <tr height="35" valign="top">
            <td colspan="3">
                    <span><a href="<%=request.getContextPath()%>">【返回首页】</a>&nbsp;&nbsp;<a
                            href="<%=request.getContextPath()%>/user.jsp">【返回用户中心】</a></span>
            </td>
        </tr>
        <!--页面跳转导航    E-->
        </thead>
        <tbody>
        <!--标题    S-->
        <tr height="35" valign="top">
            <td colspan="2">
                <span class="rl_span_title">修改收货地址</span>
            </td>
        </tr>
        <!--标题    E-->
        <!--修改地址    开始-->
        <tr height="35">
            <td class="rl_td_spn">
                <span><span style="color: #f00;">*</span>&nbsp;收货地址：</span>
            </td>
            <td class="rl_td_inp">
                <span><input type="text" name="address" id="address" placeholder="最多20个字符" required
                             class="ui-autocomplete-input"
                             maxlength="20" value="<%=userAddress.getAddress()%>"/></span>
            </td>
        </tr>
        <tr height="35">
            <td class="rl_td_spn">
                <span>备注：</span>
            </td>
            <td class="rl_td_inp">
                <span><input type="text" name="remark" id="remark" placeholder="最多18个字符" maxlength="18"
                             class="ui-autocomplete-input"
                             value="<%=userAddress.getRemark()%>"/></span>
            </td>
        </tr>
        <tr height="60">
            <td colspan="2" class="rl_td_btn">
                <span><input class="rl_btn ui-button ui-corner-all ui-widget" type="submit" value="修改地址"></span>
            </td>
        </tr>
        <!--修改地址    结束-->
        </tbody>
    </table>
</form>
</body>
</html>
