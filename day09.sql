-- 9. 년도별, 월별 입사 인원을 구하시오
-- hiredate
-- hiredate 에서 년도, 월을 추출
-- 추출된 두 값을 그룹화 기준으로 사용
-- 입사 인원을 구하라 하였으므로 count(*) 그룹함수 사용

-- a) 년도 추출 : TO_CHAR(e.hiredate, 'yyyy')
--  월 추출 : TO_CHAR(e.hiredate, 'mm')

-- b) 두 가지 기준으로 그룹화 적용
SELECT TO_CHAR(e.hiredate, 'YYYY') "입사 년도"
     , TO_CHAR(e.hiredate, 'MM')   "입사 월"
     , COUNT(*)                    "인원(명)"       
  FROM emp e
  GROUP BY TO_CHAR(e.hiredate, 'YYYY'), TO_CHAR(e.hiredate, 'MM')
  ORDER BY "입사 년도", "입사 월"
;

-- c) 년도별, 월별 입사 인원의 출력을 가로표 형태로변환
-- : 년도 추출 : TO_CHAR(e.hiredate, 'yyyy')
--  월 추출 : TO_CHAR(e.hiredate, 'mm')
-- : hiredate 에서 추출한 월의 값이 01이 나올 때
-- 그 때의 행의 갯수를 1월에서카운트(COUNT())
-- 이 과정을 12월까지 반복

--그룹화 기준 컬럼을 "입사 년도"로 잡는다.

SELECT TO_CHAR(e.hiredate, 'YYYY') "입사 년도"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "5월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "6월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "7월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "8월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '00', 1)) "9월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12월"
  FROM emp e
  GROUP BY TO_CHAR(e.hiredate, 'YYYY')
  ORDER BY "입사 년도"
;

-- 월별 총 입사 인원의 합을 가로로 출력하자.
-- 그룹화 기준 컬럼이 팔요 없다
SELECT '인원(명)' AS "입사 월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12월"
  FROM emp e
;


