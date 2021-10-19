<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주말농장을 소개합니다~</title>
<style>

h2,h4 {
padding:5% 5% 2% 10%

}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<body>
<jsp:include page="../main/header.jsp"/>
<div class="container-fluid" style="padding-left: 0px;padding-right: 0px;">
<img src="${pageContext.request.contextPath}/resources/image/farm3.jpg" style="width:100%; height=30px;"> 
</div>
<br><br>
<h2>주말농장</h2>

<h5 style="padding:0% 5% 5% 10%; color:gray">
주말농장의 수 및 신선하고 안전한 농작물에 대한 수요가 늘어남에 따라<br>
주말농장의 관리 및 수확물 거래에 대한 가이드가 점점 더 필요해지고 있습니다.<br>
</h5>

<h2>주말농장은</h2>
<h5 style="padding:0 5% 10% 10%; color:gray">
농장의 운영자와 멤버에게는 주말농장의 운영에 도움이 되며 <br>
수확물로 이익을 얻을 수 있는 관리 및 판매 플랫폼을 제공하고 <br>
지역 소비자에게는 안전한 먹거리를 확보할 수 있는 소비처 제공을 위해 <br>
주말 농장 관리 & 직거래 플랫폼 서비스를 제공하고자 합니다.<br>
</h5>

<h4 style="padding:0 5% 10% 10%; color:green">지금 주말농장을 이용해 보세요.</h4>
</body>
<jsp:include page="../main/footer.jsp"/>
</html>