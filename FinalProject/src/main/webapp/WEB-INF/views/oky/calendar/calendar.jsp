<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.hta.project.domain.MyCalendar"%>
<%@page import="java.util.List"%>
<%@page import="com.hta.project.controller.OkyCalendarController"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script>

	//값이 1자리이면 두자리로 만들어 주는 기능
	function isTwo(str){
		return str.length<2?"0"+str:str;
	}
	
	$(function(){
		$(".countView").hover(function(){
			var aObj=$(this);
			var year=$(".y").text().trim();//년
			var month=$(".m").text().trim();//월
			var date=$(this).text().trim();//일
			var yyyyMMdd=year+isTwo(month)+isTwo(date)
//			alert(yyyyMMdd);
			$.ajax({
				method: "post", //전송방식
				url:"calcountajax", //요청URL
				data:{"yyyyMMdd": yyyyMMdd}, //전송 파라미터 //"yyyyMMdd="+yyyyMMdd
				dataType:"text", //서버로 부터 받는 값의 타입
				dataType:"json", //서버로 부터 받는 값의 타입
				async:false, // $.ajax()가 기본이 비동기식 실행이므로 false로 설정
				success:function(val){
//					alert("서버통신성공" + val);
                    aObj.after("<div class='cPreview'>" + val + "</div>");
				},
				error:function(){
//					alert('서버통신실패');
				}
			});
		}, function(){
			$(".cPreview").remove();//마우스가 나가면 해당 엘리먼트를 삭제한다.
		});
	});
	
</script>
</head>
<%  
    //달력의 날짜를 바꾸기 위해 전달된 year와 month 파라미터를 받는다.
    String paramYear=request.getParameter("year");
    String paramMonth=request.getParameter("month");
    
    
    Calendar cal = Calendar.getInstance(); //new (X)
    int year=cal.get(Calendar.YEAR);//현재 년도를 구함
    int month=cal.get(Calendar.MONTH)+1;//현재 월을 구함 (0월~11월)
    
    if(paramYear !=null) {
    	year = Integer.parseInt(paramYear);
    }    
    if(paramMonth !=null) {
    	month = Integer.parseInt(paramMonth);
    }
    //월이 증가하다 12보다 커지면(13,14...)넘어가는 현상을 처리
    if(month>12) {
    	month=1;//1월로 변경
    	year++;//년도는 다음해로 넘어가니깐 년도+1증가시키기
    }
    //감소의 경우 처리
    if(month<1) {
    	month=12;
    	year--;
    }    
    
    
    //현재 월의 1일에 대한 요일 구하기: 1~7 -->1(일요일), 2(월), 3()......7(토)
    // set(y, month-1, 1) --> month-1 : calendar기준 0~11, 우리기준 (1~12)
    cal.set(year, month-1, 1); //원하는 날짜로 넣어준다
    int dayOfWeek=cal.get(Calendar.DAY_OF_WEEK);
    
    //현재 월의 마지막 날 구하기
    int lastDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    
    //해당 달의 일정 받기
    List<MyCalendar> clist=(List<MyCalendar>)request.getAttribute("clist");
