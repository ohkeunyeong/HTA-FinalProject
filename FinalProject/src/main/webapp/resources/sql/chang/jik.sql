
create table jik(
jik_num				NUMBER(10) primary key,
jik_id				varchar2(20),
nick				varchar2(20),
jik_subject			varchar2(300),
jik_content			varchar2(4000),
jik_readcount		NUMBER(10),
jik_like			NUMBER(10),
jik_date			DATE default sysdate,
jik_file			varchar2(100),
jik_original		varchar2(100)
)
INSERT INTO jik
 			(jik_num,
 			 nick, jik_subject,
 			 jik_content, jik_file, jik_original,
 			 jik_readcount,jik_date)
 			VALUES
 			(1,'asd','asd','asd','asd','asd',1,sysdate)
select * from jik;
drop table jik cascade constraints;