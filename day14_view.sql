-- day 14 view 계속
-----------------------------------

-- VIEW : 논리적으로만 존재하는 가상 테이블
-- SCOTT에 뷰 생성 권한 주기
-- 1. SYS 접속
CONN sys as sysdba;

-- 2. SCOTT 계정에 VIEW 생성 권한 설정 
-- 접속 탭
-- sys -> scott 우클릭 사용자 편집 -> 시스템 권한 탭 -> create view 권한이 부여됨 체크-> 성공
GRANT CREATE VIEW TO SCOTT;
-- Grant을(를) 성공했습니다.

-- 3. SCOTT으로 접속 변경
CONN SCOTT/TIGER;


--------------------------------------------

-- 1. emp, dept 테이블 복사
DROP TABLE new_emp;

CREATE TABLE new_emp

AS
SELECT e.*
  FROM emp e
 WHERE 1 = 1
;
DROP TABLE new_dept;

CREATE TABLE new_dept
AS
SELECT d.*
  FROM dept d
 WHERE 1 =1
;

-- 2. 복사 테이블에는 PK 설정이 누락되어 있으므로 PK 설정을 ALTER로 추가
/*
    new_dept : PK_NEW_DEPT, deptno 컬럼을 PRIMARY KEY로 설정 
    
    new_emp : PK_NEW_EMP   , empno 컬럼을 PRIMARY KEY로 설정
              FK_NEW_DEPTNO, deptno 컬럼을 FOREIGN KEY 로 설정
                             new_dept 테이블의 deptno 컬럼을 REFERENCES 하도록 설정
              FK_MGR       , mgr 컬럼을 FOREIGN KEY로 설정
                 new_emp 테이블의 empno 컬럼을 REFERENCES 하도록 설정
*/

-- 3. 복사 테이블을 기본 테이블로 하는 VIEWF 를 생성
--     : 직원의 기본 정보 + 상사의 이름 + 부서이름 + 부서위치 까지 조회가능한 뷰
CREATE OR REPLACE VIEW v_emp_dept
AS
SELECT e.empno
     , e.ename
     , e1.ename as mgr_name
     , e.deptno
     , d.dname
     , d.loc
  FROM new_emp e
     , new_dept d
     , new_emp e1
 WHERE e.deptno = d.deptno(+)
   AND e.mgr = e1.empno
WITH READ ONLY
;

-- 조인이 걸린 결과를 일반 테이블에 조히하듯 뷰를 통해 조회가능
SELECT v.*
  FROM v_emp_dept v
;
/*
EMPNO, ENAME, MGR_NAME, DEPTNO, DNAME, LOC
7902	FORD	JONES	20	RESEARCH	DALLAS
7499	ALLEN	BLAKE	30	SALES	CHICAGO
7521	WARD	BLAKE	30	SALES	CHICAGO
7654	MARTIN	BLAKE	30	SALES	CHICAGO
7844	TURNER	BLAKE	30	SALES	CHICAGO
7900	JAMES	BLAKE	30	SALES	CHICAGO
8888	J_JAMES	BLAKE			
7934	MILLER	CLARK	10	ACCOUNTING	NEW YORK
7782	CLARK	KING	10	ACCOUNTING	NEW YORK
7566	JONES	KING	20	RESEARCH	DALLAS
7698	BLAKE	KING	30	SALES	CHICAGO
7369	SMITH	FORD	20	RESEARCH	DALLAS
7777	JJ	FORD			
*/

SELECT v.empno
     , v.ename
     , v.dname
     , v.loc
  FROM v_emp_dept v
;
/*
EMPNO, ENAME, DNAME, LOC
7900	JAMES	SALES	CHICAGO
8888	J_JAMES		
7934	MILLER	ACCOUNTING	NEW YORK
7782	CLARK	ACCOUNTING	NEW YORK
7566	JONES	RESEARCH	DALLAS
7698	BLAKE	SALES	CHICAGO
*/

SELECT v.view_name
     , v.read_only
  FROM user_views v
;
/*
VIEW_NAME, READ_ONLY
V_EMP_DEPT	Y
*/


-- 5. 생성된 뷰에서 DQL 조회
-- 1) 부서명이 SALES인 부서 소속 직원을 조회하거나
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname = 'SALES'
 ;
 /*
 EMPNO, ENAME, MGR_NAME, DEPTNO, DNAME, LOC
 7499	ALLEN	BLAKE	30	SALES	CHICAGO
7521	WARD	BLAKE	30	SALES	CHICAGO
7654	MARTIN	BLAKE	30	SALES	CHICAGO
7698	BLAKE	KING	30	SALES	CHICAGO
7844	TURNER	BLAKE	30	SALES	CHICAGO
 */
 

--- 2) 부서명이 NULL인 직원을 조회
SELECT v.*
  FROM v_emp_dept v
 WHERE v.dname IS NULL
;
/*
EMPNO, ENAME, MGR_NAME, DEPTNO, DNAME, LOC
8888	J_JAMES	BLAKE			
7777	JJ	FORD			
*/

-- 3) 상사(매니저,mgr)가 NULL인 직원을 조회
SELECT v.*
  FROM v_emp_dept v
 WHERE v.mgr IS NULL
;
