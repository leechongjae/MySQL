/* LIMIT */
 
-- 전체 행 조회
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC;

-- 2번 행부터 5번 행까지 조회
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC
LIMIT 1, 4;

-- 상위 다섯줄의 행만 조회
SELECT 
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY 
    menu_price DESC,
    menu_name ASC
LIMIT 5;

