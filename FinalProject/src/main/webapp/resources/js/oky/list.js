function go(page) {
	var path = $("#path").val();
	var view = $("#view").val(); //최신순부터 값은 1~3
	var search = $("#search").val(); //검색어
	var setype = $("#searchType").val(); //검색어 타입
	var id= $("#id").val();
	var name = $("#name").val();
	console.log(search)
	console.log(setype)
	console.log(view)
	console.log(page)
	console.log(id)
	console.log(name)
	
	if (!$("#search").val()) {
	var data = "name=" + name +"&view=" + view + "&state=ajax&page=" + page;	
//	{
//	    		"view" : view,
//			    "page" : page,		
//			    "name" : name
//		};
	} else {
	var data = "name=" + name +"&view=" + view + "&state=ajax&page=" + page + "&type=" + setype + "&search=" + search;	
//	{
//    		"view"  : view,
//		    "page"  : page,		
//		    "name"  : name,
//		    "type"  : setype,
//		    "search": search
//	};
	}
	
	console.log(data)
	ajax(data);	
}


function setPaging(href, digit) {
	var output ="<li class=page-item>";
	gray="";
	if(href=="") {
		gray = " gray";
	}
	anchor = "<a class='page-link" + gray + "'" + href + ">" + digit + "</a></li>";
	output += anchor;
	return output;
}

function ajax(sdata) {
	var path = $("#path").val();
	console.log(sdata)
	output = "";
	$.ajax({
		type : "POST",
		data : sdata,
		url : "list_ajax",
		dataType : "json",
		cache : false,
		success : function(data) {
			$("#viewcount").val(data.limit);
			$("table").find("font").text("글 개수: " + data.listcount);
			
			if (data.listcount> 0) { //총 갯수가 0보다 큰 경우
				$("tbody").remove();
				var num = data.listcount - (data.page - 1) * data.limit;
				console.log(num)
				console.log(data.boardlist)
				var output = "<tbody>";
				$(data.boardlist).each(
						function(index, item) {
						    output += '<tr><td>' + (num--) + '</td>'
						    blank_count = item.nong_re_lev * 2 + 1;
						    blank = '&nbsp;';
						    for (var i =0 ; i < blank_count; i++){
						    	blank += '&nbsp;&nbsp;';
						    }
						    img="";
						    if (item.nong_re_lev > 0) {
						    	img="<img src='" + path + "/resources/image/oky/line.gif'>";
						    }
						    
						    output += "<td colspan=2 id='subject'><div>" + blank + img
						    output += ' <a href="nongdetail?name='+ item.name + '&num=' + item.nong_num + '">'
						    output += item.nong_sub.replace(/</g,'&lt;').replace(/>/g,'&gt;')
						    output += '<span class="gray small"> [' + item.cnt   + ']<span></a></div></td>'
						    output += '<td><div>' + item.id + '</div></td>'
						    output += '<td><div>' + item.nong_date + '</div></td>'
						    output += '<td><div>' + item.nong_read + '</div></td>'
						})
				   output += "</tbody>"
				   $('table').append(output) //table 완성
				   
				   $(".pagination").empty(); //페이징 처리 영역 내용 제거
				   output = "";
				   
				   digit = '이전&nbsp;'
				   href="";
				   if (data.page > 1) {
					   href = 'href=javascript:go(' + (data.page - 1) + ')';
				   }
				   output += setPaging(href, digit);
				   
				   for (var i = data.startpage; i <= data.endpage; i ++) {
					   digit = i;
					   href= "";
					   if (i != data.page) {
						   href = 'href=javascript:go(' + i + ')';
					   }
					   output += setPaging( href, digit);
				   }
				   digit = '&nbsp;다음&nbsp;';
				   href="";
				   if (data.page < data.maxpage) {
					   href = 'href=javascript:go(' + (data.page + 1) + ')';
				   }
				   output += setPaging( href, digit);
				   
				   $('.pagination').append(output)				
			}//if(data.listcount) end
			else { //카테고리에 글이 없는 경우
				$("tbody").remove();
				var output = "<tbody>";
				output += "<tr><td colspan=6><div>등록된 글이 없습니다.</div></td></tr>"
				 output += "</tbody>"
					   $('table').append(output)
				$(".pagination").empty();
			}			
		}, //succes end
		error: function() {
			console.log('에러')
		}
	})// ajax end
}//function ajax end


$(function() {
	$("#view").change(function(){ //최신순, 등록순, 조회순 변경 시
		$("#search").val("");
		go(1); 
	}); 
	
	$("#searchbtn").click(function(){
		if (!$("#search").val()){
			return false
		} else {			
			go(1);
		}
	})	
	
	$(document).keypress(function(e) { //엔터키 방지
		if (e.keyCode == 13) e.preventDefault(); 
		});
})   