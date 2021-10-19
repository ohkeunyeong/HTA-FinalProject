-- 농장테이블
create table mynong (
	MYNONG_NAME     VARCHAR2(50) PRIMARY KEY ,
	MYNONG_DATE  date default(sysdate)
);

-- 회원 테이블
CREATE TABLE MEMBER(
	ID				VARCHAR2(50)	NOT NULL	PRIMARY KEY,
	PASS			VARCHAR2(60)	NOT NULL,
	NAME			VARCHAR2(50),
	NICK			VARCHAR2(50)	NOT NULL,
	MAIL			VARCHAR2(50),
	TEL				VARCHAR2(50),
	MY_FARM			VARCHAR2(1),
	PERSNACON		VARCHAR2(50),
	ORIGINAL		VARCHAR2(100),
	POINT			NUMBER(7),
	MYNONG_NAME		VARCHAR2(50),
	foreign key (MYNONG_NAME) REFERENCES mynong(MYNONG_NAME),
	CONSTRAINT MEMBER_uq UNIQUE (NICK)
);

-- 농장 캘린더 테이블
CREATE TABLE CALBOARD (
	SEQ         NUMBER              NOT NULL PRIMARY KEY,  -- 캘린더 번호--
	NAME        VARCHAR2(50)        NOT NULL, -- 농장 이름--
	TITLE       VARCHAR2(1000)      NOT NULL, -- 일정 제목--
	CONTENT     VARCHAR2(4000)      NOT NULL, -- 일정 내용--
	MDATE       VARCHAR2(12)        NOT NULL, -- 일정 시작시간--
	REGDATE     DATE                NOT NULL, -- 생성 시간--
	foreign key (NAME) REFERENCES mynong(MYNONG_NAME) ON DELETE CASCADE
);

-- 농장 가계부 테이블
CREATE TABLE ACCOUNT (
	SEQ         NUMBER              NOT NULL PRIMARY KEY,  -- 가계부 번호--
	NAME        VARCHAR2(50)        NOT NULL, -- 농장 이름--
	TITLE       VARCHAR2(1000)      NOT NULL, -- 지출 명--
	AMOUNT      VARCHAR2(30)           NOT NULL, -- 지출 금액--
	MDATE       VARCHAR2(12)        NOT NULL, -- 지출 시간--
	foreign key (NAME) REFERENCES mynong(MYNONG_NAME) ON DELETE CASCADE
);

-- 농장 멤버게시판 테이블
CREATE TABLE NONG (
	NONG_NUM      NUMBER         NOT NULL PRIMARY KEY, -- 글 번호 --
	NAME          VARCHAR2(50)   NOT NULL, --농장 이름--
	ID            VARCHAR2(50)   , --작성자 아이디--
	NONG_PASS     VARCHAR2(30)   , --글 비밀번호--
	NONG_SUB      VARCHAR2(300)  , --제목--
	NONG_CON      VARCHAR2(4000) , --내용--
	NONG_FILE     VARCHAR2(50)   , --첨부파일 명(가공)--
	NONG_ORI      VARCHAR2(50)   , --첨부파일 명--
	NONG_RE_REF   NUMBER         , --답변 글 참조 글번호--
	NONG_RE_LEV   NUMBER         , --답변 글의 깊이--
	NONG_RE_SEQ   NUMBER         , --답변 글의 순서--
	NONG_READ     NUMBER         , --글의 조회수--
	NONG_DATE     DATE           , --글 작성 날짜--
	foreign key (NAME) REFERENCES mynong(MYNONG_NAME) ON DELETE CASCADE,
	foreign key (ID) REFERENCES MEMBER(ID) ON DELETE CASCADE -- 게시글 쓴 회원이 탈퇴처리되면 게시글도 삭제됨--
);

-- 농장 멤버게시판 댓글 테이블
CREATE TABLE NONG_CO (
	NONG_CO_NUM   NUMBER         NOT NULL PRIMARY KEY, -- 댓글 번호 --
	NAME          VARCHAR2(50)   NOT NULL, --농장 이름--
	ID            VARCHAR2(50)   , --작성자 아이디--
	NONG_CO_CON   varchar2(100)  , --댓글 내용--
	NONG_CO_DATE  DATE           , --댓글 작성 날짜--
	NONG_NUM     NUMBER REFERENCES NONG(NONG_NUM) ON DELETE CASCADE, --원문 글삭제시 댓글도 삭제됨--
	foreign key (NAME) REFERENCES mynong(MYNONG_NAME) ON DELETE CASCADE
);

