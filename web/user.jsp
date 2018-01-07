<%@ page import="com.emy.entity.User" %>
<%@ page import="com.emy.entity.UserAddress" %>
<%@ page import="java.util.List" %>
<%@ page import="com.emy.dao.user.UserAddressDao" %>
<%@ page import="com.emy.dao.user.impl.UserAddressDaoImpl" %>
<%@ page import="com.emy.dao.user.UserDao" %>
<%@ page import="com.emy.dao.user.impl.UserDaoImpl" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/3
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="ui-widget">
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
    <title>::易买网::用户中心</title>
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
            user = userD;
            session.setAttribute("user", userD);
        }
    } else {
        user = new User();
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>
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
            <%
                if (user.getType() == 2) {
            %>
            <button onclick="window.location.href='<%=request.getContextPath()%>/manager.jsp';" style="margin: 5px;"
                    class="ui-button ui-corner-all ui-widget">管理中心
            </button>
            <%
                }
            %>
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
        <li><a href="#tabs_user-1">用户信息</a></li>
        <li><a href="#tabs_user-2">收货地址</a></li>
        <li><a href="#tabs_user-3">购物车</a></li>
        <li><a href="#tabs_user-4">订单管理</a></li>
    </ul>
    <div id="tabs_user-1">
        <!-- 用户信息    开始 -->
        <table border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <tr>
                <td>
                    <button id="opener_setUser" onclick="openDialog('#dialog_setUser',400,320)"
                            class="ui-button ui-corner-all ui-widget" style="margin: 5px;">修改
                    </button>
                    <!-- 修改用户信息    开始 -->
                    <div id="dialog_setUser" title="修改用户信息" style="display: none">
                        <form action="<%=request.getContextPath()%>/url" method="post">
                            <input type="hidden" name="obj" value="user"/>
                            <input type="hidden" name="act" value="setUser"/>
                            <table class="rl_table" border="0" cellspacing="0" cellpadding="0">
                                <tbody>
                                <!--新密码    S-->
                                <tr height="35">
                                    <td class="rl_td_spn">新密码</td>
                                    <td class="rl_td_inp"><input
                                            class="rl_input text ui-widget-content ui-corner-all" type="password"
                                            id="password" value=""><input
                                            type="hidden" name="passwordNew" id="passwordNewHide" value="">
                                    </td>
                                    <td class="rl_td_err"><span id="passwordNew_msg"></span></td>
                                </tr>
                                <!--新密码    E-->
                                <!--姓名    S-->
                                <tr height="35">
                                    <td class="rl_td_spn">姓名</td>
                                    <td class="rl_td_inp"><input
                                            class="rl_input text ui-widget-content ui-corner-all" type="text"
                                            name="userName" maxlength="20" placeholder="最多20个字符"
                                            value="<%=user.getUserName()%>" required></td>
                                    <td class="rl_td_err"></td>
                                </tr>
                                <!--姓名    E-->
                                <!--性别    S-->
                                <tr height="35">
                                    <td class="rl_td_spn">性别</td>
                                    <td class="rl_td_inp"><input
                                            class="rl_radio" type="radio" name="sex"
                                            value="1" <%if(user.getSex()==1)out.print("checked");%>><span>男</span><input
                                            class="rl_radio" type="radio" name="sex"
                                            value="2" <%if(user.getSex()==2)out.print("checked");%>><span>女</span></td>
                                    <td class="rl_td_err"></td>
                                </tr>
                                <!--性别    E-->
                                <!--身份证    S-->
                                <tr height="35">
                                    <td class="rl_td_spn">身份证</td>
                                    <td class="rl_td_inp"><input
                                            class="rl_input text ui-widget-content ui-corner-all" type="text"
                                            minlength="18"
                                            maxlength="18" placeholder="18个字符" name="identityCode" id="identityCode"
                                            value="<%=user.getIdentityCode()%>">
                                    </td>
                                    <td class="rl_td_err"><span id="identityCode_msg"></span></td>
                                </tr>
                                <!--身份证    E-->
                                <!--邮箱    S-->
                                <tr height="35">
                                    <td class="rl_td_spn">邮箱</td>
                                    <td class="rl_td_inp"><input class="rl_input text ui-widget-content ui-corner-all"
                                                                 type="email"
                                                                 name="email"
                                                                 maxlength="80"
                                                                 placeholder="最多80个字符" value="<%=user.getEmail()%>">
                                    </td>
                                    <td class="rl_td_err"></td>
                                </tr>
                                <!--邮箱    E-->
                                <!--手机号    S-->
                                <tr height="35">
                                    <td class="rl_td_spn">手机号</td>
                                    <td class="rl_td_inp"><input class="rl_input text ui-widget-content ui-corner-all"
                                                                 type="text"
                                                                 minlength="11"
                                                                 maxlength="11"
                                                                 placeholder="11个数字"
                                                                 name="mobile" id="mobile"
                                                                 value="<%=user.getMobile()%>">
                                    </td>
                                    <td class="rl_td_err"><span id="mobile_msg"></span></td>
                                </tr>
                                <!--手机号    E-->
                                <!--用户类型    S-->
                                <tr height="35">
                                    <td class="rl_td_spn">用户类型</td>
                                    <td class="rl_td_inp"><input
                                            class="rl_radio" type="radio" name="type"
                                            value="1" <%if(user.getType()==1)out.print("checked");%>><span>买家</span>
                                        <input class="rl_radio" type="radio" name="type"
                                               value="2" <%if(user.getType()==2)out.print("checked");%>><span>管理员</span>
                                    </td>
                                    <td class="rl_td_err"></td>
                                </tr>
                                <!--用户类型    E-->
                                <!--递交按钮    S-->
                                <tr height="60">
                                    <td class="rl_td_btn" colspan="2">
                                        <input class="rl_btn ui-button ui-corner-all ui-widget" id="reg_btn"
                                               type="submit" value="递交修改">
                                    </td>
                                    <td></td>
                                </tr>
                                <!--递交按钮    E-->
                                </tbody>
                            </table>
                        </form>
                    </div>
                    <!-- 修改用户信息    结束 -->
                </td>
            </tr>
            </tbody>
        </table>
        <table border="1" cellspacing="0" cellpadding="0">
            <tbody>
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
                    <span>帐号类型</span>
                </td>
                <td>
            <span>
                 <%
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
        <!-- 用户信息    结束 -->
    </div>
    <div id="tabs_user-2">
        <!-- 收货地址    开始 -->
        <table border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <tr>
                <td>
                    <button id="opener_addAddress" onclick="openDialog('#dialog_addAddress',250,130);"
                            class="ui-button ui-corner-all ui-widget" style="margin: 5px;">
                        添加收货地址
                    </button>
                    <!-- S    添加收货地址-->
                    <div id="dialog_addAddress" title="添加收货地址" style="display: none">
                        <form action="<%=request.getContextPath()%>/url" method="post">
                            <input type="hidden" name="obj" value="address">
                            <input type="hidden" name="act" value="addAddress">
                            <table>
                                <tbody>
                                <!--增加地址    开始-->
                                <tr height="35">
                                    <td>
                                        <span><span style="color: #f00;">*</span>&nbsp;地址：</span>
                                    </td>
                                    <td>
                <span><input type="text" name="address" id="address" class="text ui-widget-content ui-corner-all"
                             placeholder="最多20个字符"
                             required
                             maxlength="20"/></span>
                                    </td>
                                </tr>
                                <tr height="35">
                                    <td>
                                        <span>备注：</span>
                                    </td>
                                    <td>
                                <span><input
                                        type="text" name="remark" id="remark"
                                        class="text ui-widget-content ui-corner-all" placeholder="最多20个字符"
                                        maxlength="18"/></span>
                                    </td>
                                </tr>
                                <tr height="35">
                                    <td>
                                        <span><input
                                                type="submit" value="添加地址"
                                                class="ui-button ui-corner-all ui-widget"></span>
                                    </td>
                                </tr>
                                <!--增加地址    结束-->
                                </tbody>
                            </table>
                        </form>
                    </div>
                    <!-- E    添加收货地址-->
                </td>
            </tr>
            </tbody>
        </table>
        <table border="1" cellspacing="0" cellpadding="0">
            <tbody>
            <!--标题    开始-->
            <tr>
                <td align="center">
                    <span>创建时间</span>
                </td>
                <td align="center">
                    <span>地址</span>
                </td>
                <td align="center">
                    <span>备注</span>
                </td>
                <td align="center">
                    <span>操作</span>
                </td>
            </tr>
            <!--标题    结束-->
            <!--地址信息    开始-->
            <%
                UserAddressDao userAddressDao = new UserAddressDaoImpl();
                List<UserAddress> userAddressList = userAddressDao.getByField("userId", String.valueOf(user.getId()));
                int n = userAddressList.size();
                if (n > 0) {
                    for (UserAddress userAddress : userAddressList) {
            %>
            <tr>
                <td>
                    <span><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userAddress.getCreateTime())%></span>
                </td>
                <td>
                    <span><%=userAddress.getAddress()%></span>
                </td>
                <td>
                    <span><%=userAddress.getRemark()%></span>
                </td>
                <td align="right">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <% if (userAddress.getIsDefault() != 2) { %>
                            <td>
                                <form action="<%=request.getContextPath()%>/url" method="post" style="margin: 5px;">
                                    <input type="hidden" name="obj" value="address">
                                    <input type="hidden" name="act" value="setDefaultAddress">
                                    <input type="hidden" name="addressId" value="<%=userAddress.getId()%>">
                                    <input type="submit" value="设为默认" class="ui-button ui-corner-all ui-widget">
                                </form>
                            </td>
                            <% } else { %>
                            <td>
                                <form action="#" method="post" style="float: left;padding: 5px;">
                                    <input type="submit" value="设为默认"
                                           class="ui-button ui-corner-all ui-widget ui-state-disabled">
                                </form>
                            </td>
                            <% } %>
                            <td>
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tbody>
                                    <tr>
                                        <td>
                                            <button id="opener_setAddress"
                                                    onclick="openDialog('#dialog_setAddress_<%=userAddress.getId()%>',350,200);"
                                                    class="ui-button ui-corner-all ui-widget" style="margin: 5px;">
                                                修改地址
                                            </button>
                                            <div id="dialog_setAddress_<%=userAddress.getId()%>" title="修改收货地址"
                                                 style="display: none">
                                                <form action="<%=request.getContextPath()%>/url" method="post">
                                                    <input type="hidden" name="obj" value="address">
                                                    <input type="hidden" name="act" value="setAddress">
                                                    <input type="hidden" name="addressId"
                                                           value="<%=userAddress.getId()%>">
                                                    <table class="rl_table" border="0" cellspacing="0" cellpadding="0">
                                                        <tbody>
                                                        <!--修改地址    开始-->
                                                        <tr height="35">
                                                            <td class="rl_td_spn">
                                                                <span><span
                                                                        style="color: #f00;">*</span>&nbsp;收货地址：</span>
                                                            </td>
                                                            <td class="rl_td_inp">
                                                                <span><input type="text" name="address"
                                                                             placeholder="最多20个字符" required
                                                                             class="text ui-widget-content ui-corner-all"
                                                                             maxlength="20"
                                                                             value="<%=userAddress.getAddress()%>"/></span>
                                                            </td>
                                                        </tr>
                                                        <tr height="35">
                                                            <td class="rl_td_spn">
                                                                <span>备注：</span>
                                                            </td>
                                                            <td class="rl_td_inp">
                                                                <span><input type="text" name="remark"
                                                                             placeholder="最多18个字符" maxlength="18"
                                                                             class="text ui-widget-content ui-corner-all"
                                                                             value="<%=userAddress.getRemark()%>"/></span>
                                                            </td>
                                                        </tr>
                                                        <tr height="60">
                                                            <td colspan="2" class="rl_td_btn">
                                                                <span><input
                                                                        class="rl_btn ui-button ui-corner-all ui-widget"
                                                                        type="submit" value="修改地址"></span>
                                                            </td>
                                                        </tr>
                                                        <!--修改地址    结束-->
                                                        </tbody>
                                                    </table>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td>
                                <form action="<%=request.getContextPath()%>/url" method="post" style="margin: 5px;">
                                    <input type="hidden" name="obj" value="address">
                                    <input type="hidden" name="act" value="deleteAddress">
                                    <input type="hidden" name="addressId" value="<%=userAddress.getId()%>">
                                    <input type="submit" value="删除地址" class="ui-button ui-corner-all ui-widget">
                                </form>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr><% } }%><!--地址信息    结束-->
            </tbody>
        </table>
        <!-- 收货地址    结束 -->
    </div>
    <div id="tabs_user-3">
        <p>购物车，施工中...</p>
    </div>
    <div id="tabs_user-4">
        <p>订单管理，施工中...</p>
    </div>
</div>
<!--标签集    结束-->


<!--JQuery脚本    开始-->
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="js/md5.js"></script>
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
<!-- S    修改用户信息验证-->
<script>
    $(function () {
        //S    密码加密填入隐藏域
        var $password = $("#password");
        $password.focus(function () {
            $("#passwordNewHide").val("");
        });
        $password.blur(function () {
            $("#passwordNewHide").val(MD5($(this).val()));
        });
        //E    密码加密填入隐藏域
        //S    身份证检测
        var $identityCode = $("#identityCode");
        $identityCode.focus(function () {
            $("#identityCode_msg").text("");
        });
        $identityCode.blur(function () {
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
        var $mobile = $("#mobile");
        $mobile.focus(function () {
            $("#mobile_msg").text("");
        });
        $mobile.blur(function () {
            var card = $(this).val().toLowerCase();
            var reg = /^\d{11}$/;
            if (reg.test(card) === false) {
                $("#mobile_msg").text("输入有误");
            } else {
                $("#mobile_msg").text("");
            }
        });
        //E    手机号检测

    });
</script>
<!-- E    修改用户信息验证-->
<!--JQuery脚本    结束-->
</body>
</html>
