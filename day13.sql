1 -- day 13 
2 
 
3 --------------------------------------------------- 
4 -- 오라클의 특별한 컬럼 2가지 
5 -- : 사용자가 만든 적 없어도 자동으로 제공되는 컬럼 
6 
 
7 -- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값 
8 --            물리적 위치이므로 한 행당 반드시 유일한 값일 수 밖에 없음 
9 --            ORDER BY 절에 의해 변경되지 않는 값 
10 
 
11 -- 2. ROWNUM : 조회된 결과의 첫번째 행부터 1로 증가하는 값 
12 --------------------------------------------------- 
13 
 
 -- 예) emp 테이블의 'SMITH' 를 조회 
 SELECT e.empno    
        , e.ename 
  FROM emp e 
  WHERE e.ename = 'SMITH'   
 ;   
 
 
 -- ROWID 를 같이 조회 
 SELECT e.rowid 
      , e.empno 
     , e.ename 
   FROM emp e 
  WHERE e.ename = 'SMITH'   
 ;   
28 /* 
29 ROWID,              EMPNO,   ENAME 
30 ------------------------------------ 
31 AAAR9dAAHAAAACuAAA	7369	 SMITH 
32 */ 
33 -- ROWNUM 을 같이 조회 
34 SELECT rownum 
35      , e.empno 
36      , e.ename 
37   FROM emp e 
38  WHERE e.ename = 'SMITH'   
39 ; 
40 --ROWNUM, EMPNO, ENAME 
41 ------------------------- 
42 --     1   7369	 SMITH 
43 
 
44 ---------------------------------------------- 
45 -- ORDER BY 절에 의해 ROWNUM 이 변경되는 결과 확인 
46 -- (1) ORDER BY 가 없을 때의 ROWNUM 
47 SELECT rownum 
48      , e.empno 
49      , e.ename 
50   FROM emp e 
51 ;   
52 /* 
53 1	7777	JJ 
54 2	8888	J_JAMES 
55 3	7369	SMITH 
56 4	7499	ALLEN 
57 5	7521	WARD 
58 6	7566	JONES 
59 7	7654	MARTIN 
60 8	7698	BLAKE 
61 9	7782	CLARK 
62 10	7839	KING 
63 11	7844	TURNER 
64 12	7900	JAMES 
65 13	7902	FORD 
66 14	7934	MILLER 
67 */ 
68 
 
69 -- (2) ename 순으로 오름차순 정렬 후 ROWNUM 값 확인 
70 SELECT rownum 
71      , e.empno 
72      , e.ename 
73   FROM emp e 
74  ORDER BY e.ename   
75 ;  
76 /* 
77 4	7499	ALLEN 
78 8	7698	BLAKE 
79 9	7782	CLARK 
80 13	7902	FORD 
81 12	7900	JAMES 
82 1	7777	JJ 
83 6	7566	JONES 
84 2	8888	J_JAMES 
85 10	7839	KING 
86 7	7654	MARTIN 
87 14	7934	MILLER 
88 3	7369	SMITH 
89 11	7844	TURNER 
90 5	7521	WARD 
91 */ 
92 -- ==> ROWNUM 이 ORDER BY 결과에 영향을 받지 않는 것처럼 보일 수 있음. 
93 --     SUB-QUERY 로 사용할 때 영향을 받음. 
94 
 
95 -- (3) SUB-QUERY 를 썼을 때 ROWNUM 의 값 확인 
96 SELECT rownum 
97      , a.empno 
98      , a.ename 
99      , a.numrow 
100   FROM (SELECT rownum as numrow 
101              , e.empno 
102              , e.ename 
103           FROM emp e 
104          ORDER BY e.ename) a 
105 ;          
106 /* 
107 1	7499	ALLEN	4 
108 2	7698	BLAKE	8 
109 3	7782	CLARK	9 
110 4	7902	FORD	13 
111 5	7900	JAMES	12 
112 6	7777	JJ	    1 
113 7	7566	JONES	6 
114 8	8888	J_JAMES	2 
115 9	7839	KING	10 
116 10	7654	MARTIN	7 
117 11	7934	MILLER	14 
118 12	7369	SMITH	3 
119 13	7844	TURNER	11 
120 14	7521	WARD	5 
121 */ 
122 
 
123 -- 이름에 A 가 들어가는 사람들을 조회 (ORDER BY 없이) 
124 SELECT ROWNUM 
125      , e.ename 
126   FROM emp e 
127  WHERE e.ename LIKE '%A%'   
128 ;   
129 /* 
130 1	J_JAMES 
131 2	ALLEN 
132 3	WARD 
133 4	MARTIN 
134 5	BLAKE 
135 6	CLARK 
136 7	JAMES 
137 */ 
138 
 
