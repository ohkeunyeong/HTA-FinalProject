drop table category  cascade constraints;

CREATE TABLE CATEGORY( 
  CATEGORY_CODE       VARCHAR2(50),         	-- 카테고리 코드 
  CATEGORY_NAME       VARCHAR2(100)	not null,   -- 카테고리 종류 이름 
  PRIMARY KEY(CATEGORY_CODE)
);


select * from category;