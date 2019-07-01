-- ������ ���Ǿ�

-- 1. ���̺��� ����� ��ɾ� => ���̺��� DBMS�� OBJECT�� �ϳ�
-- 2. DMBS�� OBJECT(��ü)�� ����/�ν� �ϴ� ����� 
--    ����, ����, �����ϴ� ��ɾ�
-- ���� : CREATE
-- ���� : ALTER
-- ���� : DROP

-- vs. DML (Data Manipulation Language) ������ ���۾�
-- ���� : INSERT
-- ����:  UPDATE
-- ���� : DELETE

/* DDL������ ����

   CREATE | ALTER | DROP {������ ��ü Ÿ�Ը�}
   
   DBMS�� OBJECT(��ü)�� ����
   SCHEMA, DOMAIN, TABLE, VIEW, INDEX, SEQUENCE, USER, DATABASE
   
*/
-- CREATE TABLE ���� ����
CREATE TABLE ���̺��̸�
( �÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]
 [,�÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
 ....
 [,�÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
);

/* ---------------
-- �÷��� ���� ����, �÷��� ���� ���׿� ���� ����
-----------------

 1.PRIMARY KEY(PK) : �� �÷��� �ԷµǴ� ���� �ߺ����� �ʰ�
                 �� ���� �ĺ��� �� �ִ� ������ �����ؾ� �ϸ�
                 NULL ������ �Է��� �Ұ����� ���̾�� �Ѵ�.
                 
 2.FOREIGN KEY : �ַ� JOIN�� ���Ǵ� ������������
                 �ٸ� ���̺��� PRIMARY KEY�� ���Ǿ��� ����
                 �����ؾ߸� �Ѵ�.
                 
 3. UNIQUE     : �� �÷��� �ԷµǴ� ���� �ߺ����� ������ �����ؾ� �Ѵ�.
                 NULL ������ �Է��� �����ϴ�.
                 => �����Ͱ� NULL�̰ų� NULL�� �ƴϸ� �ݵ�� ������ ���̾�� ��
 5. NOT NULL   : �� �÷��� �ԷµǴ� ���� �ߺ��� ���������
                 NULL ���´� ���� �ʵ��� �����Ѵ�.
                 
  => PK : UNIQUE + NOT NULL�� ���յ� ���¶�� ���� �� �� �ִ�.
*/

-- ��) û���� ���� �����ο� ������ ������ ���̺� ����
/*
    ���̺��̸� : member
    1. ������̵�        : member_id     : ���� : VARCHAR2 : PK
    2. ��� �̸�         : member_name   : ���� : VARCHAR2 : NOT NULL
    3. ��ȭ��ȣ ���ڸ�   : phone         : ���� : VARCHAR2
    4. �ý��۵����      : reg_date      : ��¥ : DATE
    5. ��� ��(���̸�)   : address       : ���� : VARCHAR2
    6. �����ϴ� ����     : like_number   : ���� : NUMBER
    7. ����              : major         : ���� : VARCHAR2
*/

-- 1. member ���̺� ���� ���� : member
CREATE TABLE member
( member_id     VARCHAR2(4)     PRIMARY KEY
 ,member_name   VARCHAR2(15)    NOT NULL
 ,phone         VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �� ���� �ȴ�.
 ,reg_date      DATE            DEFAULT sysdate
 ,address       VARCHAR2(30)   
 ,like_number   NUMBER
 ,major         VARCHAR2(50)
);
-- Table MEMBER��(��) �����Ǿ����ϴ�

-- 2. ���̺� ���� ����
DROP TABLE ���̺��̸�;

DROP TABLE member;
--Table MEMBER��(��) �����Ǿ����ϴ�.

