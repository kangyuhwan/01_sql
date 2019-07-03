-- day14 : dml ���
-- WHERE
-- �ִ� ��� : ���ǿ� �´� �ุ ����
-- FROM Ű���� ���� ����

-- 3) DELETE : ���̺��� ������ε����͸� ����
-- DELETE ���� ����
DELETE [FROM] ���̺��̸� ���̺�Ī
 WHERE ����
;
--- 1. WHERE ������ �ִ� DELETE ����
-- ���� �� Ŀ��
COMMIT;

-- member ���̺��� gender�� 'F'�� �����͸� �����Ϸ��� ��
DELETE member m
 WHERE m.gender = 'R'  -- ��Ÿ�� R�� ���ߴٸ�
;
-- 0�� �� ��(��) �����Ǿ����ϴ�.
-- �� ����� ������ ������ ���⶧���� ��������� �ȴ�.
-- ������ ������ ���� 0���� ������
-- ����, gender �÷��� R ���� �ִ� ���� ���� ������
-- �������� ���� ����� �´�
-- ���ϴ� ����� �ƴϴ�.
DELETE member m
 WHERE m.gender = 'F'
;
-- 1���� ����
-- WHERE ������ �����ϴ� ��� �࿡ ���ؼ� ���� ����
-- gender �� 'F'�� ���� 1�� ���� ��
-- ������ Ư�� �� ������ PK�� �ƴ� �������� �����ϴ� ���� �����ؾ� ��

-- ���� ������ �ǵ���
ROLLBACK;

-- ���� 'M004' ���� �����ϴ� ���� �����̸� PK�� �����ؾ� ��
DELETE member m
 WHERE m.member_id ='M004'
 ;
-- 1���� ����
COMMIT;

-- 2. WHERE ������ ������ DELETE ����
--    WHERE ������ �ƿ� ������ ��� ��ü ���� ����
DELETE member;
-- 8���� ����
-- ROLLBACK �ϸ� �����Ͱ� �ǻ�Ƴ� . COMMIT�� �ϸ� ROLLBACK�� �ص� �ҿ� X

--- 3. DELETE �� WHERE �� �������� ����
--     �ּҰ� '�ƻ��'�� ����� ��� ����
DELETE member m
 WHERE m.address = '�ƻ��'
;


-- (1) �ּҰ� '�ƻ��'�� ����� ���̵� ��ȸ SELECT ���� ���
SELECT m.member_id
  FROM member m
 WHERE m.address = '�ƻ��' 
 
 -- (2) �����ϴ� �������� �ۼ�
 DELETE member m
  WHERE m.member_id = ? -- 'M003' 'M007' 'M008'
  ;
  
-- (3) 2���� ���� ������ 1���� �������� ����
DELETE member m
 WHERE m.member_id IN (SELECT m.member_id
                         FROM member m
                        WHERE m.address = '�ƻ��') -- ���������� ������ = �� �ƴ� IN�� �־�� �Ѵ�.
;
-- 3�� �� ��(��) �����Ǿ����ϴ�.
ROLLBACK;
-- �ѹ� �Ϸ�

-------------------------------
-- DELETE vs. TRUNCATE
/*
  1. TRUNCATE�� DDL�� ���ϴ� ��ɾ�
     ���� ROLLBACK ������ �������� ����
     �� �� ����� DDL�� �ǵ��� �� ����.
     
  2. TRUNCATE �� DDL�̱� ������
     WHERE ������ ������ �Ұ����ϹǷ�
     Ư�� �����͸� �����Ͽ� �����ϴ� ���� �Ұ���
     ���� �����Ͽ��� �Ѵ�.
*/
-- new_member�� TRUNCATE�� ���� �Ŀ� �ǵ��ư� COMMIT ���� ����
COMMIT;

-- new_member
TRUNCATE TABLE new_member;
-- Table NEW_MEMBER��(��) �߷Ƚ��ϴ�.

-- �ǵ����⸦ �õ�
ROLLBACK;
--�ѹ� �Ϸ�
--TRUNCATE ����� ����� ���ÿ� COMMIT�� �̷�����Ƿ�
--TRUNCATE ���� ������ �ѹ� ������ Ŀ���������� ����.


--------------------------------------------------------

-- TCL : Transaction Control Language
-- 1) COMMIT
-- 2) ROLLBACK
-- 3) SAVEPOINT
-- 1. member ���̺� 1���� �߰�
-- 1-1. INSERT ���� Ŀ������ ����
COMMIT;

--- 1-2. DML : INSERT �۾� ����
INSERT INTO member m (m.member_id, m.member_name)
VALUES ('M010', 'ȫ�浿')
;


-- 1-3. 1�� �߰����� �߰� ���� ����
SAVEPOINT do_insert;
-- Savepoint��(��) �����Ǿ����ϴ�.