139 -- 이름에 A가 들어가는 사람을 이름순으로 정렬하여 조회 
140 SELECT ROWNUM 
141      , e.ename 
142   FROM emp e 
143  WHERE e.ename LIKE '%A%'   
144  ORDER BY e.ename 
145 ; 
146 /* 
147 2	ALLEN 
148 5	BLAKE 
149 6	CLARK 
150 7	JAMES 
151 1	J_JAMES 
152 4	MARTIN 
153 3	WARD 
154 */ 
155 
 
156 -- 이름에 S 가 들어가는 사람들을 조회 
157 -- 이때, ROWNUM, ROWID 를 확인 
158 SELECT ROWNUM 
159      , e.rowid 
160      , e.ename 
161   FROM emp e 
162  WHERE e.ename LIKE '%S%'   
163  ORDER BY e.ename 
164 ; 
165 /* 
166 4	AAAR9dAAHAAAACuAAJ	JAMES 
167 3	AAAR9dAAHAAAACuAAD	JONES 
168 1	AAAR9dAAHAAAACsAAC	J_JAMES 
169 2	AAAR9dAAHAAAACuAAA	SMITH 
170 */ 
171 -- 이름에 S가 들어가는 사람들의 조회 결과를 
172 -- SUB-QUERY 로 감쌌을 때의 ROWNUM, ROWID 확인 
173 SELECT ROWNUM 
174      , a.rowid 
175      , a.ename 
176   FROM (SELECT e.rowid 
177              , e.ename 
178           FROM emp e 
179          WHERE e.ename LIKE '%S%'   
180          ORDER BY e.ename) a 
181 ;          
182 /* 
183 1	AAAR9dAAHAAAACuAAJ	JAMES 
184 2	AAAR9dAAHAAAACuAAD	JONES 
185 3	AAAR9dAAHAAAACsAAC	J_JAMES 
186 4	AAAR9dAAHAAAACuAAA	SMITH 
187 */ 
188 
 
189 -- ROWNUM 으로 할 수 있는 쿼리 
190 -- emp 에서 급여를 많이 받는 상위 5명을 조회하시오. 
191 
 
192 -- 1. 급여가 많은 역순 정렬 
193 SELECT e.empno 
194      , e.ename 
195      , e.sal 
196   FROM emp e 
197  ORDER BY e.sal DESC   
198 ;   
199 /* 
200 7839	KING	5000 
201 7902	FORD	3000 
202 7566	JONES	2975 
203 7698	BLAKE	2850 
204 7782	CLARK	2450 
205 7499	ALLEN	1600 
206 7844	TURNER	1500 
207 7934	MILLER	1300 
208 7521	WARD	1250 
209 8888	J_JAMES	1250 
210 7654	MARTIN	1250 
211 7900	JAMES	950 
212 7777	JJ	    900 
213 7369	SMITH	800 
214 */ 
215 
 
216 -- 2. 1의 결과를 SUB-QUERY 로 FROM 절에 사용하고 
217 --    메인 쿼리에서 ROWNUM 을 같이 조회 
218 SELECT ROWNUM 
219      , a.* 
220   FROM (SELECT e.empno 
221              , e.ename 
222              , e.sal 
223           FROM emp e 
224          ORDER BY e.sal DESC) a 
225 ; 
226 
 
227 -- 3. 그 때, ROWNUM <= 5 조건을 추가 
228 SELECT ROWNUM 
229      , a.* 
230   FROM (SELECT e.empno 
231              , e.ename 
232              , e.sal 
233           FROM emp e 
234          ORDER BY e.sal DESC) a 
235  WHERE ROWNUM <= 5 
236 ; 
237 /* 
238 1	7839	KING	5000 
239 2	7902	FORD	3000 
240 3	7566	JONES	2975 
241 4	7698	BLAKE	2850 
242 5	7782	CLARK	2450 
243 */ 
244 
 
245 
 
246 ---------------------------------------------- 
247 -- DML : 데이터 조작어  
248 ---------------------------------------------- 
249 -- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령 
250 
 