-- 3. ���̺� ���� ����
/* -------------
   ������ ����
   -------------
   1. �÷��� �߰��ϰų� : ADD
   2. �÷��� �����ϰų� : MODIFY
   3. �÷��� �����ϰų� : DROP COLUMN
   ----------------
*/
ALTER TABLE ���̺��̸� {ADD | MODIFY | DROP COLUMN} ....;
-- ��) ������ member ���̺� �÷� 2���� �߰�
-- ����� �� : birth_month : NUMBER
-- ����      : gender      : VARCHAR2(1) : F, M �� ���� �� �ϳ��� �Է°����� ����

-- 1) ADD
-- member ���̺� ���� �� �Ʒ� ���� ����
ALTER TABLE member ADD
( birth_month NUMBER
 ,gender      VARCHAR2(1) CHECK (gender IN ('F', 'M')) -- WHERE ���� ���� ��밡��
);
-- Table MEMBER��(��) ����Ǿ����ϴ�.

-- 2) MODIFY
-- ��) ��� �� �÷��� ����2 �ڸ������� �����ϵ��� ����
ALTER TABLE ���̺��̸� MODIFY �÷��̸� ������Ÿ��(ũ��);
ALTER TABLE member MODIFY birth_month NUMBER(2);
-- Table MEMBER��(��) ����Ǿ����ϴ�.

-- 3) DROP COLUMN
-- ��) ������ ���̺� member���� like_number �÷��� ����
ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸�;
ALTER TABLE member DROP COLUMN like_number;
-- Table MEMBER��(��) ����Ǿ����ϴ�.

CREATE TABLE member
( member_id     VARCHAR2(4)     PRIMARY KEY
 ,member_name   VARCHAR2(15)    NOT NULL
 ,phone         VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �� ���� �ȴ�.
 ,reg_date      DATE            DEFAULT sysdate
 ,address       VARCHAR2(30)   
 ,like_number   NUMBER
 ,major         VARCHAR2(50)
 ,birth_month   NUMBER(2)
 ,gender        VARCHAR2(1)     CHECK (gender IN ('F', 'M'))
);
-- ���� �ܼ�ȭ�� ���̺� ���Ǳ���
-- ���������� �� �÷� �ڿ� �ٷ� ��������(constraint) �̸� ���� �����Ͽ��� ������ 
-- �ܼ�ȭ�� ���̺��̴�

-- �������ǿ� �̸��� �ο��ؼ� ���� :
-- �÷��� ���ǰ� ���� �� �������� ���Ǹ� ���Ƽ� ���� �ۼ�

-- ���̺� ����
DROP TABLE member;

-- �������� �̸��� �־� member ���̺� ����
-- CONSTRAINT ���������̸� �������� Ÿ�� (�������� ������ �÷�)
CREATE TABLE member
(  member_id     VARCHAR2(4)     
 , member_name   VARCHAR2(15)    NOT NULL
 , phone         VARCHAR2(4)     -- NULL ����Ϸ��� ���������� �� ���� �ȴ�.
 , reg_date      DATE            DEFAULT sysdate
 , address       VARCHAR2(30)   
 , major         VARCHAR2(50)
 , birth_month   NUMBER(2)
 , gender        VARCHAR2(1)     
 , CONSTRAINT pk_member         PRIMARY KEY (member_id)
 , CONSTRAINT ck_member_gender  CHECK       (gender IN ('M', 'F'))
);
-- Table MEMBER��(��) �����Ǿ����ϴ�.

-- ���̺� ������ DDL�� ������ ������ �ý��� īŻ�α׿� �����.
-- user_tables, user_constraints �� ���� �ý��� īŻ�α� ���̺��� ��ȸ����.

-- 1) �� ���̺��� ����(�÷� �̸�) ��ȸ
DESC user_tables;
/*
�̸�                        ��?       ����             
------------------------- -------- -------------- 
TABLE_NAME                NOT NULL VARCHAR2(128)
*/
-- ���� ����(SCOTT)�� ������ �ִ� ���̺� ����� ��ȸ
SELECT t.table_name
  FROM user_tables t
