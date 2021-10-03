<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
</head>
<script>

</script>
<style>
* {
	font-family: Arial, sans;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
}
h1, h2 {
	margin: 1em 0 0 0;
	text-align: center;
}
h2 {
	margin: 0 0 1em 0;
}
#container {
    margin: 0 auto;
    width: 50%;
}
#accordion input {
	display: none;
}
#accordion label {
	background: #eee;
	border-radius: .25em;
	cursor: pointer;
	display: block;
	margin-bottom: .125em;
	padding: .25em 1em;
	z-index: 20;
}
#accordion label:hover {
	background: #ccc;
}

#accordion input:checked + label {
	background: #ccc;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
	color: white;
	margin-bottom: 0;
}
#accordion article {
	background: #f7f7f7;
	height:0px;
	overflow:hidden;
	z-index:10;
}
#accordion article p {
	padding: 1em;
}
#accordion input:checked article {
}
#accordion input:checked ~ article {
	border-bottom-left-radius: .25em;
	border-bottom-right-radius: .25em;
	height: auto;
	margin-bottom: .125em;
}

#pen{
width: 15px; height: 15px;
} /* 연필그림 사이즈*/
</style>
<body>
<jsp:include page="../../main/header.jsp" /> 
<input type="hidden" id="id" value="${id}" name="id">

<div>농장명 : ${name} <br>
          아이디 : ${id}   <br>
 관리자 레벨 : ${level}   <br>
          연도 : ${year}   <br>
          월    : ${month}   <br>      
     요일 :    ${dayofweek}  <br>  
</div>
	<div id="container">
		<section id="accordion">
		<a href="account?name=${name}&year=${year-1}&month=${month}">◁</a>
        <a href="account?name=${name}&year=${year}&month=${month-1}">◀</a>
        <span class="y">
        ${year}
        </span>년
        <span class="m">
        ${month}
        </span>월 
        <a href="account?name=${name}&year=${year}&month=${month+1}">▶</a>
        <a href="account?name=${name}&year=${year+1}&month=${month}">▷</a>   
		<h3>${year}년 ${month} 월</h3>
		<c:set var="num" value="${1}"/>
		<c:set var="yoil" value="${dayofweek}"/>
		<c:forEach var="a" begin="1" end="${lastday}">
			<div>
				<input type="checkbox" id="${num}" />
				<label for="${num}" id="date">${month} 월  <c:out value="${num}"/> 일
				<c:if test="${yoil ==1 }">
	                        일요일
		        </c:if>
	            <c:if test="${yoil ==2 }">
	                        월요일
		        </c:if>
	            <c:if test="${yoil ==3 }">
	                        화요일
		        </c:if>	
	            <c:if test="${yoil ==4 }">
	                        수요일
		        </c:if>
	            <c:if test="${yoil ==5 }">
	                        목요일
		        </c:if>
		        <c:if test="${yoil ==6 }">
	                        금요일
		        </c:if>
		        <c:if test="${yoil ==0 ||yoil ==7 }">
	                        토요일
		        </c:if>   
		        <c:if test="${level ==1}">
		        <a href="#" data-toggle="modal"  data-target="#addacc" id="addacc">
     	     	<img id="pen" src="${pageContext.request.contextPath}/resources/image/oky/pen.png" alt="가계부추가"/>
            	</a>
            	</c:if>          				
				</label>
				<article>
		                   <p>${num}</p>
				</article>
		        <c:set var="num" value="${num+1}"/>	<%-- num=num+1; 의미--%>	
		        <c:set var="yoil" value="${(yoil + 1)%7}"/>
			</div>
			</c:forEach>
		</section>
  </div>

  <div class="modal fade" id="addacc" role="dialog"> <!-- 사용자 지정 부분① : date명 -->

    <div class="modal-dialog">
   
      <!-- Modal content-->

      <div class="modal-content">

        <div class="modal-header">

          <button type="button" class="close" data-dismiss="modal" >×</button>

          <h4 class="modal-title" align="center">아이디 중복 확인</h4> <!-- 사용자 지정 부분② : 타이틀 -->

        </div>

        <div class="modal-body">
                   <form id="my-form">
                   <input type ="text" name="idck" id="idck" placeholder="아이디 입력">            
                   <button type="button" id="search" class="searchid" >검색</button><br>
                   <span id="message"></span>
                   </form>
        </div>
      <!-- 사용자 지정 부분③ : 텍스트 메시지 -->

        </div>

        <div class="modal-footer">
        <button type="button"  id="okuse"  data-dismiss="modal">사용하기</button><br>

        </div>

      </div>

    </div>

</body>
</html>
