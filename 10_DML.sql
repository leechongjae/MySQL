/* DML(Data Manipulation Language) */

-- INSERT, UPDATE, DELETE, SELECT(DQL)
-- : 데이터 조작언어, 테이블에 값을 삽입하거나, 수정하거나,
--   삭제하거나, 조회하는 언어

/* Note. SQL의 분류
1. DML(Data Manipulation Language): 데이터 조작어
  - 데이터베이스에서 데이터를 조회, 추가, 수정, 삭제하는 데 사용되는 명령어 집합
  - SELECT, INSERT, DELETE, UPDATE
2. DDL(Data Definition Language): 데이터 정의어
  - 데이터베이스의 구조를 정의, 수정, 삭제하는 데 사용되는 명령어 집합
  - CREATE, ALTER, DROP, TRUNCATE
3. DCL(Data Control Language): 데이터 제어어
  - 데이터베이스의 접근 권한을 설정하거나, 데이터의 보안과 무결성을 관리하는 데 사용되는 명령어 집합
  - GRANT, REVOKE
4. TCL(Transaction Control Language): 트랜잭션 제어어
  - 데이터베이스에서 트랜잭션의 처리를 관리하기 위해 사용되는 명령어 집합
  - COMMIT, ROLLBACK, SAVEPOINT
*/

/* INSERT */
-- 새로운 행을 추가하는 구문이다.
-- 테이블의 행의 수가 증가한다.
INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');

-- NULL 허용 가능한(NULLABLE) 컬럼이나 AUTO_INCREMENT가 있는 컬럼을 제외하고 INSERT하고 싶은 데이터 컬럼을 지정해서 INSERT 가능하다.
INSERT INTO tbl_menu(menu_name, menu_price, category_code, orderable_status)
VALUES ('초콜릿죽', 6500, 7, 'Y');

-- 컬럼을 명시하면 INSERT 시 데이터의 순서를 바꾸는 것도 가능하다.
INSERT INTO tbl_menu(orderable_status, menu_price, menu_name, category_code)
VALUES ('Y', 5500, '파인애플탕', 4);

SELECT * FROM tbl_menu;

-- MULTI INSERT
INSERT INTO 
    tbl_menu 
VALUES 
    (null, '참치맛아이스크림', 1700, 12, 'Y'),
    (null, '멸치맛아이스크림', 1500, 11, 'Y'),
    (null, '소시지맛커피', 2500, 8, 'Y');

/* UPDATE */
-- 테이블에 기록된 컬럼의 값을 수정하는 구문이다.
-- 테이블의 전체 행 갯수는 변화가 없다.
SELECT
    menu_code,
    category_code
FROM 
    tbl_menu
WHERE 
    menu_name = '파인애플탕';
    
UPDATE tbl_menu
SET
    category_code = 7
WHERE
    menu_code = 24;
    
-- SUBQUERY를 활용할 수도 있다.
-- 다만, MySQL은 Oracle과 달리 자기 자신 테이블의 데이터를 사용해 UPDATE 또는 DELETE 할 때 1093 에러가 발생한다.
/* Note. MySQL이 데이터 일관성을 유지하기 위해 동일한 테이블에 대한 동시 읽기/쓰기를 허용하지 않기 때문. */
UPDATE tbl_menu
SET
    category_code = 6
WHERE
    menu_code = (SELECT
		menu_code
	FROM 
		tbl_menu 
	WHERE 
		menu_name = '파인애플탕'
);    -- 1093 에러 발생 

-- 이 때 SUBQUERY를 하나 더 사용하여 임시테이블로 사용하게 하면 해결할 수 있다.
UPDATE tbl_menu
SET
    category_code = 6
WHERE
    menu_code = (SELECT
        tmp.menu_code
    FROM 
		(SELECT
            menu_code
        FROM 
            tbl_menu 
        WHERE 
            menu_name = '파인애플탕'
	) tmp
);

/* Note. 한 가지 방법이 더 있음 */
UPDATE tbl_menu AS a
JOIN (SELECT
			menu_code
		FROM
			tbl_menu
		WHERE
			menu_name = '파인애플탕'
	) AS b ON a.menu_code = b.menu_code
SET
	a.category_code = 6;

/* DELETE */
-- 테이블의 행을 삭제하는 구문이다.
-- 테이블의 행의 갯수가 줄어든다.

-- LIMIT을 활용한 행 삭제(offset 지정은 안됨)
/* Note. 메뉴 테이블을 가격순으로 오름차순 정렬했을 때 가장 낮은 가격을 가진 상위 2개의 레코드가 삭제됨. */
DELETE FROM tbl_menu
ORDER BY menu_price
LIMIT 2;

-- WHERE 절을 활용한 단일 행 삭제
DELETE
FROM 
    tbl_menu
WHERE
    menu_code = 24;
    
-- 테이블 전체 행 삭제
DELETE FROM tbl_menu;

/* REPLACE */
-- INSERT 시 PRIMARY KEY 또는 UNIQUE KEY가 중돌이 발생할 수 있다면
-- REPLACE를 통해 중복 된 데이터를 덮어 쓸 수 있다.

SELECT
	*
FROM
	tbl_menu
WHERE menu_code = 17;

-- INSERT INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y'); -- 에러 발생
REPLACE INTO tbl_menu VALUES (17, '참기름소주', 5000, 10, 'Y');

-- INTO는 생략 가능 하다.
REPLACE tbl_menu VALUES (17, '참기름소주', 5500, 10, 'Y');

SELECT * FROM tbl_menu;


    








