/* SET OPERATORS */
/* Note. 수업 들어갈 때, UNION, UNION ALL, INTERSECT, MINUS에 대해 벤다이어 그램 설명. */

-- 쿼리 대상이 될 2개의 결과 집합
-- A. category_code가 10인 메뉴들
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10;
    
-- B. menu_price가 9000원 미만인 메뉴들
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;

/* UNION */
-- SET 연산자를 통해 결합하는 결과 집합의 컬럼이 동일해야 함.
-- 두 SELECT 질의의 결과 중 교집합은 중복을 제거한 후 반환함.
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10
UNION
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;

/* UNION ALL */
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10
UNION ALL
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    menu_price < 9000;
-- ORDER BY 1;	-- 중복된 레코드가 있는지 확인하기 위한 ORDER BY 절

/* Note.
아래서 다룰 INTERSECT와 MINUS 연산자는 MySQL에는 제공하지 않는 연산자다.
따라서 각각 INNER JOIN, OUTER JOIN(LEFT or RIGHT)을 활용해 구현 가능하다.
*/

/* INTERSECT(교집합) */
-- 두 SELECT 질의의 결과 중, 공통되는 레코드만을 반환하는 SQL 연산자다.
-- MySQL은 INTERSECT를 제공하지 않는다. 하지만 INNER JOIN 또는 IN을 활용해서 구현하는 것은 가능하다.

-- 1) INNER JOIN 활용
SELECT 
    a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
FROM
    tbl_menu a
INNER JOIN (SELECT 
		menu_code,
		menu_name,
		menu_price,
		category_code,
		orderable_status
	FROM
		tbl_menu 
	WHERE
		menu_price < 9000) b on (a.menu_code = b.menu_code)
WHERE
    a.category_code = 10;
    
-- 2) IN 연산자 활용

SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = 10 AND
    menu_code IN (SELECT 
		menu_code
	FROM
		tbl_menu 
	WHERE
		menu_price < 9000);

/* MINUS(차집합) */
-- MySQL은 MINUS를 제공하지 않는다. 하지만 LEFT JOIN을 활용해서 구현하는 것은 가능하다.
SELECT 
    a.menu_code,
    a.menu_name,
    a.menu_price,
    a.category_code,
    a.orderable_status
FROM
    tbl_menu a
LEFT JOIN (SELECT 
		menu_code,
		menu_name,
		menu_price,
		category_code,
		orderable_status
	FROM
		tbl_menu 
	WHERE
		menu_price < 9000) b on (a.menu_code = b.menu_code)
WHERE
    a.category_code = 10 AND
    b.menu_code IS NULL;