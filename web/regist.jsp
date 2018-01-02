<%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2017/12/30
  Time: 8:56
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
    <title>::易买网::用户注册</title>
    <!--基础样式 -->
    <link rel="stylesheet" type="text/css" href="css/bass.css"/>
    <link rel="stylesheet" type="text/css" href="css/html.css"/>
    <!--主页部分    结束-->
    <link rel="stylesheet" type="text/css" href="css/regist.css"/>
</head>
<body>
<div class="reg_div">
    <form class="reg_form" action="<%=request.getContextPath()%>/url" method="post">
        <!--页面功能标记    S-->
        <input type="hidden" name="act" value="regist"/>
        <!--页面功能标记    S-->
        <table class="reg_table" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <!--页面跳转导航    S-->
            <tr height="35" valign="top">
                <td colspan="3">
                    <span><a href="<%=request.getContextPath()%>">返回首页</a>&nbsp;&nbsp;<a
                            href="<%=request.getContextPath()%>/login.jsp">帐号登录</a></span>
                </td>
            </tr>
            <!--页面跳转导航    E-->
            <!--标题    S-->
            <tr height="35" valign="top">
                <td colspan="3">
                    <span class="reg_span_title">注册</span>
                </td>
            </tr>
            <!--标题    E-->
            <!--用户名    S-->
            <tr height="35">
                <td class="reg_td_spn"><span style="color: #f00; ">*</span>&nbsp;用户名</td>
                <td class="reg_td_inp"><input class="reg_input" type="text" name="loginName" maxlength="20"
                                              placeholder="最多20个字符" value=""
                                              required></td>
                <td class="reg_td_err"><span id="loginName_msg"></span></td>
            </tr>
            <!--用户名    E-->
            <!--密码    S-->
            <tr height="35">
                <td class="reg_td_spn"><span color="#f00">*</span>&nbsp;密码</td>
                <td class="reg_td_inp"><input class="reg_input" type="password" id="password" value="" required></td>
                <td class="reg_td_err"><span id="password_msg"></span></td>
            </tr>
            <!--密码    E-->
            <!--密码验证    S-->
            <tr height="35">
                <td class="reg_td_spn"><span style="color: #f00; ">*</span>&nbsp;确认密码</td>
                <td class="reg_td_inp"><input class="reg_input" type="password" id="passwordRe" value="" required>
                    <input type="hidden" name="passwordHide" value="">
                </td>
                <td class="reg_td_err"><span id="passwordRe_msg"></span></td>
            </tr>
            <!--密码验证    E-->
            <!--姓名    S-->
            <tr height="35">
                <td class="reg_td_spn"><span style="color: #f00; ">*</span>&nbsp;姓名</td>
                <td class="reg_td_inp"><input class="reg_input" type="text" name="userName" maxlength="20"
                                              placeholder="最多20个字符" value=""
                                              required></td>
                <td class="reg_td_err"></td>
            </tr>
            <!--姓名    E-->
            <!--性别    S-->
            <tr height="35">
                <td class="reg_td_spn"><span style="color: #f00; ">*</span>&nbsp;性别</td>
                <td class="reg_td_inp"><input class="reg_radio" type="radio" name="sex" value="1" checked
                                              required><span>男</span>
                    <input class="reg_radio" type="radio" name="sex" value="2" required><span>女</span></td>
                <td class="reg_td_err"></td>
            </tr>
            <!--性别    E-->
            <!--身份证    S-->
            <tr height="35">
                <td class="reg_td_spn">身份证</td>
                <td class="reg_td_inp"><input class="reg_input" type="text" maxlength="18" maxlength="18"
                                              placeholder="最多18个字符"
                                              name="identityCode" value=""></td>
                <td class="reg_td_err"></td>
            </tr>
            <!--身份证    E-->
            <!--邮箱    S-->
            <tr height="35">
                <td class="reg_td_spn">邮箱</td>
                <td class="reg_td_inp"><input class="reg_input" type="email" name="email" maxlength="80"
                                              placeholder="最多80个字符" value="">
                </td>
                <td class="reg_td_err"></td>
            </tr>
            <!--邮箱    E-->
            <!--手机号    S-->
            <tr height="35">
                <td class="reg_td_spn">手机号</td>
                <td class="reg_td_inp"><input class="reg_input" type="text" maxlength="11" placeholder="最多11个字符"
                                              name="mobile" value="">
                </td>
                <td class="reg_td_err"></td>
            </tr>
            <!--手机号    E-->
            <!--用户类型    S-->
            <tr height="35">
                <td class="reg_td_spn"><span style="color: #f00; ">*</span>&nbsp;用户类型</td>
                <td class="reg_td_inp"><input class="reg_radio" type="radio" name="type" value="1" checked
                                              required><span>买家</span>
                    <input class="reg_radio" type="radio" name="type" value="2" required><span>店家</span></td>
                <td class="reg_td_err"></td>
            </tr>
            <!--用户类型    E-->
            <!--附选项    E-->
            <tr height="30" style="text-align: center">
                <td class="reg_chk_btn" colspan="2">
                    <input class="reg_btn" type="checkbox" id="chk_btn"><span style="color: #f00; ">同意条款规定</span></td>
                </td>
                <td></td>
            </tr>
            <!--附选项    E-->
            <!--递交按钮    S-->
            <tr height="60">
                <td class="reg_td_btn" colspan="2">
                    <input class="reg_btn" id="reg_btn" type="submit" value="注册">
                </td>
                <td></td>
            </tr>
            <!--递交按钮    E-->
            </tbody>
        </table>
    </form>
    <!--JQuery脚本    S-->
    <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="js/md5.js"></script>
    <script type="text/javascript" src="js/regist_jq.js"></script>
    <!--JQuery脚本    E-->
</div>
</body>
</html>
