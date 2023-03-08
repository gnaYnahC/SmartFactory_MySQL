-- 2023-03-08 (SELECT문)

-- DESC customer; 테이블 정보 확인 명령어
SELECT * FROM customer;

-- <IS NULL>

-- 고객 테이블에서 연락처가 존재하지 않는 고객 조회
SELECT * FROM customer WHERE birth IS NULL;
SELECT * FROM customer WHERE phone IS NULL AND birth IS NULL;

-- 고객 테이블에서 연락처가 존재하지 않는 고객 조회
SELECT * FROM customer WHERE phone IS NOT NULL;




-- <집계 함수>
-- SUM() = 합계 , AVG() = 평균, MAX() = 최대값, MIN() = 최소값
-- COUNT() = 행 개수, COUNT(DISTINCT) = 중복 제외한 행 개수
-- FROM 앞에 보통 많이 사용함

-- 주문 테이블의 총 판매 개수 검색 + 의미있는 속성 이름으로 변경
SELECT SUM(amount) AS 'total_amount' FROM orders;
SELECT SUM(amount) AS total_amount FROM orders; -- 따옴표 붙이는게 좋음
SELECT SUM(amount) total_amount FROM orders; -- AS 붙이는게 좋음

-- 주문 테이블에서 총 판매 개수, 평균 판매 개수, 상품 최저가, 상품 최고가 출력
SELECT SUM(amount) AS '총 판매 개수', 
	AVG(amount) AS '평균 판매 개수', 
	MIN(price) AS '상품 최저가', 
	MAX(price) AS '상품 최고가' 
FROM orders;

-- 주문 테이블에서 총 주문 내역 건수 조회
-- 환불할 수도 있기 때문에 orderid의 마지막 값을 추출하면 안됨
SELECT count(*) FROM orders; -- COUNT(*): 모든 행의 개수를 카운트
SELECT count(orderid) FROM orders; -- COUNT(속성이름): NULL을 제외한 모든 행의 개수를 카운트

SELECT count(*) FROM customer; -- 11 
SELECT count(phone) FROM customer; -- 10
SELECT count(birth) FROM customer; -- 9




-- <GROUP BY>
-- 컬럼끼리 그룹으로 묶는 역할

-- 고객별로 주문한 주문 내역 건수 구하기
SELECT custid, count(amount) AS '주문 내역 건수' FROM orders GROUP BY custid;

-- 고객별로 주문한 상품 총 수량 구하기
SELECT custid, SUM(amount) AS '상품 총 수량' FROM orders GROUP BY custid;

-- 고객별로 주문한 총 주문액 구하기
SELECT custid, SUM(price * amount) AS '총 주문액' FROM orders GROUP BY custid;

-- 상품별로 판매 개수 구하기 + 판매 개수를 기준으로 내림차순 정렬
SELECT prodname, SUM(amount) AS '판매 개수' FROM orders GROUP BY prodname ORDER BY SUM(amount) DESC;



-- <HAVING>
-- group by절의 결과를 나타내는 그룹을 제한 (= group by 명령 이후 추가 조건)

-- 총 주문액이 10000원 이상인 고객에 대해 고객별로 주문한 상품 총 수량 구하기
/*
SELECT custid, SUM(amount), SUM(price * amount) AS '총 주문액' 
	FROM orders 
    WHERE SUM(price * amount) >= 10000 
    GROUP BY custid;
*/ -- error code: 1111, group 함수 잘못 사용

SELECT custid, SUM(amount) AS '총 주문수량', SUM(price * amount) AS '총 주문액' 
	FROM orders 
    GROUP BY custid
    HAVING SUM(price * amount) >= 10000; 

-- WHERE, GROUP BY, HAVING이 모두 쓰이는 경우는 거의 없음
-- 총 주문액이 10000원 이상인 고객에 대해 고객별로 주문한 상품 총 수량 구하기 (단, custid가 'bunny'인 경우 제외)
SELECT custid, SUM(amount) AS '총 주문수량', SUM(price * amount) AS '총 주문액' 
	FROM orders 
    GROUP BY custid
    HAVING SUM(price * amount) >= 10000 AND custid NOT LIKE 'bunny'; 