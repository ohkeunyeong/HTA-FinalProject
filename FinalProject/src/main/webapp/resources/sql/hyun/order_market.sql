drop table order_market  cascade constraints;

CREATE TABLE ORDER_MARKET(
  ORDER_NUM          VARCHAR2(20)	not null,         -- 주문번호 
  ID  		         VARCHAR2(50)	not null,         -- 아이디 
  ORDER_NAME         VARCHAR2(20)	not null,         -- 주문자 이름 
  USER_ADDRESS1   	 NUMBER(10)		not null,         -- 우편번호 
  USER_ADDRESS2      VARCHAR2(100)	not null,         -- 주소 
  ORDER_PHONE        VARCHAR2(20)	not null,         -- 전화번호 
  ORDER_TOTALPRICE   NUMBER(10)     not null, 		  -- 총 가격      
  ORDER_PAYMENT	     VARCHAR2(50)	not null,         -- 결제방식 
  ORDER_DATE   		 DATE		default sysdate,      -- 주문일자 
  ORDER_DELIVERY	 VARCHAR2(50)	not null,         -- 주문상태 
  PRIMARY KEY(ORDER_NUM),
  FOREIGN KEY (ID) REFERENCES MEMBER (ID)
);


select * from order_market;


-- 실행함 9.19