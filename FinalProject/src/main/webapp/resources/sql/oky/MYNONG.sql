-- 농장  테이블--
drop table mynong CASCADE CONSTRAINTS;
create table mynong (
MYNONG_NAME     VARCHAR2(50) PRIMARY KEY ,
MYNONG_DATE  date default(sysdate)
);

select * from mynong;

delete from mynong;
