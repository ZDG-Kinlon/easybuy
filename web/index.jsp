<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %>
<%@ page import="com.emy.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.emy.dao.news.NewsDao" %>
<%@ page import="com.emy.dao.news.impl.NewsDaoImpl" %>
<%@ page import="com.emy.entity.News" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.UnsupportedEncodingException" %><%--
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
    <link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="image/x-icon"/>
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
    <!--JQuery-UI样式 -->
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.theme.css">
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/themes/sunny/theme.css">
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/themes/sunny/jquery-ui.css">
    <!--主页部分    结束-->
</head>
<body>
<!--欢迎信息    开始-->
<table>
    <tbody>
    <tr>
        <td>
            <%
    User user = (User) session.getAttribute("user");
    if (user==null) {
        user=new User();
        //S    没有登录
        %><!--没有登录    开始-->
            <span>
            还没加入我们？<a href="<%=request.getContextPath()%>/regist.jsp">【注册】</a>&nbsp;&nbsp;已经有帐号？<a
                    href="login.jsp">【登录】</a>
        </span>
            <!--没有登录    结束--><%
        //E    没有登录
    }else{
        UserDao userDao=new UserDaoImpl();
        User userD=userDao.getById(user.getId());
        if (userD!=null && user.getPassword().equals(userD.getPassword())){
            //S    已登录
            user=userD;
            session.setAttribute("user",userD);
            %><!--已登录    开始-->
            <span>
            您好，欢迎<a href="<%=request.getContextPath()%>/user.jsp">【<%=user.getUserName()%>】</a>来到易买网！&nbsp;&nbsp;<a
                    href="<%=request.getContextPath()%>/url?obj=user&act=logout">【退出】</a>
        </span>
            <!--已登录    结束--><%
            //E    已登录
        }else{
            //S    没有登录
        %><!--没有登录    开始-->
            <span>
            还没加入我们？<a href="<%=request.getContextPath()%>/regist.jsp">【注册】</a>&nbsp;&nbsp;已经有帐号？<a
                    href="login.jsp">【登录】</a>
        </span>
            <!--没有登录    结束--><%
                    //E    没有登录
                }
            }
        %></td>
    </tr>
    </tbody>
</table>
<br>
<!--欢迎信息    结束-->

<!--资讯显示    开始-->
<div id="news_div" style="width:700px;"><%
    NewsDao newsDao = new NewsDaoImpl();
    List<News> newsList = newsDao.getAll();
    int n = newsList.size();
    if (n > 0) {
        for (News news : newsList) {
%><h3><span><%=news.getTitle()%></span></h3>
    <div>
        <ul>
            <li>&nbsp;&nbsp;<span><%=new
                    SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(news.getCreatTime())%></span></li>
            <li><textarea class="text ui-widget-content ui-corner-all" maxlength="1024" cols="50" rows="10" style="resize: none;width:648px;"><%
                String contentStr = news.getContent();
                try {
                    byte[] byteArr = Base64.getDecoder().decode(contentStr);
                    out.print(new String(byteArr, "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    out.print("（加载失败）BASE64编码：" + contentStr);
                }
            %></textarea></li>
        </ul>
    </div>
    <%
            }
        }
    %></div>
<!--资讯显示    结束-->

<!--JQuery脚本    开始-->
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.js"></script>
<script>
    $(function () {
        $("#news_div").accordion({
            event: "click hoverintent"
        });
    });
    //S    悬停事件
    $.event.special.hoverintent = {
        setup: function () {
            $(this).bind("mouseover", jQuery.event.special.hoverintent.handler);
        },
        teardown: function () {
            $(this).unbind("mouseover", jQuery.event.special.hoverintent.handler);
        },
        handler: function (event) {
            var currentX, currentY, timeout,
                args = arguments,
                target = $(event.target),
                previousX = event.pageX,
                previousY = event.pageY;

            function track(event) {
                currentX = event.pageX;
                currentY = event.pageY;
            };

            function clear() {
                target
                    .unbind("mousemove", track)
                    .unbind("mouseout", clear);
                clearTimeout(timeout);
            }

            function handler() {
                var prop,
                    orig = event;

                if ((Math.abs(previousX - currentX) +
                        Math.abs(previousY - currentY)) < 7) {
                    clear();

                    event = $.Event("hoverintent");
                    for (prop in orig) {
                        if (!(prop in event)) {
                            event[prop] = orig[prop];
                        }
                    }
                    // 防止访问原始事件，因为新事件会被异步触发，旧事件不再可用 (#6028)
                    delete event.originalEvent;

                    target.trigger(event);
                } else {
                    previousX = currentX;
                    previousY = currentY;
                    timeout = setTimeout(handler, 100);
                }
            }

            timeout = setTimeout(handler, 100);
            target.bind({
                mousemove: track,
                mouseout: clear
            });
        }
    };
    //E    悬停事件
</script>
<!--JQuery脚本    结束-->
</body>
</html>
