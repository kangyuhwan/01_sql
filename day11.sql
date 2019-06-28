--DAY 11
--서브쿼리
-- SELECT, FROM, WHERE 절에 사용될 수 있다.
-- 문제) BLAKE 직무(job)가 동일한 직원의 정보를 조회
-- 1. BLAKE 의 직무를 조회(서브쿼리)
SELECT e.job
  FROM emp e
  WHERE e.ename = 'BLAKE'
; --1의 결과 

-- 2. 1의 결과를 적용
-- => 직무(job)가 MANAGER인 사람을 조회하여라.
SELECT  e.job
     ,  e.ename
  FROM  emp e
 WHERE  e.job = 'MANAGER'
;
--메인쿼리는 WHERE 절의 조건중
-- MANAGER 값 자리에 1의 쿼리가 통으로 들어간다
-- 서브쿼리와 메인쿼리가 합쳐진다. 'MANAGER' 안에 서브쿼리 값이 들어간다
-- 'MANAGER'는 문자열이기 때문에 '를 쓰지만 서브쿼리는 e.job이 문자타입이므로
-- '따옴표를 넣을 필요가 없다.
-- => 메인쿼리의 WHERE 절 () 괄호 안에 전달되는 값은
--    1번 쿼리의 결과인 MANAGER인 것이다.
SELECT  e.job
     ,  e.ename
  FROM  emp e
 WHERE  e.job = (SELECT e.job
                   FROM emp e
                  WHERE e.ename = 'BLAKE')
;

-- 서브쿼리 수업중 실습
-- 1. 이 회사의 평균 급여보다 급여를 많이 받는 직원을 모두 조히하여라.
--    사번, 이름, 급여를 조회

-- a) 회사의 급여 평균값을 구하는 쿼리
SELECT TO_CHAR(AVG(e.sal), '9999') "평균값"
  FROM emp e
;

-- b) 그 평균 값을 직접 적용하여 그 값보다 급여가 높은 직원을 구하는 쿼리
SELECT e.ename
  FROM emp e
 WHERE e.sal > (SELECT TO_CHAR(AVG(e.sal), '9999') "평균값"
                  FROM emp e)
;

-- c) b의 쿼리에서평균 값 자리에 (a) 의 쿼리를 대체
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > (SELECT TO_CHAR(AVG(e.sal), '9999') "평균값"
                  FROM emp e)
;


-- 2. 급여가 평균 급여보다 크면서 
--    사번이 7700번 보다 높은 직원을 조회하시오.
--    사번, 이름, 급여를 조회
SELECT TO_CHAR(AVG(e.sal), '9999') "평균급여"
  FROM emp e
;

SELECT e.ename
  FROM emp e
  WHERE e.empno > 7700
;

SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
  WHERE e.sal > (SELECT TO_CHAR(AVG(e.sal), '9999') "평균급여"
                   FROM emp e)
    AND e.empno > 7700           
;
-- 3. 각 직무별로 최대 급여를 받는 직원 목록을 조회하여라.
--    사번, 이름, 직무, 급여를 조회

-- a) 직무별로 최대 급여를 구하는 쿼리 : GRUOP 함수(MAX, 그룹화기준컬럼(job)
SELECT e.job
      , MAX(e.sal) max_sal
  FROM emp e
 GROUP BY e.job
; 

-- b) a 에서 구해진 최대 급여와 job이 일치하는지 적용하는 쿼리
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
  FROM emp e
 WHERE (e.job = 'CLERK' AND e.sal = 1300) 
    OR (e.job = 'SALESMAN' AND e.sal = 1300) 
    OR (e.job = 'ANALYST' AND e.sal = 3000) 
    OR (e.job = 'MANAGER' AND e.sal = 2975) 
    OR (e.job = 'PRESIDENT' AND e.sal = 5000) 
; 

-- c) b에서 사용된 값을 a의 쿼리로 대체하기
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
  FROM emp e
 WHERE (e.job, e,sal) IN (SELECT e.job
                      , MAX(e.sal) max_sal
                   FROM emp e
                  GROUP BY e.job)
;
--===> 비교하는 값의 컬럼 갯수가 일치하지 않을 때
--   오류문구가 나옴

-- 4. 각 월별 입사인원을 세로로 출력하시오.
--    출력 형태 : 1월 ~ 12월까지 정렬하여 출력
--    "입사월", "인원(명)"
--    1월  3
--    2월  2
--    ...
--    12월 2

--TO_NUMBER는 숫자를 정렬해 줌
SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "입사월" 
     , COUNT(*) "인원(명)" 
 FROM emp e 
GROUP BY TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) 
ORDER BY "입사월" 
; 

--숫자값을 '월'자를 붙여나오게 하는 방법
-- 위의 결과가 FROM절에 통으로 들어간 후 '월'을 붙여야 함
-- 앨리어스? 를 준 다음에 별칭을 준다.
SELECT a.month || '월' "입사월"
     , a.cnt       "인원(명)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month
             , COUNT(*) cnt 
          FROM emp e 
         GROUP BY TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) 
         ORDER BY month ) a
;
