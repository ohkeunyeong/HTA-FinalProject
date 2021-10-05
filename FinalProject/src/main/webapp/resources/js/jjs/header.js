function onGeoOk(position) {
	let weatherIcon = {
	  "01": "fas fa-sun",
	  "02": "fas fa-cloud-sun",
	  "03": "fas fa-cloud",
	  "04": "fas fa-cloud-meatball",
	  "09": "fas fa-cloud-sun-rain",
	  10: "fas fa-cloud-showers-heavy",
	  11: "fas fa-poo-storm",
	  13: "fas fa-snowflake",
	  50: "fas fa-smog",
	};
	
  const lat = position.coords.latitude;
  const lon = position.coords.longitude;
  $.ajax({
	     url: "/project/api/weather",
	     data: {"lat":lat, "lon":lon},
	     dataType: "json",
	     type: "POST",
	     success: function (data) {
	    	 console.log(data);
	         const icon = data.weather[0].icon.substr(0, 2);
	         const name = data.name;
	         const temp = Math.floor(data.main.temp) + "º";
	         $(".CurrIcon").append('<i class="' + weatherIcon[icon] + '"></i>');
	         $(".CurrTemp").prepend(temp);
	         $(".City").append(name);
	     },
	   });
}

function onGeoError() {
  console.log("날씨정보 불러오기 실패");
}

$(function(){
	navigator.geolocation.getCurrentPosition(onGeoOk, onGeoError);
	
	$("#login").click(function(){
		$.ajax({
			url : "member/login",
			type : "post",
			success : function(data){
				console.log(data.saveid);
				if(data.saveid != null){
					$('#id').val(data.saveid);
					$('#remember').prop('checked', true);
				}
			}
		})
		$("#loginModal").modal({backdrop : 'static', keyboard: false});
	});
	
	$('#loginForm').submit(function(){
		if($.trim($('#id').val()) == ''){
			$('#id-message').text('아이디를 입력하세요').css('color', 'red');
			return false;
		}
		if($.trim($('#pass').val()) == ''){
			$('#pass-message').text('비밀번호를 입력하세요').css('color', 'red');
			return false;
		}
	});
	
	$('#id').keyup(function(){
		if($('#id-message').text() != ''){
			$('#id-message').text('');
		}
	});
	
	$('#pass').keyup(function(){
		if($('#pass-message').text() != ''){
			$('#pass-message').text('');
		}
	});
});