251 -- MEMBER 테이블에 데이터 추가 진행 
 DROP TABLE member; 
 CREATE TABLE member 
 (  member_id    VARCHAR2(4)      
  , member_name  VARCHAR2(15)    NOT NULL 
  , phone        VARCHAR2(4)      
  , reg_date     DATE            DEFAULT sysdate 
  , address      VARCHAR2(30)  
  , major        VARCHAR2(50) 
  , birth_month  NUMBER(2) 
  , gender       VARCHAR2(1)      
  , CONSTRAINT PK_MEMBER PRIMARY KEY (member_id) 
  , CONSTRAINT CK_GENDER CHECK (gender IN ('F', 'M')) 
  , CONSTRAINT CK_BIRTH  CHECK (birth_month BETWEEN 1 AND 12) 
 )
 ; 
 
 
267 --- 1. INTO 구문에 컬럼이름 생략시 데이터 추가 
268 --     : VALUES 절에 반드시 전체 컬럼의 데이터를 순서대로 모두 나열 
269 INSERT INTO MEMBER  
270 VALUES ('M001', '박성협', '9155', sysdate, '수원시', '행정', 3, 'M') 
271 ; 
272 INSERT INTO MEMBER  
273 VALUES ('M002', '오진오', '1418', sysdate, '군포시', NULL, NULL, 'M') 
274 ; 
275 /* 
276 INSERT INTO MEMBER  
277 VALUES ('M002', '오진오', '1418', sysdate, '군포시', 'M'); 
278 -- 위처럼 VALUES 절에 나열된 값의 개수가 전체 컬럼 수와 일치하지 않으면 
279 -- 아래와 같은 오류가 발생하므로, NULL 입력을 해서라도  
280 -- 값의 개수를 맞추어야 한다. 
281 
 
282 SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다 
283 00947. 00000 -  "not enough values" 
284 */ 
285 INSERT INTO MEMBER  
286 VALUES ('M003', '이병현', '0186', sysdate, NULL, NULL, 3, 'M') 
287 ; 
288 INSERT INTO MEMBER  
289 VALUES ('M004', '김문정', NULL, sysdate, '청주시', '일어', 3, 'F') 
290 ; 
291 INSERT INTO MEMBER  
292 VALUES ('M005', '송지환', '0322', sysdate, '안양시', '제약', 3, NULL) 
293 ; 
294 COMMIT; 
295 /* 
296 1 행 이(가) 삽입되었습니다. 
297 1 행 이(가) 삽입되었습니다. 
298 1 행 이(가) 삽입되었습니다. 
299 1 행 이(가) 삽입되었습니다. 
300 1 행 이(가) 삽입되었습니다. 
301 
 
302 커밋 완료. 
303 */ 
304 
 
305 -- PK 제약조건에 위배되는 데이터 추가 시도 : M005 이미 존재 
306 INSERT INTO MEMBER  
307 VALUES ('M005', '홍길동', '0001', sysdate, '율도국', '도술', 3, 'M') 
308 ; 
309 -- ORA-00001: 무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다 
310 
 
311 -- GENDER 컬럼에 CHECK 제약조건을 위배하는 데이터 추가 시도 
312 -- GENDER 컬럼에, 'F', 'M', NULL 외의 값을 추가하면  
313 INSERT INTO MEMBER  
314 VALUES ('M006', '홍길동', '0001', sysdate, '율도국', '도술', 3, 'G') 
315 ; 
316 -- ORA-02290: 체크 제약조건(SCOTT.CK_GENDER)이 위배되었습니다 
317 
 
318 -- BIRTH_MONHT 컬럼에 1 ~ 12 외의 숫자값 입력 시도 
319 INSERT INTO MEMBER  
320 VALUES ('M006', '홍길동', '0001', sysdate, '율도국', '도술', -1, 'M') 
321 ; 
322 -- ORA-02290: 체크 제약조건(SCOTT.CK_BIRTH)이 위배되었습니다 
323 
 
324 -- MEMBER_NAME 에 NULL 입력 시도 
325 INSERT INTO MEMBER  
326 VALUES ('M006', NULL, '0001', sysdate, '율도국', '도술', 5, 'M') 
327 ; 
328 -- ORA-01400: NULL을 ("SCOTT"."MEMBER"."MEMBER_NAME")  
329 -- 안에 삽입할 수 없습니다 
330 
 
INSERT INTO MEMBER  
VALUES ('M006', '홍길동', '0001', sysdate, '율도국', '도술', 5, 'M') 
; 
COMMIT; 