--- 2. ȫ�浿�� �ּҸ� ������Ʈ
--- 2-1. DML : UPDATE �۾� ����
UPDATE member m
   SET m.address = '������'
 WHERE m.member_id = 'M010'
 ;
 
 
 -- 2-2. �ּ� �������� �߰� ����
 SAVEPOINT do_update_addr;
 
 -- 3. ȫ�浿�� ��ȭ��ȣ ������Ʈ
UPDATE member m
   SET m.phone = '9999'
 WHERE m.member_id = 'M010'
;
-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- 3-2. ��ȭ��ȣ �������� �߰� ����
SAVEPOINT do_update_phone;

-- 4. ȫ�浿�� ���� ������Ʈ
-- 4-1. DML UPDATE �۾� ����
UPDATE member m
   SET m.gender = 'F'
 WHERE m.member_id = 'M010'
;

-- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
-- 4-2. ���� ������Ʈ���� �߰�����
SAVEPOINT do_update_gender;
-- Savepoint��(��) �����Ǿ����ϴ�.

-- ������� �ϳ��� Ʈ��������� 4���� DML ���� ���� �ִ� ��Ȳ
-- ���� COMMIT ���� �ʾұ⿡ Ʈ������� �������ᰡ �ƴ� ��Ȳ
-- SAVEPOINT�� ROLLBACK�� ������� �ϳ��� �ڷ� ���� �ȴ�.

-------------------------------------------------------

-- ȫ�浿�� ������ROLLBACK �ó�����

-- 1. �ּ� ���������� ������, ��ȭ��ȣ, ������ �߸������ߴٰ� ����
--    ����� ������ �߸� ����
--    : �ǵ��ư� SAVEPOINT = do_update_addr
ROLLBACK TO do_update_addr; -- �ѹ� ���̺� ����Ʈ��  ��ġ�� �߸� ������
-- �ѹ� �Ϸ�.

-- 2. �ּ�, ��ȭ��ȣ ���������� �¾Ұ�, ���� ������ �߸��Ǿ���
ROLLBACK TO do_update_phone;
/*
ORA-01086: 'DO_UPDATE_PHONE' �������� �� ���ǿ� �������� �ʾҰų� �������մϴ�.
01086. 00000 -  "savepoint '%s' never established in this session or is invalid"
  SAVEPOINT ���� ������ �ִ�.
  do_update_addr �� do_update_phone ���� �ռ� ������ �����̱� ������
  ������� ROLLBACK TO �� �Ͼ��
  �� �� ������ SAVEPOINT �� ��� ���� ��
*/

-- 3. 2���� ROLLBACK TO ���� �Ŀ� �ǵ��� �� �ִ� ����
ROLLBACK TO do_insert; -- insert �� ����
ROLLBACK;              -- ���� ���� ����
SAVEPOINT do_insert;


-----------------------------------------------------------
-- ��Ÿ ��ü : SEQUENCE, INDEX, VIEW

-- SEQUENCE : �⺻ Ű(PK) ������ ���Ǵ� �Ϸù�ȣ ���� ��ü

-- 1. ���۹�ȣ : 1, �ִ� : 30, ����Ŭ�� ���� ������ ����

CREATE SEQUENCE seq_member_id
START WITH 1
MAXVALUE 30
NOCYCLE
;
-- Sequence SEQ_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- �������� ��ü�̱� ������ DDL�� ����
-- �������� �����Ǹ� �ý��� īŻ�α׿� ����ȴ�.
-- user_sequences
SELECT s.sequence_name
     , s.min_value
     , s.max_value
     , s.cycle_flag
     , s.increment_by
  FROM user_sequences s
 WHERE s.sequence_name = 'SEQ_MEMBER_ID'
;
/*
SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, CYCLE_FLAG, INCREMENT_BY
SEQ_MEMBER_ID       1	     30	             N	            1
*/

/* ------------------------------------------
   ��Ÿ �����͸� �����ϴ� ���� ��ųʸ�
   ------------------------------------------
   ���Ἲ �������� : user_constraints
   ������ �������� : user_sequences
   ���̺� �������� : user_tables
   �ε��� �������� : user_tables
   ��ü�� �������� : user_objects
   */
-- 2. ������ ���
--    : ������ �������� SELECT �������� ��밡��
-- (1) NEXTVAL : �������� ���� ��ȣ�� ��
--               CREATE �ǰ� ���� �ݵ�� ���� 1�� NEXTVAL
--               NEXTVAL ȣ���� �Ǿ�� ������ ����


--     ���� : ������ �̸�. NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual
;
-- MAXVALUE �̻� �����ϸ� �Ʒ��� ������ �߻��Ѵ�.
-- exceeds ����
/*
ORA-08004: ������ SEQ_MEMBER_ID.NEXTVAL exceeds MAXVALUE�� ��ʷ� �� �� �����ϴ�
08004. 00000 -  "sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated"
*/

-- (2) CURRVAL : ���������� ���� ������ ��ȣ�� Ȯ��
--               ������ ���� �� ���� 1���� NEXTVAL ȣ���� ������
--               ������ ��ȣ�� ���� �� ����
--               ��, �������� ���� ��Ȱ��ȭ ����

