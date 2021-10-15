<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<br>
<br>
<br>
<div class="slidebox">
	<input type="radio" name="slide" id="slide01" checked> <input type="radio" name="slide" id="slide02"> <input type="radio" name="slide" id="slide03"> <input type="radio" name="slide" id="slide04">
	<ul class="slidelist">
		<li class="slideitem">
			<div>
				<label for="slide04" class="left"></label> <label for="slide02" class="right"></label> <a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg01.jpg"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide01" class="left"></label> <label for="slide03" class="right"></label> <a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg02.jpg"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide02" class="left"></label> <label for="slide04" class="right"></label> <a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg03.jpg"></a>
			</div>
		</li>
		<li class="slideitem">
			<div>
				<label for="slide03" class="left"></label> <label for="slide01" class="right"></label> <a><img src="${pageContext.request.contextPath}/resources/image/banner/slideimg04.jpg"></a>
			</div>
		</li>
	</ul>
</div>