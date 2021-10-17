drop table review  cascade constraints;


CREATE TABLE REVIEW(
  ID				 VARCHAR2(50)	 not null,
  PRODUCT_CODE       VARCHAR2(6)     not null,        -- 상품코드 gdsNum number  not null,
  CATEGORY_CODE      VARCHAR2(50)    ,       		  -- 카테고리 코드 
  PRODUCT_NAME       VARCHAR2(50)    not null,        -- 상품명 
  REVIEW_CONTENT     VARCHAR2(1000)  not null,        -- 리뷰 내용 
--  REVIEW_IMG       	 VARCHAR2(50)	 ,        		  -- 리뷰 이미지 빼기로 
  REVIEW_DATE	     DATE        	 default sysdate, 	  -- 리뷰등록일 
  MEMBER_NICK        VARCHAR2(50)    not null,        -- 회원 닉네임 
--  REVIEW_STAR      NUMBER(2)       not null,        -- 만족도 별 갯수 
  REVIEW_NUM         NUMBER          not null,        -- 리뷰 번호 
   
  PRIMARY KEY (PRODUCT_CODE,REVIEW_NUM),
  FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT (PRODUCT_CODE),
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY (CATEGORY_CODE),
  FOREIGN KEY (MEMBER_NICK) REFERENCES MEMBER (NICK),
  FOREIGN KEY (ID) REFERENCES MEMBER (ID)
);

create sequence REVIEW_seq;

drop sequence REVIEW_seq;

select * from review;

delete from review where review_num=4

 insert into review 	 
	 (id, product_code, category_code, product_name, 
	 review_img, member_nick , review_num, review_content)
	 values 
	 ('user7', '000003', '300', '대유 모두나와500ml', 
	 null, 'user7', REVIEW_seq.nextval, '효과가 아주 좋습니다. 벌레때문에 많이 고생했는데 많이 줄었어요.')
	 
	insert into review
	values(
	'user7','000003','300','1','like',null,sysdate,'user7',4
	)
	
	select sysdate from dual

INSERT INTO REVIEW( ID, PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, REVIEW_CONTENT ,
REVIEW_IMG, REVIEW_DATE, MEMBER_NICK, REVIEW_NUM)
VALUES( 'user7','000001', '600', '주말 장바구니(소)', '튼튼하고 좋아요', '', sysdate, 'user7', 1);

INSERT INTO REVIEW( ID, PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, REVIEW_CONTENT ,
REVIEW_IMG, REVIEW_DATE, MEMBER_NICK, REVIEW_NUM)
VALUES(	'user7','000003', '300', '대유 모두나와(500ml)', '효과가 아주 좋습니다. 벌레때문에 많이 고생했는데 많이 줄었어요.', '', sysdate, 'user7', 2);