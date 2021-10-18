<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<jsp:include page="../../main/header.jsp" />
	<script src="../resources/js/chang/writeform.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style>
	h1{font-sie:1.5rem; text-align:center; color:#1a92b9}
	.container{width:60%}
	label{font-wight:bold}
	#upfile{display:none}
	#f{width:20px}
	.container.left{text-align: left;}
	#att_zone{
	width: 660px;
	min-height:150px;
	padding:10px;
	border:1px dotted #00f;
}
#att_zone:empty:before{
	content : attr(data-placeholder);
	color : #999;
	font-size:.9em;
}
	</style>
</head>
<body>
  <div class="container">
   <form action="add" method="post" enctype="multipart/form-data" name="jikform" onsubmit="return registerAction()">
     <h1>MVC 게시판 -write 페이지</h1>
     <div class="form-group">
     	<label for="nick">글쓴이</label>
     	<input name="nick" id="nick" value="${nick}"
     		   readOnly
     		   type="text"	size="10" maxlength="30"
     		   class="form-control"
     		   placeholder="Enter nick">
     </div>

     <div class="form-group">
       <label for="jik_subject">제목</label>
       <input name="jik_subject" id="jik_subject" type="text" maxlength="100"
     			class="form-control"	placeholder="Enter jik_subject">
     </div>	
     
<div class="form-group">
  	<button id="btn-upload" type="button" style="border: 1px solid #ddd; outline: none;">파일 추가</button>
  	<input id="input_file" multiple="multiple" type="file" style="display:none;">
  	<span style="font-size:10px; color: gray;">※첨부파일은 최대 10개까지 등록이 가능합니다.</span>
  	<div class="data_file_txt" id="data_file_txt" style="margin:40px;">
		<div id='att_zone' 
	      data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'></div>
	</div>
</div>
     
     <div class="form-group">
       <label for="jik_content">내용</label>
       <textarea name="jik_content" id="jik_content" 
     			rows="10" 	class="form-control"></textarea>
     </div>	
     <div class="form-group">
     	<button type=submit class="btn btn-primary">등록</button>
     	<button type=reset  class="btn btn-danger">취소</button>
     </div>
     <input type="hidden" name="jik_id" id="jik_id" value="${id}">
   </form>
  </div>
  
  <script>
$(document).ready(function()
		// input file 파일 첨부시 fileCheck 함수 실행
		{
			$("#input_file").on("change", fileCheck);
		});

/**
 * 첨부파일로직
 */
$(function () {
    $('#btn-upload').click(function (e) {
        e.preventDefault();
        $('#input_file').click();
    });
});

// 파일 현재 필드 숫자 totalCount랑 비교값
var fileCount = 0;
// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
var totalCount = 10;
// 파일 고유넘버
var fileNum = 0;
// 첨부파일 배열
var content_files = new Array();

function fileCheck(e) {
    var files = e.target.files;
    
    // 파일 배열 담기
    var filesArr = Array.prototype.slice.call(files);
    
    // 파일 개수 확인 및 제한
    if (fileCount + filesArr.length > totalCount) {
      $.alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
      return;
    } else {
    	 fileCount = fileCount + filesArr.length;
    }
    
    // 각각의 파일 배열담기 및 기타
    filesArr.forEach(function (f) {
      var reader = new FileReader();
      reader.onload = function (e) {
        content_files.push(f);
        $('#articlefileChange').append(
       		'<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
       		+ '<font style="font-size:15px">' + f.name + " " + '</font>'
       		+ '<img src="../resources/image/chang/remove.png" style="width:12px; height:auto; vertical-align: middle; cursor: pointer;"/>' 
       		+ '<div/>'
		);
        fileNum ++;
      };
      reader.readAsDataURL(f);
    });
    console.log(content_files);
    //초기화 한다.
    $("#input_file").val("");
  }

// 파일 부분 삭제 함수
function fileDelete(fileNum){
    var no = fileNum.replace(/[^0-9]/g, "");
    content_files[no].is_delete = true;
	$('#' + fileNum).remove();
	fileCount --;
    console.log(content_files);
}

