/* WHERE */

-- 1) 비교 연산자 예제와 함께 WHERE절 사용
SELECT 
    menu_name, 
    menu_price, 
    orderable_status
FROM
    tbl_menu
WHERE
    orderable_status = 'Y';
    
SELECT 
    menu_name, 
    menu_price, 
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price = 13000;

-- 같지 않음 연산자와 함께 WHERE절 사용
SELECT 
    menu_code,
    menu_name, 
    orderable_status
FROM
    tbl_menu
WHERE
--     orderable_status <> 'Y';
    orderable_status != 'Y';

-- 대소 비교 연산자와 함께 WHERE절 사용
SELECT 
    menu_code, 
    menu_name, 
    menu_price
FROM
    tbl_menu
WHERE 
    menu_price > 20000;

SELECT 
    menu_code, 
    menu_name, 
    menu_price
FROM
    tbl_menu
WHERE 
    menu_price <= 20000;

-- 2) AND 연산자와 함께 WHERE절 사용
SELECT 1 AND 1;
SELECT 1 AND 0, 0 AND 1, 0 AND 0, 0 AND NULL;
SELECT 1 AND NULL, NULL AND NULL;

SELECT 
    menu_name, 
    menu_price, 
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    orderable_status = 'Y' AND
    category_code = 10;

SELECT 
    menu_code, 
    menu_name, 
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price > 5000 AND 
    category_code = 10;
        
-- 3) OR 연산자와 함께 WHERE절 사용
SELECT 1 OR 1, 1 OR 0, 0 OR 1;
SELECT 0 OR 0;
SELECT 1 OR NULL, 0 OR NULL, NULL or NULL;

SELECT 
    menu_name, 
    menu_price, 
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    orderable_status = 'Y' OR
    category_code = 10
ORDER BY
    category_code;
    
SELECT 
    menu_code, 
    menu_name, 
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price > 5000 OR
    category_code = 10;

-- 우선 순위
SELECT 1 OR 0 AND 0;
SELECT (1 OR 0) AND 0;

SELECT 
    menu_code, 
    menu_name, 
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 4 OR
    menu_price = 9000 AND
    menu_code > 10;
    
-- 4) BETWEEN 연산자 예제와 함께 WHERE절 사용
SELECT 
    menu_name, 
    menu_price, 
    category_code
FROM
    tbl_menu
WHERE
    menu_price >= 10000 AND 
    menu_price <= 25000
ORDER BY 
    menu_price;

SELECT 
    menu_name, 
    menu_price, 
    category_code
FROM
    tbl_menu
WHERE
    menu_price BETWEEN 10000 AND 25000
ORDER BY 
    menu_price;
    
-- 부정 표현
SELECT 
    menu_name, 
    menu_price, 
    category_code
FROM
    tbl_menu
WHERE
    menu_price NOT BETWEEN 10000 AND 25000
ORDER BY 
    menu_price;

-- 5) LIKE 연산자 예제와 함께 MySQL WHERE절 사용
SELECT 
    menu_name, 
    menu_price
FROM
    tbl_menu
WHERE
    menu_name LIKE '%마늘%'
ORDER BY 
    menu_name;
    
SELECT 
    menu_code, 
    menu_name, 
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price > 5000 AND 
    category_code = 10 AND
    menu_name LIKE '%갈치%';

-- 부정 표현
SELECT 
    menu_name, 
    menu_price
FROM
    tbl_menu
WHERE
    menu_name NOT LIKE '%마늘%'
ORDER BY 
    menu_name;

-- 6) IN 연산자 예제와 함께 WHERE절 사용
SELECT 
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code = 4 OR
    category_code = 5 OR
    category_code = 6
ORDER BY 
    category_code;

SELECT 
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code IN (4, 5, 6)
ORDER BY 
    category_code;
    
-- 부정 표현
SELECT 
    menu_name,
    category_code
FROM
    tbl_menu
WHERE
    category_code NOT IN (4, 5, 6)
ORDER BY 
    category_code;

-- 7) IS NULL 연산자와 함께 WHERE절 사용
SELECT 
    category_code, 
    category_name, 
    ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NULL; -- NULL값을 확인하기 위해서는 =가 아닌 IS 연산자를 사용해야 함.

-- 부정 표현
SELECT 
    category_code, 
    category_name, 
    ref_category_code
FROM
    tbl_category
WHERE
    ref_category_code IS NOT NULL;
