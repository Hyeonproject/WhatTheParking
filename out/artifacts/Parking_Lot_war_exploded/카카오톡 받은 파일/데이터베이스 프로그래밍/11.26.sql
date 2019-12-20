�� �̷н��� ���� �ǹ�, ���� ����, Ȱ��оߵ� ���� (�������� ���� ���)


�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� Ʈ���� �̿��Ͽ� �α� �����

CREATE TABLE EMP2_LOG (
  SEQ_NO       NUMBER PRIMARY KEY,
  EMPNO       NUMBER,
  NAME        VARCHAR2(30) NOT NULL,
  N_DEPTNO      VARCHAR2(06),
  N_PAY         NUMBER,
  N_POSITION    VARCHAR2(30),
  O_DEPTNO      VARCHAR2(06),
  O_PAY         NUMBER,
  O_POSITION    VARCHAR2(30),
  FLAG	     CHAR(06),
  LOGTIME     DATE	
);

CREATE SEQUENCE log_seq
     INCREMENT BY 1 
     START WITH 1
     CACHE 2 ;  

create or replace trigger emp2_log_trigger
	after insert or update or delete on emp2
	for each row
begin
	if INSERTING then
		insert into emp2_log(seq_no, empno, name, n_deptno, n_pay, n_position, flag, logtime)
		values (log_seq.nextval, :new.empno, :new.name, :new.deptno, :new.pay, :new.position, 'I', sysdate);
	elsif UPDATING then
		insert into emp2_log(seq_no, empno, name,  n_deptno, n_pay, n_position, o_deptno, o_pay, o_position, flag, logtime)
		values (log_seq.nextval, :new.empno, :new.name, :new.deptno, :new.pay, :new.position, :old.deptno, :old.pay, :old.position, 'U', sysdate);
	elsif DELETING then
		insert into emp2_log(seq_no, empno, name, o_deptno, o_pay, o_position, flag, logtime)
		values (log_seq.nextval, :old.empno, :old.name, :old.deptno, :old.pay, :old.position, 'D', sysdate);
	end if;
end;
/

INSERT INTO EMP2 VALUES (20000211,'Donald Trump',TO_DATE('19801215','YYYYMMDD'),'1005','Intern','031)345-3456','Reading book', 20000000,'',19960303);

UPDATE EMP2 SET deptno = '1004' WHERE empno = 20000211;

DELETE FROM EMP2 WHERE empno = 20000211;


�� emp2 ���̺� �����ؼ� AL pacino�� ����� ����, 1000���� �μ� ��� ���� 1���Դϴٸ� ���
(insert�� �Ĵ� �ٽ� 2���� �ǰ��ض�)
(�� PRAGMA AUTONOMOUS_TRANSACTION; ���� ����ϴ� ���� : ���̺� ���� ���� select�� ���� ���̺��� ������ �ϴ� �߻��ϴ� ���� ����)
(�� Ʈ���� �ȿ��� ��ġ�� �ִ� ���̺��� �ǵ帮�� �ȵǴ� ���� : )
(�� Ʈ���žȿ� commit�̳� rollback�� ���� �ȵȴ� : �ۿ��� insert ���� commit�� rollback�� ���ٲ��� ������)
CREATE OR REPLACE TRIGGER emp2_cnt_trigger
	AFTER INSERT OR DELETE ON emp2
	FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	v_count NUMBER;
	v_deptno NUMBER;
BEGIN
	CASE
	 WHEN INSERTING THEN
		v_deptno := :new.deptno;
	 WHEN DELETING THEN
		v_deptno := :old.deptno;
	END CASE;

	SELECT count(*)
	INTO v_count
	FROM emp2
	WHERE deptno = v_deptno;

	CASE
	 WHEN INSERTING THEN
		v_count := v_count+1;
	 WHEN DELETING THEN
		v_count := v_count-1;
	END CASE;

	DBMS_OUTPUT.PUT_LINE(v_deptno || '�� �μ��� �ο� �� : ' || v_count);
END;
/


DELETE FROM EMP2 WHERE name = 'AL Pacino';

INSERT INTO EMP2 VALUES (19960101,'AL Pacino',TO_DATE('19730322','YYYYMMDD'),'1000','Permanent employee','02)6255-8000','reading',72000000,'Department head',19900101);


�ؽ��迹�� ������

����� ���ν����� �ܿ��� Ŀ��
����� ����Ʈ �Ķ���� �� ����
Ʈ���� ��, �õ�, ����ġ�ο�

