�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� ����ó�� 617p

CREATE OR REPLACE PROCEDURE count_dept
	(vdname department.dname%TYPE)
IS
	vcount NUMBER;
	vdeptno department.deptno%TYPE;
BEGIN
	SELECT deptno
	INTO vdeptno
	FROM department
	WHERE dname = vdname;

	SELECT COUNT(*)
	INTO vcount
	FROM student
	WHERE deptno1 = vdeptno;
	
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE(vdname||' �л��� ���� '||vcount||'�� �Դϴ�.');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� �а��� �����ϴ�.');
END ;
/

EXEC count_dept('�ҷ�����');		//����ó��
EXEC count_dept('��ǻ�Ͱ��а�');


�� ������ȣ�� �Է��ؼ� �����̸�, ����, ����, ����, ���޾� ���

CREATE OR REPLACE PROCEDURE display_salary
	(vprofno professor.profno%TYPE)
IS
	vname professor.name%TYPE;
	vpay professor.pay%TYPE;
	vbonus professor.bonus%TYPE;
	vsal NUMBER;
	vtax NUMBER;
	vpayment NUMBER;
BEGIN
	SELECT name, pay, NVL(bonus,0), ((pay*12)+(NVL(bonus,0)*6))
	INTO vname, vpay, vbonus, vsal
	FROM professor
	WHERE profno = vprofno;

	IF (vsal <= 2000) THEN
		vtax := 0;
	ELSIF (vsal <= 4500) THEN
		vtax := 0.15;
	ELSIF (vsal <= 8800) THEN
		vtax := 0.24;
	ELSE
		vtax := 0.35;
	END IF;

	vtax := (vpay+vbonus)*vtax;
	vpayment := vpay+vbonus-vtax;

	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('�̸� : '||vname);
	DBMS_OUTPUT.PUT_LINE('���� : '||vpay);
	DBMS_OUTPUT.PUT_LINE('���� : '||vbonus);
	DBMS_OUTPUT.PUT_LINE('���� : '||vtax);
	DBMS_OUTPUT.PUT_LINE('���޾� :'||vpayment);
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� ������ȣ�� �����ϴ�.');
END ;
/

EXEC display_salary(1001);


















