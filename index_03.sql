-- 2023-03-08 (SELECT문)

-- DESC customer; 테이블 정보 확인 명령어
SELECT * FROM customer;

-- <IS NULL>

-- 고객 테이블에서 연락처가 존재하지 않는 고객 조회
SELECT * FROM customer WHERE birth IS NULL;
SELECT * FROM customer WHERE phone IS NULL AND birth IS NULL;

-- 고객 테이블에서 연락처가 존재하지 않는 고객 조회
SELECT * FROM customer WHERE phone IS NOT NULL;