;
/*
TABLE_NAME

DEPT
EMP
BONUS
SALGRADE
MEMBER
*/
DROP TABLE member;

DESC user_constraints;
/*
�̸�                  ��? ����             
------------------- -- -------------- 
OWNER                  VARCHAR2(128)  
CONSTRAINT_NAME        VARCHAR2(128)  
CONSTRAINT_TYPE        VARCHAR2(1)    
TABLE_NAME   
*/
-- ���� ����(SCOTT)�� ������ �ִ� ���������� ��ȸ
SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
;
/*
CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FK_DEPTNO	        R	EMP
PK_DEPT 	        P	DEPT
PK_EMP  	        P	EMP
CK_MEMBER_GENDER	C	MEMBER
PK_MEMBER       	P	MEMBER
SYS_C007648     	C	MEMBER
*/
-- MEMBER ���̺��� �������Ǹ� Ȯ���Ϸ���
SELECT c.constraint_name
     , c.constraint_type
     , c.table_name
  FROM user_constraints c
  WHERE c.table_name = 'MEMBER'
;
/*
CONSTRAINT_NAME CONSTRAINT_TYPE TABLE_NAME
SYS_C007648	        C	MEMBER
CK_MEMBER_GENDER	C	MEMBER
PK_MEMBER	        P	MEMBER
*/

-- user_objects : ���� ����ڰ� �������ִ� object���� ������ ����Ǵ�
--                �ý��� īŻ�α� ���̺�
DESC user_objects;
/*
�̸�                ��? ����            
----------------- -- ------------- 
OBJECT_NAME          VARCHAR2(128) 
SUBOBJECT_NAME       VARCHAR2(128) 
OBJECT_ID            NUMBER        
DATA_OBJECT_ID       NUMBER        
OBJECT_TYPE          VARCHAR2(23)
*/
SELECT o.object_name
     , o.object_id
     , o.object_type
  FROM user_objects o
;
/*
OBJECT_NAME, OBJECT_ID, OBJECT_TYPE
DEPT    	73559	TABLE
PK_DEPT	    73560	INDEX
EMP	        73561   TABLE
PK_EMP	    73562	INDEX
BONUS	    73563	TABLE
SALGRADE	73564	TABLE
PK_MEMBER	74647	INDEX
MEMBER  	74646	TABLE
*/

-- ���̺� ���� ����� �̹� �����ϴ� ���̺�κ��� ���� ����
-- ���̺� ���� ���� ���� ����
CREATE TALBLE ���̺��̸�
AS
SELECET �÷��̸�...
   FROM ���������̺�
  WHERE �׻� ������ �Ǵ� ����
 ;
  -- ��) �ռ� ������ member ���̺��� ���� : new_member
CREATE TABLE new_member
AS
SELECT m.*
  FROM member m
 WHERE 1 = 2 -- �׻� ������ �Ǵ� ����
;
 -- PK ������ ������� �ʰ� ���̺� ����(��ȸ�� �÷���) �����
 
 -- new_member ���̺��� ������ ��ȸ
DESC new_member;
/*
-- ��� ���̺� ������ �߰�
*/
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M001', '�ڼ���', '9155', '������', '����', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M002', '������', '1418', '������', '�Ͼ�', '1', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M003', '�̺���', '0186', 'õ�Ƚ�', '�İ�', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M004', '�蹮��', '1392', 'û�ֽ�', '�Ͼ�', '3', 'F')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M005', '����ȯ', '0322', '�Ⱦ��', '����', '3', 'M')
COMMIT;

--3������ ������ �����ؼ� �� ���̺��� ��������.
CREATE TABLE march_member
AS
SELECT m.*
  FROM member m
 WHERE m.birth_month = 3
;
-- Table MARCH_MEMBER��(��) �����Ǿ����ϴ�.

