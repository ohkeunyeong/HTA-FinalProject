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

update ORDER_MARKET
set id = 'ajaxk'


select * from order_market;

insert into order_market
values('210924_332142', 'java', '자바', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332143', 'spring', '스프링', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332144', 'vue', '뷰', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332145', 'jquery', '제이쿼리', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332146', 'javascript', '자바스크립트', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332147', 'jsp', '제이', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332148', 'user', '유저', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332149', 'user2', '유저2', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

insert into order_market
values('210924_332150', 'user3', '유저3', 333111, '서울특별시 종로구 종로3가', '010-1111-1111', '1000', '카드결제', sysdate, '배송준비');

select *
from (select rownum rnum, o.*
	  from (select *
	  		from order_market
	  		order by order_date) o
	 )
where rnum >= 1 and rnum <= 10;

select *
from order_detail
where order_num = '210924_332142';

select om.order_num, om.id, om.order_name, om.user_address1, om.user_address2,
	   om.order_phone, om.order_totalprice, om.order_payment, om.order_date,
	   om.order_delivery, od.order_de_num, od.product_code, od.order_de_count
from order_market om, order_detail od
where od.order_num = '210924_332142'
and om.order_num = od.order_num;

select o.order_num, o.id, o.order_name, o.user_address1, o.user_address2,
	   o.order_phone, o.order_totalprice, o.order_payment, o.order_date,
	   o.order_delivery, d.order_de_num, d.product_code, d.order_de_count,
	   p.product_name, p.product_img, p.product_price
from order_market o 
		inner join order_detail d
			on o.order_num = d.order_num
		inner join PRODUCT p
			on d.product_code = p.product_code
where o.order_num = '210924_332142';
	 

