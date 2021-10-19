drop table product  cascade constraints;

delete from product;

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


select * from product;

	select *
		from (select a.product_code, count(*) cnt
		  	  from (select rownum rnum, p.product_code, p.category_code, c.category_name, p.product_name, p.product_price,
			  	   		  		   p.product_detail, p.product_img, p.product_original, p.product_date
			  	   			from product p, CATEGORY c, review r
			  	   			where p.category_code = c.category_code
			  	   			and p.category_code = r.category_code) a
		  group by a.product_code
		  order by cnt desc)
		  where rnum = 1 and rnum = 10

1단계 review 개수 구하기
- review 테이블 전체 행 갯수

SELECT COUNT(*) FROM review;

- review 테이블에서 product 별 리뷰 갯수 구하기 
SELECT COUNT(product_code), review.product_code, review.product_name FROM review
group by product_code, product_name;
		  

SELECT COUNT(product_code), review.product_code, review.product_name, review.category_code, review.review_content,
review.review_img, review.review_date, review.member_nick
FROM review
group by product_code, product_name, category_code, review_content, review_img, review_date, member_nick ;

----------------------------------------------------------------------------------------------------------------------------

2단계  review와 product 테이블 join하기 
      (리뷰개수가 0인것도 나오게 하려면 left outer join)
 

  
select COUNT(a.product_code), product.product_code, product.product_name, product.product_detail,
product.category_code, product.product_price, product.product_img, product.product_original, product.product_date,
a.review_content, a.review_img, a.review_date, a.member_nick

from product left outer join

(SELECT COUNT(product_code), review.product_code, review.product_name, review.category_code, review.review_content,
review.review_img, review.review_date, review.member_nick
FROM review
group by product_code, product_name, category_code, review_content, review_img, review_date, member_nick)a

on product.product_code = a.product_code
group by a.product_code, product.product_code, product.product_name, product.product_detail,
product.category_code, product.product_price, product.product_img, product.product_original, product.product_date,
a.review_content, a.review_img, a.review_date, a.member_nick
order by a.product_code;



----------------------------------------------------------------------------------------------------------------------------

3단계  review와 product를 조인한 테이블에서 count로 리뷰개수 구하고 count로 order by 하며 rownum 매기기 

select rownum rnum, b.* from

(select COUNT(a.product_code), product.product_code, product.product_name, product.product_detail,
product.category_code, product.product_price, product.product_img, product.product_original, product.product_date,
a.review_content, a.review_img, a.review_date, a.member_nick

from product left outer join

(SELECT COUNT(product_code), review.product_code, review.product_name, review.category_code, review.review_content,
review.review_img, review.review_date, review.member_nick
FROM review
group by product_code, product_name, category_code, review_content, review_img, review_date, member_nick)a

on product.product_code = a.product_code
group by a.product_code, product.product_code, product.product_name, product.product_detail,
product.category_code, product.product_price, product.product_img, product.product_original, product.product_date,
a.review_content, a.review_img, a.review_date, a.member_nick
order by a.product_code) b

where rnum = 1 and rnum = 10








--------------------------------------------------------------------------------------------------------
select * from 

	select rownum rnum, pr.*
	  from
	  (select p.product_code, p.category_code, p.product_name, p.product_price,
	  	   		  p.product_detail, p.product_img, p.product_original, p.product_date
	  	   from 
	  	   product p,review r
	  	   where p.category_code= r.category_code ) a
	  	   group by p.category_code
	  	   order by review cnt
	  	   ,p.product_code) pr
	 
where rnum >= 1 and rnum <= 10;


select * from 

	(select rownum rnum, b.*
	  from
	  (select p.product_code, p.category_code, c.category_name, p.product_name, p.product_price,
	  	   		  p.product_detail, p.product_img, p.product_original, p.product_date
	  	   from 
	  	   product left outer join (select *, count(*) cnt
 			        				from 
 			        				review r,category c
 			        				where r.category_code = c.category_code
 			        				group by cnt) r
	       on product.category_code = c.category_code   
	       order by cnt desc  ) b
	 			 )
where rnum >= 1 and rnum <= 10;


select * from
	 			( select rownum rnum, b.*
	 			  from
	 			       (select product.*, nvl(cnt,0) cnt
	 			        from
	 			        product left outer join (select *, count(*) cnt
	 			        					   from review
	 			        					   group by cnt) c
	 			        on product.category_code = c.category_code
	 			        order by cnt desc  ) b
	 			 )

  select a.product_code, count(*) cnt
  from (select p.product_code, p.category_code, c.category_name, p.product_name, p.product_price,
	  	   		  		   p.product_detail, p.product_img, p.product_original, p.product_date
	  	   			from product p, CATEGORY c, review r
	  	   			where p.category_code = c.category_code
	  	   			and p.category_code = r.category_code) a
  group by a.product_code
  order by cnt desc
  
select *
		from (select rownum rnum, pr.*
			  from (select p.product_code, p.category_code, c.category_name, p.product_name, p.product_price,
	  	   		  		   p.product_detail, p.product_img, p.product_original, p.product_date
	  	   			from product p, CATEGORY c ,order_detail o
	  	   			where p.category_code = c.category_code
	  	   		    and   p.PRODUCT_CODE = o.PRODUCT_CODE
	  	   			order by o.ORDER_DE_COUNT,
	  	   			p.product_code) pr
			 )
		where rnum >= 1 and rnum <= 8  
  
INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000001', '600', '주말 장바구니(소)', '4000', '오래 쓸 수 있는 튼튼한 장바구니', '장바구니_소.jpg', '장바구니_소.jpg', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000002', '600', '주말 장바구니(중)', '6000', '오래 쓸 수 있는 튼튼한 장바구니', '장바구니_중.jpg', '장바구니_중.jpg', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000003', '300', '대유 모두나와(500ml)', '11500', '고추 토마토 딸기 작물 총채벌레 진딧물 해충 유인제', '대유_모두나와.png', '대유_모두나와.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000004', '300', '대유 응진싹', '8900', '응애 진딧물 온실가루이 해충퇴치 천연추출물 효과 빠른 살충제', '대유_응진싹.png', '대유_응진싹.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000005', '300', '유일 잎끝마름에(300ml)', '13500', '고추 대파 양파 마늘 쪽파 잎마름병 예방 치료 살충 살균제', '잎끝마름에.png', '잎끝마름에.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000006', '300', '대유 나르겐골드(500ml)', '8500', '식물활력 생육증진 맛 색깔 개선 영양제', '나르겐골드.png', '나르겐골드.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000007', '300', '대유 과비대애(500ml)', '14500', '비대제 사과 감귤 포도 복숭아 배 과일 나무 비료 당도 영양제', '대유_과비대애.png', '대유_과비대애.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000008', '300', '초주금 골드(500ml)', '13000', '친환경 잡초관리제 잡초제거제 농약 제초제 말고 그라목손 근사미', '초주금.png', '초주금.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000009', '300', '청충불패', '24500', '선녀벌레 뿌리파리 나방 고추 진딧물 유기농 살충제 해충관리', '청충불패.png', '청충불패.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000010', '300', '뉴 톡깍이파워(250ml)', '25000', '톡토기 깍지벌레 살충제 퇴치 친환경 고추 배추 해충관리제 진딧물', '뉴_톡깍이파워.png', '뉴_톡깍이파워.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000011', '300', '옥시-팜(100g)', '50000', '강력한 토양개량제 고추 딸기 비료 영양제 아쿠도 루핸스 한국농수산', '옥시팜.png', '옥시팜.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000012', '300', '오복이(500ml/1L)', '20000', '수용성 유황 규산 고추 탄저병 유기농 영양제 칼슘제 비료', '오복이.png', '오복이.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000013', '300', '대유 뿌리커(500ml)', '8800', '감자 고추 고구마 배추 마늘 양파 비대 구근 비대 뿌리활착 전용', '대유_뿌리커.png', '대유_뿌리커.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000014', '100', '오복꿀', '60000', '참외씨앗 오복꿀 500립 명품 참외종자 농우바이오', '오복꿀.png', '오복꿀.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000015', '100', '칼라짱', '1300000', '칼라짱 고추씨앗 1200립 극대롸 탄저병 칼라병 예방 바이러스 고추종자 농우바이오', '칼라짱.png', '칼라짱.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000016', '100', '백봉다다기', '15000', '농우바이오 백다다기 백봉 오이씨앗 종자 500립 백봉다다기 오이', '백봉다다기.png', '백봉다다기.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000017', '100', '추월배추', '14500', '추월배추 2021년포장 뿌리혹병 노균병 바이러스에 강한 김장배추 씨앗 종자', '추월배추.png', '추월배추.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000018', '100', '베타500', '11000', '베타500 김장배추 종자 300립 항암효과 베타카로틴 가을 황금배추', '베타500.png', '베타500.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000019', '100', '청진플러스', '4000', '농가왕무 백청무 추성무 가을무 김장무씨앗 청진플러스', '청진플러스.png', '청진플러스.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000020', '100', '알타리무 천사무 홍반장무', '4500', '홍반장무 알타리무 총각무 달랑무 가을무 종자 농우바이오', '홍반장무.png', '홍반장무.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000021', '100', '롱그린맛', '70000', '롱그린 오이고추 고추씨앗 1000립 아삭이 바이러스예방 종자 농우바이오', '롱그린맛.png', '롱그린맛.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000022', '100', '부추모종', '1090', '부추모종 숱이많은 부추 잎줄기 채소 야채', '부추모종.png', '부추모종.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000023', '100', '고수모종', '990', '고수모종 소화도움 한방 약재 잎줄기 채소 야채', '고수모종.png', '고수모종.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000024', '100', '쪽파모종', '390', '쪽파모종 비타민A 면역력 증진 잎줄기 채소 야채', '쪽파모종.png', '쪽파모종.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000025', '100', '케일모종(2포트)', '790', '케일모종 비타민A 면역력 증진 잎줄기 채소 야채', '케일모종.png', '케일모종.png', sysdate);

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000026', '100', '아삭이상추모종(2포트)', '790', '아삭이상추모종 일반 상추보다 두껍고 단맛 색 선명 잎줄기 채소 야채', '아삭이상추모종.png', '아삭이상추모종.png', sysdate);

----200번(비료/상토) 카테고리부터 400,500,600 -------

INSERT INTO PRODUCT(PRODUCT_CODE, CATEGORY_CODE, PRODUCT_NAME, PRODUCT_PRICE ,
PRODUCT_DETAIL, PRODUCT_IMG, PRODUCT_ORIGINAL, PRODUCT_DATE)
VALUES('000027', '200', '아삭이상추모종(2포트)', '790', '아삭이상추모종 일반 상추보다 두껍고 단맛 색 선명 잎줄기 채소 야채', '아삭이상추모종.png', '아삭이상추모종.png', sysdate);