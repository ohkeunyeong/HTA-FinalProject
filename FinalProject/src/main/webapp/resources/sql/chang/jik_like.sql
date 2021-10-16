jik_like_num	NUMBER(10) primary key,

create table jik_like(
jik_num			NUMBER(10),
jik_id			varchar2(20),
foreign key (jik_num) REFERENCES jik(jik_num)
)

select * from jik_like

drop table jik_like