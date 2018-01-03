<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.service.impl.ServiceImpl" %>
<%@ page import="com.emy.service.Service" %><%--
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
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>
    <meta charset="UTF-8">
    <meta name="Generator" content="WebStorm 2017.3.2">
    <meta name="Keywords" content="易买网,购物">
    <meta name="Description" content="易买网是一家购物网站，用户可以在线浏览商品，选购商品">
    <meta name="Author" content="Kinlon">
    <meta name="Version" content="1.0.0.1">
    <title>::易买网::用户中心</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css"/>
    <link rel="stylesheet" type="text/css" href="css/html.css"/>
</head>
<%
    User user = (User) session.getAttribute("user");
    Service service = new ServiceImpl();
    if (user == null || !service.checkUserPwd(user.getId(), user.getLoginName(), user.getPassword())) {
        //未登录
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
<body>

<table>
    <tbody>
    <tr>
        <td colspan="2" border="0" cellspacing="0" cellpadding="0">
            <span>用户信息</span>
        </td>
    </tr>
    <tr>
        <td>
            <span>帐号</span>
        </td>
        <td>
            <span><%=user.getLoginName()%></span>
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
        <td colspan="2">
            <span><a
                    href="<%=request.getContextPath()%>/url?act=logout&sessionId=<%=session.getId()%>&loginName=<%=user.getLoginName()%>&password=<%=user.getPassword()%>">【退出】</a><a
                    href="<%=request.getContextPath()%>/url?act=setUser&sessionId=<%=session.getId()%>&loginName=<%=user.getLoginName()%>&password=<%=user.getPassword()%>">【修改以下信息】</a>
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
                   if (user.getIdentityCode()!=null) {
                       out.print(user.getIdentityCode());
                   }else{
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
                    if (user.getEmail()!=null) {
                        out.print(user.getEmail());
                    }else{
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
                    if (user.getEmail()!=null) {
                        out.print(user.getMobile());
                    }else{
                        out.print("无");
                    }
                %>
            </span>
        </td>
    </tr>
    </tbody>
</table>

</body>
</html>
