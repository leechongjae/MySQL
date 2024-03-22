/* ORDER BY */

-- ORDER BY 절을 사용하여 결과 집합을 하나의 열로 정렬
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
--     menu_price ASC;    -- ASC는 오름차순
    menu_price;

-- 역순 정렬
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC;    -- DESC는 내림차순
    
-- ORDER BY 절을 사용하여 결과 집합을 여러 열로 정렬
SELECT 
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY 
    menu_price DESC,
    menu_name ASC;
    
-- ORDER BY 절을 사용하여 연산 결과로 결과 집합 정렬
SELECT 
    menu_code, 
    menu_price, 
    menu_code * menu_price
FROM
    tbl_menu
ORDER BY 
    menu_code * menu_price DESC;
   
SELECT 
    menu_code, 
    menu_price, 
    menu_code * menu_price AS 연산결과
FROM
    tbl_menu
ORDER BY 
    연산결과 DESC;

-- ORDER BY 절을 사용하여 사용자 지정 목록을 사용하여 데이터 정렬
SELECT FIELD('A', 'A', 'B', 'C');
SELECT FIELD('B', 'A', 'B', 'C');

SELECT 
    FIELD(orderable_status, 'N', 'Y')
FROM 
    tbl_menu;

SELECT 
    menu_name, 
    orderable_status
FROM
    tbl_menu
ORDER BY FIELD(orderable_status, 'N', 'Y');
-- FIELD 함수에 의해 주문 상태가 N인 메뉴가 먼저 출력되고 그 다음으로 Y인 메뉴가 출력됨.

-- NULL
-- 오름차순 시 NULL 처음으로(DEFAULT)
SELECT 
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
ORDER BY 
--     ref_category_code ASC;
    ref_category_code;    -- ASC 생략 가능
-- SQL에서 NULL값은 최소값으로 간주됨.

-- 오름차순 시 NULL 마지막으로(IS NULL ASC)
SELECT 
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
ORDER BY 
--     ref_category_code IS NULL ASC;
    ref_category_code IS NULL;    -- ASC 생략 가능
-- NULL이 아닌 행들을 먼저 정렬 후 마지막에 NULL 정렬.

-- 내림차순 시 NULL 마지막으로(DEFAULT)
SELECT 
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
ORDER BY 
    ref_category_code DESC;    -- DESC 생략 불가능

-- 내림차순 시 NULL 처음으로(IS NULL DESC)
SELECT 
    category_code,
    category_name,
    ref_category_code
FROM
    tbl_category
ORDER BY 
    ref_category_code IS NULL DESC, ref_category_code DESC;    -- DESC 생략 불가능