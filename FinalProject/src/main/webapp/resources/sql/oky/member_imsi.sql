drop table member cascade constraints;
-- 임시 멤버 테이블--
CREATE TABLE MEMBER
(
	ID			VARCHAR2(50)	NOT NULL,
	PASS		VARCHAR2(50)	NOT NULL,
	NAME		VARCHAR2(50),
	NICK		VARCHAR2(50)	NOT NULL,
	MAIL		VARCHAR2(50),
	TEL			VARCHAR2(50),
	MY_FARM		VARCHAR2(1),
	PERSNACON	VARCHAR2(50),
	POINT		NUMBER(7),
	MYNONG_NAME     VARCHAR2(50) references mynong(MYNONG_NAME),
	CONSTRAINT MEMBER_pk PRIMARY KEY (ID),
	CONSTRAINT MEMBER_uq UNIQUE (NICK)
);

select * from member;

insert into member values('admin', '1111', '운영자', '운영자', 'test@gmail.com', '01012345678', '1', 'null', '0', '')

insert into member values('test1', '1111', '테스트1', '테스트1', 'test1@gmail.com', '01012345678', '0', 'null', '0', '')

insert into member values('test2', '1111', '테스트2', '테스트2', 'test2@gmail.com', '01012345678', '0', 'null', '0','')
