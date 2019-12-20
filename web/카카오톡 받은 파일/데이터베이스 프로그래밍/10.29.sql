�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� DECLARE �̿��ؼ� �й��� 9411�� �л��� �й�, �̸��� �˻��Ͽ� ��� 557p

DECLARE
	vstudno NUMBER(4);
	vname VARCHAR2(15);
BEGIN
	SELECT studno, name INTO vstudno, vname
	FROM student
	WHERE studno = 9411;
	
	DBMS_OUTPUT.PUT_LINE('===== ��� =====');
	DBMS_OUTPUT.PUT_LINE('�й� : '||vstudno||' �̸�: '||vname);
END ;
/


===== ��� =====
�й� : 9411 �̸�: ������


�� ���ν��� (PROCEDURE) 625p

CREATE OR REPLACE PROCEDURE display_name
	(vstudno NUMBER)
IS
	vname VARCHAR2(15);
BEGIN
	SELECT name INTO vname
	FROM student
	WHERE studno = vstudno;
	
	DBMS_OUTPUT.PUT_LINE('===== ��� =====');
	DBMS_OUTPUT.PUT_LINE('�й� : '||vstudno||' �̸�: '||vname);
END ;
/

show errors;			//���� ���� ����

EXEC display_name(9411);	//���๮
EXEC display_name(9412);


�� ���������� �̿� (%TYPE ������ ���!)

CREATE OR REPLACE PROCEDURE display_name
	(vstudno student.studno%TYPE)
IS
	vname student.name%TYPE;
BEGIN
	SELECT name INTO vname
	FROM student
	WHERE studno = vstudno;
	
	DBMS_OUTPUT.PUT_LINE('===== ��� =====');
	DBMS_OUTPUT.PUT_LINE('�й� : '||vstudno||' �̸�: '||vname);
END ;
/

EXEC display_name(9411);


�� '��ǻ�Ͱ��а�'�� �Է��Ͽ� �л��� ���� ��� (��������, ���λ�� X)

CREATE OR REPLACE PROCEDURE count_dept
	(vdname department.dname%TYPE)
IS
	vcount NUMBER;
	vdeptno department.deptno%TYPE;
BEGIN
	SELECT deptno INTO vdeptno
	FROM department
	WHERE dname = vdname;

	SELECT COUNT(*) INTO vcount
	FROM student
	WHERE deptno1 = vdeptno;
	
	DBMS_OUTPUT.PUT_LINE('========== ��� ==========');
	DBMS_OUTPUT.PUT_LINE(vdname||' �л��� ���� '||vcount||'�� �Դϴ�.');
END ;
/

EXEC count_dept('��ǻ�Ͱ��а�');
EXEC count_dept('����Ʈ������а�');
EXEC count_dept('������а�');	//���� �а��̱� ������ 0���� �ƴ� ������ ���� ����!
				//����ó���� �ʿ��ϴ�
