function go(page) {
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
		url : "userList_search",
		data : sdata,
		dataType : 'json',
		success : function(data) {
			$(".card-title").text("회원수 : " + data.listcount);
			if (data.listcount > 0) {
				$("tbody").remove();
				var num = data.listcount - (data.page - 1) * data.limit;
				var output = "<tbody>";
				$(data.userlist).each(function(index, item) {
					output += "<td><div>"
							+ item.name
							+ "</div></td>";
					output += "<td><div><a href='userInfo?id=" + item.id + "'>"
							+ item.id
							+ "</a></div></td>";
					output += "<td><div>"
							+ item.nick
							+ "</div></td>";
					output += "<td><div>";
					if(item.mynong_name == null || item.mynong_name == ''){
						output += "</div></td>";
					}else{
						output += item.mynong_name +"</div></td>";
					}
							
					output += "<td>";
					if (item.my_farm == '0') {
						output += "<div>일반멤버</div>";
					} else if(item.my_farm == '1'){
						output += "<div>농장 관리자</div>";
					} else if(item.my_farm == '2'){
						output += "<div>농장멤버</div>";
					}
					output += "</td>";
					output += "<td><div>" + item.mail + "</div></td>";
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
				
			}else if(data.listcount == 0){
				$("tbody").remove();
				$(".pagination").empty();
			}
		}
	})
}

$(function() {
	$("#search_word").keyup(function() {
		go(1);
	}); // $("#search_word").keyup()
})