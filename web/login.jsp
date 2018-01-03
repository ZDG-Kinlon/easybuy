<%@ page import="com.emy.service.Service" %>
<%@ page import="com.emy.service.impl.ServiceImpl" %>
<%@ page import="com.emy.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2017/12/29
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--主页部分    开始-->
    <link rel="icon" href="images/logo_ico.png" type="image/x-icon"/>
    <meta charset="UTF-8">
    <meta name="Generator" content="WebStorm 2017.3.2">
    <meta name="Keywords" content="易买网,购物">
    <meta name="Description" content="易买网是一家购物网站，用户可以在线浏览商品，选购商品">
    <meta name="Author" content="Kinlon">
    <meta name="Version" content="1.0.0.1">
    <title>::易买网::用户登录</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css"/>
    <link rel="stylesheet" type="text/css" href="css/html.css"/>
    <!--主页部分    结束-->
    <link rel="stylesheet" type="text/css" href="css/rl.css"/>
</head>
<body>
    <%
    User user = (User) session.getAttribute("user");
    Service service = new ServiceImpl();
    if (user != null && service.checkUserPwd(user.getId(), user.getLoginName(), user.getPassword())) {
    //已经登录，直接跳转到主页
        response.sendRedirect(request.getContextPath()+"/index.jsp");
    }
	%>
<div class="login_div">
    <form class="rl_form" action="<%=request.getContextPath()%>/url"
          method="post">
        <!--页面功能标记    S-->
        <input type="hidden" name="act" value="login"/>
        <!--页面功能标记    S-->
        <table class="rl_table" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <!--页面跳转导航    S-->
            <tr height="35" valign="top">
                <td colspan="3"><span><a
                        href="<%=request.getContextPath()%>">【返回首页】</a>&nbsp;&nbsp;<a
                        href="<%=request.getContextPath()%>/regist.jsp">【帐号注册】</a></span></td>
            </tr>
            <!--页面跳转导航    E-->
            <!--标题    S-->
            <tr height="35" valign="top">
                <td colspan="3"><span class="rl_span_title">登录</span></td>
            </tr>
            <!--标题    E-->
            <!--用户名    S-->
            <tr height="35">
                <td class="rl_td_spn"><span style="color: #f00; ">*</span>&nbsp;用户名</td>
                <td class="rl_td_inp"><input class="rl_input" type="text"
                                             name="loginName" maxlength="20" placeholder="最多20个字符" value=""
                                             required></td>
                <td class="rl_td_err"><span id="loginName_msg"></span></td>
            </tr>
            <!--用户名    E-->
            <!--密码    S-->
            <tr height="35">
                <td class="rl_td_spn"><span color="#f00">*</span>&nbsp;密码</td>
                <td class="rl_td_inp"><input class="rl_input" type="password"
                                             id="password" value="" required><input type="hidden"
                                                                                    name="password" id="passwordHide"
                                                                                    value=""></td>
                <td class="rl_td_err"><span id="password_msg"></span></td>
            </tr>
            <!--密码    E-->
            <!--递交按钮    S-->
            <tr height="60">
                <td class="rl_td_btn" colspan="2"><input class="rl_btn"
                                                         id="reg_btn" type="submit" value="登录"></td>
                <td></td>
            </tr>
            <!--递交按钮    E-->
            </tbody>
        </table>
    </form>
</div>
<!--js脚本    开始-->
<script src="js/jquery-3.2.1.js" type="text/javascript"></script>
<!--JQuery脚本集    开始-->
<script src="js/md5.js" type="text/javascript"></script>
<script src="js/login_jq.js" type="text/javascript"></script>
<!--JQuery脚本集    结束-->
</body>
</html>
