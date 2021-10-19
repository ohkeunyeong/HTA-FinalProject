function go(page) {
	allcheck();
	var search_word = $("#search_word").val();
	var data = "search_word=" + search_word + "&page=" + page;
	searchajax(data);
}

function setPaging(href, digit) {
	var output = "<li class=page-item>";
	gray = "";
	if (href == "") {
		gray = " gray";
	}
	anchor = "<a class='page-link" + gray + "'" + href + ">" + digit
			+ "</a></li>";
	output += anchor;
	return output;
}

function searchajax(sdata) {
	$.ajax({
		type : "post",
		url : "noticeList_search",
		data : sdata,
		dataType : 'json',
		success : function(data) {
			$(".card-title").text("공지사항 글 개수 : " + data.listcount);
			if (data.listcount > 0) {
				$("tbody").remove();
				var num = data.listcount - (data.page - 1) * data.limit;
				var output = "<tbody>";
				$(data.noticelist).each(function(index, item) {
					output += "<tr><td><input name='RowCheck' "
							+ "type='checkbox' value='"
							+ item.notice_NUM
							+ "'></td>";
					output += "<td>" + (num--)
							+ "</td>";
					output += "<td><div><a href='noticeDetail?num="
							+ item.notice_NUM
							+ "'>"
							+ item.notice_SUBJECT
							+ "</div></td>";
					output += "<td><div>"
							+ item.notice_DATE
							+ "</div></td>";
					output += "<td><div>"
							+ item.notice_READCOUNT
							+ "</div></td>";

					if (item.notice_FIX == 'FIX') {
						output += "<td><div><button class='btn btn-primary fixbtn' "
								+ "value='' name='NOTICE_FIX' data-num='"
								+ item.notice_NUM
								+ "'>고정해제</button></div></td>";
					} else {
						output += "<td><div><button class='btn btn-primary fixbtn' "
								+ "value='FIX' name='NOTICE_FIX' data-num='"
								+ item.notice_NUM
								+ "'>고정</button></div></td>"
					}
					output += "</tr>";
				});

				output += "</tbody>";
				$('table').append(output);

				$(".pagination").empty();
				output = "";

				digit = "«";
				href = "";
				if (data.page > 1) {
					href = "href=javascript:go(" + (data.page - 1)
							+ ")";
				}
				output += setPaging(href, digit);

				for (var i = data.startpage; i <= data.endpage; i++) {
					digit = i;
					href = "";
					if (i != data.page) {
						href = "href=javascript:go(" + i + ")";
					}
					output += setPaging(href, digit);
				}

				digit = "»";
				href = "";
				if (data.page < data.maxpage) {
					href = "href=javascript:go(" + (data.page + 1)
							+ ")";
				}
				output += setPaging(href, digit);

				$(".pagination").append(output);
				
				$('.selectionDelete').remove();
				output = '<button class="btn btn-danger selectionDelete">선택삭제</button>';
				$(".btn_group").prepend(output);
				
			}else if(data.listcount == 0){
				$("tbody").remove();
				$(".pagination").empty();
				$('.selectionDelete').remove();
			}
		}
	})
}

function allcheck(){
	if($("input[name='allCheck']")[0].checked == true){
		$("input[name='allCheck']")[0].checked = false;
	}
}

function selectionDelete(){
	var valueArr = new Array();
	 var list = $("input[name='RowCheck']");
	 for(var i = 0; i < list.length; i++){
		 if(list[i].checked){
			 valueArr.push(list[i].value);
		 }
	 }
	 if(valueArr.length == 0){
		$("#noSelectionModal").modal({backdrop: 'static', keyboard: false});
	 }else{
		 $("#DeleteModal").modal({backdrop: 'static', keyboard: false});
		 $("#Deletebtn").click(function(){
			 $("#DeleteModal").modal('hide');
			 $.ajax({
				url : 'noticeSelectionDelete',
				type : 'post',
				traditional : true,
				data : {valueArr : valueArr},
				success : function(data){
					if(data == valueArr.length){
						location.href="noticeList";
					}
				}
			 });
		 });
	 }
}

$(function() {
	$("div").on('click', '.fixbtn', function() {
		var fix = $(this);
		console.log(fix)
		$.ajax({
			type : "post",
			url : "noticeFixUpdate",
			context : this,
			data : {
				"fix" : fix.val(),
				"num" : fix.data("num")
			},
			dataType : 'json',
			success : function(data) {
				if (data.result == 1) {
					if (data.notice.notice_FIX == 'FIX') {
						$(this).val("").text("고정해제");
					} else {
						$(this).val("FIX").text("고정");
					}
				}
			}
		})
	}); // $(".fixbtn").click() end

	$("#search_word").keyup(function() {
		allcheck();
		go(1);
	}); // $("#search_word").keyup()
	
	var chkObj = $("input[name='RowCheck']");
	var rowCnt = chkObj.length;
	
	$('input[name="allCheck"]').click(function(){
		var chk_listArr = $('input[name="RowCheck"]');
		for(var i = 0; i < chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	}); // $('input[name="allCheck"]').click()
	
	$(document).on('click', 'input[name="RowCheck"]', function(){
		if($("input[name='RowCheck']").length != rowCnt){
			rowCnt = $("input[name='RowCheck']").length;
		}
		
		if($('input[name="RowCheck"]:checked').length == rowCnt){
			$("input[name='allCheck']")[0].checked = true;
		}else{
			$("input[name='allCheck']")[0].checked = false;
		}
	}); // $(document).on()
	
	$(".btn_group").on("click", ".selectionDelete", function(){
		selectionDelete();
	}); // $(".btn_group").on()
	
	$("#noticeAddForm").submit(function(){
		if($.trim($('#notice_subject').val()) == ''){
			$("#NoticeValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#NoticeValidationModal-body").html("<h3>제목을 입력해주세요</h3>");
			return false;
		}
		
		if($.trim($("#notice_content").val()) == ''){
			$("#NoticeValidationModal").modal({backdrop: 'static', keyboard: false});
			$("#NoticeValidationModal-body").html("<h3>내용을 입력해주세요</h3>");
			return false;
		}
	}); // $("#noticeAddModal").submit()
});