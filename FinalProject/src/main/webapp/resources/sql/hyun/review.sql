drop table review  cascade constraints;

CREATE TABLE REVIEW(
  PRODUCT_CODE       VARCHAR2(6)     ,                -- 상품코드 
  CATEGORY_CODE      VARCHAR2(50)    not null,        -- 카테고리 코드 
  PRODUCT_NAME       VARCHAR2(20)    not null,        -- 상품명 
  REVIEW_CONTENT     VARCHAR2(1000)  not null,        -- 리뷰 내용 
  REVIEW_IMG       	 VARCHAR2(50)	 not null,        -- 리뷰 이미지 
  REVIEW_DATE	     DATE        default sysdate, 	  -- 리뷰등록일 
  MEMBER_NICK        VARCHAR2(50)    not null,        -- 회원 닉네임 
  REVIEW_STAR        NUMBER(2)       not null,        -- 만족도 별 갯수 
--REVIEW_COUNT       NUMBER(3)       not null,        -- 리뷰 개수
   
  PRIMARY KEY (REVIEW_CONTENT),
  FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT (PRODUCT_CODE),
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY (CATEGORY_CODE),
  FOREIGN KEY (MEMBER_NICK) REFERENCES MEMBER (NICK)
);


select * from review;

-- 실행함 9.19