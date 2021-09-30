drop table order_detail  cascade constraints;

CREATE TABLE ORDER_DETAIL(
  ORDER_DE_NUM       VARCHAR2(15)	not null,         -- 주문상세번호 
  ORDER_NUM          VARCHAR2(20)	not null,         -- 주문번호 
  PRODUCT_CODE       VARCHAR2(6)    not null,         -- 상품코드 
  ORDER_DE_COUNT	 NUMBER(3)      not null,         -- 주문수량 
  PRIMARY KEY(ORDER_DE_NUM),
  FOREIGN KEY (ORDER_NUM) REFERENCES ORDER_MARKET (ORDER_NUM),
  FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT (PRODUCT_CODE)
);


select * from order_detail;

create sequence order_detail_seq;

drop sequence order_detail_seq;

-- 실행함 9.19