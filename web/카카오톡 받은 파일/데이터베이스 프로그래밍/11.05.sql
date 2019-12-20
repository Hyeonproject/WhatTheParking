�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� Ŀ��(�迭)

DECLARE
	vempno	emp.empno%TYPE;
	vename	emp.ename%TYPE;
	vjob	emp.job%TYPE;
	vsal	emp.sal%TYPE;
	CURSOR c1 IS
		SELECT empno, ename, job, sal 
		FROM emp
		WHERE deptno = 30;
BEGIN
	OPEN c1;
	LOOP
		FETCH c1 INTO vempno, vename, vjob, vsal;
		EXIT WHEN c1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('��ȣ : '||vempno||' �̸�: '||vename||' ����: '||vjob||' ����: '||vsal);
	END LOOP;
	CLOSE c1;
END;
/



�� ���� ���� ���ν����� ����

CREATE OR REPLACE PROCEDURE display_emp
	(vdeptno emp.deptno%TYPE)
IS
	vempno	emp.empno%TYPE;
	vename	emp.ename%TYPE;
	vjob	emp.job%TYPE;
	vsal	emp.sal%TYPE;
	CURSOR c1 IS
		SELECT empno, ename, job, sal 
		FROM emp
		WHERE deptno = vdeptno;
BEGIN
	OPEN c1;
	LOOP
		FETCH c1 INTO vempno, vename, vjob, vsal;
		EXIT WHEN c1%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('��ȣ : '||vempno||' �̸�: '||vename||' ����: '||vjob||' ����: '||vsal);
	END LOOP;
	CLOSE c1;
END;
/

EXEC display_emp(30);


�� FOR�� 3�������� ��� (�̿ϼ�)

CREATE OR REPLACE PROCEDURE display_emp
	(vdeptno emp.deptno%TYPE)
IS
	I NUMBER := 1
	CURSOR c1 IS
		SELECT empno, ename, job, sal 
		FROM emp
		WHERE deptno = vdeptno;
BEGIN
	FOR 
	LOOP
		EXIT WHEN I>3;
		DBMS_OUTPUT.PUT_LINE('��ȣ : '||vempno||' �̸�: '||vename||' ����: '||vjob||' ����: '||vsal);
	END LOOP;
	CLOSE c1;
END;
/

EXEC display_emp(30);


�� �а��̸��� �Է��Ͽ� ����, ����, ����, ���޾� ��� (���蹮��!) FETCH���

CREATE OR REPLACE PROCEDURE display_prof
	(vdname department.dname%TYPE)
IS
	vdeptno department.deptno%TYPE;
	vname professor.name%TYPE;
	vpay professor.pay%TYPE;
	vbonus professor.bonus%TYPE;
	vsal NUMBER;
	vtax NUMBER;
	vpayment NUMBER;

	CURSOR c1 IS
		SELECT name, pay, NVL(bonus,0), (pay*12)+(NVL(bonus,0)*6)
		INTO vname, vpay, vbonus, vsal
		FROM professor
		WHERE deptno = vdeptno;
BEGIN
	SELECT deptno
	INTO vdeptno
	FROM department
	WHERE dname = vdname;

	OPEN c1;
	LOOP
	FETCH c1 INTO vname, vpay, vbonus, vsal;
	EXIT WHEN c1%NOTFOUND;

	vtax := CASE
		WHEN (vsal <= 2000) THEN 0
		WHEN (vsal <= 4500) THEN (vpay+vbonus)*0.15
		WHEN (vsal <= 8800) THEN (vpay+vbonus)*0.24
		ELSE (vpay+vbonus)*0.35
	END;

	vpayment := vpay+vbonus-vtax;

	DBMS_OUTPUT.PUT_LINE('�̸� : '||vname||' ���� : '||vpay||' ���� : '||vbonus||
' ���� : '||vtax||' ���޾� :'||vpayment);

	END LOOP;
	CLOSE c1;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� �а��� �����ϴ�.');
END ;
/

EXEC display_prof('��ǻ�Ͱ��а�');


�� �а��̸��� �Է��Ͽ� ����, ����, ����, ���޾� ��� (�Ǳ� ���蹮�� 1��!!!) FOR���

CREATE OR REPLACE PROCEDURE display_prof
   (vdname department.dname%TYPE)
IS
   vname professor.name%TYPE;
   vpay professor.pay%TYPE;
   vbonus professor.bonus%TYPE;
   vdeptno professor.deptno%TYPE;
   vtax NUMBER;
   vtotal NUMBER;
   vpayment NUMBER;

CURSOR c1 IS
	SELECT name, pay, nvl(bonus,0) bonus
	INTO   vname, vpay, vbonus
	FROM professor
	WHERE deptno = vdeptno;

BEGIN
	SELECT deptno
	INTO vdeptno
	FROM department
	WHERE dname = vdname;

	FOR prof_rec IN c1
	LOOP
	vtotal := prof_rec.pay * 12 + prof_rec.bonus * 6;
	vtax := CASE
	   	WHEN (vtotal <= 2000) THEN 0
		WHEN (vtotal <= 4500 ) THEN (prof_rec.pay + prof_rec.bonus)*0.15
		WHEN (vtotal <= 8800 ) THEN (prof_rec.pay + prof_rec.bonus)*0.24
		ELSE (prof_rec.pay + prof_rec.bonus)*0.35
		END;

	vpayment := (prof_rec.pay + prof_rec.bonus) - vtax;

	DBMS_OUTPUT.PUT_LINE('�̸� : ' || prof_rec.name ||' ���� : ' || prof_rec.pay||' ���� : '||prof_rec.bonus
        ||' ���� : ' || vtax || ' ���޾� : ' || vpayment);
	END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('�ش� �а��� ���������ʽ��ϴ�.');
END;
/

EXEC display_prof('��ǻ�Ͱ��а�')



