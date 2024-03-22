/* Transaction */

-- MySQL은 기본적으로 commit이 자동으로 되므로 수동으로 조절하고 싶다면 autocommit 설정을 바꿔 주어야 한다.

-- autocommit 활성화
SET autocommit = 1; 
-- 또는 
SET autocommit = ON;

-- autocommit 비활성화
SET autocommit = 0; 
-- 또는 
SET autocommit = OFF;

-- START TRANSACTION 구문을 작성하고 DML 작업 수행 후 COMMIT 또는 ROLLBACK을 하면 된다.
-- COMMIT 이후에는 ROLLBACK을 해도 ROLLBACK이 적용되지 않는다.
START TRANSACTION;

SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

-- COMMIT; 
ROLLBACK;