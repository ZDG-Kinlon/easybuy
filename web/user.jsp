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
<!-- 导航链接    开始 -->
<body>
<table border="0" cellspacing="0" cellpadding="0">
    <tbody>
    <tr>
        <td><a href="<%=request.getContextPath()%>/index.jsp">【返回首页】</a>&nbsp;&nbsp;
        </td>
        <%
            if (user.getType() == 2) {
        %>
        <td>
            <a href="<%=request.getContextPath()%>/manager.jsp">【进入管理中心】</a>&nbsp;&nbsp;
        </td>
        <%
            }
        %>
    </tr>
    </tbody>
</table>
<br/>
<!-- 导航链接    结束 -->
<!-- 用户信息    开始 -->
<table border="1" cellspacing="0" cellpadding="0">
    <thead>
    <td colspan="2" align="center">
        <span>====用户信息====</span>
    </td>
    </thead>
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
        <td colspan="2" align="center">
            <span><a
                    href="<%=request.getContextPath()%>/url?obj=user&act=logout">【退出】</a><a
                    href="<%=request.getContextPath()%>/setUser.jsp">【修改以下信息】</a>
            </span>
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
<br/>
<!-- 用户信息    结束 -->
<!-- 收货地址    开始 -->
<table border="1" cellspacing="0" cellpadding="0">
    <thead>
    <tr>
        <td colspan="4" align="center">
            <span>====收货地址====</span>
        </td>
    </tr>
    </thead>
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
            <span>操作&nbsp;&nbsp;<button id="opener_address"
                                        class="ui-button ui-corner-all ui-widget">添加收货地址</button></span>
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
            <span><%
                if (userAddress.getIsDefault() != 2) {
            %><a href="<%=request.getContextPath()%>/url?obj=address&act=setDefaultAddress&addressId=<%=userAddress.getId()%>">【设为默认】</a>&nbsp;&nbsp;<%
            } else {
            %>（默认地址）&nbsp;&nbsp;<%
                }
            %><a href="<%=request.getContextPath()%>/url?obj=address&act=getAddressById&addressId=<%=userAddress.getId()%>">【修改】</a>&nbsp;&nbsp;<a
                    href="<%=request.getContextPath()%>/url?obj=address&act=deleteAddress&addressId=<%=userAddress.getId()%>">【删除】</a></span>
        </td>
    </tr>
    <%
             }
        }
    %><!--地址信息    结束-->
    </tbody>
</table>
<div id="dialog_address" title="添加收货地址">
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
                <span><input type="text" name="address" id="address" class="ui-autocomplete-input" placeholder="最多20个字符"
                             required
                             maxlength="20"/></span>
                </td>
            </tr>
            <tr height="35">
                <td>
                    <span>备注：</span>
                </td>
                <td>
                                <span><input type="text" name="remark" id="remark" class="ui-autocomplete-input"
                                             placeholder="最多20个字符"
                                             maxlength="18"/></span>
                </td>
            </tr>
            <tr height="35">
                <td>
                    <span><input type="submit" value="添加地址" class="ui-button ui-corner-all ui-widget"></span>
                </td>
            </tr>
            <!--增加地址    结束-->
            </tbody>
        </table>
    </form>
</div>
<br/>
<!-- 收货地址    结束 -->


<!--JQuery脚本    开始-->
<script src="js/jquery-3.2.1.js"></script>
<script src="js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<!-- S    收货地址增加-->
<script>
    $(function () {
        $("#dialog_address").dialog({
            autoOpen: false,
            resizable: false,
            height: 130,
            width: 250,
            show: {
                effect: "fade",
                duration: 1000
            },
            hide: {
                effect: "explode",
                duration: 1000
            }
        });

        $("#opener_address").click(function () {
            $("#dialog_address").dialog("open");
        });
    });
</script>
<!-- E    收货地址增加-->
<!--JQuery脚本    结束-->


</body>
</html>
