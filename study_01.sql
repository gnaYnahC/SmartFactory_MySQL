-- 2023-03-07 <SQL 실습>

-- 모든 회원목록을 가져오는데, 이때 birthday 컬럼의 값을 기준으로 오름차순 정렬하여 가져오시오.
SELECT * FROM user ORDER BY birthday;
SELECT * FROM user ORDER BY birthday ASC;

-- 회원 목록 중 gender 컬럼의 값이 “M” 인 회원목록을 가져오는데, 이때 name 컬럼의 값을 기준으로 내림차순 정렬하여 가져오시오.
SELECT * FROM user WHERE gender = 'M' ORDER BY name DESC;
SELECT * FROM user WHERE gender IN ('M') ORDER BY name DESC;

-- 1990 년대에 태어난 회원의 id, name 컬럼을 가져와 목록으로 보여주시오.
SELECT id, name FROM user WHERE birthday <= '1999-12-31' AND birthday >= '1990-01-01';
SELECT id, name FROM user WHERE birthday BETWEEN '1990-01-01' AND '1999-12-31';
SELECT id, name FROM user WHERE birthday LIKE '199%';

-- 6월 생 회원의 목록을 birthday 기준으로 오름차순 정렬하여 가져오시오
SELECT * FROM user WHERE birthday LIKE '____-06%' ORDER BY birthday;
SELECT * FROM user WHERE birthday LIKE '%-06-%' ORDER BY birthday;

-- gender 컬럼의 값이 “M” 이고, 1970 년대에 태어난 회원의 목록을 가져오시오.
SELECT * FROM user WHERE gender = 'M' AND birthday LIKE '197%';

-- 모든 회원목록 중 age를 기준으로 내림차순 정렬하여 가져오는데, 그때 처음 3개의 레코드만 가져오시오.
SELECT * FROM user ORDER BY age DESC LIMIT 3;

-- 모든 회원 목록 중 나이가 25이상 50이하인 회원의 목록을 출력하시오.
SELECT * FROM user WHERE age >= 25 AND age <= 50;
SELECT * FROM user WHERE age BETWEEN 25 AND 50;

-- 모든 회원 목록 중 90년생 이 후 출생자 이고, 미국에 사는 회원 이름과 아이디를 출력하시오.
SELECT custid,custname FROM customer WHERE birth LIKE '1990%'  AND addr LIKE '미국%';



