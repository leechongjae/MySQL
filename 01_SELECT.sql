/* SELECT FROM */

-- SELECT 문을 사용하여 단일 열 데이터 검색
SELECT menu_name FROM tbl_menu;
SELECT menu_name FROM tbl_menu;

-- SELECT 문을 사용하여 여러 열의 데이터 검색
SELECT 
    menu_code, 
    menu_name, tbl_menutbl_menu
    menu_price
FROM
    tbl_menu;
    
-- SELECT 문을 사용하여 모든 열에서 데이터 검색
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu;

SELECT 
    * 
FROM 
    tbl_menu;

/* SELECT */

-- 연산자
SELECT 6 + 3;   
SELECT 6 * 3;
SELECT 6 % 3;

-- 내장함수(이후 챕터에서 다룰 내용)
SELECT NOW();
SELECT CONCAT('홍.',' ','길동');

-- 컬럼 별칭(이후 챕터에서 다룰 내용)
SELECT CONCAT('홍',' ','길동') AS name;
SELECT CONCAT('홍',' ','길동') AS 'Full name';