
create table free_comm(
free_comm_num			NUMBER(10) primary key,
free_board_num			NUMBER(20) references free(free_num) on delete cascade,
id						VARCHAR2(50),
nick					VARCHAR2(20),
free_comm_content		VARCHAR2(3000),
free_comm_date			DATE default sysdate,
free_comm_re_ref			NUMBER(10),
free_comm_re_lev			NUMBER(10),
free_comm_re_seq			NUMBER(10),
free_comm_secret			CHAR(2),
free_id					VARCHAR2(50)
)

drop sequence free_comm_seq;
create sequence free_comm_seq;

select * from free_comm;

drop table free_comm;