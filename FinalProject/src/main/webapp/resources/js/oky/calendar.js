//값이 1자리이면 두자리로 만들어 주는 기능
function isTwo(str) {
	return str.length < 2 ? "0" + str : str;
}

$(function() {
	$(".countView")
			.hover(
					function() {
						var aObj = $(this);
						var year = $(".y").text().trim();// 년
						var month = $(".m").text().trim();// 월
						var date = $(this).text().trim();// 일
						var yyyyMMdd = year + isTwo(month) + isTwo(date)
						$
								.ajax({
									method : "post", // 전송방식
									url : "calcountajax", // 요청URL
									data : {
										"yyyyMMdd" : yyyyMMdd
									}, // 전송 파라미터 //"yyyyMMdd="+yyyyMMdd
									dataType : "text", // 서버로 부터 받는 값의 타입
									dataType : "json", // 서버로 부터 받는 값의 타입
									async : false, // $.ajax()가 기본이 비동기식 실행이므로
													// false로 설정
									success : function(val) {
										// alert("서버통신성공" + val);
										aObj
												.before("<span class='cPreview' style='padding:0px 55px 0px 0px;'>총 일정 갯수 :"
														+ val + "</span>");
									},
									error : function() {
										// alert('서버통신실패');
									}
								});
					}, function() {
						$(".cPreview").remove();// 마우스가 나가면 해당 엘리먼트를 삭제한다.
					});
});

$(document).ready(function () {  
	
	$("#outmynong").click(function(){
		if(confirm("농장에서 탈퇴 하시겠습니까?")){
		}else {
			return false
		}	
	})
	});
