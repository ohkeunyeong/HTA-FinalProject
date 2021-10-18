<!-- 출처 : https://codepen.io/EthanMcFarlin/pen/yZLbGy  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
     <title>FAQ</title>
     <jsp:include page="../../main/header.jsp" /> 
     <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/oky/faq.css"></link>
</head>
<body>
<br><br><br>
<div class='faq'>
  <input id='faq-a' type='checkbox'>
  <label for='faq-a'>
    <p class="faq-heading">회원가입 시 나이제한이 있나요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>나이에 상관없이 모두 가입 가능합니다.<br></p>
  </label>  
  <input id='faq-b' type='checkbox'>
  <label for='faq-b'>
    <p class="faq-heading">아이디와 비밀번호(Password)를 변경할 수 있나요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>네 가능합니다. 로그인 후 우측 상단 [마이페이지 → 정보수정]에서 접속 후 변경이 가능합니다.</p>
  </label>
  <input id='faq-c' type='checkbox'>
  <label for='faq-c'>
    <p class="faq-heading">아이디와 비밀번호를 잃어버렸어요</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>좌측 상단 로그인 클릭 후 로그인 화면에서 아이디/비밀번호 찾기를 선택하면 찾을 수 있습니다.
      비밀번호는 가입한 이메일 주소로 임시 비밀번호가 발송됩니다.<br></p>
  </label>
  <input id='faq-d' type='checkbox'>
  <label for='faq-d'>
    <p class="faq-heading">회원정보 탈퇴는 어떻게 하나요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>[마이페이지 → 정보수정] 페이지에서 탈퇴가 가능합니다. 기존에 작성하셨던 글이나 정보는 모두 삭제되오니 주의하시기 바랍니다.<br></p>
  </label>
  <input id='faq-e' type='checkbox'>
  <label for='faq-e'>
    <p class="faq-heading">새로운 아이디로 재가입 할 수 있나요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>기존 아이디 탈퇴 후 재가입이 가능합니다. 탈퇴 후에는 개인정보, 게시글 등이 모두 삭제되오니 유념하시기 바랍니다.<br></p>
  </label>    
  <input id='faq-f' type='checkbox'>
  <label for='faq-f'>
    <p class="faq-heading">상품에 대한 문의는 어떻게 하나요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>상품에 대한 문의는  메일문의를 이용해주시면 됩니다.<br></p>
  </label>  
  <input id='faq-g' type='checkbox'>
  <label for='faq-g'>
    <p class="faq-heading">상품 정보가 잘못되어 있습니다.</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>잘못된 상품 정보는  메일문의를 통해 알려주시면 빠른 시간 내 수정할 수 있도록 하겠습니다.<br></p>
  </label>   
  <input id='faq-h' type='checkbox'>
  <label for='faq-h' >
    <p class="faq-heading">반품/교환 비용이 고객 부담인 경우는 어떤 경우인가요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text" ><br>제품의 하자가 아닌 고객의 단순변심으로 인한 반품/교환의 택배 비는 고객님께서 부담해주셔야 합니다. 단순변심에 의한 반품/교환은 고객님의 개인취향이나 주관적인 사항(디자인, 사이즈, 소재, 컬러 불만) 등에 의한 경우를 말합니다.<br></p>
  </label>
  <input id='faq-i' type='checkbox'>
  <label for='faq-i'>
    <p class="faq-heading">상품 배송 기간은 얼마나 걸리나요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>상품은 주문하신 날로부터 2~5일 이내(영업일 기준)에 받으실 수 있습니다.
다만, 공휴일, 연휴, 명절의 경우 택배사 사정으로 배송이 지연될 수 있으니 참고해 주시기 바랍니다.<br></p>
  </label>
  <input id='faq-j' type='checkbox'>
  <label for='faq-j'>
    <p class="faq-heading">파손된 상품을 받았습니다. 어떻게 해야 하나요?</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>파손의 경우 포장 또는 운송도중 발생이 대부분이며, 메일 문의해주시면 빠른 처리 도와드리도록 하겠습니다.<br></p>
  </label>
</div>
</body>
</html>