
create table free(
free_num				NUMBER(10) primary key,
id					varchar2(20),
nick				varchar2(20),
free_subject			varchar2(300),
free_content			varchar2(4000),
free_readcount		NUMBER(10),
free_like			NUMBER(10),
free_date			DATE default sysdate,
free_ldate			DATE default sysdate,
free_file			varchar2(100),
free_original		varchar2(100),
free_type			NUMBER(1)
)
INSERT INTO free
 			(free_num,
 			 nick, free_subject,
 			 free_content, free_file, free_original,
 			 free_readcount,free_date)
 			VALUES
 			(55,'asd','asd','gg','asd','asd',1,sysdate)
select * from free;

select * from free
where (free_subject || free_content) like '%g%'


select * from 
( select ROWNUM RNUM, b.* 
from (select free.*, nvl(cnt,0) cnt 
from free left outer join 
(select free_board_num, count(*) cnt from free_comm group by free_board_num) c 
on c.free_board_num=free.free_num order by free_num desc) b ) 
where RNUM>= 10 and RNUM <= 1 
and free_content like %d% 

drop table free cascade constraints;