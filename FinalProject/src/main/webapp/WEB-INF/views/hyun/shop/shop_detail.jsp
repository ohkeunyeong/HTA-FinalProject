<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말 장터 메인</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

<style>
h5 {
	padding-top: 10px;
	font-weight:medium;
}

.container .nav {
	margin-top: 80px;
	font-size: 20px;
}

div.goods {
	margin:auto;
	margin-bottom:40px;
	width:80%
}

 div.goods div.goodsImg { float:left; width:350px; }
 div.goods div.goodsImg img { width:350px; height:auto; }
 
 div.goods div.goodsInfo { float:right; width:450px; font-size:20px;}
 div.goods div.goodsInfo p { margin:0 0 10px 0; }
 div.goods div.goodsInfo p span { display:inline-block; width:100px; margin-left:10%; margin-right:15px; padding-top:10px;}
 
 div.goods div.goodsInfo p.cartStock input { font-size:20px; width:50px; padding:5px; margin:0; border:1px solid #eee; }
 div.goods div.goodsInfo p.cartStock button { font-size:26px; border:none; background:none; }
 div.goods div.goodsInfo p.addToCart { text-align:right; }
 div.goods div.gdsDes { font-size:18px; clear:both; padding-top:30px; padding-bottom:40px;}


</style>

</head>
<body>
	<jsp:include page="shop_header.jsp" />

    <br><br><br>    	
    
	<!-- 굿즈 장터 내 네비게이션 바 -->
	<div class="container">
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="home">장터홈</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="seed">씨앗/모종</a></li>
			<li class="nav-item"><a class="nav-link" href="soil">비료/상토</a></li>
			<li class="nav-item"><a class="nav-link" href="pesticide">살충제</a></li>
			<li class="nav-item"><a class="nav-link" href="tools">농기구</a></li>
			<li class="nav-item"><a class="nav-link" href="personacon">퍼스나콘</a></li>
			<li class="nav-item"><a class="nav-link" href="goods">굿즈</a></li>
		</ul>
	</div>

	
	<br><br><br>
		
		<div class="section1" style="width:80%; margin:auto" >
			<span>제품 상세 > ${product.product_name}</span> 
		</div>
		<br><br>
		
		<section id="content" style="margin-top:0rem;">
				
		<form role="form" method="post">
			<input type="hidden" name="code" value="${product.product_code}" />
		</form>
	
		<div class="goods">
			<div class="goodsImg">
				<img src="${pageContext.request.contextPath}/resources/image/hyun/${product.product_img}">
			</div>
	
		<div class="container goodsInfo p-3 border">
			<div class="goodsInfo">
			
				<p class="gdsName">
					<span>상품명  </span>${product.product_name}</p>
	
				<p class="cateName">
					<span>카테고리  </span>${product.category_name}</p>
	
				<p class="gdsPrice">
					<span>가격 </span>
					<fmt:formatNumber pattern="###,###,###" value="${product.product_price}" />
					원
				</p>
	
				<p class="cartStock">
				 <span>구입 수량</span>
				 <button type="button" class="plus">+</button>
				 <input type="number" class="numBox" min="1" max="100" value="1" readonly="readonly"/>
				 <button type="button" class="minus">-</button>
				 
				 <script>
				  $(".plus").click(function(){
				   var num = $(".numBox").val();
				   var plusNum = Number(num) + 1;
				   
				   if(plusNum >= 100) {
				    $(".numBox").val(num);
				   } else {
				    $(".numBox").val(plusNum);          
				   }
				  });
				  
				  $(".minus").click(function(){
				   var num = $(".numBox").val();
				   var minusNum = Number(num) - 1;
				   
				   if(minusNum <= 0) {
				    $(".numBox").val(num);
				   } else {
				    $(".numBox").val(minusNum);          
				   }
				  });
				 </script>
				 
				</p>
				
				<br>
				<p class="addToCart" style="padding-right:70%">
					<button type="button" class="btn btn-warning">카트에 담기</button>
				</p>
			</div>
		</div>
		
		<div class="gdsDes">${product.product_detail}</div>
		</div>
	
	
			<div id="review">
		
		 <c:if test="${id == null }"> <!-- 세션아이디 = id -->
		  <p>리뷰를 남기시려면 <a id="shop_login" style="color:blue">로그인</a>해주세요</p>
		 </c:if>
		 
		 <c:if test="${id != null}">
		 <section class="reviewForm">
		  <form role="form" method="post" autocomplete="off" action="/project/shop/registReview">
		  	
		  	<input type="hidden" name="product_code" value="${product.product_code}">
		  	<input type="hidden" name="member_nick" value="${member.nick}">
		  	
		   <div class="input_area">
		    <textarea name="review_content" id="review_content"></textarea>
		   </div>
		   
		   <div class="input_area">
		    <button type="submit" id="review_btn">리뷰 남기기</button>
		   </div>
		   
		  </form>
		 </section>
		 </c:if>
		 
		 <section class="reviewList">
		  <ol>
		   <li>댓글 목록</li>
		   </ol>    
		 </section>
		</div>
	</section>
	
	<script>
	$("#shop_login").click(function(){
		$.ajax({
			url : "member/login",
			type : "post",
			success : function(data){
				console.log(data.saveid);
				if(data.saveid != null){
					$('#id').val(data.saveid);
					$('#remember').prop('checked', true);
				}
			}
		})
		$("#loginModal").modal({backdrop : 'static', keyboard: false});
	});
	</script>	

	<jsp:include page="../../main/footer.jsp" />
</body>
</html>
