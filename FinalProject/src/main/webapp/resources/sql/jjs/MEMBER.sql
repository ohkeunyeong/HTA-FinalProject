DROP TABLE MEMBER;

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

SELECT * FROM MEMBER;

delete member;

INSERT INTO MEMBER(ID, PASS, NAME, NICK, MAIL, TEL, MY_FARM, PERSNACON, POINT, MYNONG_NAME)
VALUES('admin', '1234', '관리자', '관리자', 'admin@gmail.com', '01012345678', '1', 'null', 0, '');

INSERT INTO member
VALUES('user', '1234', '유저', '유저1', 'user@gmail.com', '01012345678', '2', 'null', 0, 'JavaFarm');

INSERT INTO member
VALUES('user2', '1234', '유저2', '유저2', 'user2@gmail.com', '01012345678', '2', 'null', 0, 'SpringFarm');

INSERT INTO member
VALUES('user3', '1234', '유저3', '유저3', 'user3@gmail.com', '01012345678', '2', 'null', 0, 'JspFarm');

INSERT INTO member
VALUES('user4', '1234', '유저4', '유저4', 'user4@gmail.com', '01012345678', '2', 'null', 0, 'JavaScriptFarm');

INSERT INTO member
VALUES('user5', '1234', '유저5', '유저5', 'user5@gmail.com', '01012345678', '2', 'null', 0, 'VueFarm');

INSERT INTO member
VALUES('user6', '1234', '유저6', '유저6', 'user6@gmail.com', '01012345678', '2', 'null', 0, 'JQueryFarm');

INSERT INTO member
VALUES('user7', '1234', '유저7', '유저7', 'user7@gmail.com', '01012345678', '2', 'null', 0, 'SpringFarm');

INSERT INTO member
VALUES('user8', '1234', '유저8', '유저8', 'user8@gmail.com', '01012345678', '2', 'null', 0, 'VueFarm');

INSERT INTO member
VALUES('user9', '1234', '유저9', '유저9', 'user9@gmail.com', '01012345678', '2', 'null', 0, 'JavaFarm');

INSERT INTO member
VALUES('user10', '1234', '유저10', '유저10', 'user10@gmail.com', '01012345678', '2', 'null', 0, 'JavaFarm');

INSERT INTO member
VALUES('user11', '1234', '가을', '가을', 'user11@gmail.com', '01012345678', '2', 'null', 0, 'JspFarm');

INSERT INTO member
VALUES('java', '1234', '자바', '자바', 'java@gmail.com', '01012345678', '1', 'null', 0, 'JavaFarm');

INSERT INTO member
VALUES('spring', '1234', '스프링', '스프링', 'spring@gmail.com', '01012345678', '1', 'null', 0, 'SpringFarm');

INSERT INTO member
VALUES('jsp', '1234', '제이', '제이', 'jsp@gmail.com', '01012345678', '1', 'null', 0, 'JspFarm');

INSERT INTO member
VALUES('vue', '1234', '뷰', '뷰', 'vue@gmail.com', '01012345678', '1', 'null', 0, 'VueFarm');

INSERT INTO member
VALUES('javascript', '1234', '자바스크립트', '자바스크립트', 'javascript@gmail.com', '01012345678', '1', 'null', 0, 'JavaScriptFarm');

INSERT INTO member
VALUES('jquery', '1234', '제이쿼리', '제이쿼리', 'jquery@gmail.com', '01012345678', '1', 'null', 0, 'JQueryFarm');

INSERT INTO member
VALUES('asdf', '1234', 'asdf', 'asdf', 'asdf@gmail.com', '01012345678', '0', 'null', 0, '');

select *
from member m, MYNONG n
where m.mynong_name = n.mynong_name
order by n.mynong_date;

select m.mynong_name, count(*)
from member m, MYNONG n
where m.mynong_name = n.mynong_name
group by m.mynong_name;

select *
from (select rownum rnum, me.*
	  from (select m.*, n.mynong_date, count(*)
			from member m, MYNONG n
			where m.mynong_name = n.mynong_name
			group by m.mynong_name) me
	 )
where rnum >= 1 and rnum <= 10;

select member.*, cnt, me.mynong_date
from member inner join (select m.mynong_name, count(*) cnt, n.mynong_date
						from member m, mynong n
						where m.mynong_name = n.mynong_name
						group by m.mynong_name, n.mynong_date) me
on member.mynong_name = me.mynong_name
where member.my_farm = '1'
order by me.mynong_date;

-- 농장 목록 조회 쿼리
select mynong_name, name, cnt membercnt, mynong_date
from (select rownum rnum, om.*
	  from (select member.*, cnt, nong.mynong_date
			from member inner join (select m.mynong_name, count(*) cnt, n.mynong_date
									from member m, mynong n
									where m.mynong_name = n.mynong_name
									group by m.mynong_name, n.mynong_date) nong
			on member.mynong_name = nong.mynong_name
			where member.my_farm = '1'
			order by cnt desc) om
	 )
where rnum >= 1 and rnum <= 10;

select count(*)
from mynong;

select mynong_name, name, cnt membercnt, mynong_date
		from (select rownum rnum, om.*
	  		  from (select member.*, cnt, nong.mynong_date
					from member inner join (select m.mynong_name, count(*) cnt, n.mynong_date
											from member m, mynong n
											where m.mynong_name = n.mynong_name
											group by m.mynong_name, n.mynong_date) nong
					on member.mynong_name = nong.mynong_name
					where member.my_farm = '1'
					order by mynong_date desc) om
	 		 )
		where rnum >= 1 and rnum <= 10

update member
set my_farm = '0'
where id = 'ajaxk';

update MEMBER
set mynong_name = ''
where id = 'ajaxk';

