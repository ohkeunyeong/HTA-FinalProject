drop table product  cascade constraints;

CREATE TABLE PRODUCT(
  PRODUCT_CODE       VARCHAR2(6),          		-- 상품코드 
  CATEGORY_CODE      VARCHAR2(50)	not null,   -- 카테고리 코드 
  PRODUCT_NAME       VARCHAR2(20)	not null,   -- 상품명 
  PRODUCT_PRICE   	 NUMBER(10)		not null,   -- 상품 가격 
  PRODUCT_DETAIL     VARCHAR2(100)	not null,   -- 상세 정보 
  PRODUCT_IMG        VARCHAR2(20)	not null,   -- 이미지 
  PRODUCT_SALES    	 NUMBER(10)		not null,	-- 판매량     
  PRODUCT_DATE	     VARCHAR2(50)	not null,   -- 상품등록일    
  PRIMARY KEY(PRODUCT_CODE),
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY (CATEGORY_CODE)
);


select * from product;