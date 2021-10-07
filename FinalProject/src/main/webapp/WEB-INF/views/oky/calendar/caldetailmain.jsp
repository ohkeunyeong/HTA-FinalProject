<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 상세보기</title>
<jsp:include page="../../main/header.jsp" /> 
<jsp:useBean id="util" class="com.hta.project.controller.OkyCalendarController" />
<script>
function page_back(){
	history.go(-1);
}
</script>
</head>
<body>
<br><br><br>
<h1>일정상세보기</h1>
<table border="1">

    <tr>
         <th>일정</th>
         <td>
             <jsp:setProperty value="${calendar.mdate}" property="toDates" name="util"/>
             <jsp:getProperty property="toDates" name="util"/>
         </td>
    </tr>    
    <tr>
         <th>제목</th>
         <td>${calendar.title}</td>
    </tr>    
    <tr>
         <th>내용</th>
         <td><textarea rows="10" cols="60" readonly="readonly">${calendar.content}</textarea></td>
    </tr> 
    <tr>
         <td colspan="2">
            <input type="button"  value="돌아가기" onclick="page_back();"/>
         </td>
    </tr>  
</table>
</body>
</html>