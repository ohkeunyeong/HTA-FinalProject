<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케줄 관리</title>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
</head>
<body>
<jsp:include page="../main/header.jsp" /> 
<input type="hidden" id="id" value="${id}" name="id">
<div>농장명 : ${name}<br>
      아이디 : ${id}</div>
<h1>스케줄</h1>
    <div id='calendar'></div>
</body>
</html>
