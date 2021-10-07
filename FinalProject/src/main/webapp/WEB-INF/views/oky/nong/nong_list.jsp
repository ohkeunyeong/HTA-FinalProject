<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.hta.project.domain.MyCalendar"%>
<%@page import="java.util.List"%>
<%@page import="com.hta.project.controller.OkyCalendarController"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버게시판</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/list.css"></link>
<script>	
</script>
</head>
<body>
<jsp:include page="../../main/header.jsp" /> 
<input type="hidden" id="id" value="${id}" name="id">
농장명 : ${name} <br>
          아이디 : ${id}   <br>
 관리자 레벨 : ${level}   <br>
<div class="container1" role="main">
      
<%--     <h1>게시판</h1>
      넘어온 id는 ${id} <br>
      넘어온 startpage는 ${startpage} <br>
     넘어온 endpage는 ${endpage} <br>
     넘어온 maxpage는 ${maxpage}<br>
      넘어온 page는 ${page}<br><br> --%>

      <div class="page-title">
      

         <div class="container2">
         
            <h1>멤버게시판</h1>
         </div>
         </div>


      <div id="board-search">

         <div class="container2">
                 
            <div class="search-window">
               <form  method="get" action="" name="search">
                  <div class="search-wrap">
 
                        <input type="text" placeholder="검색어를 입력해주세요." name="search"
                           id="search">
                     <br> <select name="searchType" id="searchType">
				<option value="subAcon">제목+내용</option>
				<option value="subject">제목</option>
				<option value="content">내용</option>
				<option value="writer">글쓴이</option>
                     </select>
                     <div class="btn-wrap">
                        <input type="button" id="searchbtn" class="btn" value="검색">
                     </div>
                  </div>
               </form>
            </div>
         </div>
      </div>


<%-- 게시글이 있는 경우--%> 
<c:if test="${listcount > 0 }">


       <!-- board list area -->
      <div id="board-list">

         <div class="container">
            <table class="board-table">
               <thead>
	<tr>
	   <th>
         <div class="rows" >
           <select class="form-control" id="view" style="width:100px;">
             <option value="1" selected>최신순</option>
             <option value="2">등록순</option>
             <option value="3">조회순</option>                     
           </select>
         </div>	   
	   </th>
	       <th colspan=4></th>
	   <th>
			<font size=3>글 개수 : ${listcount}</font>
	   </th>
	</tr>               
                  <tr>
                     <th scope="col" class="th-num">번호</th>
                     <th colspan=2 scope="col" class="th-date">제목</th>
                     <th scope="col" class="th-date">작성자</th>
                     <th scope="col" class="th-date">날짜</th>
                     <th scope="col" class="th-date">조회수</th>
                  </tr>
               </thead>
               <tbody>
                   <c:set var="num" value="${listcount-(page-1)*limit}" />
                  <c:forEach var="b" items="${boardlist}">
	<tr>
	  <td><%--번호 --%>
		<c:out value="${num}"/><%-- num 출력 --%>		
		<c:set var="num" value="${num-1}"/>	<%-- num=num-1; 의미--%>	
	  </td> 
	  <td colspan=2><%--제목 --%>
	     <div>			
			<%-- 답변글 제목앞에 여백 처리 부분 
			      board_re_lev,  board_num, 
			      board_subject, board_name, board_date, 
			      board_readcount : property 이름 --%>
		    <c:if test="${b.nong_re_lev != 0}">  <!--  답글인 경우 -->
				<c:forEach var="a" begin="0" end="${b.nong_re_lev*2}" step="1">
				&nbsp; 	
				</c:forEach>		
<!-- 				<img src='image/line.gif'> -->
			</c:if>  
			 
			<c:if test="${b.nong_re_lev == 0}">  <%-- 원문인 경우 --%>
				&nbsp;  
			</c:if> 			
			
			<a href="FreeboardDetailAction.okybo?num=${b.nong_num}">
				 <c:out value="${b.nong_sub}" />  
				<%-- ${b.board_subject} --%>
				<%-- escapeXml="true" : HTML 태그를 화면에 그대로 보여줍니다. --%>	
			</a>
		  </div>
		</td>
		<td><div>${b.id}</div></td>
		<td><div>${b.nong_date}</div></td>	
		<td><div>${b.nong_read}</div></td>
	   </tr>
	  </c:forEach> 
	 </tbody>	
	</table>
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
      <div class="btn-wrap">   
       <button type="button" id="write" class="btn btn-light btn-sm">글 쓰 기</button>  
      </div>
		</div>
	</div>
   </div>
     </c:if><%-- <c:if test="${listcount > 0 }"> end --%>
	
<%-- 게시글이 없는 경우--%>
<c:if test="${listcount == 0 }">
	<font size=5>등록된 글이 없습니다.</font>
</c:if>

 </div>
</body>
</html>
