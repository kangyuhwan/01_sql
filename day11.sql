--DAY 11
--��������
-- SELECT, FROM, WHERE ���� ���� �� �ִ�.
-- ����) BLAKE ����(job)�� ������ ������ ������ ��ȸ
-- 1. BLAKE �� ������ ��ȸ(��������)
SELECT e.job
  FROM emp e
  WHERE e.ename = 'BLAKE'
; --1�� ��� 

-- 2. 1�� ����� ����
-- => ����(job)�� MANAGER�� ����� ��ȸ�Ͽ���.
SELECT  e.job
     ,  e.ename
  FROM  emp e
 WHERE  e.job = 'MANAGER'
;
--���������� WHERE ���� ������
-- MANAGER �� �ڸ��� 1�� ������ ������ ����
-- ���������� ���������� ��������. 'MANAGER' �ȿ� �������� ���� ����
-- 'MANAGER'�� ���ڿ��̱� ������ '�� ������ ���������� e.job�� ����Ÿ���̹Ƿ�
-- '����ǥ�� ���� �ʿ䰡 ����.
-- => ���������� WHERE �� () ��ȣ �ȿ� ���޵Ǵ� ����
--    1�� ������ ����� MANAGER�� ���̴�.
SELECT  e.job
     ,  e.ename
  FROM  emp e
 WHERE  e.job = (SELECT e.job
                   FROM emp e
                  WHERE e.ename = 'BLAKE')
;

-- �������� ������ �ǽ�
-- 1. �� ȸ���� ��� �޿����� �޿��� ���� �޴� ������ ��� �����Ͽ���.
--    ���, �̸�, �޿��� ��ȸ

-- a) ȸ���� �޿� ��հ��� ���ϴ� ����
SELECT TO_CHAR(AVG(e.sal), '9999') "��հ�"
  FROM emp e
;

-- b) �� ��� ���� ���� �����Ͽ� �� ������ �޿��� ���� ������ ���ϴ� ����
SELECT e.ename
  FROM emp e
 WHERE e.sal > (SELECT TO_CHAR(AVG(e.sal), '9999') "��հ�"
                  FROM emp e)
;

-- c) b�� ����������� �� �ڸ��� (a) �� ������ ��ü
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > (SELECT TO_CHAR(AVG(e.sal), '9999') "��հ�"
                  FROM emp e)
;


-- 2. �޿��� ��� �޿����� ũ�鼭 
--    ����� 7700�� ���� ���� ������ ��ȸ�Ͻÿ�.
--    ���, �̸�, �޿��� ��ȸ
SELECT TO_CHAR(AVG(e.sal), '9999') "��ձ޿�"
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
  WHERE e.sal > (SELECT TO_CHAR(AVG(e.sal), '9999') "��ձ޿�"
                   FROM emp e)
    AND e.empno > 7700           
;
-- 3. �� �������� �ִ� �޿��� �޴� ���� ����� ��ȸ�Ͽ���.
--    ���, �̸�, ����, �޿��� ��ȸ

-- a) �������� �ִ� �޿��� ���ϴ� ���� : GRUOP �Լ�(MAX, �׷�ȭ�����÷�(job)
SELECT e.job
      , MAX(e.sal) max_sal
  FROM emp e
 GROUP BY e.job
; 

-- b) a ���� ������ �ִ� �޿��� job�� ��ġ�ϴ��� �����ϴ� ����
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

-- c) b���� ���� ���� a�� ������ ��ü�ϱ�
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
--===> ���ϴ� ���� �÷� ������ ��ġ���� ���� ��
--   ���������� ����

-- 4. �� ���� �Ի��ο��� ���η� ����Ͻÿ�.
--    ��� ���� : 1�� ~ 12������ �����Ͽ� ���
--    "�Ի��", "�ο�(��)"
--    1��  3
--    2��  2
--    ...
--    12�� 2

--TO_NUMBER�� ���ڸ� ������ ��
SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "�Ի��" 
     , COUNT(*) "�ο�(��)" 
 FROM emp e 
GROUP BY TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) 
ORDER BY "�Ի��" 
; 

--���ڰ��� '��'�ڸ� �ٿ������� �ϴ� ���
-- ���� ����� FROM���� ������ �� �� '��'�� �ٿ��� ��
-- �ٸ��? �� �� ������ ��Ī�� �ش�.
SELECT a.month || '��' "�Ի��"
     , a.cnt       "�ο�(��)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month
             , COUNT(*) cnt 
          FROM emp e 
         GROUP BY TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) 
         ORDER BY month ) a
;
