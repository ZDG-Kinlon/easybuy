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
    <link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="image/x-icon"/>
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
    <link rel="stylesheet" type="text/css" href="css/rl.css"/>
</head>
<body>
<div class="reg_div">
    <form class="reg_form" action="<%=request.getContextPath()%>/url" method="post">
        <!--页面功能标记    S-->
        <input type="hidden" name="obj" value="user"/>
        <input type="hidden" name="act" value="regist"/>
        <!--页面功能标记    S-->
        <table class="rl_table" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <!--页面跳转导航    S-->
            <tr height="35" valign="top">
                <td colspan="3">
                    <span><a href="<%=request.getContextPath()%>">【返回首页】</a>&nbsp;&nbsp;<a
                            href="<%=request.getContextPath()%>/login.jsp">【帐号登录】</a></span>
                </td>
            </tr>
            <!--页面跳转导航    E-->
            <!--标题    S-->
            <tr height="35" valign="top">
                <td colspan="3">
                    <span class="rl_span_title">注册</span>
                </td>
            </tr>
            <!--标题    E-->
            <!--用户名    S-->
            <tr height="35">
                <td class="rl_td_spn"><span style="color: #f00; ">*</span>&nbsp;用户名</td>
                <td class="rl_td_inp"><input class="rl_input" type="text" id="loginName" maxlength="20"
                                             placeholder="最多20个字符" value=""
                                             required>
                    <input type="hidden" name="loginName" id="loginNameHide" value="" required>
                </td>
                <td class="rl_td_err"><span id="loginName_msg"></span></td>
            </tr>
            <!--用户名    E-->
            <!--密码    S-->
            <tr height="35">
                <td class="rl_td_spn"><span color="#f00">*</span>&nbsp;密码</td>
                <td class="rl_td_inp"><input class="rl_input" type="password" id="password" value="" required></td>
                <td class="rl_td_err"><span id="password_msg"></span></td>
            </tr>
            <!--密码    E-->
            <!--密码验证    S-->
            <tr height="35">
                <td class="rl_td_spn"><span style="color: #f00; ">*</span>&nbsp;确认密码</td>
                <td class="rl_td_inp"><input class="rl_input" type="password" id="passwordRe" value="" required>
                    <input type="hidden" name="password" id="passwordHide" value="" required>
                </td>
                <td class="rl_td_err"><span id="passwordRe_msg"></span></td>
            </tr>
            <!--密码验证    E-->
            <!--姓名    S-->
            <tr height="35">
                <td class="rl_td_spn"><span style="color: #f00; ">*</span>&nbsp;姓名</td>
                <td class="rl_td_inp"><input class="rl_input" type="text" name="userName" maxlength="20"
                                             placeholder="最多20个字符" value=""
                                             required></td>
                <td class="rl_td_err"></td>
            </tr>
            <!--姓名    E-->
            <!--性别    S-->
            <tr height="35">
                <td class="rl_td_spn"><span style="color: #f00; ">*</span>&nbsp;性别</td>
                <td class="rl_td_inp"><input class="rl_radio" type="radio" name="sex" value="1" checked
                                             required><span>男</span>
                    <input class="rl_radio" type="radio" name="sex" value="2" required><span>女</span></td>
                <td class="rl_td_err"></td>
            </tr>
            <!--性别    E-->
            <!--身份证    S-->
            <tr height="35">
                <td class="rl_td_spn">身份证</td>
                <td class="rl_td_inp"><input class="rl_input" type="text" minlength="18" maxlength="18"
                                             placeholder="18个字符"
                                             name="identityCode" id="identityCode" value=""></td>
                <td class="rl_td_err"><span id="identityCode_msg"></span></td>
            </tr>
            <!--身份证    E-->
            <!--邮箱    S-->
            <tr height="35">
                <td class="rl_td_spn">邮箱</td>
                <td class="rl_td_inp"><input class="rl_input" type="email" name="email" maxlength="80"
                                             placeholder="最多80个字符" value="">
                </td>
                <td class="rl_td_err"></td>
            </tr>
            <!--邮箱    E-->
            <!--手机号    S-->
            <tr height="35">
                <td class="rl_td_spn">手机号</td>
                <td class="rl_td_inp"><input class="rl_input" type="text" minlength="11" maxlength="11" placeholder="11个数字"
                                             name="mobile" id="mobile" value="">
                </td>
                <td class="rl_td_err"><span id="mobile_msg"></span></td>
            </tr>
            <!--手机号    E-->
            <!--用户类型    S-->
            <tr height="35">
                <td class="rl_td_spn"><span style="color: #f00; ">*</span>&nbsp;用户类型</td>
                <td class="rl_td_inp"><input class="rl_radio" type="radio" name="type" value="1" checked
                                             required><span>买家</span>
                    <input class="rl_radio" type="radio" name="type" value="2" required><span>管理员</span></td>
                <td class="rl_td_err"></td>
            </tr>
            <!--用户类型    E-->
            <!--附选项    E-->
            <tr height="30" style="text-align: center">
                <td class="reg_chk_btn" colspan="2">
                    <input class="rl_btn" type="checkbox" id="chk_btn"><span style="color: #f00; ">同意条款规定</span></td>
                </td>
                <td></td>
            </tr>
            <!--附选项    E-->
            <!--递交按钮    S-->
            <tr height="60">
                <td class="rl_td_btn" colspan="2">
                    <input class="rl_btn" id="reg_btn" type="submit" value="注册">
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
    <script charset="utf-8" type="text/javascript">
        /**
         * 注册页面JQuery脚本
         * @author Kinlon
         * @version 1.0.0
         */
        $(function () {
            //S    同意条款
            //递交按钮初识化
            if ($(this).prop("checked")) {
                $("#reg_btn").prop("disabled", false);
            } else {
                $("#reg_btn").prop("disabled", true);
            }
            $("#chk_btn").click(function () {
                if ($(this).prop("checked")) {
                    $("#reg_btn").prop("disabled", false);
                } else {
                    $("#reg_btn").prop("disabled", true);
                }
            });
            //E    同意条款

            //S    身份证检测
            $("#identityCode").focus(function () {
                $("#identityCode_msg").text("");
            });
            $("#identityCode").blur(function () {
                var card = $(this).val().toLowerCase();
                var reg = /(^\d{18}$)|(^\d{17}(\d|x)$)/;
                if (reg.test(card) === false) {
                    $("#identityCode_msg").text("输入有误");
                } else {
                    $("#identityCode_msg").text("");
                }
            });
            //E    身份证检测

            //S    手机号检测
            $("#mobile").focus(function () {
                $("#mobile_msg").text("");
            });
            $("#mobile").blur(function () {
                var card = $(this).val().toLowerCase();
                var reg = /^\d{11}$/;
                if (reg.test(card) === false) {
                    $("#mobile_msg").text("输入有误");
                } else {
                    $("#mobile_msg").text("");
                }
            });
            //E    手机号检测

            //S    二次密码验证
            $("#password").focus(function () {
                $("#passwordRe_msg").text("");
            });
            $("#passwordRe").focus(function () {
                $("#passwordRe_msg").text("");
            });
            $("#passwordRe").blur(function () {
                //1.获取表单密码框的信息
                var $pwd = $(":password");
                //2.非空验证
                if ($pwd.eq(0).val().trim() === "" || $pwd.eq(1).val().trim() === "") {
                    //消息提示
                    $("#passwordRe_msg").text("密码为空");
                } else {
                    //3.密码加密并比较
                    var pwdE = MD5($pwd.eq(0).val().trim());
                    if (pwdE === MD5($pwd.eq(1).val().trim())) {
                        //写入加密后的密码
                        $("#passwordHide").val(pwdE);
                        console.log(pwdE);
                        $("#passwordRe_msg").text("");
                    } else {
                        //消息提示
                        $("#passwordRe_msg").text("密码不一致");
                        //重置密码框
                        $pwd.eq(0).val("");
                        $pwd.eq(1).val("");
                    }
                }
            });
            //E    二次密码验证
            //S    帐号存在性判断
            $("#loginName").focus(function () {
                $("#loginName_msg").text("");
            });

            $("#loginName").blur(function () {
                //1.获取用户名
                var loginName = $(this).val().trim();
                //2.使用JQuery异步交互
                $.ajax({
                    url: "url?obj=user&act=registCheckLoginName",
                    data: {"loginName": loginName},
                    dataType: "text",
                    type: "get",
                    success: function (data) {
                        //3.消息提示
                        var str;
                        switch (data) {
                            case "0":
                                str = "可以使用";
                                $("#loginNameHide").val($("#loginName").val());
                                break;
                            case "1":
                                str = "已经存在";
                                $("#loginNameHide").val("");
                                break;
                            default:
                                str = "检测异常";
                                $("#loginNameHide").val("");
                                break;
                        }
                        $("#loginName_msg").text(str);
                    }
                });
            });
            //E    帐号存在性判断

        });
    </script>
    <!--JQuery脚本    E-->
</div>
</body>
</html>
