-- 9. �⵵��, ���� �Ի� �ο��� ���Ͻÿ�
-- hiredate
-- hiredate ���� �⵵, ���� ����
-- ����� �� ���� �׷�ȭ �������� ���
-- �Ի� �ο��� ���϶� �Ͽ����Ƿ� count(*) �׷��Լ� ���

-- a) �⵵ ���� : TO_CHAR(e.hiredate, 'yyyy')
--  �� ���� : TO_CHAR(e.hiredate, 'mm')

-- b) �� ���� �������� �׷�ȭ ����
SELECT TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , TO_CHAR(e.hiredate, 'MM')   "�Ի� ��"
     , COUNT(*)                    "�ο�(��)"       
  FROM emp e
  GROUP BY TO_CHAR(e.hiredate, 'YYYY'), TO_CHAR(e.hiredate, 'MM')
  ORDER BY "�Ի� �⵵", "�Ի� ��"
;

-- c) �⵵��, ���� �Ի� �ο��� ����� ����ǥ ���·κ�ȯ
-- : �⵵ ���� : TO_CHAR(e.hiredate, 'yyyy')
--  �� ���� : TO_CHAR(e.hiredate, 'mm')
-- : hiredate ���� ������ ���� ���� 01�� ���� ��
-- �� ���� ���� ������ 1������ī��Ʈ(COUNT())
-- �� ������ 12������ �ݺ�

--�׷�ȭ ���� �÷��� "�Ի� �⵵"�� ��´�.

SELECT TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "5��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "6��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "7��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "8��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '00', 1)) "9��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e
  GROUP BY TO_CHAR(e.hiredate, 'YYYY')
  ORDER BY "�Ի� �⵵"
;

-- ���� �� �Ի� �ο��� ���� ���η� �������.
-- �׷�ȭ ���� �÷��� �ȿ� ����
SELECT '�ο�(��)' AS "�Ի� ��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05', 1)) "5��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06', 1)) "6��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07', 1)) "7��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08', 1)) "8��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09', 1)) "9��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e
;


