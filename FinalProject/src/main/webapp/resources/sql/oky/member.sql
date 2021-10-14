-- 맴버 테이블 생성 전에 MYNONG.sql 농장테이블 생성 할 것--
drop table member cascade constraints;
CREATE TABLE MEMBER(
	ID				VARCHAR2(50)	NOT NULL	PRIMARY KEY,
	PASS			VARCHAR2(60)	NOT NULL,
	NAME			VARCHAR2(50),
	NICK			VARCHAR2(50)	NOT NULL,
	MAIL			VARCHAR2(50),
	TEL				VARCHAR2(50),
	MY_FARM			VARCHAR2(1),
	PERSNACON		VARCHAR2(50),
	POINT			NUMBER(7),
	MYNONG_NAME		VARCHAR2(50),
	foreign key (MYNONG_NAME) REFERENCES mynong(MYNONG_NAME),
	CONSTRAINT MEMBER_uq UNIQUE (NICK)
);

select * from member;


update  member set MYNONG_NAME='test', MY_FARM='2' where id='test3';

update  member set MYNONG_NAME='test1', MY_FARM='1' where id='test2';
delete from member where id='admin';

insert into member values('admin', '1111', '운영자', '운영자', 'test@gmail.com', '01012345678', '0', 'null', '0', '')

insert into member values('test1', '1111', '테스트1', '테스트1', 'test1@gmail.com', '01012345678', '0', 'null', '0', '')

insert into member values('test2', '1111', '테스트2', '테스트2', 'test2@gmail.com', '01012345678', '0', 'null', '0','')

insert into member values('test3', '1111', '테스트3', '테스트3', 'test2@gmail.com', '01012345678', '0', 'null', '0','')

insert into member values('test4', '1111', '테스트4', '테스트4', 'test2@gmail.com', '01012345678', '0', 'null', '0','')

insert into member values('test5', '1111', '테스트5', '테스트5', 'test2@gmail.com', '01012345678', '0', 'null', '0','')

insert into member values('test6', '1111', '테스트6', '테스트6', 'test2@gmail.com', '01012345678', '0', 'null', '0','')

insert into member values('test7', '1111', '테스트7', '테스트7', 'test2@gmail.com', '01012345678', '0', 'null', '0','')

insert into member values('test8', '1111', '테스트8', '테스트8', 'test1@gmail.com', '01012345678', '0', '', '0', '')

insert into member values('test9', '1111', '테스트9', '테스트9', 'test1@gmail.com', '01012345678', '0', '', '0', '')

