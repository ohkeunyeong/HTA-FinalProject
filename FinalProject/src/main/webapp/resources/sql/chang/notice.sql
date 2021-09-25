
create table notice(
notice_num				number(10) primary key,
notice_subject			varchar2(300),
notice_content			varchar2(4000),
notice_readcount		number(10),
notice_date				DATE default sysdate,
notice_fix				varchar2(10)
)

select * from notice

drop table notice

--공지사항 리스트 출력
select *
from (select rownum rnum, b.*
	  from (select *
	  		from NOTICE
	  		order by NOTICE_DATE desc) b
	 )
where rnum >= 1 and rnum <= 3

select *
from (select rownum rnum, n.*
			  from (select *
			  		from notice
			  		where NOTICE_SUBJECT like '%asd%'
			  		order by NOTICE_DATE desc) n
			 )
		where rnum >= 1 and rnum <= 3
