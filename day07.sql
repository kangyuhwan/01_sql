--day 07
---(4)
/*
���� �⺻���� Ÿ��
1. ���� : �ݵ�� ''(����ǥ)
2. ���� : ��� ����
3. ��¥ : ����, �⵵, ��, ��, ��, ��, ��
*/
--to_char() : ����Ÿ������ ��ȯ

--1 
SELECT to_char(12345, '9999')
  FROM dual
;

---3. to_number() : ����Ŭ�� �ڵ� ����ȯ�� ���ֹǷ�
SELECT DECODE('YES', 'YES', '�Է°��� YES �Դϴ�.'
                   , 'NO', '�Է°��� NO �Դϴ�.') AS �Է°��
FROM dual
;

SELECT e.empno
      ,e.ename
      ,e.job
      ,to_char(DECODE(e.job, 'CLERK'    , e.sal * 0.05
                           , 'SALESMAN' , e.sal * 0.04
                           , 'MANAGER'  , e.sal * 0.037
                           , 'ANALYST'  , e.sal * 0.03
                           , 'PRESIDENT', e.sal * 0.015), '$999.99') "������ ������"
  FROM emp e
;

SELECT e.empno "�����ȣ"
      ,e.ename "�̸�"
      ,e.sal   "�޿�"
      ,to_char(DECODE(e.job, 'CLERK'     , 300
                           , 'SALESMAN'  , 450  
                           , 'MANAGER'   , 600 
                           , 'ANALYST'   , 800 
                           , 'PRESIDENT' , 1000), '$9,999') "�ڱ� ��ߺ�"
  FROM emp e
;