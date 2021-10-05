DROP TABLE ACCOUNT cascade constraints;

CREATE TABLE ACCOUNT (
SEQ         NUMBER              NOT NULL PRIMARY KEY,  -- 가계부 번호--
NAME        VARCHAR2(50)        NOT NULL, -- 농장 이름--
TITLE       VARCHAR2(1000)      NOT NULL, -- 지출 명--
CONTENT     VARCHAR2(4000)              , -- 지출 내역 세부정보--
AMOUNT      VARCHAR2(30)           NOT NULL, -- 지출 금액--
MDATE       VARCHAR2(12)        NOT NULL, -- 지출 시간--
foreign key (NAME) REFERENCES mynong(MYNONG_NAME)
);

drop sequence ACCOUNT_SEQ;

create sequence ACCOUNT_SEQ;

SELECT * FROM ACCOUNT;

-- 해당 달의 날마다 존재하는 가계부 목록 구하기
SELECT RN, SEQ, NAME, TITLE, CONTENT, AMOUNT, MDATE
FROM (	SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(MDATE,1,8) ORDER BY MDATE) AS RN , 
		SEQ, NAME,TITLE,CONTENT,AMOUNT, MDATE
		FROM ACCOUNT
		WHERE NAME = 'testnong' AND SUBSTR(MDATE,1,6) ='202110'
	);
