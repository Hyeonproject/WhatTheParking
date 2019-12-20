�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� �����̸��� �Է��Ͽ� '�к�'���� Ű�� ���� ū ���л����� ã�ƶ�. (���� 1��)
�кθ�, �й�, �̸�, �г�, Ű, �а����� ����϶�
(Ű�� ���� ū �л����� ���)

CREATE OR REPLACE PROCEDURE display_stud2
	(p_college department.dname%TYPE)
IS
	v_max NUMBER;
	v_deptno department.deptno%TYPE;
CURSOR c1 IS
	SELECT studno , name , height , d1.dname, d1.part
	FROM student JOIN department d1 ON (deptno1 =d1.deptno)
	JOIN department d2 ON (d1.part = d2.deptno)
	WHERE SUBSTR(jumin,7,1)=2 AND d2.part = v_deptno
        ORDER BY height DESC;
BEGIN
	SELECT deptno  INTO v_deptno
	FROM department
	WHERE dname = p_college;

	FOR stud_rec IN c1
	LOOP
		SELECT max(height) INTO v_max
		FROM student JOIN department ON (deptno1=deptno)
		WHERE SUBSTR(jumin,7,1)=2 AND part=stud_rec.part;

		IF(v_max=stud_rec.height ) THEN
		DBMS_OUTPUT.PUT_LINE( stud_rec.studno ||' �й� '|| stud_rec.name||' �̸� '|| v_max ||' Ű '|| stud_rec.dname||' �а��� ' );
		END IF;
	END LOOP;
EXCEPTION
	WHEN  NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE(' �ش� ��ȣ�� �����ϴ�.');
END;
/


SET SERVEROUTPUT ON 
EXEC display_stud2('College of Engineering');
EXEC display_stud2('College of Liberal Arts');
SET SERVEROUTPUT ON 
EXEC display_stud2('��������');
EXEC display_stud2('�ι�����');



�� ���� ���� �Է¾��� �кκ� Ű�� ���� ū ���л��� ���


CREATE OR REPLACE PROCEDURE display_stud
IS
	v_max NUMBER;
CURSOR c1 IS
	SELECT studno , name , height , dname, part
	FROM student JOIN department ON (deptno1 =deptno)
	WHERE SUBSTR(jumin,7,1)=2
        ORDER BY height DESC;
BEGIN
	FOR stud_rec IN c1
	LOOP
		SELECT max(height)  INTO v_max
		FROM student JOIN department ON (deptno1=deptno)
		WHERE SUBSTR(jumin,7,1)=2 AND part=stud_rec.part;

		IF(v_max=stud_rec.height ) THEN
		DBMS_OUTPUT.PUT_LINE( stud_rec.studno ||' �й� '|| stud_rec.name||' �̸� '|| v_max ||' Ű '|| stud_rec.dname||' �а��� ' );
		END IF;
	END LOOP;
EXCEPTION
	WHEN  NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE(' �ش� ��ȣ�� �����ϴ�.');
END;
/


SET SERVEROUTPUT ON 
EXEC display_stud;


�� ���� 2��

CREATE OR REPLACE PROCEDURE display_sal
	(v_college department.dname%TYPE)
IS
	v_max NUMBER;
	v_deptno department.deptno%TYPE;
CURSOR c1 IS
	SELECT name, position, d1.dname �а�, pay+NVL(bonus,0) �޿�
	FROM professor
	JOIN department d1 USING (deptno)
	JOIN department d2 ON (d1.part = d2.deptno)
	WHERE d2.part = v_deptno
	ORDER BY �޿� DESC;
BEGIN
	SELECT deptno INTO v_deptno
	FROM department
	WHERE dname = v_college;

	FOR prof_rec IN c1
	LOOP
		SELECT MAX(pay+NVL(bonus,0)) INTO v_max
		FROM professor
		WHERE position = prof_rec.position;

		IF (v_max = prof_rec.�޿�) THEN	
			v_max := v_max*10000;
			DBMS_OUTPUT.PUT_LINE('�̸� : '|| prof_rec.name || ' ���޸� : '|| prof_rec.position || ' �а��� : '|| prof_rec.�а� || ' �޿� : '|| v_max);
		END IF; 
	END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('�ش� �а��� ���������ʽ��ϴ�.');
END;
/

EXEC display_sal('��������');



�� FUNCTION (e.* ����!!!)


CREATE OR REPLACE FUNCTION favg
	(korean student2018.korean%TYPE,
	english student2018.english%TYPE,
	math student2018.math%TYPE)
	RETURN NUMBER
IS
	v_avg NUMBER;
BEGIN
	v_avg := ROUND((korean+english+math)/3,1);
	RETURN v_avg;
END;
/


CREATE OR REPLACE FUNCTION ftotal
	(v_avg NUMBER,
	toeic student2018.toeic%TYPE)
	RETURN NUMBER
IS
	v_total NUMBER;
BEGIN
	v_total := ROUND(v_avg*0.8+(toeic/10)*0.2);
	RETURN v_total;
END;
/


with e
as (	SELECT studno, studname, grade, toeic, favg(korean,english,math) ��ռ���
	FROM STUDENT2018)
SELECT e.*, ftotal(��ռ���, toeic) ����
FROM e
ORDER BY ���� DESC
/



�� ������� ������ FUNCTION���� �ٲ㺸��!





















