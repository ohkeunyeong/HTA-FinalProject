<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.hta.project.domain.MyCalendar"%>
<%@page import="java.util.List"%>
<%@page import="com.hta.project.controller.CalendarController"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캘린더</title>
<jsp:include page="../../main/header.jsp" /> 
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
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
                    aObj.before("<span class='cPreview' style='padding:0px 95px 0px 0px;'>총 일정 갯수 :" + val + "</span>");
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
<body style="overflow-x:hidden; overflow-y:auto;">
<br><br><br>
<input type="hidden" id="id" value="${id}" name="id">
<style>
    #pen{
    width: 15px; height: 15px;
    } /* 연필그림 사이즈*/
     
     a> p{
         font-size: 11px;
         background-color: #28a745;
         color: white;        
     } 
     

     
/**
 * ALL the UI design credit goes to:
 * https://www.sketchappsources.com/free-source/2676-calendar-template-sketch-freebie-resource.html
 */


/* WRAPPER */

.wrapper {
  display: grid;
  grid-template-rows: 70px 1fr 70px;
  grid-template-columns: 1fr;
  grid-template-areas: "sidebar"
                       "content";
  width: 100vw; /* unnecessary, but let's keep things consistent */
  height: 100vh;
}

@media screen and (min-width: 850px) {
  .wrapper {
    grid-template-columns: 200px 5fr;
    grid-template-rows: 1fr;
    grid-template-areas: "sidebar content";
  }
}



/* SIDEBAR */

main {
  grid-area: content;
  padding: 48px;
}

sidebar {
  grid-area: sidebar;
  display: grid;
  grid-template-columns: 1fr 3fr 1fr;
  grid-template-rows: 3fr 1fr;
  grid-template-areas: "logo menu avatar"
                       "copyright menu avatar";
}
.logo {
  display: flex;
  align-items: center;
  justify-content: center;
}
.copyright {
  text-align: center;
}
.avatar {
  grid-area: avatar;
  display: flex;
  align-items: center;
  flex-direction: row-reverse;
}
.avatar__name {
  flex: 1;
  text-align: right;
  margin-right: 1em;
}
.avatar__img > img {
  display: block;
}

.copyright {
  grid-area: copyright;
}
.menu {
  grid-area: menu;
  display: flex;
  align-items: center;
  justify-content: space-evenly;
}
.logo {
  grid-area: logo;
}
.menu__text {
  display: none;
}

@media screen and (min-width: 850px) {
  sidebar {
    grid-template-areas: "logo"
                         "avatar"
                         "menu"
                         "copyright";
    grid-template-columns: 1fr;
    grid-template-rows: 50px auto 1fr 50px;
  }
  
  .menu {
    flex-direction: column;
    align-items: normal;
    justify-content: flex-start;
  }
  .menu__text {
    display: inline-block;
  }
  .avatar {
    flex-direction: column;
  }
  .avatar__name {
    margin: 1em 0;
  }
  .avatar__img > img {
    border-radius: 50%;
  }
}




/* MAIN */

.toolbar{
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}
.calendar{}

.calendar__week,
.calendar__header {
  display: grid;
  grid-template-columns: repeat(7, 1fr);  
}
.calendar__week {
  grid-auto-rows: 100px;
  text-align: right;
}

.calendar__header {
  grid-auto-rows: 50px;
  align-items: center;
  text-align: center;
}

.calendar__day {
  padding: 16px;
}




/* COSMETIC STYLING */

:root {
  --red: #ED5454;
}

.wrapper {
/*   font-family: Montserrat; 
  font-weight: 100;  */
  color: #A8B2B9;  
} 

sidebar {
  background-color: white;
  box-shadow: 5px 0px 20px rgba(0, 0, 0, 0.2);
}

main {
  background-color: #FCFBFC;
}

.avatar__name {
  font-size: 0.8rem;
}

.menu__item {
  text-transform: uppercase;
  font-size: 0.7rem;
  font-weight: 500;
  padding: 16px 16px 16px 14px;
  border-left: 4px solid transparent;
  color: inherit;
  text-decoration: none;
  transition: color ease 0.3s;
}

.menu__item--active .menu__icon {
  color: var(--red);
}
.menu__item--active .menu__text {
  color: black;
}

.menu__item:hover {
  color: black;
}


.menu__icon {
  font-size: 1.3rem;
}

@media screen and (min-width: 850px) {
  .menu__icon {
    font-size: 0.9rem;
    padding-right: 16px;
  }
  .menu__item--active {
    border-left: 4px solid var(--red);
    box-shadow: inset 10px 0px 17px -13px var(--red);
  }
}

.copyright {
  font-size: 0.7rem;
  font-weight: 400;
}

.calendar {
  background-color: white;
  border: 1px solid #e1e1e1;
}

.calendar__header > div {
  text-transform: uppercase;
  font-size: 0.8em;
  font-weight: bold;
}

.calendar__day {
  border-right: 1px solid #e1e1e1;
  border-top: 1px solid #e1e1e1;
}

.calendar__day:last-child {
  border-right: 0;
}

.toggle{
  display: grid;
  grid-template-columns: 1fr 1fr;

  text-align: center;
  font-size: 0.9em;
}
.toggle__option{
  padding: 16px;
  border: 1px solid #e1e1e1;
  border-radius: 8px;
  text-transform: capitalize;
  cursor: pointer;
}
.toggle__option:first-child {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}
.toggle__option:last-child {
    border-left: 0;
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}
.toggle__option--selected{
  border-color: white;
  background-color: white;
  color: var(--red);
  font-weight: 500;
  box-shadow: 1px 2px 30px -5px var(--red);
}
</style>
<div class="wrapper">
  <main>
    <div class="toolbar">