--      ���� : �������̸�.CURRVAL
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
-- 30

-- 3. ������ ���� : ALTER SEQUENCE
--    ������ SEQ_MEMBER_ID �� MAXVALUE ������ NOMAXVALUE �� ����
ALTER SEQUENCE SEQ_MEMBER_ID
NOMAXVALUE
;

-- SEQ_MEMBER_ID �� INCREAMENT �� 10���� �����Ϸ���
ALTER SEQUENCE SEQ_MEMBER_ID
INCREMENT BY 10
;
-- Sequence SEQ_MEMBER_ID��(��) ����Ǿ����ϴ�.
ALTER SEQUENCE SEQ_MEMBER_ID
CYCLE
;

-- 4. ������ ����
DROP SEQUENCE SEQ_MEMBER_ID;
-- Sequence SEQ_MEMBER_ID��(��) �����Ǿ����ϴ�.
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;
/*
ORA-02289: �������� �������� �ʽ��ϴ�.
02289. 00000 -  "sequence does not exist"
*/

----------------------------------------------

-- new_member ���̺� ������ �Է½� �������� Ȱ��
-- new_member�� id �÷��� ����� ������ �ű� ����
/*
    �������̸� :  seq_new_member_id
    ���۹�ȣ   : START WITH 1
    ���� ��    : INCREMENT BY 1
    �ִ��ȣ   : NOMAXVALUE
    ����Ŭ���� : NOCYCLE
*/
CREATE SEQUENCE seq_new_member_id
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
;
-- Sequence SEQ_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- new_member �� id_�� M001, M002 �����ϴ� ���·� ����
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL, 3, 0) AS member_id
  FROM dual
;
INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL, 3, 0)
        , 'ȫ�浿')
;
INSERT INTO new_member (member_id, member_name)
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL, 3, 0)
        , '���')
;
COMMIT;

-- INDEX : �������� �˻��� ������ �˻� �ӵ� ������ ����
--         DMBS �� �����ϴ� ��ü

-- 1. user_indexes ���̺��� �̹� �����ϴ� INDEX ��ȸ
SELECT i.index_name
     , i.index_type
     , i.table_name
     , i.include_column
  FROM user_indexes i
;
/*
INDEX_NAME, INDEX_TYPE, TABLE_NAME, INCLUDE_COLUMN
SYS_C007661	NORMAL	COUSTOMER	
PK_DEPT	NORMAL	DEPT	
PK_EMP	NORMAL	EMP	
SYS_C007666	NORMAL	MAIN_TABLE1	
SYS_C007667	NORMAL	MAIN_TABLE1	
PK_MAIN	NORMAL	MAIN_TABLE2	
UQ_NICKNAME	NORMAL	MAIN_TABLE2	
PK_MAIN3	NORMAL	MAIN_TABLE3	
UQ_NICKNAME3	NORMAL	MAIN_TABLE3	
PK_MEMBER	NORMAL	MEMBER	
PK_SUB3	NORMAL	SUB_TABLE3	
*/

--2. ���̺��� ��Ű �÷��� ���ؼ��� DBMS��
--   �ڵ����� �ε��� �������� �� �� ����
--   UNIQUE �� ���ؼ��� �ε����� �ڵ����� ������
--   �� �� �ε��� ������ �÷��� ���ؼ��� �ߺ� ���� �Ұ���

-- ��) MEMBER ���̺��� MEMBER_ID �÷��� ���� �ε��� ���� �õ�
CREATE INDEX idx_member
ON member (member_id)
; -- �ε��� ��������
/*
ORA-01408: �� ��Ͽ��� �̹� �ε����� �ۼ��Ǿ� �ֽ��ϴ�
01408. 00000 -  "such column list already indexed"
 ==> PK_MEMBER ��� �̸��� �ٸ� IDX_MEMBER_ID�� ���� �õ��ص�
     ���� �÷��� ���ؼ��� �ε����� �� �� �������� ����.
*/

-- 3. ���� ���̺� new_member ���� PK�� ���⶧���� �ε����� ���� ����
-- (1) new_member �� member_id �÷��� �ε��� ����
CREATE INDEX idx_new_member_id
ON new_member (member_id)
;
-- Index IDX_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�.

-- �ε��� ���� Ȯ�� �� DROP
DROP INDEX idx_new_member_id;

-- ����

-- DESC ���ķ� ����
CREATE INDEX idx_new_member_id
ON new_member (member_id DESC)
;

-- ����
DROP INDEX idx_new_member_id;

-- �ε��� ��� �÷��� ���� UNIQUE ���� Ȯ���ϴٸ�
-- UNIQUE INDEX�� ��������
CREATE UNIQUE INDEX idx_new_member_id
ON new_member ()
;
-- INDEX�� SELECT�� ���� ��
-- ���� �˻��� ���ؼ� ��������� SELECT�� ����ϴ� ��� ����
-- HINT ���� SELECT�� ����ϴ�.
