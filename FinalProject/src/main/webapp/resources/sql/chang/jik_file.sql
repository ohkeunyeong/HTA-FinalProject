
create table jik_file(
jik_num				NUMBER(10) primary key,
jik_mfile			varchar2(100),
jik_moriginal		varchar2(100)
)

INSERT INTO jik
 			(jik_num,
 			 nick, jik_subject,
 			 jik_content, jik_file, jik_original,
 			 jik_readcount,jik_date)
 			VALUES
 			(55,'asd','asd','gg','asd','asd',1,sysdate)
select * from jik;

select * from jik
where (jik_subject || jik_content) like '%g%'


select * from 
( select ROWNUM RNUM, b.* 
from (select jik.*, nvl(cnt,0) cnt 
from jik left outer join 
(select jik_board_num, count(*) cnt from jik_comm group by jik_board_num) c 
on c.jik_board_num=jik.jik_num order by jik_num desc) b ) 
where RNUM>= 10 and RNUM <= 1 
and jik_content like %d% 

drop table jik cascade constraints;