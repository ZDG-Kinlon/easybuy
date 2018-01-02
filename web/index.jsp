<%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/2
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Title</title>
</head>
<body>
	<table class="rl_table" border="0" cellspacing="0" cellpadding="0">
		<tbody>
			<!--页面跳转导航    S-->
			<tr>
				<td colspan="3"><span><a
						href="<%=request.getContextPath()%>/login.jsp">帐号登录</a>&nbsp;&nbsp;<a
						href="<%=request.getContextPath()%>/regist.jsp">帐号注册</a></span></td>
			</tr>
			<!--页面跳转导航    E-->
		</tbody>
	</table>
</body>
</html>
