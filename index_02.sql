-- 2023-03-07 (SELECT문)

-- -- smartfactory 데이터베이스를 사용하는 명령어
USE smart_factory;

-- 문자 == 쿼리(query) 
-- 고객 테이블 전체 조회
SELECT * FROM customer;

-- 주문 테이블 전체 조회
SELECT * FROM orders;

-- 모든 고객의 아이디를 검색
SELECT custid FROM customer;

-- 모든 고객의 고객아이디와 생년월일 검색
SELECT custid, birth FROM customer; -- 속성 순서가 있음
SELECT birth, custid FROM customer; -- 속성 순서가 있음

-- 모든 고객의 아이디, 주소, 전화번호, 이름, 생년월일 검색
SELECT custid, addr, phone, custname, birth FROM customer;

-- (와일드카드 사용)
-- *: ALL 모든것을 의미

-- 고객 테이블에 있는 모든 주소를 검색 (중복 포함된 결과)
SELECT addr FROM customer;




-- 고객 테이블에 있는 중복을 제외한 주소를 검색 
-- 중복값 제거 키워드 DISTINCT
SELECT DISTINCT addr FROM customer;



-- WHERE절!!

-- 비교 연산자: =, <, <=, >, >=
-- 고객 이름이 강해린인 고객을 검색
SELECT * FROM customer WHERE custname = '강해린';

-- 제품 가격이 4000원 이상인 주문 내역을 검색
SELECT * FROM orders WHERE price >= 4000;

-- 범위: BETWEEN a AND b 
-- 1995s 이상 2000년 이하 출생 고객 검색
SELECT * FROM customer WHERE birth BETWEEN '1995-01-01' AND '2000-12-31';
SELECT * FROM customer WHERE birth >= '1995-01-01' AND birth <= '2000-12-31';

-- 집합 (IN, NOT IN)
-- 주소가 서울 혹은 런던인 고객 검색
SELECT * FROM customer WHERE addr IN ('대한민국 서울','영국 런던');
SELECT * FROM customer WHERE addr = '대한민국 서울' OR addr = '영국 런던';
SELECT * FROM customer WHERE addr LIKE '대한민국 서울' OR addr LIKE '영국 런던';

-- 주소가 서울 혹은 런던이 아닌 고객 검색
SELECT * FROM customer WHERE addr NOT IN ('대한민국 서울','영국 런던');
SELECT * FROM customer WHERE addr != '대한민국 서울' AND addr != '영국 런던';
SELECT * FROM customer WHERE addr NOT LIKE '대한민국 서울' AND addr NOT LIKE '영국 런던';



-- 패턴 (LIKE): 특정 패턴을 포함하는 데이터를 검색, 와일드카드를 쓰기 위한 방법
-- %: 0개 이상의 문자
-- _: 1개의 단일 문자

-- 주소가 '미국 로스앤젤레스'인 고객 검색
SELECT * FROM customer WHERE addr LIKE '미국 로스앤젤레스';
-- 주소에 '미국'이 포함되어 있는 고객 검색
SELECT * FROM customer WHERE addr LIKE '미국%';
SELECT * FROM customer WHERE addr LIKE '_국%'; -- 두 번째 글자가 '국'인 주소 찾기
SELECT * FROM customer WHERE addr LIKE '_미국_'; -- 두 번째 세 번째 글자가 '미국'인 주소 찾기

-- 고객 이름 두번째 글자가 '지'인 고객 검색
SELECT * FROM customer WHERE custname LIKE '_지_'; -- 이름이 3자이며, 두번째 글자가 '지'인 사람
SELECT * FROM customer WHERE custname LIKE '_지%'; -- 이름이 두글자 이상인 사람 중 두번째 글자가 '지'인 사람
SELECT * FROM customer WHERE custname LIKE '%지_'; -- 뒤에서 두번째 글자가 '지'인 사람
SELECT * FROM customer WHERE custname LIKE '%지%'; -- 이름에 '지'가 들어간 사람
SELECT * FROM customer WHERE custname LIKE '_지'; -- 이름에 두 자이며, 마지막 글자가 '지'인 사람

-- 고객 이름 세번째 글자가 '수'인 고객 검색
SELECT * FROM customer WHERE custname LIKE '__수%';



-- 복합 조건: AND, OR, NOT

-- 주소지가 대한민국이고, 2000년생 이후 출생 고객 검색
SELECT * FROM customer WHERE addr LIKE '대한민국%' AND birth >= '2000-01-01';

-- 주소지가 미국이거나 영국인 고객 검색
SELECT * FROM customer WHERE addr LIKE '_국%';
SELECT * FROM customer WHERE addr LIKE '미국%' OR addr LIKE '영국%';
SELECT * FROM customer WHERE addr LIKE '%미국%' OR addr LIKE '%영국%'; -- 실행속도의 차이가 있을 수 있으니 이런 조건에선 앞에 %를 빼자

-- 휴대폰 번호 마지막 자리가 4가 아닌 고객 검색
SELECT * FROM customer WHERE phone NOT LIKE '%4';



-- ORDER BY: 결과 순서 조절 (ASC: 오름차순, DESC: 내림차순)

-- order by 절을 사용하지 않는 경우, pk 기준으로 정렬
SELECT * FROM customer;
SELECT * FROM customer ORDER BY custid ; -- 위와 같음
SELECT * FROM customer ORDER BY custid ASC; -- 위와 같음

SELECT * FROM orders order by orderid DESC;
SELECT * FROM orders order by orderid ASC;

-- ORDER BY와 WHERE 함께 사용, WHERE절이 앞에 나와야 함
-- 2000년 이후 출생자 중에서 주소를 기준으로 내림차순 검색
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY addr DESC;

-- ORDER BY 뒤에 여러 개의 속성을 줄 수 있음
-- 아래 두 쿼리문의 결과는 상이함
SELECT * FROM orders;
SELECT * FROM orders order by price DESC, amount DESC;
SELECT * FROM orders order by amount DESC, price DESC;



-- LIMIT : 출력 개수 제한
-- LIMIT 형식: LIMIT 시작, 개수 == LIMIT 개수 OFFSET 시작
-- LIMIT 0,2 == LIMIT 2 == LIMIT 2 OFFSET 0
-- 주의) LIMIT에서 시작은 0임을 잊지말자!
-- 문법의 제일 뒤

-- 고객테이블 전체를 조회하는데, 앞에 두 건만 조회하고 싶은 경우
SELECT *
 FROM customer
 LIMIT 2;

-- 고객테이블 전체를 조회하는데, 두번째 부터 여섯번째 행만 조회하고 싶은 경우
SELECT *
 FROM customer
 LIMIT 1,5;
-- 또는
SELECT *
 FROM customer
 LIMIT 5 OFFSET 1;

-- 2000년 이후 출생자 고객 중에서 앞에 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' LIMIT 2;

-- 2000년 이후 출생자 고객 중에서 뒤에 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY custid DESC LIMIT 2;

-- 추가)
-- 짝수 해에 태어난 고객
SELECT * FROM customer WHERE YEAR(birth)%2=0;

-- 홀수 일에 태어난 고객
SELECT * FROM customer WHERE MOD(DAY(birth),2)=1;

-- 2000-02-22 다음날에 태어난 고객 조회
SELECT * FROM customer WHERE birth = DATE('2000-02-22') + 1;

