/* DDL(Data Definition Language) */

/* Note. 스키마(schema)
데이터베이스에 저장되는 데이터 구조와 제약조건을 정의한 것.
*/

/* CREATE */
-- 테이블 생성을 위한 구문
-- IF NOT EXISTS를 적용하면 기존에 존재하는 테이블이라도 에러가 발생하지 않는다.

-- 테이블의 컬럼 설정
-- column_name data_type(length) [NOT NULL] [DEFAULT value] [AUTO_INCREMENT] column_constraint;

-- tb1 테이블 생성
CREATE TABLE IF NOT EXISTS tb1 (
    pk INT PRIMARY KEY,
    fk INT,
    col1 VARCHAR(255),
    CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 테이블 구조 확인
DESCRIBE tb1;

-- 방금 생성한 테이블에 INSERT 테스트
INSERT INTO tb1 VALUES (1, 10, 'Y');

SELECT * FROM tb1;

/* AUTO_INCREMENT */
-- INSERT 시 PRIMARY키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게)시켜 저장할 수 있다.

-- tb2 테이블 생성
CREATE TABLE IF NOT EXISTS tb2 (
    pk INT AUTO_INCREMENT PRIMARY KEY,
    fk INT,
    col1 VARCHAR(255),
    CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 테이블 구조 확인
DESCRIBE tb2;

INSERT INTO tb2 VALUES (null, 10, 'Y');
INSERT INTO tb2 VALUES (null, 20, 'Y');

SELECT * FROM tb2;

/* ALTER */
-- 테이블에 추가/변경/수정/삭제하는 모든 것은 ALTER 명령어를 사용해 적용한다.
-- 종류가 너무 많고 복잡하므로 대표적인 것만 살펴보도록 하자.

-- 열 추가
ALTER TABLE tb2
ADD col2 INT NOT NULL;

DESCRIBE tb2;

-- 열 삭제
ALTER TABLE tb2
DROP COLUMN col2;

DESCRIBE tb2;

-- 열 이름 및 데이터 형식 변경
ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;

DESCRIBE tb2;

-- 열 제약 조건 추가 및 삭제(이후 챕터에서 다룰 내용)
ALTER TABLE tb2
DROP PRIMARY KEY;    -- 에러 발생

-- AUTO_INCREMENT가 설정된 컬럼은 PRIMARY KEY를 제거할 수 없으므로 MODIFY 명령어로 AUTO_INCREMENT를 제거한다.
-- MODIFY는 컬럼의 정의를 바꾸는 것이다.
ALTER TABLE tb2
MODIFY pk INT;

DESCRIBE tb2;

-- 다시 PRIMARY KEY 제약조건 제거
ALTER TABLE tb2
DROP PRIMARY KEY; 

DESCRIBE tb2;

-- PRIMARY KEY 제약조건 추가
ALTER TABLE tb2
ADD PRIMARY KEY(pk);

DESCRIBE tb2;

-- 컬럼 여러개 추가하기
-- ALTER TABLE table_name
--     ADD new_column_name column_definition
--     [FIRST | AFTER column_name],
--     ADD new_column_name column_definition
--     [FIRST | AFTER column_name],
--     ...;
ALTER TABLE tb2
ADD col3 DATE NOT NULL,			
ADD col4 TINYINT NOT NULL;    -- 1292 에러 발생

-- DATE 형이 0으로 추가가 안 되는 것은 MySQL이 5.7버전 이후 SELECT @@GLOBAL.sql_mode 했을 때 나온 결과
-- ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
-- 에서 NO_ZERO_DATE 때문이고 0으로 채워진 DATE 컬럼이 존재하면 안되기 때문이다.
SELECT @@GLOBAL.sql_mode;

-- sql_mode를 통해 시스템 에 대해 비워주고 다시 껐다가 키면 DATE 컬럼 추가 구문이 작동된다.(root 계정으로 할 것)
set GLOBAL sql_mode = '';

-- WORKBENCH를 껐다 킨 후 다시 DATE형을 가진 컬럼들 추가
ALTER TABLE tb2
ADD col3 DATE NOT NULL,			
ADD col4 TINYINT NOT NULL;  

DESCRIBE tb2;

/* DROP */
-- 테이블을 삭제하기 위한 구문
-- IF EXISTS를 적용하면 존재하지 않는 테이블 삭제 구문이라도 에러가 발생하지 않는다.

-- DROP [TEMPORARY] TABLE [IF EXISTS] table_name [, table_name] ...
-- [RESTRICT | CASCADE]

-- tb3 테이블 생성
CREATE TABLE IF NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- tb3 테이블 삭제
DROP TABLE IF EXISTS tb3;

-- 한번에 여러개의 테이블 삭제
-- tb4 테이블 생성
CREATE TABLE IF NOT EXISTS tb4 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- tb5 테이블 생성
CREATE TABLE IF NOT EXISTS tb5 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 한번에 2개의 테이 삭제
DROP TABLE IF EXISTS tb4, tb5;

/* TRUNCATE */
-- TRUNCATE [TABLE] table_name;

-- 논리적으로는 WHERE절이 없는 DELETE 구문과 큰 차이가 없어 보인다.
-- 하지만 어차피 데이터를 다 삭제할 경우 행마다 하나씩 지워지는 DELETE보다
-- DROP이후 바로 테이블을 재생성 하주는 TRUNCATE가 훨씬 효율적으로 한번에 테이블을 초기화 시켜준다.
-- 또한 AUTO_INCREMENT 컬럼이 있는 경우 시작 값도 0으로 초기화가 된다.

-- tb6 테이블 생성
CREATE TABLE IF NOT EXISTS tb6 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 4개 행 데이터 INSERT
INSERT INTO tb6 VALUES (null, 10, 'Y');
INSERT INTO tb6 VALUES (null, 20, 'Y');
INSERT INTO tb6 VALUES (null, 30, 'Y');
INSERT INTO tb6 VALUES (null, 40, 'Y');

-- 제대로 INSERT 되었는지 확인
SELECT * FROM tb6;

-- 테이블 초기화 하기
-- TRUNCATE TABLE tb6;
TRUNCATE tb6;    -- TABLE 키워드 생략 가능

-- 제대로 지워 졌는지 확인
SELECT * FROM tb6;