$(function(){
	$('.noticeModifyBtn').click(function(){
		var num = $(".num").val();
		$.ajax({
			type : "post",
			url : "noticeSelect",
			data : {"num" : num},
			dataType : 'json',
			success : function(data) {
				$("input[name='NOTICE_NUM']").remove();
				$("#noticeModify_subject").val(data.notice.notice_SUBJECT);
				$("#noticeModify_content").val(data.notice.notice_CONTENT);
				if(data.notice.notice_FIX == 'FIX'){
					$("#noticeModify_fix").prop("checked", true).val('FIX');
				}else{
					$("#noticeModify_fix").prop("checked", false).val('');
				}
				$("#noticeModifyForm")
					.append("<input type='hidden' value='" 
							+ data.notice.notice_NUM + "' name='NOTICE_NUM'>");
				$("#noticeModifyModal").modal({backdrop: 'static', keyboard: false});
			}
		})
	}); // $('.noticeModifyBtn').click() end
	
	$("#noticeModify_fix").click(function(){
		if($("#noticeModify_fix").prop("checked") == true){
			$("#noticeModify_fix").val("FIX");
		}else{
			$("#noticeModify_fix").val("");
		}
	}); // $("#noticeModify_fix").click() end
	
	$("#noticeModifyForm").submit(function(){
		if($.trim($("#noticeModify_subject").val()) == ''){
			$("#NoticeValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#NoticeValidationModal-body").html("<h3>제목을 입력해주세요</h3>");
			return false;
		}
		
		if($.trim($("#noticeModify_content").val()) == ''){
			$("#NoticeValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#NoticeValidationModal-body").html("<h3>내용을 입력해주세요</h3>");
			return false;
		}
	}); // $("#noticeModifyForm").submit()
});