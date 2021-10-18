free_like_num	NUMBER(10) primary key,

create table free_like(
free_num			NUMBER(10),
free_id			varchar2(20),
foreign key (free_num) REFERENCES free(free_num)
)

select * from free_like

drop table free_like