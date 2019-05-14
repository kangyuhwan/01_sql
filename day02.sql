-- Alias : ��Ī
-- 11) emp ���̺���
--     empno => Employee No.
--     ename => Employee Name
--     job   => Job Name
--     �� �÷��� �̸��� ��Ī���ιٲپ ��ȸ\

SELECT empno AS "Emplyyee No."
      ,ename "Employee Name" -- AS Ű����� ��������
      ,job   "Job Name"      -- AS Ű����� ��������
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

-- 12)�ѱ� ��Ī�� ���
--    emp ���̺��� �� �÷��� �ѱ� ��Ī�� ���
--    empno => ���
--    ename => �� �� (������ ����)
--    job   => ����
SELECT empno ���
      ,ename "�� ��"
      ,job   AS ����
    FROM emp
;

-- 13) ���̺� ��Ī ����
--     emp ���̺��� empno, ename�� ��ȸ�Ͻÿ�
--1.  ��Ī ���� ���� �ۼ�
SELECT empno
      ,ename
    FROM emp
;
--2. SELECTJFDP �÷� ������ ��, �տ� �����̺� �̸��� ���� �� �ִ�.
--   ���̺� �̸��� �ٿ��� �÷��� ��ȸ
SELECT emp.empno
      ,emp.ename
    FROM emp
;

--3. FROM ���� emp ���̺� e ��� ��Ī�� �ְ�
--   SELECT ���� �÷��տ� ���̺� ��Ī e�� �ٿ��� ��ȸ
SELECT e.empno -- ���̺� ��Ī�� ���Ǵ� ��ġ : �÷� �̸� ��
      ,e.ename 
    FROM emp e -- ���̺� ��Ī ��� ��ġ
;

--14) ���� ��Ī�� ����� ��, �ֵ���ǥ�� ������� ������
-- => ��� ��½� ��Ī�� ��� �빮��ȭ �Ǿ� ��ȸ��.
-- emp ���̺���
-- empno => EmployeeNo
-- ename => "Employee Name"
-- job => "Job Name"
SELECT e.empno AS EmployeeNo
      ,e.ename "Employee Name"
      ,e.job "Job Name"
 FROM emp e
;

/*
EMPLOYEENO, Employee, Name Job Name �ֵ���ǥ�� �� ���� �빮�ڷθ� ����� �ȴ�.
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

--15) ��Ī�� ������ ���� : �÷��� ��Ī�� �� ���
--    �÷��� ��Ī�� �� ���  ORDER BY ���� ��Ī�� ��� �� �� �ִ�.
--   emp ���̺� e ��Ī�� �ְ� emp ���̺���
--   empno => ���
--   ename => �̸�
--   job   => ����
--   hiredate => �Ի���
--   comm => ����
--   ���� ���� �� �÷��� ��Ī�� �־� ��ȸ�ϰ�
--   ����, ����, ename �� ��� �������� ������ ����
SELECT e.empno ���
      ,e.ename �̸�
      ,e.job   ����
      ,e.hiredate �Ի���
      ,e.comm ����
    FROM emp e
    ORDER BY ����, ����, e.ename
;
-- 10������ �����ϳ� ��Ī�� ����� �κи� ���̰���
--  => ��� : ORDER BY ������ ��Ī�� ���� �÷����� ���� �� �� �ִ�.
/*����, ����, e.name���� ���������� ���ĵ�
��� �̸�  ����  �Ի���  ����
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

