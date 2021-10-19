
create table free_files(
free_num				NUMBER(10),
free_file			varchar2(100),
free_original		varchar2(100)
)

drop table free_file


select * from free_files;

select free_file
from free_files
where free_num=98