/*
 * 폼 submit 로직
 */
	function registerAction(){
		
	var form = $("form")[0];        
 	var formData = new FormData(form);
		for (var x = 0; x < content_files.length; x++) {
			// 삭제 안한것만 담아 준다. 
			if(!content_files[x].is_delete){
				 formData.append("article_file", content_files[x]);
			}
		}
   /*
   * 파일업로드 multiple ajax처리
   */    
	$.ajax({
   	      type: "POST",
   	   	  enctype: "multipart/form-data",
   	      url: "../jik/file-upload",
       	  data : formData,
       	  processData: false,
   	      contentType: false,
   	      success: function (data) {
   	    	if(JSON.parse(data)['result'] == "OK"){
   	    		alert("파일업로드 성공");
			} else
				alert("서버내 오류로 처리가 지연되고있습니다. 잠시 후 다시 시도해주세요");
   	      },
   	      error: function (xhr, status, error) {
   	    	alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
   	     return false;
   	      }
   	    });
   	    return false;
	}
	  ( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
	    imageView = function imageView(att_zone, btn){

	      var attZone = document.getElementById(att_zone);
	      var btnAtt = document.getElementById(btn)
	      var sel_files = [];
	      
	      // 이미지와 체크 박스를 감싸고 있는 div 속성
	      var div_style = 'display:inline-block;position:relative;'
	                    + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
	      // 미리보기 이미지 속성
	      var img_style = 'width:100%;height:100%;z-index:none';
	      // 이미지안에 표시되는 체크박스의 속성
	      var chk_style = 'width:30px;height:30px;position:absolute;font-size:24px;'
	                    + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,255,255,0.1);color:#f00';
	    
	      btnAtt.onchange = function(e){
	        var files = e.target.files;
	        var fileArr = Array.prototype.slice.call(files)
	        for(f of fileArr){
	          imageLoader(f);
	        }
	      }  
	      
	    
	      // 탐색기에서 드래그앤 드롭 사용
	      attZone.addEventListener('dragenter', function(e){
	        e.preventDefault();
	        e.stopPropagation();
	      }, false)
	      
	      attZone.addEventListener('dragover', function(e){
	        e.preventDefault();
	        e.stopPropagation();
	        
	      }, false)
	    
	      attZone.addEventListener('drop', function(e){
	        var files = {};
	        e.preventDefault();
	        e.stopPropagation();
	        var dt = e.dataTransfer;
	        files = dt.files;
	        for(f of files){
	          imageLoader(f);
	        }
	        
	      }, false)
	      

	      
	      /*첨부된 이미리즐을 배열에 넣고 미리보기 */
	      imageLoader = function(file){
	        sel_files.push(file);
	        var reader = new FileReader();
	        reader.onload = function(ee){
	          let img = document.createElement('img')
	          img.setAttribute('style', img_style)
	          img.src = ee.target.result;
	          attZone.appendChild(makeDiv(img, file));
	        }
	        
	        reader.readAsDataURL(file);
	      }
	      
	      /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
	      makeDiv = function(img, file){
	        var div = document.createElement('div')
	        div.setAttribute('style', div_style)
	        
	        var btn = document.createElement('input')
	        btn.setAttribute('type', 'button')
	        btn.setAttribute('value', 'x')
	        btn.setAttribute('delFile', file.name);
	        btn.setAttribute('style', chk_style);
	        btn.onclick = function(ev){
	          var ele = ev.srcElement;
	          var delFile = ele.getAttribute('delFile');
	          for(var i=0 ;i<sel_files.length; i++){
	            if(delFile== sel_files[i].name){
	              sel_files.splice(i, 1);      
	            }
	          }
	          
	          dt = new DataTransfer();
	          for(f in sel_files) {
	            var file = sel_files[f];
	            dt.items.add(file);
	          }
	          btnAtt.files = dt.files;
	          var p = ele.parentNode;
	          attZone.removeChild(p)
	        }
	        div.appendChild(img)
	        div.appendChild(btn)
	        return div
	      }
	    }
	  )('att_zone', 'data_file_txt')

</script>
</body>
</html>