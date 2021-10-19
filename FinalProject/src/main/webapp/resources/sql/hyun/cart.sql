drop table cart  cascade constraints;

CREATE TABLE CART(
  CART_NUM       	 NUMBER(15)	not null,         -- 장바구니 번호 VARCHAR2(15)
  PRODUCT_CODE       VARCHAR2(6)     not null,        -- 상품코드 
  ID        	     VARCHAR2(20)	not null,         -- 멤버 아이디 
  ORDER_DE_COUNT	 NUMBER(3)      not null,         -- 주문수량 
  ADD_DATE           DATE		    default sysdate,  -- 장바구니에 담은 날짜 
  PRIMARY KEY (CART_NUM),
  FOREIGN KEY (ID) REFERENCES MEMBER (ID)
);

create sequence cart_seq;


select * from cart;

create sequence cart_seq;
--실행함 9.19

select cart.id, cart.order_de_count, product.*
	  from cart, product
	  where cart.id = 'ajaxk'
	  and cart.cart_num in (32, 33)
	  and cart.product_code = product.product_code
	  
select 'A00002', cart.id, cart.order_de_count, product.*
		from cart, product
		where id = 'ajaxk'
		and cart_num in (32, 33)
		and cart.product_code = product.product_code