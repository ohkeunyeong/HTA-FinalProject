drop table review  cascade constraints;

CREATE TABLE REVIEW(
  REP
  PRODUCT_CODE       VARCHAR2(6)     ,                -- 상품코드 
  CATEGORY_CODE      VARCHAR2(50)    ,        -- 카테고리 코드 
  PRODUCT_NAME       VARCHAR2(50)    not null,        -- 상품명 
  REVIEW_CONTENT     VARCHAR2(1000)  not null,        -- 리뷰 내용 
  REVIEW_IMG       	 VARCHAR2(50)	 ,        		  -- 리뷰 이미지 
  REVIEW_DATE	     DATE        default sysdate, 	  -- 리뷰등록일 
  MEMBER_NICK        VARCHAR2(50)    not null,        -- 회원 닉네임 
  REVIEW_STAR        NUMBER(2)       not null,        -- 만족도 별 갯수 
--  REVIEW_COUNT       NUMBER(3)       not null,        -- 리뷰 번호  --추가 
   
  PRIMARY KEY (REVIEW_CONTENT),
  FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT (PRODUCT_CODE),
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY (CATEGORY_CODE),
  FOREIGN KEY (MEMBER_NICK) REFERENCES MEMBER (NICK)
);

create sequence REVIEW_seq;

select * from review;

INSERT INTO REVIEW( PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, REVIEW_CONTENT ,
REVIEW_IMG, REVIEW_DATE, MEMBER_NICK, REVIEW_STAR)
VALUES('000001', '600', '주말 장바구니(소)', '튼튼하고 좋아요', '', sysdate, 'user1', '4');

INSERT INTO REVIEW( PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, REVIEW_CONTENT ,
REVIEW_IMG, REVIEW_DATE, MEMBER_NICK, REVIEW_STAR)
VALUES('000003', '300', '대유 모두나와(500ml)', '효과가 아주 좋습니다. 벌레때문에 많이 고생했는데 많이 줄었어요.', '', sysdate, 'user2', '5');