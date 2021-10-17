  function allSel(val){
	  
	  var chks=document.getElementsByName("seq");
	  for(var i=0; i<chks.length; i++){
		  chks[i].checked=val;
	  }
	  
  }
  
  $(function(){
	  $("form").submit(function(){
		  var bool=true;
		  var count=$(this).find("input[name=seq]:checked").length;
		  if(count==0){
			  alert('하나 이상 체크하세요');
			  bool=false;			  
		  }else if(confirm("삭제하시겠습니까?")){
			  bool=true;
		  }else{
			  bool=false;
		  }
		  return bool;
	  });
	  
	  //체크박스 처리: 전체선택 체크박스 체크/해제를 자동으로 하는 기능
	  var chks=document.getElementsByName("seq");
	  for(var i=0; i<chks.length; i++){
		  chks[i].onclick = function(){//체크박스 클릭 이벤트 시
			  var checkedObjs=document.querySelectorAll("input[name=seq]:checked");
		  	  if(checkedObjs.length==chks.length){
		  		document.getElementsByName("all")[0].checked=true;//체크해줌
		  	  }else{
		  		document.getElementsByName("all")[0].checked=false;//체크해줌  
		  	  }			  
		   }
		}
  })