<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.hta.project.domain.MyCalendar"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정목록보기</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script>
  function allSel(val){
	  
	  var chks=document.getElementsByName("seq");
	  for(var i=0; i<chks.length; i++){
		  chks[i].checked=val;
	  }
	  
  }
  
  $(function(){
	  $("form").submit(function(){
		  var bool=true;
		  var count=$(this).find("input[name=seq]:checked").length;
		  if(count==0){
			  alert('하나 이상 체크하세요');
			  bool=false;			  
		  }else if(confirm("삭제하시겠습니까?")){
			  bool=true;
		  }else{
			  bool=false;
		  }
		  return bool;
	  });
	  
	  //체크박스 처리: 전체선택 체크박스 체크/해제를 자동으로 하는 기능
	  var chks=document.getElementsByName("seq");
	  for(var i=0; i<chks.length; i++){
		  chks[i].onclick = function(){//체크박스 클릭 이벤트 시
			  var checkedObjs=document.querySelectorAll("input[name=seq]:checked");
		  	  if(checkedObjs.length==chks.length){
		  		document.getElementsByName("all")[0].checked=true;//체크해줌
		  	  }else{
		  		document.getElementsByName("all")[0].checked=false;//체크해줌  
		  	  }			  
		   }
		}
  })
</script>
</head>
<%
    List<MyCalendar> list = (List<MyCalendar>)request.getAttribute("list");
%>
<body>
<br><br><br>
<input type="hidden" id="id" value="${id}" name="id">
<h1>일정목록보기</h1>
<form action="calmuldel" method="post">
<input type="hidden" name="name" value="${name}"/>
<input type="hidden" name="year" value="${param.year}">
<input type="hidden" name="month" value="${param.month}">
<input type="hidden" name="date" value="${param.date}">
<table border="1">
     <col width="50px">
     <col width="300px">
     <col width="250px">
     <col width="250px">
     <tr>
     <c:if test="${level ==1}">
         <th><input type="checkbox" name="all" onclick="allSel(this.checked)" /></th>
     </c:if>
         <th>제목</th>
         <th>일정</th>
         <th>작성일</th>
     </tr>
     <%
        if(list==null || list.size()==0) {
        	out.print("<tr><td colspan='4'>---작성된 일정이 없습니다.---</td></tr>");
        }else {
        	for(MyCalendar dao:list) {
        		%>
        		<tr>
        		    <c:if test="${level ==1}">
        		    <td><input type="checkbox" name="seq" value="<%=dao.getSeq()%>"/></td>
        		    </c:if>
        		    <td><a href="caldetail?name=${name}&seq=<%=dao.getSeq()%>"><%=dao.getTitle()%></a></td>
        		    <td><%=toDates(dao.getMdate())%></td>
        		    <td><fmt:formatDate pattern="yyyy-MM-dd" value="<%=dao.getRegdate()%>"/> </td>
        		</tr>
        		<% 
        	}
        }
     %>
     <tr>
         <td colspan="4">
         <c:if test="${level ==1}">
         	 <input type="submit" value="삭제" />
         </c:if>
             <a href="calendar?name=${name}&year=${sessionScope.ymd.year}&month=${sessionScope.ymd.month}">달력보기</a>
         </td>
</table>
</form>
<jsp:include page="../../main/footer.jsp" /> 
</body>
<%!
	public String toDates(String mdate){
	
		//문자열--->date타입으로 변환--> 문자열을 데이트패턴으로 수정 --> 데이트다입으로 변환
		
		//날짜형식: yyyy-MM-dd hh:mm:ss
		String m=mdate.substring(0, 4)  + "-"
		  		+mdate.substring(4, 6)  + "-"
		  		+mdate.substring(6, 8)  + " "		  		
		  		+mdate.substring(8, 10)  + ":"	
		  		+mdate.substring(10)  + ":00";	
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		Timestamp tm=Timestamp.valueOf(m);//문자열을 Date타입으로 변환
	  	return sdf.format(tm);
}
%>
</html>