-- �����Ͽ� ���̺� ������ ���� �� �� �ִ� ������ �ָ�
-- �ش� ������ �����ϴ� ���� �����ͱ��� ����Ǹ鼭 ���̺� ����

-- �׻� ���� �Ǵ� ������ �ָ� ��� �����͸� �����ϸ鼭 ���̺� ����
CREATE TABLE full_member
AS
SELECT m.*
  FROM member m
 WHERE 1 = 1
;

DROP TABLE full_member;
-- WHERE  ������ �����ص� �׻� ���� ���� �������� �̹Ƿ� ��� �����Ͱ� ����Ǹ� �� ���̺� ����
CREATE TABLE full_member
AS
SELECT m.*
  FROM member m
;
DROP TABLE member;
DROP TABLE full_member;
DROP TABLE march_member;

-----------------------------

-- ���̺� ����(ALTER) ���ǻ���

-- 1) �÷��� ���� �� : ��� ���濡 �����ο�
--                     ������ Ÿ�Ժ���, ������ ũ�⺯�濡 ��� �����ο�

-- 2) �÷��� �����Ͱ� ���� ��
--  : �����Ͱ� �ҽǵǸ� �ȵǹǷ� ���濡 ������ ����
--    Ÿ�� ������ ���� Ÿ�Գ������� ����
--    ���� Ÿ�԰��� CHAR -> VARCHAR2�� ���� ����
--    ũ�� ������ ���� Ȥ�� Ŀ���� �������θ� ����
--    ���� Ÿ���� ũ�⺯���� ���е��� Ŀ���� �������θ� ����

-- ��) MARCH_MEMBER ���̺��� BIRTH_MONTH �÷���
--     ������ Ÿ���� ũ�⸦ NUMBER(1)�� ���̸�
ALTER TABLE march_member MODIFY (BIRTH_MONTH NUMBER(1));
/*
ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�
01440. 00000 -  "column to be modified must be empty to decrease precision or scale"
*/
-- ���� �������� ���е��� �����ϴ� ������ �����ϸ�
-- 2 -> 10�ڸ�, �� �� �Ҽ��� 2�ڸ�
ALTER TABLE march_member MODIFY (BIRTH_MONTH NUMBER(10, 2));
-- Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

-- ���� �������� BIRTH_MONTH �÷��� ���� �����ͷ� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(1));
/*
ORA-01439: ������ ������ ������ ���� ��� �־�� �մϴ�
01439. 00000 -  "column to be modified must be empty to change datatype"
*/

UPDATE "SCOTT"."MARCH_MEMBER" SET BIRTH_MONTH = '' WHERE ROWID = 'AAASOfAAHAAAAGzAAA' AND ORA_ROWSCN = '6059270';
UPDATE "SCOTT"."MARCH_MEMBER" SET BIRTH_MONTH = '' WHERE ROWID = 'AAASOfAAHAAAAGzAAB' AND ORA_ROWSCN = '6059270';
UPDATE "SCOTT"."MARCH_MEMBER" SET BIRTH_MONTH = '' WHERE ROWID = 'AAASOfAAHAAAAGzAAC' AND ORA_ROWSCN = '6059270';
UPDATE "SCOTT"."MARCH_MEMBER" SET BIRTH_MONTH = '' WHERE ROWID = 'AAASOfAAHAAAAGzAAD' AND ORA_ROWSCN = '6059270';
UPDATE "SCOTT"."MARCH_MEMBER" SET BIRTH_MONTH = '' WHERE ROWID = 'AAASOfAAHAAAAG0AAC' AND ORA_ROWSCN = '6067535';
-- MARCH_MEMBER ���̺��� ��� �࿡ ���ؼ�
-- BIRTH_MONTH �÷��� ���� NULL �����ͷ� �����ϴ� ���
UPDATE "SCOTT"."MARCH_MEMBER"
   SET BIRTH_MONTH= ''
;
COMMIT;
/*
6�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
*/

