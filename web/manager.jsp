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
<table border="0" cellspacing="0" cellpadding="0">
    <thead>
    <tr>
        <td><a href="<%=request.getContextPath()%>/index.jsp">【返回首页】</a>&nbsp;&nbsp;
        </td>
        <td><a href="<%=request.getContextPath()%>/user.jsp">【返回用户中心】</a>&nbsp;&nbsp;
        </td>
    </tr>
    </thead>
</table>
<br/>
<!-- 导航链接    结束 -->
<!-- 用户信息    开始 -->
<table border="1" cellspacing="0" cellpadding="0">
    <thead>
    <tr>
        <td colspan="2" align="center"><span>====用户信息====</span></td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><span>帐号</span></td>
        <td><span><%=user.getLoginName()%></span></td>
    </tr>
    <tr>
        <td colspan="2" align="center"><span><a
                href="<%=request.getContextPath()%>/url?obj=user&act=logout">【退出】</a><a
                href="<%=request.getContextPath()%>/setUser.jsp">【修改以下信息】</a> </span></td>
    </tr>
    <tr>
        <td><span>帐号类型</span></td>
        <td><span> <%
            switch (user.getType()) {
                case 1:
                    out.print("买家");
                    break;
                case 2:
                    out.print("管理员");
                    break;
                default:
                    request.setAttribute("msg", "帐号类型异常：" + user.getType());
                    break;
            }
        %>
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <span>性别</span>
        </td>
        <td>
            <span>
                <%
                    switch (user.getSex()) {
                        case 1:
                            out.print("男");
                            break;
                        case 2:
                            out.print("女");
                            break;
                        default:
                            request.setAttribute("msg", "性别异常：" + user.getSex());
                            break;
                    }
                %>
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <span>身份证</span>
        </td>
        <td>
            <span>
                <%
                    if (user.getIdentityCode() != null) {
                        out.print(user.getIdentityCode());
                    } else {
                        out.print("无");
                    }
                %>
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <span>邮箱</span>
        </td>
        <td>
            <span>
                <%
                    if (user.getEmail() != null) {
                        out.print(user.getEmail());
                    } else {
                        out.print("无");
                    }
                %>
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <span>手机号</span>
        </td>
        <td>
            <span>
                <%
                    if (user.getEmail() != null) {
                        out.print(user.getMobile());
                    } else {
                        out.print("无");
                    }
                %>
            </span>
        </td>
    </tr>
    </tbody>
</table>
<br/>
<!-- 用户信息    结束 -->
<!-- 资讯管理（管理员）    开始 -->
<table border="1" cellspacing="0" cellpadding="0">
    <thead>
    <tr>
        <td align="center">
            <span>====资讯管理====</span>
        </td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><!--资讯信息    开始-->
            <div id="news_div"><%
                NewsDao newsDao = new NewsDaoImpl();
                List<News> newsList = newsDao.getAll();
                int n = newsList.size();
                if (n > 0) {
                    for (News news : newsList) {
            %><h3><span><%=news.getTitle()%></span></h3>
                <div>
                    <ul>
                        <li>&nbsp;&nbsp;<span><%=new
                                SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(news.getCreatTime())%></span>&nbsp;&nbsp;<a
                                href="<%=request.getContextPath()%>/url?obj=news&act=getNewsById&newsId=<%=news.getId()%>">【修改】</a>&nbsp;&nbsp;<a
                                href="<%=request.getContextPath()%>/url?obj=news&act=deleteNews&newsId=<%=news.getId()%>">【删除】</a>
                        </li>
                        <li><textarea maxlength="1024" cols="50" rows="10" style="resize: none;width:648px;"><%
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
        </td>
    </tr>
    <!--资讯信息    结束-->
    <tr>
        <td>
            <button id="opener_news" class="ui-button ui-corner-all ui-widget">添加收货地址</button>
            <div id="dialog_news" title="添加资讯">
                <form action="<%=request.getContextPath()%>/url" method="post">
                    <input type="hidden" name="obj" value="news">
                    <input type="hidden" name="act" value="addNews">
                    <table>
                        <tbody>
                        <!--增加资讯    开始-->
                        <tr>
                            <td>
                                <span><span style="color: #f00;">*</span>&nbsp;标题：</span>
                            </td>
                            <td>
                <span><input name="title" type="text" size="40" class="ui-autocomplete-input" placeholder="最多255个字符"
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
                <span><textarea id="content" class="ui-autocomplete-input" maxlength="1024" cols="50" rows="10"
                                style="resize: none;width:648px;" class="ui-autocomplete-input"
                                required placeholder="最多1024个字符"></textarea><input type="hidden" name="content"
                                                                                   id="contentHide" value=""></span>
                            </td>
                        </tr>
                        <!--增加资讯    结束-->
                        </tbody>
                    </table>
                </form>
            </div>
        </td>
    </tr>
    </tbody>
</table>
<br/>
<!-- 资讯管理（管理员）    结束 -->


<!-- 资讯管理（管理员）    结束 -->


<!-- 商品分类管理（管理员）    开始 -->
<table border="1" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            商品分类管理，施工中...
        </td>
    </tr>
</table>
<br/>
<!-- 商品分类管理（管理员）    结束 -->
<!-- 商品管理（管理员）    开始 -->
<table border="1" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            商品管理，施工中...
        </td>
    </tr>
</table>
<br/>
<!-- 商品管理（管理员）    结束 -->
<!-- JQuery脚本    开始 -->
<!--JQuery脚本    开始-->
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="js/jbase64.js"></script>

<!-- S    添加资讯-->
<script>
    $(function () {
        $("#dialog_news").dialog({
            autoOpen: false,
            resizable: false,
            height: 250,
            width: 750,
            show: {
                effect: "fade",
                duration: 1000
            },
            hide: {
                effect: "explode",
                duration: 1000
            }
        });

        $("#opener_news").click(function () {
            $("#dialog_news").dialog("open");
        });
    });
</script>
<!-- E    添加资讯-->

<script>
    $(function () {
        //S    加密资讯内容，防止换行符号丢失
        $("#content").blur(function () {
            $("#contentHide").val(BASE64.encoder($(this).val()));
        });
        //E    加密资讯内容，防止换行符号丢失
    });
</script>
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
<!-- JQuery脚本    结束 -->
</body>
</html>