-- 농장 멤버게시판 이미지 삭제 테이블
create table nongdelete_File(
  NONG_FILE      VARCHAR2(50) primary key
);

-- 직거래 게시판 테이블
create table jik(
	jik_num				NUMBER(10) primary key,
	jik_id				varchar2(20),
	nick				varchar2(20),
	jik_subject			varchar2(300),
	jik_content			varchar2(4000),
	jik_readcount		NUMBER(10),
	jik_like			NUMBER(10),
	jik_date			DATE default sysdate,
	jik_file			varchar2(100),
	jik_original		varchar2(100)
);

-- 직거래 게시판 댓글 테이블
create table jik_comm(
	jik_comm_num			NUMBER(10) primary key,
	jik_board_num			NUMBER(20) references jik(jik_num) on delete cascade,
	id						VARCHAR2(50),
	nick					VARCHAR2(20),
	jik_comm_content		VARCHAR2(3000),
	jik_comm_date			DATE default sysdate,
	jik_comm_re_ref			NUMBER(10),
	jik_comm_re_lev			NUMBER(10),
	jik_comm_re_seq			NUMBER(10),
	jik_comm_secret			CHAR(2),
	jik_id					VARCHAR2(50)
);

-- 직거래 게시판 좋아요 테이블
create table jik_like(
	jik_num			NUMBER(10),
	jik_id			varchar2(20),
	foreign key (jik_num) REFERENCES jik(jik_num)
);

-- 직거래 게시판 이미지 파일 저장 테이블
create table jik_files(
	jik_num				NUMBER(10),
	jik_file			varchar2(100),
	jik_original		varchar2(100)
);

-- 자유게시판 테이블
create table free(
	free_num				NUMBER(10) primary key,
	id					varchar2(20),
	nick				varchar2(20),
	free_subject			varchar2(300),
	free_content			varchar2(4000),
	free_readcount		NUMBER(10),
	free_like			NUMBER(10),
	free_date			DATE default sysdate,
	free_ldate			DATE default sysdate,
	free_file			varchar2(100),
	free_original		varchar2(100),
	free_type			NUMBER(1)
);

-- 자유게시판 댓글 테이블
create table free_comm(
	free_comm_num			NUMBER(10) primary key,
	free_board_num			NUMBER(20) references free(free_num) on delete cascade,
	id						VARCHAR2(50),
	nick					VARCHAR2(20),
	free_comm_content		VARCHAR2(3000),
	free_comm_date			DATE default sysdate,
	free_comm_re_ref			NUMBER(10),
	free_comm_re_lev			NUMBER(10),
	free_comm_re_seq			NUMBER(10),
	free_comm_secret			CHAR(2),
	free_id					VARCHAR2(50)
);

-- 자유게시판 좋아요 테이블
create table free_like(
	free_num			NUMBER(10),
	free_id			varchar2(20),
	foreign key (free_num) REFERENCES free(free_num)
);

-- 이미지 삭제 파일 저장 테이블
create table delete_File(
	BOARD_FILE		VARCHAR2(50) primary key
);

-- 카테고리 테이블
CREATE TABLE CATEGORY( 
  CATEGORY_CODE       VARCHAR2(50),         	-- 카테고리 코드 
  CATEGORY_NAME       VARCHAR2(100)	not null,   -- 카테고리 종류 이름 
  PRIMARY KEY(CATEGORY_CODE)
);

insert into CATEGORY
values('100', '씨앗/모종');

insert into CATEGORY
values('200', '비료/상토');

insert into CATEGORY
values('300', '살충제');

insert into CATEGORY
values('400', '농기구');

insert into CATEGORY
values('500', '굿즈');


-- 상품 테이블
CREATE TABLE PRODUCT(
  PRODUCT_CODE       VARCHAR2(6),          		-- 상품코드 
  CATEGORY_CODE      VARCHAR2(50)	not null,   -- 카테고리 코드 
  PRODUCT_NAME       VARCHAR2(50)	not null,   -- 상품명 
  PRODUCT_PRICE   	 NUMBER(10)		not null,   -- 상품 가격 
  PRODUCT_DETAIL     VARCHAR2(100)	not null,   -- 상세 정보 
  PRODUCT_IMG        VARCHAR2(50)	not null,   -- 실제 저장된 이미지이름 
  PRODUCT_ORIGINAL   VARCHAR2(50)	not null,   -- 첨부될 파일 명 
  PRODUCT_DATE	     VARCHAR2(50)	not null,   -- 상품등록일    
  PRIMARY KEY(PRODUCT_CODE),
  FOREIGN KEY (CATEGORY_CODE) REFERENCES CATEGORY (CATEGORY_CODE)
);

