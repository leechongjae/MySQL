/* INDEX */

CREATE TABLE phone (
    phone_code INT PRIMARY KEY,
    phone_name VARCHAR(100),
    phone_price DECIMAL(10, 2)
);

INSERT INTO phone (phone_code , phone_name , phone_price )
VALUES (1, 'galaxyS23', 1200000),
       (2, 'iPhone14pro', 1433000),
       (3, 'galaxyZfold3', 1730000);

SELECT * FROM phone;

-- 인덱스가 없는 컬럼을 WHERE절의 조건으로 활용한 조회 진행 시 EXPLAIN으로 쿼리 실행 계획 확인
-- 인덱스 설정 전의 조회 구문 실행 결과(실제로 쿼리에서 사용하는 인덱스를 나타내는 key 컬럼의 값이 null이다.)
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS23';
/* Note. 쿼리 실행 계획(Excecution Plan)
- id: 쿼리 실행 계획에서의 선택(select)의 순서나 번호를 나타냄.. 간단한 쿼리의 경우 보통 1로 표시함.
- select_type: 쿼리의 타입을 나타냄. SIMPLE은 복잡한 서브 쿼리나 UNION 등이 없는 단일 쿼리임을 의미.
- table: 쿼리에서 참조하고 있는 테이블의 이름을 나타냄.
- partitions: 쿼리가 참조하는 테이블의 파티션 정보를 나타냄.
- type: 조인 또는 조회의 타입을 나타냄. 여기서 ALL은 전체 테이블 스캔을 의미하며,
		이는 곧 쿼리가 인덱스를 사용하지 않고 테이블의 모든 행을 검사한다는 것을 의미.
- possible_keys: 쿼리 실행에 사용될 수 있는 인덱스를 나타냄.
                 여기서 NULL은 쿼리가 사용할 수 있는 인덱스가 없음을 의미.
- key: 실제로 쿼리 실행에 사용된 인덱스의 이름을 나타냄. 여기서 NULL은 인덱스가 사용되지 않음을 의미.
- key_len: 사용된 인덱스의 길이를 나타냄. 인덱스가 사용되지 않았기 때문에 NULL.
- ref: 인덱스와 함께 사용된 컬럼이나 상수를 나타냄. 인덱스가 사용되지 않았기 때문에 NULL.
- rows: 쿼리를 수행하기 위해 데이터베이스가 대략적으로 예상한 결과 행의 개수를 나타냄.
- filtered: 쿼리 조건을 만족시키는 행의 비율(%)을 나타냄.
            여기서 33.33%는 전체 행 중에서 약 33.33%의 행만이 쿼리의 조건을 만족시킬 것이라 예상한다는 것을 의미.
- Extra: 쿼리에 대한 추가 정보를 제공함.
		 여기서 Using where는 WHERE 조건절을 사용해 행을 필터링한다는 것을 의미.
*/

-- 인덱스 생성
CREATE INDEX idx_name
ON phone (phone_name);

-- 인덱스 확인
SHOW INDEX FROM phone;

-- 2개 이상의 컬럼을 한번에 하나의 인덱스로 설정해서 생성할 수 있다.
-- 복합 인덱스 생성
CREATE INDEX idx_name_price
ON phone (phone_name, phone_price);

SHOW INDEX FROM phone;

-- 인덱스를 사용한 쿼리
SELECT * FROM phone WHERE phone_name = 'iPhone14pro';

-- 실행 계획을 통해 인덱스를 사용하여 데이터를 빠르게 검색했는지 확인
EXPLAIN SELECT * FROM phone WHERE phone_name = 'iPhone14pro';

-- 인덱스 최적화(재구성)은 인덱스가 파편화되었거나, 데이터의 대부분이 변경된 경우에 유용하다.
-- 이는 인덱스의 성능을 개선하고, 디스크 공간을 더 효율적으로 사용하게 해준다.
-- 단, 인덱스를 재구성하는 동안 해당 테이블은 잠길 수 있으므로, 이 작업은 주의해서 수행해야 한다.
-- 'ALTER TABLE' 명령어를 사용해서 재구성한다.
ALTER TABLE phone DROP INDEX idx_name;
ALTER TABLE phone ADD INDEX idx_name(phone_name);

-- 또한, MySQL의 InnoDB 엔진을 사용하는 경우에는 OPTIMIZE TABLE 명령을 사용하여 테이블과 인덱스를 최적화할 수도 있다.
OPTIMIZE TABLE phone;

-- 인덱스 삭제
DROP INDEX idx_name ON phone;
SHOW INDEX FROM phone;
