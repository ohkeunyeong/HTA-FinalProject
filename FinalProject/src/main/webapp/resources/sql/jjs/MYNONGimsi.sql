-- 농장 이름 테이블--
drop table mynong CASCADE CONSTRAINTS;
create table mynong (
MYNONG_NAME     VARCHAR2(50) PRIMARY KEY,
MYNONG_DATE	DATE
);

select * from mynong;

delete from mynong;

insert into MYNONG
values('JavaFarm', sysdate);

insert into MYNONG
values('SpringFarm', sysdate);

insert into MYNONG
values('JspFarm', sysdate);

insert into MYNONG
values('JavaScriptFarm', sysdate);

insert into MYNONG
values('VueFarm', sysdate);

insert into MYNONG
values('JQueryFarm', sysdate);
