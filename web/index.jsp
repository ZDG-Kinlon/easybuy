<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %>
<%@ page import="com.emy.dao.news.NewsDao" %>
<%@ page import="com.emy.dao.news.impl.NewsDaoImpl" %>
<%@ page import="com.emy.entity.News" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="com.emy.entity.ProductCategory" %>
<%@ page import="com.emy.dao.product.ProductCategoryDao" %>
<%@ page import="com.emy.dao.product.impl.ProductCategoryDaoImpl" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.List" %><%--
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
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.css">
    <link rel="stylesheet" href="js/jquery-ui-1.12.1/jquery-ui.theme.css">
    <!--主页部分    结束-->
</head>
<body>
<!--欢迎信息    开始-->
<table>
    <tbody>
    <tr>
        <td><%
            User user = (User) session.getAttribute("user");
            User userD=new User();
            if (user!=null) {
                UserDao userDao=new UserDaoImpl();
                userD=userDao.getById(user.getId());
            }
            if (user !=null && userD!=null && user.getPassword().equals(userD.getPassword())){
                //S    已登录
                user=userD;
                session.setAttribute("user",userD);
            %><!--已登录    开始-->
            <table border="0" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td>
                    <span>您好，欢迎<button
                            onclick="window.location.href='<%=request.getContextPath()%>/user.jsp';"
                            style="margin: 5px;"
                            class="ui-button ui-corner-all ui-widget"><%=user.getUserName()%></button>来到易买网！</span>
                    </td>
                    <td>
                        <button href="<%=request.getContextPath()%>/url?obj=user&act=logout" style="margin: 5px;"
                                class="ui-button ui-corner-all ui-widget">退出
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
                <%
            }else {
            %>
        <td>
            <span>还没加入我们？<button
                    onclick="window.location.href='<%=request.getContextPath()%>/regist.jsp';"
                    style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">注册</button></span>
        </td>
        <td>
            <span>已经有帐号？<button onclick="window.location.href='<%=request.getContextPath()%>/login.jsp';"
                                style="margin: 5px;"
                                class="ui-button ui-corner-all ui-widget">登录
            </button></span>
        </td>
        <% } %>
    </tr>
    </tbody>
</table>
<br>
<!--欢迎信息    结束-->

<!--资讯显示    开始-->
<div id="news_div" style="width:700px;margin:5px"><%
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
            <li><textarea class="text ui-widget-content ui-corner-all" maxlength="1024" cols="50" rows="10"
                          style="resize: none;width:648px;"><%
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
    %>
</div>
<!--资讯显示    结束-->

<!--商品分类    开始-->
<%

    //1.获取商品分类List集合
    ProductCategoryDao productCategoryDao = new ProductCategoryDaoImpl();
    List<ProductCategory> productCategoryList = productCategoryDao.getAll();
    int pcs = productCategoryList.size();
    if (pcs > 0) {
%><div style="margin:5px">
<ul id="menu_product_category">
    <li class="ui-state-disabled"><span style="">全部商品分类</span></li><%
        //2.寻找一级分类
        ProductCategory pc1;
        for (int i1 = 0; i1 < pcs; i1++) {
            pc1 = productCategoryList.get(i1);
            if (pc1.getId3() == 0 && pc1.getId2() == 0 && pc1.getId1() != 0) {
                int n1 = pc1.getId1();
                //找到一级分类
%><li><span><%=pc1.getName()%></span><%
		        //3.寻找二级分类
		        ProductCategory pc2;
		        int n2 = 0;
		        for (int i2 = 0; i2 < pcs; i2++) {
		            pc2 = productCategoryList.get(i2);
		            if (pc2.getId3() == 0 && pc2.getId2() != 0 && pc2.getId1() == pc1.getId1()) {
		                n2++;
		                //找到二级分类
		                if (n2 == 1) {
		                    //找到二级分类的第一个
		%><ul><%
		            	}
		%><li><span><%=pc2.getName()%></span><%
		                 //4.寻找三级分类
		                 ProductCategory pc3;
		                 int n3=0;
		                 for (int i3 = 0; i3 < pcs; i3++) {
		                     pc3=productCategoryList.get(i3);
		                     if(pc3.getId3()!=0 && pc3.getId2()==pc2.getId2() && pc3.getId1()==pc2.getId1()){
		                         n3++;
		                         //找到三级分类
		                         if(n3==1){
		                             //找到三级分类的第一个
			%><ul><%
				                }
				                String url = "" + n1 + "_" + n2 + "_" + n3;
			%><li><a href="#_<%=url%>"><%=pc3.getName()%></a></li><%
			               }
			               if (i3 == pcs - 1 && n3 > 0) {
			                       //找到三级分类最后一个，闭合标签
			%></ul></li><%
			               }
			           }
		            }
		            if (i2 == pcs - 1 && n2 > 0) {
		                    //找到二级分类最后一个，闭合标签
		%></ul></li><%
					}
		        }
			}
		}
		%></ul></div><%
	}
%>
<!--商品分类    结束-->



<!--JQuery脚本    开始-->
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.js"></script>
<!--菜单特效    开始-->
<style rel="stylesheet">
    .ui-menu { width: 100px; }
    .ui-menu-item{font-size:20px;}
</style>
<script>
    $(function() {
        $( "#menu_product_category" ).menu();
    });
</script>
<!--菜单特效    结束-->
<!--折叠特效    开始-->
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
<!--折叠特效    结束-->
<!--JQuery脚本    结束-->
</body>
</html>
