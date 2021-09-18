
create table jik(
jik_num				NUMBER(10) primary key,
nick				varchar2(20),
jik_subject			varchar2(300),
jik_content			varchar2(4000),
jik_readcount		NUMBER(10),
jik_like			NUMBER(10),
jik_date			DATE default sysdate,
jik_file			varchar2(100),
jik_original		varchar2(100)
)

select * from jik;