<!--       <div class="toggle">
        <div class="toggle__option">week</div>
        <div class="toggle__option toggle__option--selected">month</div>
      </div> -->
      <div class="caption">
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
	</div>
<!--       <div class="search-input">
        <input type="text" value="What are you looking for?">
        <i class="fa fa-search"></i>
      </div> -->
    </div>
    <div class="calendar">
      <div class="calendar__header">
        <div>일</div>
        <div>월</div>
        <div>화</div>
        <div>수</div>
        <div>목</div>
        <div>금</div>
        <div>토</div>
      </div>
      <div class="calendar__week">
        <%
        	//달력에서 시작하는 공백을 출력한다.
                    //공백 출력하는 for문
                    for(int i=0; i<dayOfWeek-1; i++){
                    	out.print("<div class='calendar__day day'></div>");
                    }
                    //날짜 출력하는 for문
                    for(int i=1; i<=lastDay; i++){
        %>      
       <div class="calendar__day day">
            	     <a class="countView" style="color:<%=CalendarController.fontColor(dayOfWeek, i)%>; text-decoration: none;" href="calboardlist?name=${name}&year=<%=year%>&month=<%=month%>&date=<%=i%>"><%=i%></a>
            	     <a href="insertcalform?name=${name}&year=<%=year%>&month=<%=month%>&date=<%=i%>">
            	     <c:if test="${level ==1}">
            	     		<img id="pen" src="${pageContext.request.contextPath}/resources/image/oky/pen.png" alt="일정추가"/>
            	     </c:if>
            	     </a>
             	     <%=getCalViewList(i, clist) %> 
      </div> 
            	<%
            	//행을 바꿔주기---> 현재일(i)이 토요일인지 확인: (공백수+현재날짜)한 값이 7로 나눠 떨어지면 7배수
            	if((dayOfWeek-1 + i)%7==0){
            		out.print("</div><div class='calendar__week'>");
            	}
            }
            //나머지 공백 출력하는 for문
            int countNbsp=(7-(dayOfWeek-1 + lastDay)%7)%7; //모듈러스 연산자
            for(int i=0; i<countNbsp; i++) {
            	out.print("<div class='calendar__day day'></div>");
            }
        %>          
        </div>     
      <!-- <div class="calendar__week">
        <div class="calendar__day day">1</div>
        <div class="calendar__day day">2</div>
        <div class="calendar__day day">3</div>
        <div class="calendar__day day">4</div>
        <div class="calendar__day day">5</div>
        <div class="calendar__day day">6</div>
        <div class="calendar__day day">7</div>
      </div>
      <div class="calendar__week">
        <div class="calendar__day day"></div>
        <div class="calendar__day day"></div>
        <div class="calendar__day day"></div>
        <div class="calendar__day day"></div>
        <div class="calendar__day day"></div>
        <div class="calendar__day day"></div>
        <div class="calendar__day day"></div>        
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">15</div>
        <div class="calendar__day day">16</div>
        <div class="calendar__day day">17</div>
        <div class="calendar__day day">18</div>
        <div class="calendar__day day">19</div>
        <div class="calendar__day day">20</div>
        <div class="calendar__day day">21</div>    
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">22</div>
        <div class="calendar__day day">23</div>
        <div class="calendar__day day">24</div>
        <div class="calendar__day day">25</div>
        <div class="calendar__day day">26</div> 
        <div class="calendar__day day">27</div> 
        <div class="calendar__day day">28</div> 
      </div>
      <div class="calendar__week">
        <div class="calendar__day day">29</div>
        <div class="calendar__day day">30</div>
        <div class="calendar__day day">31</div>
        <div class="calendar__day day">1</div>
        <div class="calendar__day day">2</div>
        <div class="calendar__day day">3</div>
        <div class="calendar__day day">4</div>
      </div> -->
    </div>
  </main>
  <sidebar>
   <!--  <div class="logo">logo</div> -->
    <div class="avatar">
      <div class="avatar__img">
        <img src="https://picsum.photos/70" alt="avatar">
      </div>
      <div class="avatar__name">John Smith</div>
    </div>
    <nav class="menu">
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-home"></i>
        <span class="menu__text">overview</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-envelope"></i>
        <span class="menu__text">messages</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-list"></i>
        <span class="menu__text">workout</span>
      </a>
      <a class="menu__item menu__item--active" href="#">
        <i class="menu__icon fa fa-calendar"></i>
        <span class="menu__text">calendar</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-bar-chart"></i>
        <span class="menu__text">goals</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-trophy"></i>
        <span class="menu__text">achivements</span>
      </a>
      <a class="menu__item" href="#">
        <i class="menu__icon fa fa-sliders"></i>
        <span class="menu__text">measurements</span>
      </a>
    </nav>
    <div class="copyright">copyright &copy; 2018</div>
  </sidebar>
</div>
 <%!public String getCalViewList(int i, List<MyCalendar> clist){
	   String d=CalendarController.isTwo(i+""); // mdate--> "05"
	   String cList="";//달력에 출력해줄 일정제목을 저장할 변수
	   for(MyCalendar cal: clist){
		   if(cal.getMdate().substring(6, 8).equals(d)){
			   cList+="<a style='text-decoration: none; text-align:left;' href='caldetailmain?name=" + cal.getName()+ "&seq=" + cal.getSeq() +"'><p style='margin-bottom: 0.3rem;'>"
		+(cal.getTitle().length() > 20 ? cal.getTitle().substring(0, 20) + "..." : cal.getTitle())
					+"</p></a>";
		   }
	   }
	   return cList; //결과: "<p>title</p><p>title</p>"
}%> 
<jsp:include page="../../main/footer.jsp" /> 
</body>
</html>