%>
<body>
<jsp:include page="../../main/header.jsp" /> 
<input type="hidden" id="id" value="${id}" name="id">
<style>
    #calendar{
         border-collapse: collapse;  /* 표의 테두리를 실선으로 표현한다 */
         border: 1px solid gray;
    }
    #calendar td{
        width: 80px;
        height: 80px;
        test-align: left;
        vertical-align: top;
    }
    #pen{
    width: 15px; height: 15px;
    } /* 연필그림 사이즈*/
    
    #container{
        width: 600px;
        margin: 0 auto;
    }
    
      #container td > a{
      text-decoration: none; /* 앵커태그 밑줄 지워짐*/  
      }
      
     #container td > a> p{
         margin-botton:1px;
         font-size: 7px;
         background-color: orange;
         color: white;        
     }
     
      
     td:hover {
         background-color: yellow;  
     }
     
     .cPreview{
         position: absolute;
         left:-20px;
         top:-30px;
         background: pink;
         width: 40px;
         height: 40px;
         text-align: center;
         line-height: 40px;
         foot-weight: bold;
         border-radius: 20px 20px 1px 20px
     }
     
     td{
          position: relative;
     }
     caption {
    display: table-caption;
    text-align: -webkit-center;
    caption-side: top;
    text-decoration: none; /* 앵커태그 밑줄 지워짐*/  
}
</style>
<div>농장명 : ${name} <br>
      아이디 : ${id}</div>
    <div id="container">
    <h1>일정달력보기</h1>
    <table border="1" id="calendar">
    <caption>
        <a href="calendar?name=${name}&year=<%=year-1%>&month=<%=month%>">◁</a>
        <a href="calendar?name=${name}&year=<%=year%>&month=<%=month-1%>">◀</a>
        <span class="y">
        <%=year%>
        </span>년
        <span class="m">
        <%=month%>
        </span>월 
        <a href="calendar?name=${name}&year=<%=year%>&month=<%=month+1%>">▶</a>
        <a href="calendar?name=${name}&year=<%=year+1%>&month=<%=month%>">▷</a>        
    </caption>
    <tr>
         <th>일</th>
         <th>월</th>
         <th>화</th>
         <th>수</th>
         <th>목</th>
         <th>금</th>
         <th>토</th>
    </tr>
    <tr>
        <%  //달력에서 시작하는 공백을 출력한다.
            //공백 출력하는 for문
            for(int i=0; i<dayOfWeek-1; i++){
            	out.print("<td>&nbsp;</td>");
            }
            //날짜 출력하는 for문
            for(int i=1; i<=lastDay; i++){
            	%>
            	<td>
            	     <a class="countView" style="color:<%=OkyCalendarController.fontColor(dayOfWeek, i)%>;" href="calboardlist?name=${name}&year=<%=year%>&month=<%=month%>&date=<%=i%>"><%=i%></a>
            	     <a href="insertcalform?name=${name}&year=<%=year%>&month=<%=month%>&date=<%=i%>">
            	     <c:if test="${level ==1}">
            	     		<img id="pen" src="${pageContext.request.contextPath}/resources/image/oky/pen.png" alt="일정추가"/>
            	     </c:if>
            	     </a>
             	     <%=getCalViewList(i, clist) %> 
            	</td>
            	<%
            	//행을 바꿔주기---> 현재일(i)이 토요일인지 확인: (공백수+현재날짜)한 값이 7로 나눠 떨어지면 7배수
            	if((dayOfWeek-1 + i)%7==0){
            		out.print("</tr><tr>");
            	}
            }
            //나머지 공백 출력하는 for문
            int countNbsp=(7-(dayOfWeek-1 + lastDay)%7)%7; //모듈러스 연산자
            for(int i=0; i<countNbsp; i++) {
            	out.print("<td>&nbsp;</td>");
            }
        %>   
    </tr>        
</table>
</div>

 <%!
    public String getCalViewList(int i, List<MyCalendar> clist){
	   String d=OkyCalendarController.isTwo(i+""); // mdate--> "05"
	   String cList="";//달력에 출력해줄 일정제목을 저장할 변수
	   for(MyCalendar cal: clist){
		   if(cal.getMdate().substring(6, 8).equals(d)){
			   cList+="<a href='caldetail?name=" + cal.getName()+ "&seq=" + cal.getSeq() +  "&year="+ "2021"  +"&month=" + "10" +"'><p>"
		+(cal.getTitle().length() > 7 ? cal.getTitle().substring(0, 7) + "..." : cal.getTitle())
					+"</p></a>";
		   }
	   }
	   return cList; //결과: "<p>title</p><p>title</p>"
}
%> 
</body>
</html>
