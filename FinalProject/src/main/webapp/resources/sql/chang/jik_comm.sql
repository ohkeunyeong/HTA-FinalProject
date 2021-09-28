
create table jik_comm(
jik_comm_num			NUMBER(10) primary key,
jik_board_num			NUMBER(20) references jik(jik_num) on delete cascade,
id						VARCHAR2(50),
nick					VARCHAR2(20),
jik_comm_content		VARCHAR2(3000),
jik_comm_date			DATE default sysdate,
jik_comm_re_ref			NUMBER(10),
jik_comm_re_lev			NUMBER(10),
jik_comm_re_seq			NUMBER(10),
jik_comm_secret			CHAR(2)
)

create sequence jik_comm_seq;

select * from jik_comm;

drop table jik_comm;