/* DISTINCT */

-- 단일 열 DISTINCT
SELECT 
    category_code
FROM
    tbl_menu
ORDER BY 
    category_code;
    
SELECT 
    DISTINCT category_code
FROM
    tbl_menu
ORDER BY 
    category_code;
    
-- NULL값을 포함한 열의 DISTINCT
SELECT
	ref_category_code
FROM 
	tbl_category;
    
SELECT
	DISTINCT ref_category_code
FROM 
	tbl_category;

-- 열이 여러 개인 DISTINCT
SELECT 
    category_code, 
    orderable_status
FROM
    tbl_menu;
    
SELECT DISTINCT
    category_code, 
    orderable_status
FROM
    tbl_menu;

