1 -- day 13 
2 
 
3 --------------------------------------------------- 
4 -- ����Ŭ�� Ư���� �÷� 2���� 
5 -- : ����ڰ� ���� �� ��� �ڵ����� �����Ǵ� �÷� 
6 
 
7 -- 1. ROWID : ���������� ��ũ�� ����� ��ġ�� ����Ű�� �� 
8 --            ������ ��ġ�̹Ƿ� �� ��� �ݵ�� ������ ���� �� �ۿ� ���� 
9 --            ORDER BY ���� ���� ������� �ʴ� �� 
10 
 
11 -- 2. ROWNUM : ��ȸ�� ����� ù��° ����� 1�� �����ϴ� �� 
12 --------------------------------------------------- 
13 
 
 -- ��) emp ���̺��� 'SMITH' �� ��ȸ 
 SELECT e.empno    
        , e.ename 
  FROM emp e 
  WHERE e.ename = 'SMITH'   
 ;   
 
 
 -- ROWID �� ���� ��ȸ 
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
33 -- ROWNUM �� ���� ��ȸ 
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
45 -- ORDER BY ���� ���� ROWNUM �� ����Ǵ� ��� Ȯ�� 
46 -- (1) ORDER BY �� ���� ���� ROWNUM 
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
 
69 -- (2) ename ������ �������� ���� �� ROWNUM �� Ȯ�� 
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
92 -- ==> ROWNUM �� ORDER BY ����� ������ ���� �ʴ� ��ó�� ���� �� ����. 
93 --     SUB-QUERY �� ����� �� ������ ����. 
94 
 
95 -- (3) SUB-QUERY �� ���� �� ROWNUM �� �� Ȯ�� 
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
 
123 -- �̸��� A �� ���� ������� ��ȸ (ORDER BY ����) 
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
 
139 -- �̸��� A�� ���� ����� �̸������� �����Ͽ� ��ȸ 
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
 
156 -- �̸��� S �� ���� ������� ��ȸ 
157 -- �̶�, ROWNUM, ROWID �� Ȯ�� 
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
171 -- �̸��� S�� ���� ������� ��ȸ ����� 
172 -- SUB-QUERY �� ������ ���� ROWNUM, ROWID Ȯ�� 
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
 
189 -- ROWNUM ���� �� �� �ִ� ���� 
190 -- emp ���� �޿��� ���� �޴� ���� 5���� ��ȸ�Ͻÿ�. 
191 
 
192 -- 1. �޿��� ���� ���� ���� 
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
 
216 -- 2. 1�� ����� SUB-QUERY �� FROM ���� ����ϰ� 
217 --    ���� �������� ROWNUM �� ���� ��ȸ 
218 SELECT ROWNUM 
219      , a.* 
220   FROM (SELECT e.empno 
221              , e.ename 
222              , e.sal 
223           FROM emp e 
224          ORDER BY e.sal DESC) a 
225 ; 
226 
 
227 -- 3. �� ��, ROWNUM <= 5 ������ �߰� 
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
247 -- DML : ������ ���۾�  
248 ---------------------------------------------- 
249 -- 1) INSERT : ���̺� ������ ��(row)�� �߰��ϴ� ��� 
250 
 
