--day 07
---(4)
/*
가장 기본적인 타입
1. 문자 : 반드시 ''(따옴표)
2. 숫자 : 산술 연산
3. 날짜 : 세기, 년도, 달, 일, 시, 분, 초
*/
--to_char() : 문자타입으로 변환

--1 
SELECT to_char(12345, '9999')
  FROM dual
;

---3. to_number() : 오라클이 자동 형변환을 해주므로
SELECT DECODE('YES', 'YES', '입력값이 YES 입니다.'
                   , 'NO', '입력값이 NO 입니다.') AS 입력결과
FROM dual
;

SELECT e.empno
      ,e.ename
      ,e.job
      ,to_char(DECODE(e.job, 'CLERK'    , e.sal * 0.05
                           , 'SALESMAN' , e.sal * 0.04
                           , 'MANAGER'  , e.sal * 0.037
                           , 'ANALYST'  , e.sal * 0.03
                           , 'PRESIDENT', e.sal * 0.015), '$999.99') "경조사 지원금"
  FROM emp e
;

SELECT e.empno "사원번호"
      ,e.ename "이름"
      ,e.sal   "급여"
      ,to_char(DECODE(e.job, 'CLERK'     , 300
                           , 'SALESMAN'  , 450  
                           , 'MANAGER'   , 600 
                           , 'ANALYST'   , 800 
                           , 'PRESIDENT' , 1000), '$9,999') "자기 계발비"
  FROM emp e
;