-- 장바구니 테이블
CREATE TABLE CART(
  CART_NUM       	 NUMBER(15)	not null,         -- 장바구니 번호 VARCHAR2(15)
  PRODUCT_CODE       VARCHAR2(6)     not null,        -- 상품코드 
  ID        	     VARCHAR2(20)	not null,         -- 멤버 아이디 
  ORDER_DE_COUNT	 NUMBER(3)      not null,         -- 주문수량 
  ADD_DATE           DATE		    default sysdate,  -- 장바구니에 담은 날짜 
  PRIMARY KEY (CART_NUM),
  FOREIGN KEY (ID) REFERENCES MEMBER (ID),
  FOREIGN KEY (PRODUCT_CODE) REFERENCES PRODUCT (PRODUCT_CODE)
);

-- 주문 테이블
CREATE TABLE ORDER_MARKET(
  ORDER_NUM          VARCHAR2(50)	not null,         -- 주문번호 
  ID  		         VARCHAR2(50)	not null,         -- 아이디 
  ORDER_NAME         VARCHAR2(20)	not null,         -- 주문자 이름 
  USER_ADDRESS1   	 VARCHAR2(20)	not null,         -- 우편번호 
  USER_ADDRESS2      VARCHAR2(100)	not null,         -- 주소 
  ORDER_PHONE        VARCHAR2(20)	not null,         -- 전화번호 
  ORDER_TOTALPRICE   NUMBER(10)     not null, 		  -- 총 가격      
  ORDER_PAYMENT	     VARCHAR2(50)	not null,         -- 결제방식 
  ORDER_DATE   		 DATE		default sysdate,      -- 주문일자 
  ORDER_DELIVERY	 VARCHAR2(50)	not null,         -- 주문상태 
  PRIMARY KEY(ORDER_NUM),
  FOREIGN KEY (ID) REFERENCES MEMBER (ID)
);

-- 주문 상세 테이블
CREATE TABLE ORDER_DETAIL(
  ORDER_DE_NUM       VARCHAR2(15)	not null,   -- 주문상세번호 
  ORDER_NUM          VARCHAR2(50)	not null,   -- 주문번호 
  ORDER_DE_COUNT	 NUMBER(3)      not null,   -- 주문수량 
  PRODUCT_CODE       VARCHAR2(6)    not null,   -- 상품코드 
  CATEGORY_CODE      VARCHAR2(50)	not null,   -- 카테고리 코드 
  PRODUCT_NAME       VARCHAR2(50)	not null,   -- 상품명 
  PRODUCT_PRICE   	 NUMBER(10)		not null,   -- 상품 가격 
  PRODUCT_DETAIL     VARCHAR2(100)	not null,   -- 상세 정보 
  PRODUCT_IMG        VARCHAR2(50)	not null,   -- 실제 저장된 이미지이름 
  PRODUCT_ORIGINAL   VARCHAR2(50)	not null,   -- 첨부될 파일 명
  PRIMARY KEY(ORDER_DE_NUM),
  FOREIGN KEY (ORDER_NUM) REFERENCES ORDER_MARKET (ORDER_NUM)
);

-- 공지사항 테이블
create table notice(
	notice_num				number(10) primary key,
	notice_subject			varchar2(300),
	notice_content			varchar2(4000),
	notice_readcount		number(10),
	notice_date				DATE default sysdate,
	notice_fix				varchar2(10)
);

-- 관리자 신고글 테이블
create TABLE REPORT(
	REPORT_NUM NUMBER(3) PRIMARY KEY,
	BOARD_NUM NUMBER(3),
	BOARD_ID VARCHAR2(50),
	BOARD_SUBJECT VARCHAR2(500),
	BOARD_CONTENT VARCHAR2(2000),
	REPORT_CONTENT VARCHAR2(2000),
	BOARD_TABLE VARCHAR2(50),
	REPORT_DATE DATE
);