-- �����Ͱ� ���� �÷����� ���� ��
-- VACHAR2(2) �����÷����� ����
ALTER TABLE march_member MODIFY (BIRTH_MONTH VARCHAR2(2));
--Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

-- NUMBER(1) ����1�ڸ� �÷����� ����
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH NUMBER(1));
-- Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.


----------------------------------------------------------------

-- 3) �⺻ ��(DEFAULT) ������ ���� ���� ������ ���� ��

-- ��) 3�� ���� ����� ������ MARCH_MEMBER ���̺��� �����غ���
--   : BIRTH_MONTH �÷��� ���� �׻� 3���� �����Ǿ �� �� ����.

-- a)
-- MARCH_MEMBER ���̺�
-- BIRTH_MONTH �÷��� ���� ���� ����
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, GENDER) VALUES ('M006', '�Կ���', '0437', '������', '�İ�', 'F');
COMMIT;
-- b) a�� ��� ���� �߰� �� DEFAULT ���� �߰�
ALTER TABLE march_member 
MODIFY (BIRTH_MONTH DEFAULT 3);
-- Table MARCH_MEMBER��(��) ����Ǿ����ϴ�.

-- c) MARCH_MEMBER ���̺� DEFAULT 
-- �� ����� �߰�
INSERT INTO "SCOTT"."MARCH_MEMBER" (MEMBER_ID, MEMBER_NAME, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M007', 'ȫ�浿', '������', '����', '3', 'M');
COMMIT;

-- ���̺� ���Ἲ ���� ���� ó����� 4����
/*
 MAIN_TABLE
 ------------------------------------------------
 ID         VARCHAR2(10)    PRIMARY KEY
 NICKNAME   VARCHAR2(30)    UNIQUE
 REG_DATE   DATE            DEFAULT SYSDATE
 GENDER     VARCHAR2(1)     CHECK (GENDER IN ('M', 'F'))
 MESSAGE    VARCHAR(300)
 ------------------------------------------------
 
 SUB_TABLE
 ------------------------------------------------
 ID         VARCHAR2(10)    REFERENCES MAIN_TABLE(ID)
                            (FK FROM MAIN_TABLE.ID)
 HOBBY      VARCHAR2(200)
 BIRTH_YEAR NUMBER(4)
 ------------------------------------------------
*/

----- 1. �÷� ������ ��, ���� ���� �̸� ���� �ٷ� ����
;
DROP TABLE MAIN_TABLE1;
CREATE TABLE MAIN_TABLE1
(  ID         VARCHAR2(10)    PRIMARY KEY
 , NICKNAME   VARCHAR2(30)    UNIQUE
 , REG_DATE   DATE            DEFAULT SYSDATE
 , GENDER     VARCHAR2(1)     CHECK (GENDER IN ('M', 'F'))
 , MESSAGE    VARCHAR(300)
);
-- Table MAIN_TABLE��(��) �����Ǿ����ϴ�.

DROP TABLE SUB_TABLE1;
CREATE TABLE SUB_TABLE1
(  ID         VARCHAR2(10)    REFERENCES MAIN_TABLE1(ID) --MAIN_TABLE�� ID�÷��� �����´�                             
 , HOBBY      VARCHAR2(200)
 , BIRTH_YEAR NUMBER(4)
);

-- Table SUB_TABLE1��(��) �����Ǿ����ϴ�.
-- 2. �÷� ������ ��, ���� ���� �̸��� �ָ� ����
DROP TABLE MAIN_TABLE2;
CREATE TABLE MAIN_TABLE2
(  ID         VARCHAR2(10)    CONSTRAINT PK_MAIN PRIMARY KEY
 , NICKNAME   VARCHAR2(30)    CONSTRAINT UQ_NICKNAME UNIQUE
 , REG_DATE   DATE            DEFAULT SYSDATE
 , GENDER     VARCHAR2(1)     CONSTRAINT CK_GENDER CHECK (GENDER IN ('M', 'F'))
 , MESSAGE    VARCHAR(300)
);
-- Table MAIN_TABLE2��(��) �����Ǿ����ϴ�.

DROP TABLE SUB_TABLE2;
CREATE TABLE SUB_TABLE2
(  ID         VARCHAR2(10)    CONSTRAINT FK_SUB REFERENCES MAIN_TABLE2(ID) --MAIN_TABLE�� ID�÷��� �����´�                             
 , HOBBY      VARCHAR2(200)
 , BIRTH_YEAR NUMBER(4)
);
-- Table SUB_TABLE2��(��) �����Ǿ����ϴ�.

-- MAIN_TABLE1�̶� ���������� ��

-- 3. �÷� ���� �� ���������� ���� �����ϴ� ���
DROP TABLE MAIN_TABLE3;
CREATE TABLE MAIN_TABLE3
(  ID         VARCHAR2(10)    
 , NICKNAME   VARCHAR2(30)    
 , REG_DATE   DATE            DEFAULT SYSDATE
 , GENDER     VARCHAR2(1)     
 , MESSAGE    VARCHAR(300)
 , CONSTRAINT PK_MAIN3      PRIMARY KEY (ID)
 , CONSTRAINT UQ_NICKNAME3  UNIQUE (NICKNAME)
 , CONSTRAINT CK_GENDER3    CHECK (GENDER IN ('M', 'F'))
);
-- Table MAIN_TABLE3��(��) �����Ǿ����ϴ�.

DROP TABLE SUB_TABLE3;
CREATE TABLE SUB_TABLE3
(  ID         VARCHAR2(10)                             
 , HOBBY      VARCHAR2(200)
 , BIRTH_YEAR NUMBER(4)
 , CONSTRAINT FK_SUB3 FOREIGN KEY(ID) REFERENCES MAIN_TABLE3(ID) => FOREIGN KEY �� MAIN_TABLE�� �ٶ󺸰� �ִ�.
 -- SUB_TABLE3�� ��� PRIMARY KEY �� ID, BIRTH_YEAR �� ����Ű�� ����
 -- ����Ű�� PK�� �������� ���� �ݵ�� �������� �߰��θ� ��������
 , CONSTRAINT PK_SUB3 PRIMARY KEY(ID, BIRTH_YEAR)
);

-- Table SUB_TABLE3��(��) �����Ǿ����ϴ�.

-- �߰� ����
-- �ǽ� 10)
/* �� ���̺� 3�� ����� ������ �ۼ�
   3�� ������� �ۼ�
    GAME
    GAME_CODE NUMBER(2)     PRIMARY KEY -���� �ڵ�
    GAME_NAME VARCHAR(200)  NOT NULL    -���� �̸�
    ----------------------------
    GMEMBER
    ID        VARCHAR2(4)   PRIMARY KEY -ȸ���� ���̵�
    NAME      VARCHAR2(15)  NOT NULL    -ȸ���� �̸�
    ----------------------------
    MEMBER_GAME_HISTORY
    ID        VARCHAR2(4)   FOREIGN KEY FK����, FK �̸� : FK_ID
                                        GMEMBER ���̺��� ID �÷��� �����ϵ��� �����϶�
    YEAR      NUMBER(4)                 -- ������ �� �⵵
    GAME_CODE NUMBER(2)                 FK ����, FK �̸� : FK_GAME_CODE
                                        GAME ���̺��� GAME_CODE �÷��� �����ϵ��� ����
    
*/

--����10
CREATE TABLE coustomer
( userid        VARCHAR2(4)     PRIMARY KEY
, name          VARCHAR2(30)    NOT NULL
, birthyear     NUMBER(4)       
, regdate       DATE            DEFAULT sysdate
, address       VARCHAR2(30)
);

DESC coustomer;