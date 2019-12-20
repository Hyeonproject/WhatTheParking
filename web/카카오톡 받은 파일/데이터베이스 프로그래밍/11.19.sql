�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� Ʈ����

CREATE TABLE torder
( no		NUMBER,
  ord_code	VARCHAR2(10),
  ord_date	DATE);

CREATE OR REPLACE TRIGGER t_order
	BEFORE INSERT ON torder
BEGIN
	IF (TO_CHAR(sysdate, 'HH24:MI') NOT BETWEEN '13:50' AND '14:00') THEN
		RAISE_APPLICATION_ERROR(-20100, '���ð� �ƴմϴ�.');
	END IF;
END;
/

INSERT INTO torder VALUES (1, 'C100', SYSDATE);
INSERT INTO torder VALUES (2, 'C200', SYSDATE);
INSERT INTO torder VALUES (3, 'C300', SYSDATE);

DROP trigger t_order;
DROP table torder purge;

�� Ʈ���� 2
(delete�� new�� ���� ������ ù��° if���� ������ �ȵȴ�.)

CREATE OR REPLACE TRIGGER t_order
	BEFORE insert or update on torder
FOR EACH ROW
BEGIN
	IF (:new.ord_code) not in ('C100') THEN
		IF Updating THEN
			DBMS_OUTPUT.PUT_LINE(:old.ord_code);
		END IF;
		RAISE_APPLICATION_ERROR(-20200, '��ǰ�ڵ尡 Ʋ���ϴ�.');
	END IF;
END;
/

INSERT INTO torder VALUES (2, 'C100', SYSDATE);
INSERT INTO torder VALUES (3, 'C300', SYSDATE);
UPDATE torder set ord_code = 'c200' WHERE no = 2;


�� ����Ʈ 8��

CREATE OR REPLACE TRIGGER t_emp
	AFTER INSERT ON emp
FOR EACH ROW
BEGIN
	SELECT COUNT(*), AVG(sal)
	INTO v_count, v_sal
	FROM emp
	WHERE deptno = :new.deptno
	GROUP BY deptno
	
	DBMS_OUTPUT.PUT_LINE(v_count);
	DBMS_OUTPUT.PUT_LINE(v_sal);
END;
/

	



























	