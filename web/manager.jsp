<%@ page import="com.emy.entity.User"%>
<%@ page import="java.util.List"%>
<%@ page import="com.emy.dao.user.UserDao"%>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl"%>
<%@ page import="com.emy.dao.news.NewsDao"%>
<%@ page import="com.emy.dao.news.impl.NewsDaoImpl"%>
<%@ page import="com.emy.entity.News"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.io.UnsupportedEncodingException"%><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/3
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <!--主页部分    开始-->
    <link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico"
          type="image/x-icon" />
    <meta charset="UTF-8">
    <meta name="Generator" content="WebStorm 2017.3.2">
    <meta name="Keywords" content="易买网,购物">
    <meta name="Description" content="易买网是一家购物网站，用户可以在线浏览商品，选购商品">
    <meta name="Author" content="Kinlon">
    <meta name="Version" content="1.0.0.1">
    <title>::易买网::管理中心</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css" />
    <link rel="stylesheet" type="text/css" href="css/html.css" />
    <link rel="stylesheet" type="text/css" href="css/html.css" />
    <!--主页部分    结束-->
</head>
<%
    User user = (User) session.getAttribute("user");
    if (user != null){
        UserDao userDao = new UserDaoImpl();
        User userD = userDao.getById(user.getId());
        if (userD == null || !user.getPassword().equals(userD.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            if(user.getType()!=2){
                response.sendRedirect(request.getContextPath() + "/user.jsp");
            }else{
                user = userD;
                session.setAttribute("user", userD);
            }
        }
    }else{
        user=new User();
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
<br />
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
<table border="1" cellspacing="0" cellpadding="0" >
    <thead>
    <tr>
        <td align="center">
            <span>====资讯管理====</span>
        </td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>
            <!--资讯信息    开始-->
            <%
                NewsDao newsDao = new NewsDaoImpl();
                List<News> newsList = newsDao.getAll();
                int n = newsList.size();
                if (n > 0) {
                    for (News news : newsList) {
            %>
            <table border="0" cellspacing="0" cellpadding="0" >
                <thead>
                <tr>
                    <td>
                        <span><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(news.getCreatTime())%></span>
                    </td>
                    <td>
                        <input type="text" size="40" maxlength="255" value="<%=news.getTitle()%>"/>
                    </td>
                    <td>
			            <span><a
                                href="<%=request.getContextPath()%>/url?obj=news&act=getNewsById&newsId=<%=news.getId()%>">【修改】</a>&nbsp;&nbsp;<a
                                href="<%=request.getContextPath()%>/url?obj=news&act=deleteNews&newsId=<%=news.getId()%>">【删除】</a></span>
                    </td>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td colspan="3">
				         <textarea maxlength="1024" cols="50" rows="10"
                                   style="resize: none;width:648px;"><%
                             String contentStr = news.getContent();
                             try {
                                 byte[] byteArr = Base64.getDecoder().decode(contentStr);
                                 out.print(new String(byteArr, "UTF-8"));
                             } catch (UnsupportedEncodingException e) {
                                 out.print("（加载失败）BASE64编码：" + contentStr);
                             }
                         %></textarea>
                    </td>
                </tr>
                </tbody>
            </table>
            <%
                    }
                }
            %>
        </td>
    </tr>
    <!--资讯信息    结束-->
    </tbody>
</table>
<form action="<%=request.getContextPath()%>/url" method="post">
    <input type="hidden" name="obj" value="news">
    <input type="hidden" name="act" value="addNews">
    <table>
        <tbody>
        <!--增加地址    开始-->
        <tr>
            <td>
                <span><span style="color: #f00;">*</span>&nbsp;标题：</span>
            </td>
            <td>
                <span><input name="title" type="text" size="40" placeholder="最多255个字符" required
                             maxlength="255"/></span>
            </td>
            <td>
                <span><input type="submit" value="添加资讯"></span>
            </td>
        </tr>
        <tr>
            <td>
                <span><span style="color: #f00;">*</span>&nbsp;内容：</span>
            </td>
            <td colspan="2">
                <span><textarea id="content" maxlength="1024" cols="50" rows="10" style="resize: none;width:648px;"
                                required placeholder="最多1024个字符"></textarea><input type="hidden" name="content"
                                                                                   id="contentHide" value=""></span>
            </td>
        </tr>
        <!--增加地址    结束-->
        </tbody>
    </table>
</form>
<br/>
<!-- 资讯管理（管理员）    结束 -->
<!-- 商品分类管理（管理员）    开始 -->
<table border="1" cellspacing="0" cellpadding="0" >
    <tr>
        <td>
            商品分类管理，施工中...
        </td>
    </tr>
</table>
<br/>
<!-- 商品分类管理（管理员）    结束 -->
<!-- 商品管理（管理员）    开始 -->
<table border="1" cellspacing="0" cellpadding="0" >
    <tr>
        <td>
            商品管理，施工中...
        </td>
    </tr>
</table>
<br/>
<!-- 商品管理（管理员）    结束 -->
<!-- JQuery脚本    开始 -->
<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="js/jbase64.js"></script>
<script type="text/javascript">
    /**
     * 管理页面JQuery脚本
     * @author Kinlon
     * @version 1.0.0
     */
    $(function(){
        //S    加密资讯内容，防止换行符号丢失
        $("#content").blur(function(){
            $("#contentHide").val(BASE64.encoder($(this).val()));
            /*
测试增加资讯
測試新增資訊
Test increase information
추가 정보 테스트
テストが増加して情報を増加して
ทดสอบการเพิ่มข้อมูล
увеличение  информации  испытания
اختبار   زيادة   المعلومات
            */
        });
    });
</script>
<!-- JQuery脚本    结束 -->
</body>
</html>
