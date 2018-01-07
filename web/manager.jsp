<%@ page import="com.emy.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %>
<%@ page import="com.emy.dao.news.NewsDao" %>
<%@ page import="com.emy.dao.news.impl.NewsDaoImpl" %>
<%@ page import="com.emy.entity.News" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.UnsupportedEncodingException" %><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/3
  Time: 10:05
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
    <title>::易买网::管理中心</title>
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
    if (user != null) {
        UserDao userDao = new UserDaoImpl();
        User userD = userDao.getById(user.getId());
        if (userD == null || !user.getPassword().equals(userD.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            if (user.getType() != 2) {
                response.sendRedirect(request.getContextPath() + "/user.jsp");
            } else {
                user = userD;
                session.setAttribute("user", userD);
            }
        }
    } else {
        user = new User();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
<!-- 导航链接    开始 -->
<body>
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
            <button onclick="window.location.href='<%=request.getContextPath()%>/user.jsp';" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">用户中心
            </button>
        </td>
        <td>
            <form action="<%=request.getContextPath()%>/url" method="post" style="margin: 5px;">
                <input type="hidden" name="obj" value="user">
                <input type="hidden" name="act" value="logout">
                <input type="hidden" name="userId" value="<%=user.getId()%>">
                <input type="submit" value="退出登录" class="ui-button ui-corner-all ui-widget">
            </form>
        </td>
    </tr>
    </tbody>
</table>
<!-- 导航链接    结束 -->


<!--标签集    开始-->
<div id="tabs_user">
    <ul>
        <li><a href="#tabs_user-1">资讯</a></li>
        <li><a href="#tabs_user-2">分类</a></li>
        <li><a href="#tabs_user-3">商品</a></li>
        <li><a href="#tabs_user-4">订单</a></li>
    </ul>
    <div id="tabs_user-1">
        <!-- 资讯管理（管理员）    开始 -->
        <table border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <tr>
                <td>
                    <button id="opener_addNews" onclick="openDialog('#dialog_addNews',750,250);"
                            class="ui-button ui-corner-all ui-widget" style="margin: 5px;">
                        添加资讯
                    </button>
                    <!-- S    添加资讯-->
                    <div id="dialog_addNews" title="添加资讯" style="display: none;">
                        <form action="<%=request.getContextPath()%>/url" method="post">
                            <input type="hidden" name="obj" value="news">
                            <input type="hidden" name="act" value="addNews">
                            <table>
                                <tbody>
                                <tr>
                                    <td>
                                        <span><span style="color: #f00;">*</span>&nbsp;标题：</span>
                                    </td>
                                    <td>
                <span><input name="title" type="text" size="40" class="text ui-widget-content ui-corner-all"
                             placeholder="最多255个字符"
                             required
                             maxlength="255"/></span>
                                    </td>
                                    <td>
                                <span><input type="submit" class="ui-button ui-corner-all ui-widget"
                                             value="添加资讯"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span><span style="color: #f00;">*</span>&nbsp;内容：</span>
                                    </td>
                                    <td colspan="2">
                <span><textarea id="content" class="text ui-widget-content ui-corner-all" maxlength="1024" cols="50"
                                rows="10" style="resize: none;width:648px;" required placeholder="最多1024个字符"></textarea><input
                        type="hidden" name="content" id="contentHide" value=""></span>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                    <!-- E    添加资讯-->
                </td>
            </tr>
            </tbody>
        </table>
        <table border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <tr>
                <td><!--资讯信息    开始-->
                    <div id="news_div">
                        <%
                            NewsDao newsDao = new NewsDaoImpl();
                            List<News> newsList = newsDao.getAll();
                            String contentStr = "";
                            String contentStr2 = "";
                            int n = newsList.size();
                            if (n > 0) {
                                for (News news : newsList) {
                        %>
                        <h3>
                            <span><%=news.getTitle()%></span>
                        </h3>
                        <div>
                            <ul>
                                <li>
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tbody>
                                        <tr>
                                            <td><span><%=new
                                                    SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(news.getCreatTime())%></span>
                                            </td>
                                            <td>
                                                <button id="opener_setAddress_<%=news.getId()%>"
                                                        onclick="openDialog('#dialog_addAddress_<%=news.getId()%>',750,250);"
                                                        class="ui-button ui-corner-all ui-widget" style="margin: 5px;">
                                                    修改
                                                </button>
                                                <div id="dialog_addAddress_<%=news.getId()%>" title="修改资讯"
                                                     style="display: none">
                                                    <form action="<%=request.getContextPath()%>/url" method="post"
                                                          style="margin: 5px">
                                                        <input type="hidden" name="obj" value="news">
                                                        <input type="hidden" name="act" value="setNews">
                                                        <input type="hidden" name="newsId" value="<%=news.getId()%>">
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                            <tr>
                                                                <td>
                                                                    <span><span
                                                                            style="color: #f00;">*</span>&nbsp;标题：</span>
                                                                </td>
                                                                <td>
                                                                    <span><input name="title" type="text" size="40"
                                                                                 placeholder="最多255个字符" required
                                                                                 class="text ui-widget-content ui-corner-all"
                                                                                 maxlength="255"
                                                                                 value="<%=news.getTitle()%>"/></span>
                                                                </td>
                                                                <td>
                                                                    <span><input type="submit" value="修改资讯"
                                                                                 class="ui-button ui-corner-all ui-widget"></span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <span><span
                                                                            style="color: #f00;">*</span>&nbsp;内容：</span>
                                                                </td>
                                                                <td colspan="2">
                                                                    <span><textarea id="content_<%=news.getId()%>"
                                                                                    maxlength="1024" cols="50" rows="10"
                                                                                    style="resize: none;width:648px;"
                                                                                    class="text ui-widget-content ui-corner-all"
                                                                                    required placeholder="最多1024个字符"><%
                                                                        contentStr = news.getContent();
                                                                        try {
                                                                            byte[] byteArr = Base64.getDecoder().decode(contentStr);
                                                                            contentStr2 = new String(byteArr, "UTF-8");
                                                                            out.print(contentStr2);
                                                                        } catch (UnsupportedEncodingException e) {
                                                                            out.print("（加载失败）BASE64编码：" + contentStr);
                                                                        }
                                                                    %></textarea>
                                                                        <input type="hidden" name="content"
                                                                               class="content_base64"
                                                                               id="contentHide_<%=news.getId()%>"
                                                                               value=""></span>
                                                                </td>
                                                            </tr>
                                                            <!--修改资讯    结束-->
                                                            </tbody>
                                                        </table>
                                                    </form>
                                                </div>
                                            </td>
                                            <td>
                                                <form action="<%=request.getContextPath()%>/url" method="post"
                                                      style="margin: 5px">
                                                    <input type="hidden" name="obj" value="news">
                                                    <input type="hidden" name="act" value="deleteNews">
                                                    <input type="hidden" name="newsId" value="<%=news.getId()%>">
                                                    <input type="submit" value="删除"
                                                           class="ui-button ui-corner-all ui-widget">
                                                </form>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </li>
                                <li><textarea maxlength="1024" cols="50" rows="10"
                                              style="resize: none;width:648px;"><%=contentStr2%></textarea>
                                </li>
                            </ul>
                        </div>
                        <%
                                }
                            }
                        %></div>
                </td>
            </tr>
            <!--资讯信息    结束-->
            </tbody>
        </table>
        <!-- 资讯管理（管理员）    结束 -->
    </div>
    <div id="tabs_user-2">
        <p>商品分类管理，施工中...</p>
    </div>
    <div id="tabs_user-3">
        <p>商品仓库管理，施工中...</p>
    </div>
    <div id="tabs_user-4">
        <p>订单管理，施工中...</p>
    </div>
</div>
<!--标签集    结束-->

<!--JQuery脚本    开始-->
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="js/jbase64.js"></script>
<!-- S    显示消息框-->
<script>
    /**
     * 开启提示框
     *
     * @param tagId 显示提示框内容的标签id
     * @param width 显示宽度
     * @param height 显示高度
     */
    function openDialog(tagId, width, height) {
        $(tagId).dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            width: width,
            height: height,
            show: {
                effect: "fade",
                duration: 1000
            },
            hide: {
                effect: "explode",
                duration: 1000
            }
        });
        $(tagId).dialog("open");
    }
</script>
<!-- E    显示消息框-->

<!-- S    标签集-->
<script>
    $(function () {
        var tabs = $("#tabs_user").tabs();
        tabs.find(".ui-tabs-nav").sortable({
            axis: "x",
            stop: function () {
                tabs.tabs("refresh");
            }
        });
    });
</script>
<!-- E    标签集-->

<!-- S    BASE64-->
<script>
    $(function () {
        //S    加密资讯内容，防止换行符号丢失
        $(".content_text").blur(function () {
            $("#" + "contentHide_" + $(this).attr("id").split("_").pop()).val(BASE64.encoder($(this).val()));
        });
        //E    加密资讯内容，防止换行符号丢失
    });
</script>
<!-- E    BASE64-->

<!-- S    折叠特效-->
<script>
    $(function () {
        $("#news_div").accordion({
            event: "click"
        });
    });
</script>
<!--     折叠特效-->
<!-- JQuery脚本    结束 -->
</body>
</html>
