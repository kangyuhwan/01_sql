-- 1. simple case 구문으로 구현
-- : decode 와 거의 유사, 동일비교만 가능
--   decode 와 다른 점 : 괄호가 없음
--  콤마 대신 when, then, else 등을 사용

SELECT e.empno
     , e.ename
     , e.job
     , CASE e.job WHEN 'CLERK' THEN e.sal * 0.05
                  WHEN 'SALESMAN' THEN e.sal * 0.05
                  WHEN 'MANAGER' THEN e.sal * 0.05
                  WHEN 'ANALYST' THEN e.sal * 0.05
                  WHEN 'PRESIDENT' THEN e.sal * 0.05
        END AS "경조사 지원금"          
FROM emp e 
;
/*
EMPNO, ENAME, JOB, 경조사 지원금
7369	SMITH	CLERK	40
7499	ALLEN	SALESMAN	80
7521	WARD	SALESMAN	62.5
7566	JONES	MANAGER	148.75
7654	MARTIN	SALESMAN	62.5
7698	BLAKE	MANAGER	142.5
7782	CLARK	MANAGER	122.5
7839	KING	PRESIDENT	250
7844	TURNER	SALESMAN	75
7900	JAMES	CLERK	47.5
7902	FORD	ANALYST	150
7934	MILLER	CLERK	65
*/

SELECT e.empno
     , e.ename
     , e.job
     , CASE WHEN e.job = 'CLERK'    THEN e.sal * 0.05
            WHEN e.job = 'SALESMAN' THEN e.sal * 0.04
            WHEN e.job = 'MANAGER' THEN e.sal * 0.037
            WHEN e.job = 'ANALYST' THEN e.sal * 0.03
            WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
            ELSE 10
        END AS "경조사 지원금"    
  FROM emp e
;

--CASE 결과에 숫자 통와 패턴 씌우기
-- : $ 기호, 숫자 세자리 끊어 읽기, 소수점 3자리 쓰기
SELECT e.empno
     , e.ename
     , e.job
     , to_char(CASE WHEN e.job = 'CLERK'    THEN e.sal * 0.05
                    WHEN e.job = 'SALESMAN' THEN e.sal * 0.04
                    WHEN e.job = 'MANAGER' THEN e.sal * 0.037
                    WHEN e.job = 'ANALYST' THEN e.sal * 0.03
                    WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
                    ELSE 10
                END, '$9,999.99') AS "경조사 지원금"    
  FROM emp e
;
/*
EMPNO,  ENAME,  JOB,          경조사 지원금
7369	SMITH	CLERK	        $40.00
7499	ALLEN	SALESMAN	    $64.00
7521	WARD	SALESMAN	    $50.00
7566	JONES	MANAGER	       $110.08
7654	MARTIN	SALESMAN	    $50.00
7698	BLAKE	MANAGER	       $105.45
7782	CLARK	MANAGER	        $90.65
7839	KING	PRESIDENT	    $75.00
7844	TURNER	SALESMAN	    $60.00
7900	JAMES	CLERK	        $47.50
7902	FORD	ANALYST	        $90.00
7934	MILLER	CLERK	        $65.00
*/

/* SALGRADE (급여 등급) 테이블 내용
GRADE,  LOSAL,  HISAL
1   	700	    1200
2   	1201	1400
3	    1401	2000
4	    2001	3000
5	    3001	9999
*/
--문제 : 제공되는 급여 등급을 바탕으로
--       각 직원의 급여 등급을 CASE 문으로 구해보자
--       사번, 이름, 급여, 등여등급을 조회하시오.

SELECT e.empno
     , e.ename
     , e.sal 
     , CASE WHEN e.sal IS NULL                  THEN 0
            WHEN e.sal BETWEEN  700   AND 1200  THEN 1
            WHEN e.sal BETWEEN  1201  AND 1400  THEN 2
            WHEN e.sal BETWEEN  1401  AND 2000  THEN 3
            WHEN e.sal BETWEEN  2001  AND 3000  THEN 4
            WHEN e.sal BETWEEN  3001  AND 9999  THEN 5
        END AS "급여등급"
  FROM emp e
  ORDER BY sal DESC
  
;
      