function userlist(){
	$.ajax({
		type : "post",
		url : "main_userList",
		dataType : 'json',
		success : function(data){
			$('.mainUserListBody > table > tbody').remove();
			var output = "<tbody>";
			$(data.userlist).each(function(index, item){
				output += "<td>" + item.name + "</td>";
				output += "<td><a href='userInfo?id=" + item.id + "'>" 
					    + item.id + "</a></td>";
				output += "<td>" + item.nick + "</td>";
				output += "<td>";
				if(item.mynong_name == null || item.mynong_name == ''){
					output += "</td>";
				}else{
					output += item.mynong_name +"</td>";
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
				output += "</tr>";
			});
			
			output += "</tbody>";
			$('.mainUserListBody > table').append(output);
		}
	});
}

$(function(){
	userlist();
});