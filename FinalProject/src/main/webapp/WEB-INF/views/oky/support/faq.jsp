<!-- 출처 : https://codepen.io/EthanMcFarlin/pen/yZLbGy  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
     <title>FAQ</title>
     <jsp:include page="../../main/header.jsp" /> 
     <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>

@import url(https://fonts.googleapis.com/css?family=Lato);

@import url(https://fonts.googleapis.com/css?family=Open Sans);

.faq-heading {
  font-family: Lato;   
  font-weight: 400;
  font-size: 19px;
   -webkit-transition: text-indent 0.2s;
  text-indent: 20px;
  color: #333;
}

.faq-text {
  font-family: Open Sans;   
  font-weight: 400;
  color: #919191;
  width:95%;
  padding-left:20px;
  margin-bottom:30px;
}

.faq {
  width: 1000px;
  margin: 0 auto;
  background: white;
  border-radius: 4px;
  position: relative;
  border: 1px solid #E1E1E1;
}
.faq label {
  display: block;
  position: relative;
  overflow: hidden;
  cursor: pointer;
  height: 56px;
  padding-top:1px;
 
  background-color: #FAFAFA;
  border-bottom: 1px solid #E1E1E1;
}

.faq input[type="checkbox"] {
  display: none;
}

.faq .faq-arrow {
  width: 5px;
  height: 5px;
  transition: -webkit-transform 0.8s;
  transition: transform 0.8s;
  transition: transform 0.8s, -webkit-transform 0.8s;
  -webkit-transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
  border-top: 2px solid rgba(0, 0, 0, 0.33);
  border-right: 2px solid rgba(0, 0, 0, 0.33);
  float: right;
  position: relative;
  top: -30px;
  right: 27px;
  -webkit-transform: rotate(45deg);
          transform: rotate(45deg);
}

 .faq input[type="checkbox"]:checked + label > .faq-arrow {
  transition: -webkit-transform 0.8s;
  transition: transform 0.8s;
  transition: transform 0.8s, -webkit-transform 0.8s;
  -webkit-transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
  -webkit-transform: rotate(135deg);
          transform: rotate(135deg);
}
 .faq input[type="checkbox"]:checked + label {
  display: block;
  background: rgba(255,255,255,255) !important;
  color: #4f7351;
  height: 225px;
  transition: height 0.8s;
  -webkit-transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

 .faq input[type='checkbox']:not(:checked) + label {
  display: block;
  transition: height 0.8s;
  height: 60px;
  -webkit-transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

::-webkit-scrollbar {
  display: none;
}

</style>
</head>
<body>
<br><br><br>
<div class='faq'>
  <input id='faq-a' type='checkbox'>
  <label for='faq-a'>
    <p class="faq-heading">질문</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>답변</p>
  </label>
  <input id='faq-b' type='checkbox'>
  <label for='faq-b'>
    <p class="faq-heading">질문</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>답변<br><br></p>
  </label>
  <input id='faq-c' type='checkbox'>
  <label for='faq-c'>
    <p class="faq-heading">질문</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>답변<br><br></p>
  </label>
  <input id='faq-d' type='checkbox'>
  <label for='faq-d'>
    <p class="faq-heading">질문</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>답변<br><br></p>
  </label>
  <input id='faq-e' type='checkbox'>
  <label for='faq-e'>
    <p class="faq-heading">질문</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>답변<br><br></p>
  </label>
    <input id='settings' type='checkbox'>
  <input id='faq-f' type='checkbox'>
  <label for='faq-f'>
    <p class="faq-heading">질문</p>
    <div class='faq-arrow'></div>
      <p class="faq-text"><br>답변<br><br></p>
  </label>
</div>
 
<jsp:include page="../../main/footer.jsp" />  
</body>
</html>