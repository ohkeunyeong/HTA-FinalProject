--멤버 게시판--
DROP TABLE NONG cascade constraints;

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
foreign key (NAME) REFERENCES mynong(MYNONG_NAME),
foreign key (ID) REFERENCES MEMBER(ID) ON DELETE CASCADE -- 게시글 쓴 회원이 탈퇴처리되면 게시글도 삭제됨--
)


SELECT * FROM NONG;

delete from nong where nong_num='admin';

insert into nong values
(1, 'testnong', 'admin', '비밀번호', '제목', '내용', '첨부파일가공', '첨부파일', 0, 0, 0, 1, sysdate)