251 -- MEMBER ���̺� ������ �߰� ���� 
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
 
 
267 --- 1. INTO ������ �÷��̸� ������ ������ �߰� 
268 --     : VALUES ���� �ݵ�� ��ü �÷��� �����͸� ������� ��� ���� 
269 INSERT INTO MEMBER  
270 VALUES ('M001', '�ڼ���', '9155', sysdate, '������', '����', 3, 'M') 
271 ; 
272 INSERT INTO MEMBER  
273 VALUES ('M002', '������', '1418', sysdate, '������', NULL, NULL, 'M') 
274 ; 
275 /* 
276 INSERT INTO MEMBER  
277 VALUES ('M002', '������', '1418', sysdate, '������', 'M'); 
278 -- ��ó�� VALUES ���� ������ ���� ������ ��ü �÷� ���� ��ġ���� ������ 
279 -- �Ʒ��� ���� ������ �߻��ϹǷ�, NULL �Է��� �ؼ���  
280 -- ���� ������ ���߾�� �Ѵ�. 
281 
 
282 SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ� 
283 00947. 00000 -  "not enough values" 
284 */ 
285 INSERT INTO MEMBER  
286 VALUES ('M003', '�̺���', '0186', sysdate, NULL, NULL, 3, 'M') 
287 ; 
288 INSERT INTO MEMBER  
289 VALUES ('M004', '�蹮��', NULL, sysdate, 'û�ֽ�', '�Ͼ�', 3, 'F') 
290 ; 
291 INSERT INTO MEMBER  
292 VALUES ('M005', '����ȯ', '0322', sysdate, '�Ⱦ��', '����', 3, NULL) 
293 ; 
294 COMMIT; 
295 /* 
296 1 �� ��(��) ���ԵǾ����ϴ�. 
297 1 �� ��(��) ���ԵǾ����ϴ�. 
298 1 �� ��(��) ���ԵǾ����ϴ�. 
299 1 �� ��(��) ���ԵǾ����ϴ�. 
300 1 �� ��(��) ���ԵǾ����ϴ�. 
301 
 
302 Ŀ�� �Ϸ�. 
303 */ 
304 
 
305 -- PK �������ǿ� ����Ǵ� ������ �߰� �õ� : M005 �̹� ���� 
306 INSERT INTO MEMBER  
307 VALUES ('M005', 'ȫ�浿', '0001', sysdate, '������', '����', 3, 'M') 
308 ; 
309 -- ORA-00001: ���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ� 
310 
 
311 -- GENDER �÷��� CHECK ���������� �����ϴ� ������ �߰� �õ� 
312 -- GENDER �÷���, 'F', 'M', NULL ���� ���� �߰��ϸ�  
313 INSERT INTO MEMBER  
314 VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', 3, 'G') 
315 ; 
316 -- ORA-02290: üũ ��������(SCOTT.CK_GENDER)�� ����Ǿ����ϴ� 
317 
 
318 -- BIRTH_MONHT �÷��� 1 ~ 12 ���� ���ڰ� �Է� �õ� 
319 INSERT INTO MEMBER  
320 VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', -1, 'M') 
321 ; 
322 -- ORA-02290: üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ� 
323 
 
324 -- MEMBER_NAME �� NULL �Է� �õ� 
325 INSERT INTO MEMBER  
326 VALUES ('M006', NULL, '0001', sysdate, '������', '����', 5, 'M') 
327 ; 
328 -- ORA-01400: NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME")  
329 -- �ȿ� ������ �� �����ϴ� 
330 
 
INSERT INTO MEMBER  
VALUES ('M006', 'ȫ�浿', '0001', sysdate, '������', '����', 5, 'M') 
; 
COMMIT; 

--2. INTO ���� �÷� �̸��� ����� ����� ������ �߰�
--        : VALUES ���� INTO�� �������
--          ���� Ÿ��, ������ ���߾ �ۼ�
INSERT INTO MEMBER (member_id, member_name)
VALUES ('M007', '������')
;
COMMIT;
/*
1 �� ��(��) ���ԵǾ����ϴ�.
*/
INSERT INTO MEMBER (member_id, member_name, gender)
VALUES ('M008', '������', 'M')
;
-- ����) new_member ���̺� 
--       member ���̺�κ��� �����͸� �����Ͽ� ������ �Է��� �Ͻÿ�
--       ��, member ���̺��� �����Ϳ��� birth_month
--       Ȧ������ ����鸸 ��ȸ�Ͽ� �Է��Ͻÿ�.
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE mod(m.birth_ month)
 ;
 
 ------------------------
-- 2)UPDATE : ���̺��� �� (���ڵ�)�� ����
--            WHERE �������� ���տ� ����
--            
--            1�ุ �����ϰų� ���� �� ������ ����
--            ���� ���� �����Ǵ� ���� �ſ� ���ǰ��ʿ��ϴ�.

