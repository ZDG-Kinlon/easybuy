<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/3
  Time: 13:33
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
    <title>::易买网::修改用户信息</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css"/>
    <link rel="stylesheet" type="text/css" href="css/html.css"/>
    <link rel="stylesheet" type="text/css" href="css/rl.css">
    <!--主页部分    结束-->
</head>
<%
    User user = (User) session.getAttribute("user");
    if (user!=null){
        UserDao userDao = new UserDaoImpl();
        User userD = userDao.getById(user.getId());
        if (userD == null || !user.getPassword().equals(userD.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            user = userD;
            session.setAttribute("user", userD);
        }
    } else{
        user=new User();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
<body>
<div class="reg_div">
    <form class="reg_form" action="<%=request.getContextPath()%>/url" method="post">
        <!--页面功能标记    S-->
        <input type="hidden" name="obj" value="user"/>
        <input type="hidden" name="act" value="setUser"/>
        <!--页面功能标记    S-->
        <table class="rl_table" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <!--页面跳转导航    S-->
            <tr height="35" valign="top">
                <td colspan="3">
                    <span><a href="<%=request.getContextPath()%>">【返回首页】</a>&nbsp;&nbsp;<a
                            href="<%=request.getContextPath()%>/user.jsp">【返回用户中心】</a></span>
                </td>
            </tr>
            <!--页面跳转导航    E-->
            <!--标题    S-->
            <tr height="35" valign="top">
                <td colspan="3">
                    <span class="rl_span_title">修改用户信息<input
                            type="hidden" name="loginName" value="<%=user.getLoginName()%>"><input
                            type="hidden" name="password" value="<%=user.getPassword()%>">
                    </span>
                </td>
            </tr>
            <!--标题    E-->
            <!--新密码    S-->
            <tr height="35">
                <td class="rl_td_spn">新密码</td>
                <td class="rl_td_inp"><input class="rl_input" type="password" id="password" value="">
                    <input type="hidden" name="passwordNew" id="passwordNewHide" value="">
                </td>
                <td class="rl_td_err"><span id="passwordNew_msg"></span></td>
            </tr>
            <!--新密码    E-->
            <!--姓名    S-->
            <tr height="35">
                <td class="rl_td_spn">姓名</td>
                <td class="rl_td_inp"><input class="rl_input" type="text" name="userName" maxlength="20"
                                             placeholder="最多20个字符" value="<%=user.getUserName()%>"
                                             required></td>
                <td class="rl_td_err"></td>
            </tr>
            <!--姓名    E-->
            <!--性别    S-->
            <tr height="35">
                <td class="rl_td_spn">性别</td>
                <td class="rl_td_inp">
                    <input class="rl_radio" type="radio" name="sex"
                           value="1" <%if(user.getSex()==1)out.print("checked");%>><span>男</span><input
                        class="rl_radio" type="radio" name="sex"
                        value="2" <%if(user.getSex()==2)out.print("checked");%>><span>女</span></td>
                <td class="rl_td_err"></td>
            </tr>
            <!--性别    E-->
            <!--身份证    S-->
            <tr height="35">
                <td class="rl_td_spn">身份证</td>
                <td class="rl_td_inp"><input class="rl_input" type="text" minlength="18" maxlength="18"
                                             placeholder="18个字符"
                                             name="identityCode" id="identityCode" value="<%=user.getIdentityCode()%>">
                </td>
                <td class="rl_td_err"><span id="identityCode_msg"></span></td>
            </tr>
            <!--身份证    E-->
            <!--邮箱    S-->
            <tr height="35">
                <td class="rl_td_spn">邮箱</td>
                <td class="rl_td_inp"><input class="rl_input" type="email" name="email" maxlength="80"
                                             placeholder="最多80个字符" value="<%=user.getEmail()%>">
                </td>
                <td class="rl_td_err"></td>
            </tr>
            <!--邮箱    E-->
            <!--手机号    S-->
            <tr height="35">
                <td class="rl_td_spn">手机号</td>
                <td class="rl_td_inp"><input class="rl_input" type="text" minlength="11" maxlength="11"
                                             placeholder="11个数字"
                                             name="mobile" id="mobile" value="<%=user.getMobile()%>">
                </td>
                <td class="rl_td_err"><span id="mobile_msg"></span></td>
            </tr>
            <!--手机号    E-->
            <!--用户类型    S-->
            <tr height="35">
                <td class="rl_td_spn">用户类型</td>
                <td class="rl_td_inp"><input class="rl_radio" type="radio" name="type"
                                             value="1" <%if(user.getType()==1)out.print("checked");%>><span>买家</span>
                    <input class="rl_radio" type="radio" name="type"
                           value="2" <%if(user.getType()==2)out.print("checked");%>><span>店家</span></td>
                <td class="rl_td_err"></td>
            </tr>
            <!--用户类型    E-->
            <!--递交按钮    S-->
            <tr height="60">
                <td class="rl_td_btn" colspan="2">
                    <input class="rl_btn" id="reg_btn" type="submit" value="递交修改">
                </td>
                <td></td>
            </tr>
            <!--递交按钮    E-->
            </tbody>
        </table>
    </form>
    <!--JQuery脚本    S-->
    <script charset="utf-8" type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <script charset="utf-8" type="text/javascript" src="js/md5.js"></script>
    <script charset="utf-8" type="text/javascript" src="js/setUser_jq.js"></script>
    <!--JQuery脚本    E-->
</div>
</body>
</html>
