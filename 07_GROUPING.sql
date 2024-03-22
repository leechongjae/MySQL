/* GROUP BY */

-- 메뉴가 존재하는 카테고리 그룹 조회
SELECT 
    category_code
FROM
    tbl_menu
GROUP BY category_code;

-- COUNT 함수 활용
-- 카테고리별 메뉴 개수
SELECT 
    category_code,
    COUNT(*)
FROM
    tbl_menu
GROUP BY category_code;

-- SUM 함수 활용
-- 카테고리별 메뉴 가격 합계
SELECT 
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
GROUP BY category_code;

-- AVG 함수 활용
-- 카테고리별 메뉴 가격 평균
SELECT 
    category_code,
    AVG(menu_price)
FROM
    tbl_menu
GROUP BY category_code;

-- 2개 이상의 그룹 생성
SELECT 
    menu_price,
    category_code
FROM
    tbl_menu
GROUP BY 
    menu_price,
    category_code;

SELECT 
    category_code,
    menu_price
FROM
    tbl_menu
GROUP BY 
    menu_price,
    category_code;
    
/* HAVING */
-- HAVING을 활용해 5번(중식) 카테고리부터 8번(커피) 카테고리까지의 메뉴 카테고리 번호 조회
SELECT 
    category_code
FROM
    tbl_menu
GROUP BY category_code;

SELECT 
    category_code
FROM
    tbl_menu
GROUP BY category_code
HAVING category_code BETWEEN 5 AND 8;

/* ROLLUP */
-- 각 그룹에 대한 소계 및 총계를 계산하여 resultset에 포함시킴.
-- 컬럼 한 개를 활용한 ROLLUP(카테고리별 총합)
SELECT 
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
GROUP BY 
    category_code;

SELECT 
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
GROUP BY 
    category_code
WITH ROLLUP;

-- 컬럼 두 개를 활용한 ROLLUP(같은 메뉴 가격별 총합 및 해당 메뉴 가격별 같은 카테고리의 총합)
-- ROLLUP을 통해 먼터 나온 컬럼의 총합을 구하고 이후 나오는 컬럼의 총합도 구하는 방식이다.
SELECT 
    menu_price,
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
GROUP BY 
    menu_price,
    category_code;

SELECT 
    menu_price,
    category_code,
    SUM(menu_price)
FROM
    tbl_menu
GROUP BY 
    menu_price,
    category_code
WITH ROLLUP;
