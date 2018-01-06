<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %>
<%@ page import="com.emy.entity.News" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="java.util.Base64" %><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/6
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--主页部分    开始-->
    <link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico"
          type="image/x-icon"/>
    <meta charset="UTF-8">
    <meta name="Generator" content="WebStorm 2017.3.2">
    <meta name="Keywords" content="易买网,购物">
    <meta name="Description" content="易买网是一家购物网站，用户可以在线浏览商品，选购商品">
    <meta name="Author" content="Kinlon">
    <meta name="Version" content="1.0.0.1">
    <title>::易买网::修改资讯</title>
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
    News news;
    if (user != null) {
        UserDao userDao = new UserDaoImpl();
        User userD = userDao.getById(user.getId());
        if (userD == null || !user.getPassword().equals(userD.getPassword())) {
            news = new News();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            if (user.getType() != 2) {
                news = new News();
                response.sendRedirect(request.getContextPath() + "/user.jsp");
            } else {
                user = userD;
                session.setAttribute("user", userD);
                news = (News) request.getAttribute("news");
                if (news == null) {
                    news = new News();
                    request.setAttribute("msg", "参数不正确");
                    request.getRequestDispatcher("user.jsp").forward(request, response);
                }
            }
        }
    } else {
        news = new News();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
<body>
<form action="<%=request.getContextPath()%>/url" method="post">
    <input type="hidden" name="obj" value="news">
    <input type="hidden" name="act" value="setNews">
    <input type="hidden" name="newsId" value="<%=news.getId()%>">
    <table>
        <thead>
        <!--页面跳转导航    S-->
        <tr height="35" valign="top">
            <td colspan="3">
                    <span><a href="<%=request.getContextPath()%>">【返回首页】</a>&nbsp;&nbsp;<a
                            href="<%=request.getContextPath()%>/manager.jsp">【返回管理中心】</a></span>
            </td>
        </tr>
        <!--页面跳转导航    E-->
        </thead>
        <tbody>
        <!--标题    S-->
        <tr height="35" valign="top">
            <td colspan="2">
                <span class="rl_span_title">修改资讯</span>
            </td>
        </tr>
        <!--标题    E-->
        <!--修改资讯    开始-->
        <tr>
            <td>
                <span><span style="color: #f00;">*</span>&nbsp;标题：</span>
            </td>
            <td>
                <span><input name="title" type="text" size="40" placeholder="最多255个字符" required class="ui-autocomplete-input"
                             maxlength="255" value="<%=news.getTitle()%>"/></span>
            </td>
            <td>
                <span><input type="submit" value="修改资讯" class="ui-button ui-corner-all ui-widget"></span>
            </td>
        </tr>
        <tr>
            <td>
                <span><span style="color: #f00;">*</span>&nbsp;内容：</span>
            </td>
            <td colspan="2">
                <span><textarea id="content" maxlength="1024" cols="50" rows="10" style="resize: none;width:648px;" class="ui-autocomplete-input"
                                required placeholder="最多1024个字符"><%
                    String contentStr = news.getContent();
                    try {
                        byte[] byteArr = Base64.getDecoder().decode(contentStr);
                        out.print(new String(byteArr, "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        out.print("（加载失败）BASE64编码：" + contentStr);
                    }
                %></textarea><input
                        type="hidden" name="content" id="contentHide" value=""></span>
            </td>
        </tr>
        <!--修改资讯    结束-->
        </tbody>
    </table>
</form>
<!-- JQuery脚本    开始 -->
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="js/jbase64.js"></script>
<script type="text/javascript">
    /**
     * 管理页面JQuery脚本
     * @author Kinlon
     * @version 1.0.0
     */
    $(function () {
        //S    加密资讯内容，防止换行符号丢失
        $("#content").blur(function () {
            $("#contentHide").val(BASE64.encoder($(this).val()));
        });
    });
</script>
<!-- JQuery脚本    结束 -->
</body>
</html>
