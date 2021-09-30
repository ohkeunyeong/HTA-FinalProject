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

insert into order_detail
values(order_detail_seq.nextval, '210924_332142', 'A00001', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332142', 'A00002', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332142', 'A00003', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332143', 'A00002', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332144', 'A00003', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332145', 'A00004', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332146', 'A00005', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332147', 'A00006', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332148', 'A00007', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332149', 'A00008', 3);

insert into order_detail
values(order_detail_seq.nextval, '210924_332150', 'A00001', 3);

