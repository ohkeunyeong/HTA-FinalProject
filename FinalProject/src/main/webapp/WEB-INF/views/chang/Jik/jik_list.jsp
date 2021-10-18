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
<script src="../resources/js/chang/list2.js"></script>
  	<script>
	if('${result}'=='deleteSuccess'){
		alert("글 삭제 성공")
	}
	
	</script>
</head>
 <title>직거래 장터</title>
</head>
<body>
<br><br><br><br><br><br><br>
<div class="container">
<input type="hidden" id="Loginid" value="${id}" name="loginid">
<%-- 게시글이 있는 경우--%> 
<c:if test="${listcount > 0 }">
  <div class="rows">
  	<span>줄보기</span>
  	<select class="form-control" id="viewcount">
  		<option value="1">1</option>
  		<option value="3">3</option>
  		<option value="5">5</option>
  		<option value="7">7</option>
  		<option value="10" selected>10</option>
  	</select>
  </div>
  <table class="table table-striped">
   <thead>
	<tr>
	   <th colspan="3">직거래 장터</th>
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
	<c:forEach var="b" items="${jiklist}">
	<tr>
	  <td><%--번호 --%>
		<c:out value="${num}"/><%-- num 출력 --%>		
		<c:set var="num" value="${num-1}"/>	<%-- num=num-1; 의미--%>	
	  </td>
	  <td><%--제목 --%>
	     <div>			
			<a href="detail?num=${b.jik_num}&id=${b.jik_id}" >
				 <c:out value="${b.jik_subject}" escapeXml="true"/>  
			<span class="gray small">[<c:out value="${b.cnt}" />]</span>
			</a>
		  </div>
		</td>
		<td><div>${b.nick}</div></td>
		<td><div>${b.jik_date}</div></td>	
		<td><div>${b.jik_readcount}</div></td>
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
	<font size=5>등록된 글이 없습니다.</font>
</c:if>
<br>
          <form  method="get" action="" name="search">
             <div class="input-group">
 				<select name="searchType" id="searchType">
					<option value="0" selected>제목+내용</option>
					<option value="1">제목</option>
					<option value="2">내용</option>
					<option value="3">글쓴이</option>
                </select>
                <input type="text" placeholder="검색어를 입력해주세요." name="search" id="search">
                <input type="button" id="searchbtn" class="btn" value="검색">
              </div>
           </form>
<button type="button" class="btn btn-info float-right">글 쓰 기</button>
</div>
</body>
</html>