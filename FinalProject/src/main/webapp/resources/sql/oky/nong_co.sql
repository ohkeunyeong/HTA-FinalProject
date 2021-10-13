--멤버게시판 댓글--
DROP TABLE NONG_CO cascade constraints;

CREATE TABLE NONG_CO (
NONG_CO_NUM   NUMBER         NOT NULL PRIMARY KEY, -- 댓글 번호 --
NAME          VARCHAR2(50)   NOT NULL, --농장 이름--
ID            VARCHAR2(50)   , --작성자 아이디--
NONG_CO_CON   varchar2(100)  , --댓글 내용--
NONG_CO_DATE  DATE           , --댓글 작성 날짜--
NONG_NUM     NUMBER REFERENCES NONG(NONG_NUM) ON DELETE CASCADE, --원문 글삭제시 댓글도 삭제됨--
foreign key (NAME) REFERENCES mynong(MYNONG_NAME) ON DELETE CASCADE
)

DROP   SEQUENCE NONG_CO_SEQ;
CREATE SEQUENCE NONG_CO_SEQ;


SELECT * FROM NONG_CO;