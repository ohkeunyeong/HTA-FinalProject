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
		url : "orderList_search",
		data : sdata,
		dataType : 'json',
		success : function(data) {
			$(".card-title").text("주문건수 : " + data.listcount);
			if (data.listcount > 0) {
				$("tbody").remove();
				var output = "<tbody>";
				$(data.orderlist).each(function(index, item) {
					var address = String(item.user_address1).substring(0, 3) + "-" +  String(item.user_address1).substring(3, 6);
					output += "<td><div><a href='orderDetail?order_num="
							+ item.order_num + "'>"+ item.order_num +"</a>"
							+ "</div></td>";
					output += "<td><div><span>"
							+ item.order_name
							+ "</span></div></td>";
					output += "<td><div><span>"
							+ address + " " + item.user_address2
							+ "</span></div></td>";
					output += "<td><div><span>"
							+ Number(item.order_totalprice).toLocaleString('en') + "원"
							+ "</span></div></td>";
					output += "<td><div><span>"
							+ item.order_date
							+ "</span></div></td>";
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
				$(".orderNo").remove();
				
			}else if(data.listcount == 0){
				$(".orderNo").remove();
				var message = "<p class='text-center h2 mt-3 mb-3 orderNo'><span>주문건수가 없습니다.</span></p>";
				$("tbody").remove();
				$(".pagination").empty();
				$('.card-body').append(message);
			}
		}
	})
}

$(function() {
	$("#search_word").keyup(function() {
		go(1);
	}); // $("#search_word").keyup()
})