<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Smile Case</title>
</head>
<body>
	<div>
		<p>에러 발생</p>
		<p><%= request.getAttribute("errorMsg") %></p>
		<a href="<%=request.getContextPath()%>">메인페이지로...</a>
	</div>
</body>
</html>