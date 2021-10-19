
create table jik_files(
jik_num				NUMBER(10),
jik_file			varchar2(100),
jik_original		varchar2(100)
)

drop table jik_files


select * from jik_files;

select jik_file
from jik_files
where jik_num=98