-- UPDATE ���� ����
UPDATE ���̺��̸�
   SET �÷�1 = ��1
    [, �÷�2 = ��2
    ....
    [, �÷�n = ��n]
[WHERE ����]
;

-- ��) ȫ�浿�� �̸��� �����õ�
UPDATE member m -- ���̺� ��Ī
   SET m.member_name = '�浿��'
 WHERE m.member_id = 'M006' -- PK�� ã�ƾ� ��Ȯ�� ã�ư� �� �ִ�.
;
COMMIT;

-- ��) �蹮�� ����� ��ȭ��ȣ ���ڸ� ������Ʈ
--     �ʱ⿡ INSERT �� NULL�� �����͸� ���� ���� ���
--     �Ŀ� ������ ������ �߻��� �� �ִ�.
--     �̷� ��� UPDATE �������� ó��.

UPDATE member m
   SET m.phone = '1392'
 WHERE m.member_id = 'M004'
;
COMMIT;
-- NULL�����Ϳ� ��ȭ��ȣ�� ���� �ȴ�.
 -- ��) ������ (M009) ����� ������ ����
 -- ������
 UPDATE member m
    SET m.major = '������'
    -- WHERE m.member_id = 'M009' -- �Ǽ��� WHERE ����
;
/*
9�� ���� �������� �Ǿ����ϴ�.
: WHERE ������ ���������� ��� �࿡ ���ؼ�
  major �÷��� ��� ������ �Ͼ ���
  
  ==> DML �۾� �Ǽ�,
      ���� �� : �׷��� UPDATE ���� ������ �ƴ϶�� ��.
 */
 -- COMMIT �۾����� �ǵ����� ROLLBACK �������
 -- �߸��� ������Ʈ
 ROLLBACK;
 -- �ѹ� �Ϸ�
 -- M004 ����� ��ȭ��ȣ�� ������Ʈ �� ���� ������ Ŀ���̹Ƿ�
 -- �� ������ �����ͷ� ����
 
 -- M009 ����� major ������Ʈ ����
  UPDATE member m
    SET m.major = '������'
    -- WHERE m.member_id = 'M009' -- �Ǽ��� WHERE ����
;
-- 1���� ������Ʈ �Ǿ����ϴ�.
COMMIT;

-- ���� �÷� ������Ʈ(2�� �̻��� �÷� �� ���� ������Ʈ)
-- ��) ������(M008) ����� ��ȭ��ȣ, �ּ�, ������ �� ���� ������Ʈ
-- SET ���� ������Ʈ �� �÷��� ���� ����
UPDATE member m
   SET m.phone = '4119'
     , m.address = '�ƻ��'
     , m.major = '�Ͼ�'
 WHERE m.member_id = 'M008'
;
COMMIT;

-- ��) '�Ⱦ��'�� ��� '����ȯ' ����� GENDER ���� ����
--     WHERE ���ǿ� �ּҸ� ���ϴ� ������ ���� ���
UPDATE member m
   SET m.gender = 'N'
 WHERE m.address = '�Ⱦ��'
-- where ������ ����(x), WHERE ������ ���� ����(x)
;
ROLLBACK;

-- ���� ���� ����� ���� �����۵��� ��ó�� ��������
-- �����Ͱ� �پ������� ���۵��� ������ �մ� �����̴�.
-- ���� UPDATE�ۼ� �ÿ��� WHERE ���� ���� ���Ǹ� ��￩�� �Ѵ�.
-- 1���� �����ϴ� �����̶�� �ݵ�� PK �÷��� ���ؾ� �Ѵ�.


--���ڵ� ����

-- UPADATE ������ SELECT 
--1 ) PHONE �÷��� NULL�� �������
--    �ϰ������� '0000'���� ������Ʈ �Ͻÿ�


--2 ) M001�� ���ؼ� ������ NULL ������ ������Ʈ �ϼ���

--3 ) ADDRESS �÷��� NULL �� ���

--4 ) M009 ����� NULL �����͸� ��� ������Ʈ
--    PHONE : 3581
--    ADDRESS : õ�Ƚ�
--    GENDER : M

 UPDATE member m 
    SET m.phone = '3581' 
      , m.address = 'õ�Ƚ�' 
      , m.gender = 'M' 
  WHERE m.member_id = 'M009' 
 ;  