--2. INTO 절에 컬럼 이름을 명시한 경우의 데이터 추가
--        : VALUES 절에 INTO의 순서대로
--          값의 타입, 갯수를 맞추어서 작성
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '김지원')
;
COMMIT;
/*
1 행 이(가) 삽입되었습니다.
*/
INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '김지우', 'M')
;
-- 문제) new_member 테이블에 
--       member 테이블로부터 데이터를 복사하여 다중행 입력을 하시오
--       단, member 테이블의 데이터에서 birth_month
--       홀수달인 사람들만 조회하여 입력하시오.
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE mod(m.birth_ month)
 ;
 
 ------------------------
-- 2)UPDATE : 테이블의 행 (레코드)을 수정
--            WHERE 조건절의 조합에 따라서
--            
--            1행만 수정하거나 다중 행 수정이 가능
--            다중 행이 수정되는 경우는 매우 주의가필요하다.

-- UPDATE 구문 구조
UPDATE 테이블이름
   SET 컬럼1 = 값1
    [, 컬럼2 = 값2
    ....
    [, 컬럼n = 값n]
[WHERE 조건]
;

-- 예) 홍길동의 이름을 수정시도
UPDATE member m -- 테이블 별칭
   SET m.member_name = '길동이'
 WHERE m.member_id = 'M006' -- PK로 찾아야 정확히 찾아갈 수 있다.
;
COMMIT;

-- 예) 김문정 멤버의 전화번호 뒷자리 업데이트
--     초기에 INSERT 시 NULL로 데이터를 받지 않은 경우
--     후에 데이터 수정이 발생할 수 있다.
--     이런 경우 UPDATE 구문으로 처리.

UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;
-- NULL데이터에 전화번호가 들어가게 된다.
 -- 예) 유현동 (M009) 멤버의 전공을 수정
 -- 역문컨
 UPDATE member m
    SET m.major = '역문컨'
    -- WHERE m.member_id = 'M009' -- 실수로 WHERE 누락
;
/*
9개 행이 업데이터 되었습니다.
: WHERE 조건절 누락때문에 모든 행에 대해서
  major 컬럼이 모두 수정이 일어난 결과
  
  ==> DML 작업 실수,
      주의 점 : 그러나 UPDATE 구문 오류는 아니라는 점.
 */
 -- COMMIT 작업까지 되돌리는 ROLLBACK 명령으로
 -- 잘못된 업데이트
 ROLLBACK;
 -- 롤백 완료
 -- M004 멤버의 전화번호를 업데이트 한 것이 마지막 커밋이므로
 -- 그 상태의 데이터로 복원
 
 -- M009 멤버의 major 업데이트 구문
  UPDATE member m
    SET m.major = '역문컨'
    -- WHERE m.member_id = 'M009' -- 실수로 WHERE 누락
;
-- 1행이 업데이트 되었습니다.
COMMIT;

-- 다중 컬럼 업데이트(2개 이상의 컬럼 한 번에 업데이트)
-- 예) 김지우(M008) 멤버의 전화번호, 주소, 전공을 한 번에 업데이트
-- SET 절에 업데이트 할 컬럼과 값을 나열
UPDATE member m
   SET m.phone = '4119'
     , m.address = '아산시'
     , m.major = '일어'
 WHERE m.member_id = 'M008'
;
COMMIT;

-- 예) '안양시'에 사는 '송지환' 멤버의 GENDER 값을 수정
--     WHERE 조건에 주소를 비교하는 구문을 쓰는 경우
UPDATE member m
   SET m.gender = 'N'
 WHERE m.address = '안양시'
-- where 조건절 누락(x), WHERE 조건절 문법 오류(x)
;
ROLLBACK;

-- 위의 실행 결과는 얼핏 정상작동한 것처럼 보이지만
-- 데이터가 다양해지면 오작동의 여지가 잇는 구문이다.
-- 따라서 UPDATE작성 시에는 WHERE 조건 절에 주의를 기울여야 한다.
-- 1행을 수정하는 목적이라면 반드시 PK 컬럼을 비교해야 한다.


--레코드 변경

-- UPADATE 구문에 SELECT 
--1 ) PHONE 컬럼이 NULL인 사람들은
--    일괄적으로 '0000'으로 업데이트 하시오


--2 ) M001에 대해서 전공을 NULL 값으로 업데이트 하세요

--3 ) ADDRESS 컬럼이 NULL 인 사람

--4 ) M009 멤버의 NULL 데이터를 모두 업데이트
--    PHONE : 3581
--    ADDRESS : 천안시
--    GENDER : M

 UPDATE member m 
    SET m.phone = '3581' 
      , m.address = '천안시' 
      , m.gender = 'M' 
  WHERE m.member_id = 'M009' 
 ;  



