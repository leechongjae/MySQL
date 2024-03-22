/* 서브쿼리 */

-- 서브쿼리
-- 민트 미역국의 카테고리 번호 조회    
SELECT
    category_code
FROM
    tbl_menu
WHERE
    menu_name = '민트미역국';
    
-- 메인쿼리
-- 다중열 결과 조회
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu;
    
-- 서브쿼리를 활용한 메인쿼리
-- Q) 민트미역국과 같은 카테고리의 메뉴 조회하시오.
SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu
WHERE
    category_code = (SELECT 
            category_code
        FROM
            tbl_menu
        WHERE
            menu_name = '민트미역국');

-- 가장 많은 메뉴가 포함된 카테고리 조회
-- 서브쿼리
SELECT
    COUNT(*) AS 'count'
FROM
    tbl_menu
GROUP BY category_code;

-- FROM 절에 쓰인 서브쿼리(derived table, 파생 테이블)는 반드시 자신의 별칭이 있어야 한다.
SELECT
    MAX(count)
FROM
    (SELECT
        COUNT(*) AS 'count'
    FROM
        tbl_menu
    GROUP BY category_code) AS countmenu;
    
/* 상관 서브쿼리 */

-- 메인 쿼리가 서브쿼리의 결과에 영향을 주는 경우 상관 서브쿼리라고 한다.
-- 서브쿼리
SELECT
    AVG(menu_price)
FROM
    tbl_menu
WHERE
    category_code = 4;

-- 카테고리별 평균 가격보다 높은 가격의 메뉴 조회

SELECT 
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu a
WHERE
    menu_price > (SELECT
            AVG(menu_price)
        FROM
            tbl_menu
        WHERE
            category_code = a.category_code);  

/* EXISTS */

-- 조회 결과가 있을 때 true 아니면 false

-- 메뉴가 있는 카테고리 조회
SELECT
    category_name,
    category_code
FROM
    tbl_category a
WHERE
    EXISTS(
		SELECT
            1
        FROM
            tbl_menu b
        WHERE
            b.category_code = a.category_code
    )
ORDER BY 1;
                
/* Common Table Expressions */

-- 파생 테이블과 비슷한 개념이며 코드의 가독성과 재사용성을 위해 파생 테이블 대신 사용하게 된다.)
-- FROM절에서만 사용 됨(JOIN일 시 JOIN 구문에서도 가능)
WITH menucate AS (
    SELECT
        menu_name,
        category_name
    FROM 
        tbl_menu a
    JOIN 
        tbl_category b on a.category_code = b.category_code
)
SELECT
    *
FROM 
    menucate
ORDER BY 
    menu_name;