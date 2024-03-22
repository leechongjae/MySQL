/* CAST FUNCTIONS */
/* Note. Notion 자료의 데이터 형식 표 외울 필요 없음!
  - 요새는 H/W 가격이 상당히 저렴하기 때문에 자료형이 그렇게 중요하지 않음(가변형 데이터도 존재하는 세상이기 때문).
  - 숫자: INT, FLOAT, 추가로 BIGINT, DOUBLE REAL 정도만 알고 있어도 충분함.
  - 문자: CHAR, VARCHAR, 추가로 TEXT, LONGTEXT 정도만 알고 있어도 충분함.
  - 날짜: DATE, TIME, DATETIME, 참고로 TIMESTAMP는 자주 사용하지는 않음.
*/

/* 명시적 형변환(Explicit Conversion) */
-- CAST (expression AS 데이터형식 [(길이)])
-- CONVERT (expression, 데이터형식 [(길이)])
-- 데이터 형식으로 가능한 것은 BINARY, CHAR, DATE, DATETIME, DECIMAL, JSON, SIGNED INTEGER, TIME, UNSIGNED INTEGER 등이 있다.

SELECT 
    AVG(menu_price)
FROM
    tbl_menu;
SELECT CAST(AVG(menu_price) AS SIGNED INTEGER) AS '평균 메뉴 가격' FROM tbl_menu;
SELECT CONVERT(AVG(menu_price), SIGNED INTEGER) AS '평균 메뉴 가격' FROM tbl_menu;

SELECT CAST('2023$5$30' AS DATE);
SELECT CAST('2023/5/30' AS DATE);
SELECT CAST('2023%5%30' AS DATE);
SELECT CAST('2023@5@30' AS DATE);

-- 카테고리별 메뉴 가격 합계 구하기
SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원') FROM tbl_menu;

-- 카테고리별 메뉴 가격 합계 구하기
SELECT category_code, CONCAT(CAST(SUM(menu_price) AS CHAR(10)), '원') FROM tbl_menu GROUP BY category_code;

/* 암시적 형변환(Implicit Conversion) */
/* Note.
암시적 형변환은 각 DBMS마다 문법이 다르기 때문에 사실상 외우는 것이 무의미하며 불가능하다.
따라서 이를 염두에 두고 아래 예시를 실행해본다.
*/
SELECT '1' + '2';    -- 각 문자가 정수로 변환됨
SELECT CONCAT(menu_price, '원') FROM tbl_menu;    -- menu_price가 문자로 변환됨
SELECT 3 > 'MAY';    -- 문자는 0으로 변환된다.

SELECT 5 > '6MAY';   -- 문자에서 첫번째로 나온 숫자는 정수로 전환된다.
SELECT 5 > 'M6AY';   -- 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.
SELECT '2023-5-30';  -- 날짜형으로 바뀔 수 있는 문자는 DATE형으로 변환된다.


