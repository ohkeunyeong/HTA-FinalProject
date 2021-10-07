$(document).ready(function () {  
	
$("#insertacc").click(function(){
 num = /^[0-9]*$/;
 
 if(!num.test($("#amount").val())){
	 alert("금액은 숫자만 입력 가능합니다.")
	 $("#amount").val('').focus();		
	 return false;
 }
	
})

$("#updateaccbtn").click(function(){
 num = /^[0-9]*$/;
 
 if(!num.test($("#upamount").val())){
	 alert("금액은 숫자만 입력 가능합니다.")
	 $("#upamount").val('').focus();		
	 return false;
 }
	
})

});

function checkTarget(num) {
	var element = document.getElementById('thisdate');
	  element.innerHTML = num;
	$("#inputdate").val(num);
}

function accupdate(seq ,title, amount, date, hour, min) {
	$("#upseq").val(seq);
	$("#uptitle").val(title);
	$("#upamount").val(amount);
	$("#update").val(date).prop("selected", true);	
	$("#uphour").val(hour).prop("selected", true);
	$("#upmin").val(min).prop("selected", true);
	
}

function accdelete(seq) {
	if(confirm("삭제하시겠습니까?")){
		location.href='accdelete?name=${name}&year=${year}&month=${month}&seq='+seq; 
	}else {
		alert('취소')
	}
}