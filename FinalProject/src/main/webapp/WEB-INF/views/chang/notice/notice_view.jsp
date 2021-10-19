<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>MVC 게시판 - view</title>
 <jsp:include page="../../main/header.jsp" />
  <script src="../resources/js/jquery-3.6.0.min.js"></script>
 <link rel="stylesheet" href="../resources/css/chang/view.css">
</head>
<body>
  <input type="hidden" id="Loginid" value="${id}" name="loginid">
  <input type="hidden" id="Loginnick" value="${nick}" name="Loginnick">
  <br><br><br><br><br><br><br><br><br><br>
  

  <div class="container">
 	<table class="table table-striped">
 		<tr>
 			<th colspan="2">공지사항</th></tr>
 		<tr>
 			
 			<td colspan="2">
 				<div id="nick"> 
 					<img  src="${pageContext.request.contextPath}/resources/image/chang/farmer.png" alt="프로필 사진" width="40px">&nbsp;&nbsp;운영자
 				</div>
 			</td>
 		</tr>
 		<tr>
 			<td colspan="2"><c:out value="${notice.NOTICE_SUBJECT}" /></td>
 		</tr>
 		<tr>
 			<td colspan="2" style="padding-right:0px"><textarea class="form-control" rows="5"
 				readOnly >${notice.NOTICE_CONTENT}</textarea></td>
 		</tr>
 		<tr/>
 		
 	<tr>
 		<td colspan="2" rowspan="5" class="center">
 			<a href="noticeList">
 				<button class="btn btn-secondary">목록으로 돌아가기</button>
 			</a>
 		</td>
 	</tr>
 	</table>

  </div><!-- class="container" -->

</body>
</html>