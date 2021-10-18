function go(page) {
	var farmSelect = $("#farmSelect").val();
	var data = "farmSelect=" + farmSelect + "&page=" + page;
	farmSelect_ajax(data);
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

function farmSelect_ajax(sdata) {
	$.ajax({
		type : "post",
		url : "farmList_ajax",
		data : sdata,
		dataType : 'json',
		success : function(data) {
			console.log(data);
			if (data.listcount > 0) {
				$(".card-body").remove();
				var output = "<div class='card-body'>";
				$(data.farmlist).each(function(index, item) {
					output += "<div class='row border mb-3'>" 
						    + "<div class='col-12 col-sm-5'>"
						    + "<div class='col-12 mt-5 ml-5'>";
					output += "<img src='/project/upload" + item.original + "' style='width: 200px; height: 200px'>";
					output += "</div></div>";
					output += "<div class='col12 col-sm-6'>"
							+ "<div class='col-12 mt-3'>"
							+ "<div class='input-group'>";
					output += "<p class='h4 p-2'>농장이름 : <span>" + item.mynong_name + "</span></p>";
					output += "</div></div>";
					output += "<div class='col-12 mt-3'><div class='input-group'>";
					output += "<p class='h4 p-2'>농장관리자 : <span>" + item.name + "</span></p></div></div>";
					output += "<div class='col-12 mt-3'><div class='input-group'>";
					output += "<p class='h4 p-2'>농장인원수 : <span>" + item.membercnt + "</span></p></div></div>";
					output += "<div class='col-12 mt-3'><div class='input-group'>";
					output += "<p class='h4 p-2'>농장등록일 : <span>" + item.mynong_date + "</span></p></div></div>";
					output += "</div></div>";
				});

				output += "</div>";
				$('.card-header').after(output);

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
				
			}
		}
	})
}

$(function(){
	$("#farmSelect").change(function(){
		go(1);
	});
});