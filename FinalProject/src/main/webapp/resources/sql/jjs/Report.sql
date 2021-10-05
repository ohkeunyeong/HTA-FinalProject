drop table report;

create TABLE REPORT(
	REPORT_NUM NUMBER(3) PRIMARY KEY,
	BOARD_NUM NUMBER(3),
	BOARD_NICK VARCHAR2(50),
	BOARD_SUBJECT VARCHAR2(500),
	BOARD_CONTENT VARCHAR2(2000),
	REPORT_CONTENT VARCHAR2(2000),
	BOARD_TABLE VARCHAR2(50),
	REPORT_DATE DATE
)

SELECT *
FROM REPORT;

create sequence report_seq;
drop sequence report_seq;

insert into REPORT
values(report_seq.nextval, 1, 'asd', '제목', '내용', '부적절한 게시물로 신고합니다.', 'jik', sysdate);

insert into REPORT
values(report_seq.nextval, 2, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'work', sysdate);

insert into REPORT
values(report_seq.nextval, 2, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'work', sysdate);

insert into REPORT
values(report_seq.nextval, 3, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'free', sysdate);

insert into REPORT
values(report_seq.nextval, 4, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'free', sysdate);

insert into REPORT
values(report_seq.nextval, 1, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'jik', sysdate);

insert into REPORT
values(report_seq.nextval, 1, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'jik', sysdate);

insert into REPORT
values(report_seq.nextval, 1, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'jik', sysdate);

insert into REPORT
values(report_seq.nextval, 1, 'asd', '제목', '내용', '부적절한 글로 신고합니다.', 'jik', sysdate);

delete report;

select report_num, board_num, jik_subject, report_content, board_table, report_date
		from (select rownum rnum, r.*
			  from (select *
			  		from report, jik
			  		order by report_date desc) r
			 )
		where rnum >= 1 and rnum <= 7
		
select report_num, board_num, jik_subject board_subject, 
	   nick board_nickname, report_date, jik_content board_content, 
	   report_content, board_table
from report, jik
where report.report_num = 1;

select report_num, board_num, jik_subject board_subject, 
	   		   nick board_nickname, report_date, jik_content board_content, 
	   		   report_content, board_table
		from report, jik
		where report.report_num = 55

select *
from report;

select *
from report
where report_num = 1;
