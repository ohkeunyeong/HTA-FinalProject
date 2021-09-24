
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
