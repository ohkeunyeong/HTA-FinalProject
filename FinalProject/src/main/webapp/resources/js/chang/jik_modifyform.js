$(document).ready(function(){
	
	//submit 버튼 클릭할 때 이벤트 부분
	$("form").submit(function(){
		
		if($.trim($("#jik_subject").val()) == ""){
			alert("제목을 입력하세요");
			$("#jik_subject").focus();
			return false;
		}
		
		if($.trim($("#jik_content").val()) == ""){
			alert("내용을 입력하세요");
			$("#jik_content").focus();
			return false;
		}
	});//submit end
})//ready() end
	
		
		
