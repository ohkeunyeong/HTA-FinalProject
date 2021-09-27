drop table product  cascade constraints;

CREATE TABLE PRODUCT(
  PRODUCT_CODE       VARCHAR2(6),          		-- 상품코드 
  CATEGORY_CODE      VARCHAR2(50)	not null,   -- 카테고리 코드 
  PRODUCT_NAME       VARCHAR2(20)	not null,   -- 상품명 
  PRODUCT_PRICE   	 NUMBER(10)		not null,   -- 상품 가격 
  PRODUCT_DETAIL     VARCHAR2(100)	not null,   -- 상세 정보 
  PRODUCT_IMG        VARCHAR2(50)	not null,   -- 실제 저장된 이미지이름 
  PRODUCT_ORIGINAL   VARCHAR2(50)	not null,   -- 첨부될 파일 명 
  PRODUCT_DATE	     VARCHAR2(50)	not null,   -- 상품등록일    
  PRIMARY KEY(PRODUCT_CODE),
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY (CATEGORY_CODE)
);


select * from product;

select *
from (select rownum rnum, pr.*
	  from(select p.product_code, p.category_code, c.category_name, p.product_name, p.product_price,
	  	   		  p.product_detail, p.product_img, p.product_original, p.product_date
	  	   from product p, CATEGORY c
	  	   where p.category_code = c.category_code
	  	   order by p.product_code) pr
	 )
where rnum >= 1 and rnum <= 10;