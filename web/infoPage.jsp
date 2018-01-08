<%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/1
  Time: 17:01
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
    <title>::易买网::请求结果</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css"/>
    <link rel="stylesheet" type="text/css" href="css/html.css"/>
    <!--JQuery-UI样式 -->
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.css">
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.theme.css">
    <!--主页部分    结束-->
</head>
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
                    class="ui-button ui-corner-all ui-widget">返回注册
            </button>
        </td>
        <td>
            <button onclick="window.location.href='<%=request.getContextPath()%>/login.jsp';" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">返回登录
            </button>
        </td>
        <td>
            <button onclick="window.location.href='<%=request.getContextPath()%>/user.jsp';" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">用户中心
            </button>
        </td>
        <td>
            <button onclick="window.location.href='<%=request.getContextPath()%>/manager.jsp';" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">管理中心
            </button>
        </td>
        <td>
            <button onclick="javascript:history.go(-1);return false;" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">返回上一页
            </button>
        </td>
    </tr>
    </tbody>
</table>
<!-- 导航链接    结束 -->

<div id="dialog_login">
    <h3>注册</h3>
    <div>
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td><span>请求结果：</span></td>
                <td>
                    <%
                        String runInfo = (String) request.getAttribute("msg");
                        out.println(runInfo);
                    %>
                </td>
            </tr>
        </table>
    </div>
</div>
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.js"></script>
<script>
    $(function () {
        $("#dialog_login").accordion();
    });
</script>
</body>
</html>
