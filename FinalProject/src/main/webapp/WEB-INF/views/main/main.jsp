<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 농장 메인</title>

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<jsp:include page="header.jsp" />  
<script>
//oky 로그인시 농장 가입 받았을때 팝업 띄우기
	$(function(){
		if('${invite}' == '3'){
			window.open("${pageContext.request.contextPath}/member/invite", "window_name","width=480,height=230,location=no,status=no,scrollbars=yes");
		}	
	});
</script>
<style>
h2{
font-weight:bold;
color:MediumSeaGreen;
padding-left:5%
}

h6{
padding-left:90%
}
/* 고객센터 / 공지사항 버튼 */

.a{
width:100%
}

.a .button {
  text-align:left;
  height:170px;
  background-color:#94b8b8; 
  border: none; 
  padding: 40px 60px 20px 30px;
  cursor: pointer;
  float: left;
  color: white; 
  font-size:20px;
  width : 50%;
}

.btn-group p{
  font-size:16px;
  font-style:regular;
  padding-top:4px;
}

/* Clear floats (clearfix hack) */
.btn-group:after {
  content: "";
  clear: both;
  display: table;
}

.btn-group .button:not(:last-child) {
  border-right: none;
}

.btn-group .button:hover {
  background-color:#75a3a3;
  text-decoration:none; 
}/* text-decoration:none; hover시 하얀 밑줄 생기는거 없앰 */
</style>
</head>
<body>
<br><br>
<div class="container justify-content-center">
		<img src="${pageContext.request.contextPath}/resources/image/farm2.png" alt="Logo" style="height: 400px; margin-bottom: 30px; margin-left:25%">
	</div>
	<!--  <a href='https://www.freepik.com/vectors/water'>Water vector created by upklyak - www.freepik.com</a> -->
	
	
<div class="container">

  <h2>직거래 장터</h2>
  <span><h5 style="padding-left:5%">장터의 글을 확인해요</h5>
  <h6><a href="${pageContext.request.contextPath}/jik/list">더보기</a></h6></span>
   
<div class="row" style="margin:20px 20px 50px 20px">

<c:set var="num" value="${listcount-(page-1)*limit}"/>	
<c:forEach var="b" items="${mainjiklist}">
  <div class="col-sm-4" style="margin-bottom:20px;">
    <div class="card" style="padding-top:10px; height:330px;">
      <div class="card-body" >
        <h5 class="card-title" style="font-weight:bold">${b.jik_subject}</h5>
        <p class="card-text" maxlength="30" style="margin:0; font-weight:bold">${b.jik_date}
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        조회수:${b.jik_readcount} &nbsp;&nbsp;좋아요:${b.jik_like}
        <br>${b.nick}</p>
        <p class="card-text" style="color:gray;"><br>${b.jik_content}</p>
        <a href="${pageContext.request.contextPath}/jik/detail?num=${b.jik_num}&id=${b.jik_id}" class="btn btn-primary">상세보기</a>
      </div>
    </div>
  </div>
</c:forEach>
  </div>
</div>
		
<div class="container">

  <h2>수다농장</h2>
  <span><h5 style="padding-left:5%">항상 즐거운 우리들~</h5>
  <h6><a href="${pageContext.request.contextPath}/free/list">더보기</a></h6></span>


<div class="row" style="margin:20px 20px 50px 20px">

<c:set var="num" value="${listcount-(page-1)*limit}"/>	
<c:forEach var="b" items="${mainfreelist}">
  <div class="col-sm-4" style="margin-bottom:20px;">
    <div class="card" style="padding-top:10px; height:330px;">
      <div class="card-body" >
        <h5 class="card-title" style="font-weight:bold">${b.free_subject}</h5>
        <p class="card-text" maxlength="30" style=" margin:0; font-weight:bold">${b.free_date}
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        조회수:${b.free_readcount} &nbsp;&nbsp;좋아요:${b.free_like}
        <br>${b.nick}</p>
        <p class="card-text" style="color:gray;"><br>${b.free_content}</p>
        <a href="${pageContext.request.contextPath}/free/detail?num=${b.free_num}&id=${b.free_id}" class="btn btn-primary">상세보기</a>
      </div>
    </div>
  </div>
</c:forEach>
  </div>
</div>
		
	

<%-- 게시글이 없는 경우--%>
<c:if test="${listcount == 0 }">
	<font size=5>등록된 글이 없습니다.</font>
</c:if>
<br>
	
	
		<div class="btn-group a">
			<a href="${pageContext.request.contextPath}/notice/noticeList" class="button">
				&nbsp;&nbsp;&nbsp;&nbsp;공지사항<br>
				<p>
				&nbsp;&nbsp;&nbsp;&nbsp;주말농장의 공지사항을 확인하세요.<br>	
				
				</p>		
			</a>
			<a href="${pageContext.request.contextPath}/emailprocess?id=${id}" class="button">
				&nbsp;&nbsp;&nbsp;&nbsp;메일 문의<br>
				<p>
				&nbsp;&nbsp;&nbsp;&nbsp;주말농부님들의 의견을 들려주세요.<br>
				
				</p>
			</a>
		</div>
		

		
<jsp:include page="footer.jsp" />  
</body>
</html>



