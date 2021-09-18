<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
	<title>로그인 페이지</title>
</head>
<body>
<form action="/login" method="post">
	<sec:csrfInput/>
	<input type="text" name="id" placeholder="아이디" />
	<input type="password" name="password" placeholder="비밀번호" />
	<button>로그인</button>
</form>
</body>
</html>