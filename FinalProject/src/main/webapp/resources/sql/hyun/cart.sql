drop table cart  cascade constraints;

CREATE TABLE CART(
  CART_NUM       	 VARCHAR2(15)	not null,         -- 장바구니 번호 
  PRODUCT_CODE       VARCHAR2(6)     not null,        -- 상품코드 
  ID        	     VARCHAR2(20)	not null,         -- 주문번호 
  ORDER_DE_COUNT	 NUMBER(3)      not null,         -- 주문수량 
  ADD_DATE           DATE		    default sysdate,  -- 장바구니에 담은 날짜 
  PRIMARY KEY (CART_NUM),
  FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT (PRODUCT_CODE),
  FOREIGN KEY (ID) REFERENCES MEMBER (ID),
);


select * from cart;

--아직 실행 안함 09.17