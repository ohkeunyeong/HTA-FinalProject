drop table category  cascade constraints;

CREATE TABLE CATEGORY( 
  CATEGORY_CODE       VARCHAR2(50),         	-- 카테고리 코드 
  CATEGORY_NAME       VARCHAR2(100)	not null,   -- 카테고리 종류 이름 
  PRIMARY KEY(CATEGORY_CODE)
);


select * from category;

insert into CATEGORY
values('100', '씨앗/모종');

insert into CATEGORY
values('200', '비료/상토');

insert into CATEGORY
values('300', '살충제');

insert into CATEGORY
values('400', '농기구');

insert into CATEGORY
values('500', '굿즈');

select a.product_code, count(*) cnt
  from (select p.product_code, p.category_code, c.category_name, p.product_name, p.product_price,
	  	   		  		   p.product_detail, p.product_img, p.product_original, p.product_date
	  	   			from product p, CATEGORY c, review r
	  	   			where p.category_code = c.category_code
	  	   			and p.category_code = r.category_code) a
  group by a.product_code
  order by cnt desc
  
