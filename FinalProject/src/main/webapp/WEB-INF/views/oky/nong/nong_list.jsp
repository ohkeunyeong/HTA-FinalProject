<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버게시판</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/nong_list.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/list.css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/nong_list.css"></link>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
 <script>
  var result="${result}";
  if(result =='deleteSuccess') {
	  alert("삭제 완료 되었습니니다.")
  }else if(result =='updateSuccess') {
	  alert("수정 완료 되었습니니다.")
  }
  
  $(document).ready(function () {  
		
	  $("#outmynong").click(function(){
	  	if(confirm("농장에서 탈퇴 하시겠습니까?")){
	  	}else {
	  		return false
	  	}	
	  })
	  });
 </script>
</head>
<body style="overflow-x:hidden; overflow-y:auto;">
<br><br>
<div class="wrapper">
<main>
<input type="hidden" id="id" value="${id}" name="id">
<input type="hidden" id="name" value="${name}" name="name">
<input type="hidden" id="path" value="${pageContext.request.contextPath}" name="path">

<div class="container1" role="main">

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
	  <td colspan=2 id="subject"><%--제목 --%>
	     <div>			
			<%-- 답변글 제목앞에 여백 처리 부분 
			      board_re_lev,  board_num, 
			      board_subject, board_name, board_date, 
			      board_readcount : property 이름 --%>
		    <c:if test="${b.nong_re_lev != 0}">  <!--  답글인 경우 -->
				<c:forEach var="a" begin="0" end="${b.nong_re_lev*2}" step="1">
				&nbsp; 	
				</c:forEach>		
 				<img src='${pageContext.request.contextPath}/resources/image/oky/line.gif'> 
			</c:if>  
			 
			<c:if test="${b.nong_re_lev == 0}">  <%-- 원문인 경우 --%>
				&nbsp;  
			</c:if> 			
			
			<a href="nongdetail?name=${name}&num=${b.nong_num}">
				 <c:out value="${b.nong_sub}" escapeXml="true" /> 
				 <span class="gray small">[<c:out value="${b.cnt}"/>]</span>
				<%-- ${b.nong_sub} --%>
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
				   <a href="nong?name=${name}&page=${page-1}" 
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
					   <a href="nong?name=${name}&page=${a}" 
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
				<a href="nong?name=${name}&page=${page+1}" 
				   class="page-link">&nbsp;다음</a>
			  </li>	
			</c:if>
		 </ul>
      <div class="btn-wrap">   
       <button type="button" id="write" onclick="location.href='nongwrite?name=${name}'" class="btn">글 쓰 기</button>  
      </div>
		</div>
	</div>
   </div>
     </c:if><%-- <c:if test="${listcount > 0 }"> end --%>
	
<%-- 게시글이 없는 경우--%>
<c:if test="${listcount == 0 }">
<div class="container">
	<font size=5>등록된 글이 없습니다.</font>
	<div class="btn-wrap">   
       <button type="button" id="write" onclick="location.href='nongwrite?name=${name}'" class="btn">글 쓰 기</button>  
      </div>
</div>
</c:if>
 </div>
 </main>
<sidebar>
   <!--  <div class="logo">logo</div> -->
    <div class="avatar">
      <div class="avatar__img">
        <img width="25" class="display" src="pdisplay?fileName=${user.original}">
      </div>
      <div class="avatar__name" style="color:black;">${user.nick} 님</div>
    </div>
    <nav class="menu">
      <a class="menu__item" href="${pageContext.request.contextPath}/calprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/calendar.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">캘린더</span>
      </a>
      <a class="menu__item" href="${pageContext.request.contextPath}/accprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/accounting.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">가계부</span>
      </a>    
      <a class="menu__item menu__item--active" href="${pageContext.request.contextPath}/nongprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/bbs.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">멤버게시판</span>
      </a>
      <a class="menu__item" href="${pageContext.request.contextPath}/mynongprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/setting.png" alt="by"/>
        <!-- <i class="menu__icon fa fa-envelope"></i> -->
      <span style="padding:0px 0px 0px 17px;" class="menu__text">농장관리</span>
      </a>
      <span id="outmynong">
      <a class="menu__item" href="${pageContext.request.contextPath}/outmynong?id=${id}"><span class="menu__text">농장탈퇴</span></a>
      </span>
    </nav>
  </sidebar>
  </div>         
</body>
</html>
