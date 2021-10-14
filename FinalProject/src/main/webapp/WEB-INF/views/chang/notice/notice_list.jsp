<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
 <jsp:include page="../../main/header.jsp" />
<style>
   select.form-control{
         width:auto;margin-bottom:2em;display:inline-block}
   .rows{text-align:right;}
   .gray{color:gray}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(1){width:8%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(2){width:50%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(3){width:14%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(4){width:17%}
   body > div > table > thead > tr:nth-child(2) > th:nth-child(5){width:11%}
a { color: #000; }
form{margin: 0 auto; width:80%; text-align: center}
select{
	color: #495057;
	background-color: #fff;
	background-clip: padding-box;
	border : 1px solid #ced4da;
	border-radius: .25rem;
	transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
	outline:none;
}
.input-group{ display : block;}
 </style>
  	<script>
	if('${result}'=='deleteSuccess'){
		alert("글 삭제 성공")
	}
	</script>
</head>
 <title>공지사항</title>
</head>
<body>
<br><br><br><br><br><br><br>
<div class="container">
<input type="hidden" id="Loginid" value="${id}" name="loginid">
<%-- 게시글이 있는 경우--%> 
<c:if test="${listcount > 0 }">
  <table class="table table-striped">
   <thead>
	<tr>
	   <th colspan="3">공지사항</th>
	   <th colspan="2">
			<font size=3>글 개수 : ${listcount}</font>
	   </th>
	</tr>
	<tr>
		<th><div>번호</div></th>
		<th><div>제목</div></th>
		<th><div>작성자</div></th>
		<th><div>날짜</div></th>
		<th><div>조회수</div></th>
	</tr>	
   </thead>
   <tbody>
	<c:set var="num" value="${listcount-(page-1)*limit}"/>	
	<c:forEach var="b" items="${noticelist}">	
	<tr>
	  <td><%--번호 --%>
		<c:out value="${num}"/><%-- num 출력 --%>		
		<c:set var="num" value="${num-1}"/>	<%-- num=num-1; 의미--%>	
	  </td>
	  <td><%--제목 --%>
	     <div>
			<a href="noticeDetail?num=${b.NOTICE_NUM}" >
			 <img src="../resources/image/chang/notice2.png" width="25px">
				 <c:out value="${b.NOTICE_SUBJECT}" escapeXml="true"/>  
			</a>
		  </div>
		</td>
		<td><div>운영자</div></td>
		<td><div>${b.NOTICE_DATE}</div></td>	
		<td><div>${b.NOTICE_READCOUNT}</div></td>
	   </tr>
	  </c:forEach>
	 </tbody>	
	</table>
		<br>
	<div class="center-block">
		  <ul class="pagination justify-content-center">		
			 <c:if test="${page <= 1 }">
				<li class="page-item">
				  <a class="page-link gray">이전&nbsp;</a>
				</li>
			 </c:if>
			 <c:if test="${page > 1 }">			
				<li class="page-item">
				   <a href="list?page=${page-1}" 
				      class="page-link">이전&nbsp;</a>
				</li> 
			 </c:if>
					
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page }">
					<li class="page-item " >
					   <a class="page-link gray">${a}</a>
					</li>
				</c:if>
				<c:if test="${a != page }">
				    <li class="page-item">
					   <a href="list?page=${a}" 
					      class="page-link">${a}</a>
				    </li>	
				</c:if>
			</c:forEach>
			
			<c:if test="${page >= maxpage }">
				<li class="page-item">
				   <a class="page-link gray">&nbsp;다음</a> 
				</li>
			</c:if>
			<c:if test="${page < maxpage }">
			  <li class="page-item">
				<a href="list?page=${page+1}" 
				   class="page-link">&nbsp;다음</a>
			  </li>	
			</c:if>
		 </ul>
		</div>
     </c:if><%-- <c:if test="${listcount > 0 }"> end --%>
	
<%-- 게시글이 없는 경우--%>
<c:if test="${listcount == 0 }">
	<font size=5>등록된 공지사항이 없습니다.</font>
</c:if>
<br>
</div>
</body>
</html>