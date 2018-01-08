<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %><%--
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
    <link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="image/x-icon"/>
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
    <link rel="stylesheet" type="text/css" href="css/rl.css"/>
    <!--主页部分    结束-->
    <!--JQuery-UI样式 -->
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.css">
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.theme.css">
</head>
<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
        UserDao userDao = new UserDaoImpl();
        User userD = userDao.getById(user.getId());
        if (userD != null && user.getPassword().equals(userD.getPassword())) {
            session.setAttribute("user", userD);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
%>
<body>
<!-- 导航链接    开始 -->
<table border="0" cellspacing="0" cellpadding="0">
    <tbody>
    <tr>
        <td>
            <button onclick="window.location.href='<%=request.getContextPath()%>/index.jsp';" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">返回首页
            </button>
        </td>
        <td>
            <button onclick="window.location.href='<%=request.getContextPath()%>/regist.jsp';" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">用户注册
            </button>
        </td>
    </tr>
    </tbody>
</table>
<!-- 导航链接    结束 -->
<!-- 登录区域    开始 -->
<div id="dialog_login">
    <h3>注册</h3>
    <div>
        <form class="rl_form" action="<%=request.getContextPath()%>/url" method="post">
            <!--页面功能标记    S-->
            <input type="hidden" name="obj" value="user"/>
            <input type="hidden" name="act" value="login"/>
            <!--页面功能标记    S-->
            <table class="rl_table" border="0" cellspacing="0" cellpadding="0">
                <tbody>
                <!--用户名    S-->
                <tr height="35">
                    <td class="rl_td_spn"><span style="color: #f00; ">*</span>&nbsp;用户名</td>
                    <td class="rl_td_inp">
                        <input class="rl_input text ui-widget-content ui-corner-all" type="text" name="loginName"
                               maxlength="20" placeholder="最多20个字符" value="" required>
                    </td>
                    <td class="rl_td_err"><span id="loginName_msg"></span></td>
                </tr>
                <!--用户名    E-->
                <!--密码    S-->
                <tr height="35">
                    <td class="rl_td_spn"><span color="#f00">*</span>&nbsp;密码</td>
                    <td class="rl_td_inp">
                        <input class="rl_input text ui-widget-content ui-corner-all" type="password" id="password"
                               value="" required>
                        <input type="hidden" name="password" id="passwordHide" value="">
                    </td>
                    <td class="rl_td_err"><span id="password_msg"></span></td>
                </tr>
                <!--密码    E-->
                <!--递交按钮    S-->
                <tr height="60">
                    <td class="rl_td_btn" colspan="2">
                        <input class="rl_btn ui-button ui-corner-all ui-widget" id="reg_btn" type="submit" value="登录">
                    </td>
                    <td></td>
                </tr>
                <!--递交按钮    E-->
                </tbody>
            </table>
        </form>
    </div>
</div>
<!-- 登录区域    开始 -->
<!--JQuery脚本集    开始-->
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.js"></script>
<script src="js/md5.js"></script>

<!-- S    注册区域样式-->
<script>
    $(function () {
        $("#dialog_login").accordion();
    });
</script>
<!-- E    注册区域样式-->
<!-- S    登录脚本-->
<script>
    /**
     * 登录页面JQuery脚本
     * @author Kinlon
     * @version 1.0.0
     */
    $(function () {
        //S    密码加密
        $("#password").blur(function () {
            $("#passwordHide").val(MD5($(this).val()));
        });
        $("#password").keyup(function () {
            $("#passwordHide").val(MD5($(this).val()));
        });
        //E    密码加密
    });
</script>
<!-- E    登录脚本-->
<!--JQuery脚本集    结束-->
</body>
</html>
