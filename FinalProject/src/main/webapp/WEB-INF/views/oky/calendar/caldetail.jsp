<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 상세보기</title>
<jsp:include page="../../main/header.jsp" /> 
<script>
$(function(){
	  $("#delete").click(function(){
		  var bool=true;
         if(confirm("삭제하시겠습니까?")){
        	 bool=true;
        	 location.href='calmuldel?name=${name}&seq=${calendar.seq}'; 
		  }else{
			 bool=false;
		  }
         return bool;
	  });

});
</script>
</head>
<body>
<br><br><br>
<jsp:useBean id="util" class="com.hta.project.controller.OkyCalendarController" />
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
             <c:if test="${level ==1}">
             <input type="button"  value="수정하기"  
             onclick="location.href='updateform?name=${name}&seq=${calendar.seq}'"/>
             <input id="delete" type="button"  value="삭제"/>
             </c:if>
             <input type="button"  value="목록"     onclick="location.href='calboardlist?name=${name}'"/>
             <input type="button"  value="달력"    
                     onclick="location.href='calendar?name=${name}&year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}'"/>
         </td>
    </tr>  
</table>
<jsp:include page="../../main/footer.jsp" /> 
</body>
</html>