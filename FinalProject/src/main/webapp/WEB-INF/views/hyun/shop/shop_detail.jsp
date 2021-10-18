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
<script src="${pageContext.request.contextPath}/resources/js/jjs/productDetailView.js"></script>

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
<!--리뷰 목록 스크립트 -->
 <script> 
		   function reviewList() {
			   
			   
			 var product_code = ${product.product_code};
			 $.getJSON("/shop/shop_detail/reviewList" + "?n=" + product_code, function(data){
			  var str = "";
			  
			  $(data).each(function(){
			   
			   console.log(data);
			   
			   var review_Date = new Date(this.review_Date);
			   review_Date = review_Date.toLocaleDateString("ko-US")
			   
			   str += "<li data-product_code='" + this.product_code + "'>"
			     + "<div class='userInfo'>"
			     + "<span class='ID'>" + this.ID + "</span>"
			     + "<span class='date'>" + review_Date + "</span>"
			     + "</div>"
			     + "<div class='review_Content'>" + this.review_content + "</div>"
			     + "<div class='product_code' type='hidden'>" + this.product_code + "</div>"
			     + "<div class='product_name' type='hidden'>" + this.product_name + "</div>"
			     + "<div class='category_code'type='hidden'>" + this.category_code + "</div>"
			     + "</li>";           
			  });
			  
			  $("section.reviewList ol").html(str);
			 });
			 
			 }
			</script>

</head>
<body>
	<jsp:include page="../../main/header.jsp" />
		<jsp:include page="shop_nav.jsp" />
		<div class="section1" style="width:80%; margin:auto" >
			<span>제품 상세 > ${p.product_name}</span> 
		</div>
		<br><br>
		
		<section id="content" style="margin-top:0rem;">
			
		<input type="hidden" class="code" value="${p.product_code}" />
		<input type="hidden" class="id" value="${id}" />
	
		<div class="goods">
			<div class="goodsImg">
				<img src="${pageContext.request.contextPath}/upload${p.product_img}">
			</div>
	
		<div class="container goodsInfo p-3 border">
			<div class="goodsInfo">
			
				<p class="gdsName">
					<span>상품명  </span>${p.product_name}</p>
	
				<p class="cateName">
					<span>카테고리  </span>${p.category_name}</p>
	
				<p class="gdsPrice">
					<span>가격 </span>
					<fmt:formatNumber pattern="###,###,###" value="${p.product_price}" />
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
					<button type="button" class="btn btn-warning" id="cartbtn">카트에 담기</button>
				</p>
			</div>
		</div>
		
		<div class="gdsDes">${p.product_detail}</div>
		</div>
	
	
			<div id="review">
		
		 <c:if test="${id == null }"> <!-- 세션아이디 = id -->
		  <p>리뷰를 남기시려면 <a id="shop_login" style="color:blue">로그인</a>해주세요</p>
		 </c:if>
		 
		 <c:if test="${id != null}">
		 <section class="reviewForm">
		  <form role="form" method="post" autocomplete="off" action="/project/shop/registReview">
		  	
		  	<input type="hidden" name="product_code" value="${product.product_code}">
		  	<input type="hidden" name="product_name" value="${product.product_name}">
		  	<input type="hidden" name="category_code" value="${product.category_code}">
		  	
		   <div class="input_area">
		    <textarea name="review_content" id="review_content"></textarea>
		   </div>
		   
		   <div class="input_area">
		    <button type="submit" id="review_btn">리뷰 남기기</button>
		   </div>
		   
		   		<script>
				 $("#review_btn").click(function(){
				  
				  var formObj = $(".reviewForm form[role='form']");
				  var product_code = $("#product_code").val();
				  var review_content = $("#review_content").val();
				  var product_name = $("#product_name").val();
				  var category_code = $("#category_code").val();
				  
				  var data = {
					  product_code : product_code,
					  review_content : review_content,
					  product_name : product_name
				    };
				  
				  $.ajax({
				   url : "/shop/registReview",
				   type : "post",
				   data : data,
				   success : function(){
				    reviewList();
				    $("#review_content").val("");
				   }
				  });
				 });
				</script>
		  </form>
		 </section>
		 </c:if>
		 
		 <section class="reviewList">
		  <ol>
		   <li>댓글 목록</li>
		   </ol>    
		    <script>
		   reviewList();
		   </script>
		 </section>
		</div>
	</section>
	
	<script>
	$("#shop_login").click(function(){
		$.ajax({
			url : "../member/login",
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
	<jsp:include page="shopModal.jsp" />
	<jsp:include page="../../main/footer.jsp" />
</body>
</html>
