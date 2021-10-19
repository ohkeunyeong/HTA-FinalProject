
create table free_files(
free_num			NUMBER(10) references free(free_num) on delete cascade,
free_file			varchar2(100),
free_original		varchar2(100)
)

drop table free_files


select * from free_files;

select free_file
from free_files
where free_num=98