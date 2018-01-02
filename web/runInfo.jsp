<%--
  Created by IntelliJ IDEA.
  User: Kinlon
  Date: 2018/1/1
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>请求结果</title>
</head>
<body>
	<%
        String runInfo=(String)request.getAttribute("runInfo");
        out.println(runInfo);
    %>
</body>
</html>
