<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
</head>
<script>
$(document).ready(function () {  
	
$("#insertacc").click(function(){
 num = /^[0-9]*$/;
 
 if(!num.test($("#amount").val())){
	 alert("금액은 숫자만 입력 가능합니다.")
	 $("#amount").val('').focus();		
	 return false;
 }
	
})
	
});
function checkTarget(num) {
	var element = document.getElementById('thisdate');
	  element.innerHTML = num;
	$("#inputdate").val(num);
 }

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
<jsp:useBean id="util" class="com.hta.project.controller.OkyAccountController" />
<jsp:include page="../../main/header.jsp" /> 
<input type="hidden" id="id" value="${id}" name="id">

<div>농장명 : ${name} <br>
          아이디 : ${id}   <br>
 관리자 레벨 : ${level}   <br>
          연도 : ${year}   <br>
          월    : ${month}   <br>      
     요일 :    ${dayofweek}  <br>  
   리스트: ${alist}
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
		<h3>${year}년 ${month} 월 합계:
		<span>
		<c:set var = "total" value = "0" />
			<c:forEach var="result" items="${alist}" varStatus="status">     
			<c:set var= "total" value="${total + result.amount}"/>
			</c:forEach>
        <fmt:formatNumber value="${total}" pattern="#,###"/>
		</span>원
		</h3>
		<c:set var="yoil" value="${dayofweek}"/>
		<c:forEach var="a" begin="1" end="${lastday}">
			<div>
				 <input type="checkbox" id="${a}" />
				<label for="${a}" id="date"> 
				${month} 월 ${a}일
				<c:if test="${yoil ==1 }">일요일</c:if>
	            <c:if test="${yoil ==2 }">월요일</c:if>
	            <c:if test="${yoil ==3 }">화요일</c:if>	
	            <c:if test="${yoil ==4 }">수요일</c:if>
	            <c:if test="${yoil ==5 }">목요일</c:if>
		        <c:if test="${yoil ==6 }">금요일</c:if>
		        <c:if test="${yoil ==0 ||yoil ==7 }">토요일</c:if>   
		         		합계:
		        <span>		          
		             <c:set var = "total" value = "0" />  
                   <c:forEach var="b" items="${alist}">
				   <c:set var="date" value="${fn:substring(b.mdate, 6, 8)}"/>
				   <c:if test="${date== a}">
			         <c:set var= "total" value="${total + b.amount}"/>
			       </c:if>
			       </c:forEach>		        		        
                       <fmt:formatNumber value="${total}" pattern="#,###"/>				   		        
		        </span>원
		        <c:if test="${level ==1}"> 
			        <a href="#" onClick="checkTarget(${a})" data-toggle="modal" data-target="#largeModal" id="addacc" >
		     	     	<img id="pen" src="${pageContext.request.contextPath}/resources/image/oky/pen.png" alt="가계부추가"/>
            		</a>
                </c:if>
		        </label>                               
				<article>
		        <table class="table table-striped">
		         <thead>
					<tr>
						<th>지출시간</th>
						<th>지출금액</th>
						<th>지출내역</th>
					</tr>	
				  </thead>
				   <tbody>
				   <c:forEach var="b" items="${alist}">
				   <c:set var="date" value="${fn:substring(b.mdate, 6, 8)}"/>
				   <c:if test="${date== a}">
					    <tr>
					    	<td>   
					    		<jsp:setProperty value="${b.mdate}" property="toDates2" name="util"/>
	             				<jsp:getProperty property="toDates2" name="util"/>
	             			</td>
							<td><fmt:formatNumber value="${b.amount}" pattern="#,###"/>원</td>	
							<td>${b.title}</td>
					   </tr>	
			       </c:if>
			       </c:forEach>
			       </tbody>
		        </table>	
				</article>
		        <c:set var="yoil" value="${(yoil + 1)%7}"/>
			</div>
			</c:forEach>
		</section>
  </div>  
  <!-- modal -->
<div class="modal fade" id="largeModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true" style="disply:none;">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form name="insertacc" action="insertacc" method="post">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">지출내역</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		   <table border="1">
		       <tr>
		            <th>일정</th>
		            <td>
		            <input type="hidden"  value="${name}" name="name">
		            <input type="hidden"  value="${year}" name="year">
		            <input type="hidden"  value="${month}" name="month">
		            <input type="hidden"  id="inputdate" name="date">
		               <span>${year}년  </span> 
		               <span>${month}월</span> 
		               <span><span id="thisdate"></span>일</span>
		                 <select name="hour">  
		                   <c:forEach var="thishour" begin="0" end="24">
		                   <c:if test="${thishour == hour}">
		                   <option value="${hour}" selected>${hour}</option>
		                   </c:if>
		                   <c:if test="${thishour != hour}">
		                   <option value="${thishour}" > ${thishour}</option>
		                   </c:if>                        
		                   </c:forEach>                                  
		                 </select>시
		                 <select name="min">
		                   <c:forEach var="thismin" begin="0" end="60">
		                   <c:if test="${thismin == min}">
		                   <option value="${min}" selected>${min}</option>
		                   </c:if>
		                   <c:if test="${thismin != min}">
		                   <option value="${thismin}" >${thismin}</option>
		                   </c:if>                        
		                   </c:forEach>                     
		                 </select>분
		            </td>
		       </tr>
		       <tr>
		            <th>금액</th>
		            <td><input type="text" id="amount" name="amount" placeholder="예) 5만원 => 50000" required/></td>
		       </tr>        
		       <tr>
		            <th>지출내역</th>
		            <td><input type="text" name="title" required/></td>
		       </tr>
		       
		       <tr>
		            <th>내용</th>
		            <td><textarea rows="10" cols="50" name="content" style="resize: none;"></textarea></td>
		       </tr>
		   </table>     
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" id="insertacc">등록</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
      </div>
     </form>            
    </div>
  </div>
</div>
</body>
</html>
