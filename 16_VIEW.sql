/* VIEW */
-- SELECT 쿼리문을 저장한 객체로 가상테이블이라고 불린다.
-- 실질적인 데이터를 물리적으로 저장하고 있지 않음
-- 테이블을 사용하는 것과 동일하게 사용할 수 있다.

SELECT * FROM tbl_menu;

-- VIEW 생성
CREATE VIEW hansik AS
SELECT menu_code, menu_name, menu_price, category_code, orderable_status
FROM tbl_menu 
WHERE category_code = 4;

-- 생성된 VIEW 조회
SELECT * FROM hansik;

-- 베이스 테이블의 정보가 변경되면 VIEW의 결과도 같이 변경된다.
INSERT INTO tbl_menu VALUES (null, '식혜맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;

-- VIEW를 통한 DML
-- 1) VIEW를 통한 INSERT(VIEW는 AUTO_INCREMENT가 없으므로 PK 컬럼의 값을 지정해 주어야 한다.)
-- INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT INTO hansik VALUES (99, '수정과맛국밥', 5500, 4, 'Y');
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- 2) VIEW를 통한 UPDATE
UPDATE hansik SET menu_name = '버터맛국밥', menu_price = 5700 WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- 3) VIEW를 통한 DELETE
DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- 사용된 SUBQUERY에 따라 DML 명령어로 조작이 불가능한 경우
-- 1) 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2) 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
-- 3) 산술 표현식이 정의된 경우
-- 4) JOIN을 이용해 여러 테이블을 연결한 경우
-- 5) DISTINCT를 포함한 경우
-- 6) 그룹함수나 GROUP BY 절을 포함한 경우

-- VIEW 삭제
DROP VIEW hansik;

-- VIEW에 쓰인 SUBQUERY 안에 연산 결과 컬럼도 사용 가능하다.
CREATE VIEW hansik AS
SELECT menu_name AS '메뉴명', TRUNCATE(menu_price / 1000, 1)  AS '가격(천원)', category_name AS '카테고리명'
FROM tbl_menu a
JOIN tbl_category b ON a.category_code = b.category_code
WHERE b.category_name = '한식';

SELECT * FROM hansik;

-- OR REPLACE 옵션
-- 테이블을 DROP하지 않고 기존의 VIEW를 새로운 VIEW로 쉽게 대체할 수 있다.
CREATE OR REPLACE VIEW hansik AS
SELECT menu_code AS '메뉴코드', menu_name '메뉴명', category_name '카테고리명'
FROM tbl_menu a
JOIN tbl_category b ON a.category_code = b.category_code
WHERE b.category_name = '한식';

SELECT * FROM hansik;