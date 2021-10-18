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
<jsp:useBean id="util" class="com.hta.project.controller.AccountController" />
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/oky/account.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/account.css"></link>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
</head>

<body style="overflow-x:hidden; overflow-y:auto;">
<br><br>
<input type="hidden" id="id" value="${id}" name="id">
<div class="wrapper">
 <main>
     <div class="toolbar" style="margin-left: 407px;">
      <div class="caption" style="color:black; font-size:18px;">
        <a href="account?name=${name}&year=${year-1}&month=${month}"><img id="arrowy" src="${pageContext.request.contextPath}/resources/image/oky/by.png" alt="by"/></a>
        <a href="account?name=${name}&year=${year}&month=${month-1}"><img id="arrowm" src="${pageContext.request.contextPath}/resources/image/oky/bm.png" alt="bm"/></a>
        <span class="y">
        ${year}
        </span>년
        <span class="m">
        ${month}
        </span>월 
        <a href="account?name=${name}&year=${year}&month=${month+1}"><img id="arrowm" src="${pageContext.request.contextPath}/resources/image/oky/fm.png" alt="fm"/></a>
        <a href="account?name=${name}&year=${year+1}&month=${month}"><img id="arrowy" src="${pageContext.request.contextPath}/resources/image/oky/fy.png" alt="fy"/></a>   
	</div>
    </div>
	<div id="container" >
		<section id="accordion" style="width: 872px;"> 
		<h3>${year}년 ${month} 월 합계:
		<span>
		<c:set var = "total" value = "0" />
			<c:forEach var="result" items="${alist}" varStatus="status">  
			<c:set var= "total" value="${total + result.amount}"/>   
			</c:forEach>
        <fmt:formatNumber value="${total}" pattern="#,###"/>
		</span>원
		</h3>
		<br>
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
		        <div style="margin-left: 518px;">
		             합계:		          
		             <c:set var = "total" value = "0" />  
                   <c:forEach var="b" items="${alist}">
				   <c:set var="date" value="${fn:substring(b.mdate, 6, 8)}"/>
				   <c:if test="${date== a}">
			         <c:set var= "total" value="${total + b.amount}"/>
			       </c:if>
			       </c:forEach>		        		        
                       <fmt:formatNumber value="${total}" pattern="#,###"/>				   		        
              		        원
		        <c:if test="${level ==1}"> 
			        <a href="#" onClick="checkTarget(${a})" data-toggle="modal" data-target="#insertModal" id="addacc" >
		     	     	<img id="pen" src="${pageContext.request.contextPath}/resources/image/oky/pen.png" alt="가계부추가"/>
            		</a>
                </c:if>
		        </div>
		        </label>                               
				<article>
		        <table class="table table-striped">
		         <thead>
					<tr>
						<th width="33%">지출시간</th>
						<th width="33%">지출금액</th>
						<th width="33%">지출내역</th>
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
							<td>
							${b.title}
				                <c:if test="${level ==1}"> 
							    <button onClick="accupdate(${b.seq}, '${b.title}', ${b.amount}, ${a}, ${fn:substring(b.mdate, 8, 10)}, ${fn:substring(b.mdate, 10, 12)})" data-toggle="modal" data-target="#updateModal" id="updateacc" type="button" class="btn btn-primary" id="insertacc">수정</button>
        						<button onClick="accdelete(${b.seq}, '${name}', '${year}', '${month}')"type="button" class="btn btn-danger" data-dismiss="modal">삭제</button>
        						</c:if>
							</td>
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
  <!-- 지출입력 modal -->
<div class="modal fade" id="insertModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true" style="disply:none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <form name="insertacc" action="insertacc" method="post">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">지출내역</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		   <table>
		       <tr>
		            <th>일정</th>
		            <td>
		            <input type="hidden"  value="${name}" name="name">
		            <input type="hidden"  value="${year}" name="year">
		            <input type="hidden"  value="${month}" name="month">
		            <input type="hidden"  id="inputdate" name="date">
		               <span style="margin-left: 7px;">${year}년  </span> 
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
		       <tr class="space"></tr>
		       <tr>
		            <th>금액</th>
		            <td><input type="text" style="margin-left: 7px;" id="amount" name="amount" placeholder="예) 5만원 => 50000" required/></td>
		       </tr>   
		       <tr class="space"></tr>     
		       <tr>
		            <th>지출내역</th>
		            <td><input type="text" style="margin-left: 7px;" name="title" required/></td>
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

  <!-- 지출수정 modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true" style="disply:none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <form name="accupdateform" action="accupdate" method="post">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">내역수정</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		   <table>
		       <tr>
		            <th>일정</th>
		            <td> 	               
 		            <input type="hidden"  value="${name}" name="name">
 		            <input type="hidden"  id="upseq" name="seq">
		               	<select name="year" id="upyear" style="margin-left: 7px;">  
		                   <c:set var="year" value="${year}"/>
                      		<c:forEach var="i"  begin="${year-2}"   end="${year+2}"   step="1">
                             <option ${year==i?"selected":""} value="${i}">${i}</option>
                      		</c:forEach> 		                                                   
		                 </select>년
		                 
		                 <select name="month" id="upmonth">  
		                   <c:set var="month" value="${month}"/>
                      		<c:forEach var="i"  begin="1"   end="12"   step="1">
                             <option ${month==i?"selected":""} value="${i}">${i}</option>
                      		</c:forEach> 		                                                   
		                 </select>월
		                 
		                 <select name="date" id="update">
                      		 <c:forEach var="thisupdate"  begin="1"   end="31"   step="1">
                              <option value="${thisupdate}">${thisupdate}</option>
                      		 </c:forEach>                
                  		 </select>일
		               
		                 <select name="hour" id="uphour">  
		                   <c:forEach var="thishour" begin="0" end="24">
		                   <option value="${thishour}" > ${thishour}</option>                   
		                   </c:forEach>                                  
		                 </select>시
		                 <select name="min" id="upmin">
		                   <c:forEach var="thismin" begin="0" end="60">
		                   <option value="${thismin}" >${thismin}</option>                     
		                   </c:forEach>                     
		                 </select>
		            </td>
		       </tr>
		       <tr class="space"></tr>
		       <tr>
		            <th>금액</th>
		            <td><input type="text" style="margin-left: 7px;" id="upamount" name="amount" placeholder="예) 5만원 => 50000" required/></td>
		       </tr>
		       <tr class="space"></tr>        
		       <tr>
		            <th>지출내역</th>
		            <td><input type="text" style="margin-left: 7px;" id="uptitle" name="title" required/></td>
		       </tr>
		   </table>     
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary" id="updateaccbtn">수정</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
      </div>
     </form>            
    </div>
  </div>
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
      <a class="menu__item menu__item--active" href="${pageContext.request.contextPath}/accprocess?id=${id}">
      <img id="sideicon" src="${pageContext.request.contextPath}/resources/image/oky/accounting.png" alt="by"/>
        <span style="padding:0px 0px 0px 17px;" class="menu__text">가계부</span>
      </a>    
      <a class="menu__item" href="${pageContext.request.contextPath}/nongprocess?id=${id}">
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
  <div id="footer" >
</div>
</body>
</html>
