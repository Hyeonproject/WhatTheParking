�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� �а��̸��� �Է��Ͽ� ����, ����, ����, ���޾� ��� (�Ǳ� ���蹮�� 1��!!!) FOR���
-- Stored procedure ��� ��.

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
	SELECT name, pay, NVL(bonus,0) bonus
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


�� 628p. FUNCTION ���

CREATE OR REPLACE FUNCTION max_sal
	(s_deptno emp.deptno%TYPE)	
	RETURN NUMBER
IS
	max_sal emp.sal%TYPE;
BEGIN
	SELECT max(sal)
	INTO max_sal
	FROM emp
	WHERE deptno = s_deptno;
	RETURN max_sal;
END;
/

SELECT dname �μ��̸� , max_sal(deptno) �ְ����
FROM dept
WHERE deptno IN (SELECT DISTINCT deptno FROM emp)
/


�� ���ݸ����� FUNCTION�� �̿��Ͽ� ��� 1 (����õ)
(Ŀ���� ���� ����� �������϶��� ���!)

CREATE OR REPLACE FUNCTION tax
	(s_profno professor.profno%TYPE)
	RETURN NUMBER
IS
	v_tax NUMBER;
	v_total NUMBER;
	v_payment NUMBER;
CURSOR c1 IS
	SELECT pay, NVL(bonus,0) bonus
	FROM professor
	WHERE profno = s_profno;
BEGIN
	FOR prof_rec IN c1
	LOOP
	v_total := prof_rec.pay * 12 + prof_rec.bonus * 6;
	v_tax := CASE
	   	WHEN (v_total <= 2000) THEN 0
		WHEN (v_total <= 4500 ) THEN (prof_rec.pay + prof_rec.bonus)*0.15
		WHEN (v_total <= 8800 ) THEN (prof_rec.pay + prof_rec.bonus)*0.24
		ELSE (prof_rec.pay + prof_rec.bonus)*0.35
		END;

	v_payment := (prof_rec.pay + prof_rec.bonus) - v_tax;

	RETURN v_tax;
	END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('�ش� ������ ���������ʽ��ϴ�.');
END;
/

SELECT name �̸�, pay ����, NVL(bonus,0) ����, tax(profno) ����,
	(pay+NVL(bonus,0))-tax(profno) ���޾�
FROM professor
/


�� ���ݸ����� FUNCTION�� �̿��Ͽ� ��� 2 (��õ)

CREATE OR REPLACE FUNCTION tax
	(f_pay professor.pay%TYPE,
	f_bonus professor.bonus%TYPE)
	RETURN NUMBER
IS
	v_tax NUMBER;
	v_total NUMBER;
	v_payment NUMBER;
BEGIN
	v_total := f_pay * 12 + f_bonus * 6;
	v_tax := CASE
	   	WHEN (v_total <= 2000) THEN 0
		WHEN (v_total <= 4500 ) THEN (f_pay + f_bonus)*0.15
		WHEN (v_total <= 8800 ) THEN (f_pay + f_bonus)*0.24
		ELSE (f_pay + f_bonus)*0.35
		END;

	v_payment := (f_pay + f_bonus) - v_tax;

	RETURN v_tax;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('�ش� ������ ���������ʽ��ϴ�.');
END;
/

SELECT name �̸�, pay ����, NVL(bonus,0) ����, tax(pay, NVL(bonus,0)) ����,
	(pay+NVL(bonus,0))-tax(pay, NVL(bonus,0)) ���޾�
FROM professor
/


�� �̹� �����ϴ� ������Ʈ�� ��� �������ְ� ���������!

DROP procedure tax;


�� 1�г� �л����� �񸸵��� ���Ͽ���. (�й��� �ƴ� Ű, �����Ը� �Է�)
�������� �ƴ� �з��� �����ش�.

CREATE OR REPLACE FUNCTION bmi
	(f_weight student.weight%TYPE,
	f_height student.height%TYPE)
	RETURN VARCHAR2
IS
	v_bmi NUMBER;
	v_result VARCHAR2(20);
BEGIN
	v_bmi := f_weight/((f_height/100)*(f_height/100));
	v_result := CASE
	   	WHEN (v_bmi < 18.5) THEN '��ü��'
		WHEN (v_bmi < 23) THEN '����'
		WHEN (v_bmi < 25) THEN '����ü��'
		WHEN (v_bmi < 30) THEN '1�ܰ��'
		ELSE '2�ܰ��'
		END;

	RETURN v_result;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('�ش� �л��� ���������ʽ��ϴ�.');
END;
/

SELECT name �̸�, weight ������, height Ű, bmi(weight, height) �񸸵�
FROM student
WHERE grade = 1
/


�� 








