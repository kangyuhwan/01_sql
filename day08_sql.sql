-- 1. simple case �������� ����
-- : decode �� ���� ����, ���Ϻ񱳸� ����
--   decode �� �ٸ� �� : ��ȣ�� ����
--  �޸� ��� when, then, else ���� ���

SELECT e.empno
     , e.ename
     , e.job
     , CASE e.job WHEN 'CLERK' THEN e.sal * 0.05
                  WHEN 'SALESMAN' THEN e.sal * 0.05
                  WHEN 'MANAGER' THEN e.sal * 0.05
                  WHEN 'ANALYST' THEN e.sal * 0.05
                  WHEN 'PRESIDENT' THEN e.sal * 0.05
        END AS "������ ������"          
FROM emp e 
;
/*
EMPNO, ENAME, JOB, ������ ������
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
        END AS "������ ������"    
  FROM emp e
;

--CASE ����� ���� ��� ���� �����
-- : $ ��ȣ, ���� ���ڸ� ���� �б�, �Ҽ��� 3�ڸ� ����
SELECT e.empno
     , e.ename
     , e.job
     , to_char(CASE WHEN e.job = 'CLERK'    THEN e.sal * 0.05
                    WHEN e.job = 'SALESMAN' THEN e.sal * 0.04
                    WHEN e.job = 'MANAGER' THEN e.sal * 0.037
                    WHEN e.job = 'ANALYST' THEN e.sal * 0.03
                    WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015
                    ELSE 10
                END, '$9,999.99') AS "������ ������"    
  FROM emp e
;
/*
EMPNO,  ENAME,  JOB,          ������ ������
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

/* SALGRADE (�޿� ���) ���̺� ����
GRADE,  LOSAL,  HISAL
1   	700	    1200
2   	1201	1400
3	    1401	2000
4	    2001	3000
5	    3001	9999
*/
--���� : �����Ǵ� �޿� ����� ��������
--       �� ������ �޿� ����� CASE ������ ���غ���
--       ���, �̸�, �޿�, ������ ��ȸ�Ͻÿ�.

SELECT e.empno
     , e.ename
     , e.sal 
     , CASE WHEN e.sal IS NULL                  THEN 0
            WHEN e.sal BETWEEN  700   AND 1200  THEN 1
            WHEN e.sal BETWEEN  1201  AND 1400  THEN 2
            WHEN e.sal BETWEEN  1401  AND 2000  THEN 3
            WHEN e.sal BETWEEN  2001  AND 3000  THEN 4
            WHEN e.sal BETWEEN  3001  AND 9999  THEN 5
        END AS "�޿����"
  FROM emp e
  ORDER BY sal DESC
  
;
      