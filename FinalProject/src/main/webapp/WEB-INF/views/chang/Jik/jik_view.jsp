<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>MVC 게시판 - view</title>
 <jsp:include page="../../main/header.jsp" />
  <script src="../resources/js/jquery-3.6.0.min.js"></script>
 <script src="../resources/js/chang/view3.js"></script>
 <link rel="stylesheet" href="../resources/css/chang/view.css">
</head>
<body>
  <input type="hidden" id="Loginid" value="${id}" name="loginid">
  <input type="hidden" id="Loginnick" value="${nick}" name="Loginnick">
  <div class="container">
 	<table class="table table-striped">
 		<tr>
 			<th colspan="2">직거래 게시판 - view페이지</th></tr>
 		<tr>
 			<td><div>글쓴이</div></td>
 			<td><div id="nick">${jikdata.nick}</div></td>
 		</tr>
 		<tr>
 			<td><div>제목</div></td>
 			<td><c:out value="${jikdata.jik_subject}" /></td>
 		</tr>
 		<tr>
 			<td><div>내용</div></td>
 			<td style="padding-right:0px"><textarea class="form-control" rows="5"
 				readOnly >${jikdata.jik_content}</textarea></td>
 		</tr>
 		
 	
 		<tr>
 			<td><div>첨부파일</div></td>
 		<c:if test="${!empty jikdata.jik_file}"><%--파일 첨부한 경우 --%>
 		<td><img src="../resources/image/chang/down.png" width="10px">
 			<form method="post" action="down">
 				<input type="hidden" value="${jikdata.jik_file}" name="filename">
 				<input type="hidden" value="${jikdata.jik_original}" name="original">
 				<input type="submit" value="${jikdata.jik_original}" >
 			</form>
 			</td>
 		</c:if>
 		<c:if test="${empty jikdata.jik_file}"><%-- 파일첨부하지 않은 경우 --%>
 			<td></td>
 		</c:if>
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
		<div class="CommentWriter">
			<div class="comment_inbox">
				<b class="comment_inbox_name">${jikdata.nick}</b><span
				   class="comment_inbox_count">0/200</span>
				  <textarea placeholder="댓글을 남겨보세요" rows="1"
				  class="comment_inbox_text" maxLength="200"></textarea> 
				  
			</div>
			<div class="register_box">
				<div class="button btn_cancel">취소</div>
				<div class="button btn_register" id="write">등록</div>
			</div>
		</div><!-- CommentWriter end -->
	</div><!-- CommentBox end -->
  </div><!-- class="container" -->

</body>
</html>