<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>직거래 장터</title>
 <jsp:include page="../../main/header.jsp" />
  <script src="../resources/js/jquery-3.6.0.min.js"></script>
 <script src="../resources/js/chang/jik_comm.js"></script>
<script src="../resources/js/chang/jik_controller.js"></script>
 <link rel="stylesheet" href="../resources/css/chang/view.css">
</head>
<body>
  <input type="hidden" id="Loginid" value="${id}" name="loginid">
  <input type="hidden" id="Loginnick" value="${nick}" name="Loginnick">
  <input type="hidden" id="Jik_id" value="${jikdata.jik_id}" name="Jik_id">
  <input type="hidden" id="jik_subject" value="${jikdata.jik_subject}">
  <input type="hidden" id="jik_content" value="${jikdata.jik_content}" >
  <input type="hidden" id="jik_like" value="${jik_like}">
  <br><br><br><br><br><br><br><br><br><br>
  

  <div class="container">
 	<table class="table">
 		<tr>
 			<th colspan="2"><c:out value="${jikdata.jik_subject}" /></th></tr>
 		<tr>
 			
 			<td colspan="2">
 				<div id="nick"> 
 				<img width="25" class="display" src="display?fileName=${jikdata.profile}">&nbsp;&nbsp;${jikdata.nick}
 				<c:if test="${id !=null && id != ''}">
 				<a href="#" class="report_button" onclick=" window.open('../jik/report', '신고하기', 'width=500, height=700, scrollbars=no, resizable=no')">신고하기</a>
 				</c:if>
 				</div>
 			</td>
 		</tr>
 		<tr>
 			<td colspan="2" class="noborder right"> 최종 작성 시간 : ${jikdata.jik_ldate}   조회수 : ${jikdata.jik_readcount}&nbsp;&nbsp;  좋아요 : ${jikdata.jik_like}
 			</tr>
 		<tr>
 			<td colspan="2" style="padding-right:0px">	
 		<c:if test="${!empty jik_files}">
 			<div contentEditable="false" >
   				<div id="slideShow">
   					<ul class="slides">
   						<c:forEach var="b" items="${jik_files}">
     						<li><img width="700" height="500" src="display?fileName=${b.jik_file}" alt=""></li>
     					</c:forEach>
    				</ul>
   		 			<p class="controller">
       					<!--  &lang: 왼쪽 방향 화살표 &rang: 오른쪽 방향 화살표 -->
        				<span class="prev">&lang;</span> 
       					<span class="next">&rang;</span> 
     				</p> 
    			</div>
 			</div> 
 			</c:if>
 			${jikdata.jik_content}
 			</td>
 		</tr>
 	<tr>
 		<td colspan="2" class="center noborder">
 	
 		</td>
 	</tr>
 	
 	<tr>
 		<td colspan="2" class="center">
 			
 			<c:if test="${jikdata.jik_id == id || id =='admin' }">
 			 <a href="modifyView?num=${jikdata.jik_num}">
 			 	<button class="btn btn-warning">수정</button>
 			 </a>
 			 <a href="#">
 			 	<button class="btn btn-danger" data-toggle="modal"
 			 			data-target="#myModal">삭제</button>
 			 </a>
 			 </c:if>
 			
 			<a href="list">
 				<button class="btn btn-secondary">목록</button>
 			</a>
 			</td>
 		</tr>
 	</table>
<%-- 게시판 view end --%>

		<%-- modal 시작 --%>
		<div class="modal" id="myModal">
		 <div class="modal-dialog">
		  <div class="modal-content">
		  	<%-- Modal body --%>
		  	<div class="modal-body">
		  	 <form name="deleteForm" action="delete" method="post">
		  	 	<%--http://localhost:8088/myhome5/detail?num=22
		  	 		주소를 보면 num을 파라미터로 넘기고 있습니다.
		  	 		이 값을 가져와서 ${param.num}를 사용
		  	 		또는 ${boarddata.BOARD_NUM}
		  	 	 --%>
		  	 	 <input type="hidden" name="jik_num" value="${param.num}"
		  	 	 	  id="jik_num">
					정말로 삭제하시겠습니까?<br><br>
		  	 	 	<button type="submit" class="btn btn-primary">삭제</button>
		  	 	 	<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
		  		 </form>
		  		</div><!-- class="modal-body" -->
		  </div><!-- class="modal-content" -->
		</div><!-- class="modal-dialog" -->
	</div><!-- class="modal" id="myModal"-->
	
	
	<div class="CommentBox">
		<div class="comment_option">
			<h3 class="comment_title">
				댓글	<span id="count">${count}</span>
			</h3>
			<div class="comment_tab">
				<ul class="comment_tab_list">
				</ul>
			</div>
		</div><!--  comment option end -->
		<ul class="comment_list">
		</ul>
		<span id="message"></span>
		<div class="CommentWriter">
			<div class="comment_inbox">
				<b class="comment_inbox_name">${nick}</b><span
				   class="comment_inbox_count">0/200</span>
				  <textarea placeholder="로그인 후 댓글을 남겨보세요" rows="3"
				  class="comment_inbox_text" maxLength="200"></textarea> 
			</div>
		<c:if test="${id!=null}">
			<div class="register_box">
				<input type="checkbox" class="secret" />비밀댓글
				<div class="button btn_cancel">취소</div>
				<div class="button btn_register" id="write">등록</div>
			</div>
		</c:if>
		</div><!-- CommentWriter end -->
	</div><!-- CommentBox end -->
  </div><!-- class="container" -->


</body>
</html>