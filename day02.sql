-- Alias : 별칭
-- 11) emp 테이블에서
--     empno => Employee No.
--     ename => Employee Name
--     job   => Job Name
--     세 컬럼의 이름을 별칭으로바꾸어서 조회\

SELECT empno AS "Emplyyee No."
      ,ename "Employee Name" -- AS 키워드는 생략가능
      ,job   "Job Name"      -- AS 키워드는 생략가능
  FROM emp
;
/*
Emplyyee No. Employee Name Job Name
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
*/

-- 12)한글 별칭을 사용
--    emp 테이블에서 각 컬럼에 한글 별칭을 사용
--    empno => 사번
--    ename => 이 름 (공백이 존재)
--    job   => 직무
SELECT empno 사번
      ,ename "이 름"
      ,job   AS 직무
    FROM emp
;

-- 13) 테이블에 별칭 설정
--     emp 테이블에서 empno, ename을 조회하시오
--1.  별칭 없이 구문 작성
SELECT empno
      ,ename
    FROM emp
;
--2. SELECTJFDP 컬럼 나열할 때, 앞에 ㄴ테이블 이름을 붙일 수 있다.
--   테이블 이름을 붙여서 컬럼을 조회
SELECT emp.empno
      ,emp.ename
    FROM emp
;

--3. FROM 절의 emp 테이블에 e 라는 별칭을 주고
--   SELECT 절의 컬럼앞에 테이블 별칭 e를 붙여서 조회
SELECT e.empno -- 테이블 별칭이 사용되는 위치 : 컬럼 이름 앞
      ,e.ename 
    FROM emp e -- 테이블 별칭 사용 위치
;

--14) 영문 별칭을 사용할 때, 쌍따옴표를 사용하지 않으면
-- => 결과 출력시 별칭이 모두 대문자화 되어 조회됨.
-- emp 테이블에서
-- empno => EmployeeNo
-- ename => "Employee Name"
-- job => "Job Name"
SELECT e.empno AS EmployeeNo
      ,e.ename "Employee Name"
      ,e.job "Job Name"
 FROM emp e
;

/*
EMPLOYEENO, Employee, Name Job Name 쌍따옴표를 안 쓰면 대문자로만 출력이 된다.
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK*/

--15) 별칭과 정렬의 조합 : 컬럼에 별칭을 준 경우
--    컬럼에 별칭을 준 경우  ORDER BY 절에 별칭을 사용 할 수 있다.
--   emp 테이블에 e 별칭을 주고 emp 테이블에서
--   empno => 사번
--   ename => 이름
--   job   => 직무
--   hiredate => 입사일
--   comm => 수당
--   위와 같이 각 컬럼에 별칭을 주어 조회하고
--   수당, 직무, ename 를 모두 오름차순 정렬해 보기
SELECT e.empno 사번
      ,e.ename 이름
      ,e.job   직무
      ,e.hiredate 입사일
      ,e.comm 수당
    FROM emp e
    ORDER BY 수당, 직무, e.ename
;
-- 10예제와 동일하나 별칭을 사용한 부분만 차이가남
--  => 결과 : ORDER BY 절에는 별칭과 원래 컬럼명을 섞어 쓸 수 있다.
/*수당, 직무, e.name으로 오름차순이 정렬됨
사번 이름  직무  입사일  수당
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	81/12/03	
7900	JAMES	CLERK	81/12/03	
7934	MILLER	CLERK	82/01/23	
7369	SMITH	CLERK	80/12/17	
7698	BLAKE	MANAGER	81/05/01	
7782	CLARK	MANAGER	81/06/09	
7566	JONES	MANAGER	81/04/02	
7839	KING	PRESIDENT	81/11/17	*/

