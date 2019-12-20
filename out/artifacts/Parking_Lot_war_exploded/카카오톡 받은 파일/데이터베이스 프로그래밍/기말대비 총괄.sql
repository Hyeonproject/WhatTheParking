�� PL/SQL Ȱ��ȭ (�ʼ�!!!)

SET SERVEROUTPUT ON;


�� DECLARE �̿��ؼ� �й��� 9411�� �л��� �й�, �̸��� �˻��Ͽ� ��� 557p

DECLARE
	vstudno NUMBER(4);
	vname VARCHAR2(15);
BEGIN
	SELECT studno, name
	INTO vstudno, vname
	FROM student
	WHERE studno = 9411;
	
	DBMS_OUTPUT.PUT_LINE('===== ��� =====');
	DBMS_OUTPUT.PUT_LINE('�й� : '||vstudno||' �̸�: '||vname);
END ;
/

===== ��� =====
�й� : 9411 �̸�: ������


�� ���ν��� (PROCEDURE)

CREATE OR REPLACE PROCEDURE display_name
	(vstudno student.studno%TYPE)
IS
	vname student.name%TYPE;
BEGIN
	SELECT name
	INTO vname
	FROM student
	WHERE studno = vstudno;
	
	DBMS_OUTPUT.PUT_LINE('===== ��� =====');
	DBMS_OUTPUT.PUT_LINE('�й� : '||vstudno||' �̸�: '||vname);
END ;
/

EXEC display_name(9411);

===== ��� =====
�й� : 9411 �̸�: ������


�� '��ǻ�Ͱ��а�'�� �Է��Ͽ� �л��� ���� ���, ����ó�� 617p

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
	
	DBMS_OUTPUT.PUT_LINE('===== ��� =====');
	DBMS_OUTPUT.PUT_LINE(vdname||' �л��� ���� '||vcount||'�� �Դϴ�.');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� �а��� �����ϴ�.');
END ;
/

EXEC count_dept('�ҷ�����');		//����ó��
EXEC count_dept('��ǻ�Ͱ��а�');

===== ��� =====
��ǻ�Ͱ��а� �л��� ���� 4�� �Դϴ�.


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

	DBMS_OUTPUT.PUT_LINE('===== ��� =====');
	DBMS_OUTPUT.PUT_LINE('�̸� : '||vname);
	DBMS_OUTPUT.PUT_LINE('���� : '||vpay);
	DBMS_OUTPUT.PUT_LINE('���� : '||vbonus);
	DBMS_OUTPUT.PUT_LINE('���� : '||vtax);
	DBMS_OUTPUT.PUT_LINE('���޾� :'||vpayment);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� ������ȣ�� �����ϴ�.');
END ;
/

EXEC display_salary(1001);

===== ��� =====
�̸� : ������
���� : 550
���� : 100
���� : 156
���޾� :494


�� Ŀ���� �̿��Ͽ� �ش�μ��� ������� ���

CREATE OR REPLACE PROCEDURE display_emp
	(vdeptno emp.deptno%TYPE)
IS
	vempno emp.empno%TYPE;
	vename emp.ename%TYPE;
	vjob emp.job%TYPE;
	vsal emp.sal%TYPE;
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

��ȣ : 7499 �̸�: ALLEN ����: SALESMAN ����: 1600
��ȣ : 7521 �̸�: WARD ����: SALESMAN ����: 1250
��ȣ : 7654 �̸�: MARTIN ����: SALESMAN ����: 1250
��ȣ : 7698 �̸�: BLAKE ����: MANAGER ����: 2850
��ȣ : 7844 �̸�: TURNER ����: SALESMAN ����: 1500
��ȣ : 7900 �̸�: JAMES ����: CLERK ����: 950


�� �а��̸��� �Է��Ͽ� ����, ����, ����, ���޾� ��� (���蹮��!!!) FETCH��� (��ġ���)

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
		WHEN (vsal <= 4500) THEN 0.15
		WHEN (vsal <= 8800) THEN 0.24
		ELSE 0.35
	END;
	vtax := (vpay+vbonus)*vtax;
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

EXEC display_prof('Computer Engineering');

�̸� : ������ ���� : 550 ���� : 100 ���� : 156 ���޾� :494
�̸� : �ڽ°� ���� : 380 ���� : 60 ���� : 105.6 ���޾� :334.4
�̸� : �۵��� ���� : 270 ���� : 0 ���� : 40.5 ���޾� :229.5


�� �а��̸��� �Է��Ͽ� ����, ����, ����, ���޾� ��� (�Ǳ� ���蹮��!!!) FOR���

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
		WHEN (vtotal <= 4500 ) THEN 0.15
		WHEN (vtotal <= 8800 ) THEN 0.24
		ELSE 0.35
		END;
	vtax := (prof_rec.pay + prof_rec.bonus)*vtax;
	vpayment := (prof_rec.pay + prof_rec.bonus) - vtax;

	DBMS_OUTPUT.PUT_LINE('�̸� : ' || prof_rec.name ||' ���� : ' || prof_rec.pay||' ���� : '||prof_rec.bonus
        ||' ���� : ' || vtax || ' ���޾� : ' || vpayment);
	END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('�ش� �а��� ���������ʽ��ϴ�.');
END;
/

EXEC display_prof('Computer Engineering')

�̸� : ������ ���� : 550 ���� : 100 ���� : 156 ���޾� : 494
�̸� : �ڽ°� ���� : 380 ���� : 60 ���� : 105.6 ���޾� : 334.4
�̸� : �۵��� ���� : 270 ���� : 0 ���� : 40.5 ���޾� : 229.5


�� FUNCTION�� �̿��Ͽ� �μ��� �ְ���� ���

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

�μ��̸�                       �ְ����
---------------------------- ----------
ACCOUNTING                         5000
RESEARCH                           5000
SALES                              2850


�� ���ݸ����� FUNCTION�� �̿��Ͽ� ���

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

SELECT name �̸�, pay ����, bonus ����, tax(pay, NVL(bonus,0)) ����,
	(pay+NVL(bonus,0))-tax(pay, NVL(bonus,0)) ���޾�
FROM professor
/

�̸�                                 ����       ����       ����     ���޾�
------------------------------ ---------- ---------- ---------- ----------
������                                550        100        156        494
�ڽ°�                                380         60      105.6      334.4
�۵���                                270                  40.5      229.5
�缱��                                250                  37.5      212.5
�迵��                                350         80      103.2      326.8
�ֽ���                                490         90      139.2      440.8
�赵��                                530        110      153.6      486.4
���ѿ�                                330         50         57        323
������                                290                  43.5      246.5
�ɽ�                                  570        130        168        532
�ֽ���                                330                  49.5      280.5
�ڿ���                                310         50         54        306
����ö                                260                    39        221
�ٺ�                                  500         80      139.2      440.8
����                                  220                    33        187
����                                  290         30         48        272


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

�̸�                               ������         Ű �񸸵�
------------------------------ ---------- ---------- ---------------
������                                 48        162 ��ü��
������                                 63        175 ����
�ο���                                 69        173 ����ü��
������                                 81        179 1�ܰ��
���                                   51        163 ����


�� Ʈ���� (torder���̺� ���� �� �������)

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
     CACHE 2;

CREATE OR REPLACE TRIGGER emp2_log_trigger
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
(�ȉ�~!~!~!~!)

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


�� �����̸��� �Է��Ͽ� '�к�'���� Ű�� ���� ū ���л����� ã�Ƽ� �кθ�, �й�, �̸�, �г�, Ű, �а����� ����϶�
(����1��. Ű�� ���� ū �л����� ���) ���蹮��!!!

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
	SELECT deptno
	INTO v_deptno
	FROM department
	WHERE dname = p_college;

	FOR stud_rec IN c1
	LOOP
		SELECT max(height) INTO v_max
		FROM student JOIN department ON (deptno1=deptno)
		WHERE SUBSTR(jumin,7,1)=2 AND part=stud_rec.part;

		IF (v_max=stud_rec.height) THEN
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

=====���=====
9513 �й� ������ �̸� 177 Ű �����а� �а���
9413 �й� �̹̰� �̸� 168 Ű ����Ʈ������а� �а���


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

		IF(v_max=stud_rec.height) THEN
		DBMS_OUTPUT.PUT_LINE( stud_rec.studno ||' �й� '|| stud_rec.name||' �̸� '|| v_max ||' Ű '|| stud_rec.dname||' �а��� ' );
		END IF;
	END LOOP;
EXCEPTION
	WHEN  NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE(' �ش� ��ȣ�� �����ϴ�.');
END;
/

EXEC display_stud;

=====���=====
9513 �й� ������ �̸� 177 Ű �����а� �а���
9413 �й� �̹̰� �̸� 168 Ű ����Ʈ������а� �а���
9514 �й� ������ �̸� 160 Ű ���������а� �а���


�� �Էµ� ���п� �Ҽӵ� '����'�� �޿��� ���� ���� �������� ���
(����2��) ���蹮��!!!

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

=====���=====
�̸� : �ɽ� ���޸� : ������ �а��� : ���ڰ��а� �޿� : 7000000
�̸� : �ڽ°� ���޸� : ������ �а��� : ��ǻ�Ͱ��а� �޿� : 4400000
�̸� : ������ ���޸� : ���Ӱ��� �а��� : ����Ʈ������а� �޿� : 2900000


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


�� Anonymous Procedure ������ 2�� (����Ʈ 1��)

DECLARE
	v_dan NUMBER := 2;
BEGIN
	FOR i IN 1..10
	LOOP
		DBMS_OUTPUT.PUT_LINE(v_dan||' * '||i||' = '||v_dan*i);
	END LOOP;
END;
/

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
2 * 10 = 20


�� Stored �Լ� ����, ���޾� ��� (����Ʈ 2��)


CREATE OR REPLACE FUNCTION tax
	(f_empno emp.empno%TYPE)
	RETURN NUMBER
IS
	v_sal emp.sal%TYPE;
	v_comm emp.comm%TYPE;
	v_tax NUMBER;
	v_total NUMBER;
	v_payment NUMBER;
BEGIN
	SELECT sal, NVL(comm,0)
	INTO v_sal, v_comm
	FROM emp
	WHERE empno = f_empno;

	v_total := v_sal * 12 + v_comm * 6;
	v_tax := CASE
		WHEN (v_total <= 2000) THEN (v_sal + v_comm)*0.1
		WHEN (v_total <= 4000 ) THEN (v_sal + v_comm)*0.2
		ELSE (v_sal + v_comm)*0.3
		END;

	v_payment := (v_sal + v_comm) - v_tax;
	RETURN v_tax;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� ����� ���������ʽ��ϴ�.');
END;
/

Function created.

CREATE OR REPLACE FUNCTION payment
	(f_empno emp.empno%TYPE)
	RETURN NUMBER
IS
	v_sal emp.sal%TYPE;
	v_comm emp.comm%TYPE;
	v_tax NUMBER;
	v_total NUMBER;
	v_payment NUMBER;
BEGIN
	SELECT sal, NVL(comm,0)
	INTO v_sal, v_comm
	FROM emp
	WHERE empno = f_empno;

	v_payment := (v_sal + v_comm) - tax(f_empno);

	RETURN v_payment;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� ����� ���������ʽ��ϴ�.');
END;
/

Function created.

SQL> SELECT empno �����ȣ, ename �̸�, sal ����, comm ����, tax(empno) ����, payment(empno) ���޾�
  2  FROM emp
  3  /

  �����ȣ �̸�                       ����       ����       ����     ���޾�
---------- -------------------- ---------- ---------- ---------- ----------
      7369 SMITH                       800                   240        560
      7499 ALLEN                      1600        300        570       1330
      7521 WARD                       1250        500        525       1225
      7566 JONES                      2975                 892.5     2082.5
      7654 MARTIN                     1250       1400        795       1855
      7698 BLAKE                      2850                   855       1995
      7782 CLARK                      2450                   735       1715
      7788 SCOTT                      3000                   900       2100
      7839 KING                       5000                  1500       3500
      7844 TURNER                     1500          0        450       1050
      7876 ADAMS                      1100                   330        770
      7900 JAMES                       950                   285        665
      7902 FORD                       3000                   900       2100
      7934 MILLER                     1300                   390        910


�� Stored Procedure ��� �л����� ���� ���


CREATE OR REPLACE PROCEDURE display_student

IS

CURSOR c1 IS
	SELECT studno, name, grade, DECODE(SUBSTR(jumin,7,1),1,'����','����') sex,
	TO_CHAR(sysdate, 'YYYY') - TO_CHAR(birthday, 'YYYY') age, d.dname department
	FROM student s JOIN department d
	ON s.deptno1 = d.deptno;
BEGIN
	FOR prof_rec IN c1
	LOOP
		DBMS_OUTPUT.PUT_LINE('�й� : ' ||prof_rec.studno||' �̸� : '||prof_rec.name||' �г� : '||prof_rec.grade
		||' ���� : '||prof_rec.sex||' ���� : '||prof_rec.age||' �а��� : '||prof_rec.department);
	END LOOP;
END;
/

Procedure created.

SQL> EXEC display_student()
�й� : 9411 �̸� : ������ �г� : 4 ���� : ���� ���� : 43 �а��� : ��ǻ�Ͱ��а�
�й� : 9412 �̸� : ����� �г� : 4 ���� : ���� ���� : 43 �а��� : ��Ƽ�̵����а�
�й� : 9413 �̸� : �̹̰� �г� : 4 ���� : ���� ���� : 43 �а��� : ����Ʈ������а�
�й� : 9414 �̸� : ����� �г� : 4 ���� : ���� ���� : 43 �а��� : ���ڰ��а�
�й� : 9415 �̸� : �ڵ�ȣ �г� : 4 ���� : ���� ���� : 43 �а��� : �����а�
�й� : 9511 �̸� : ��ſ� �г� : 3 ���� : ���� ���� : 42 �а��� : ��ǻ�Ͱ��а�
�й� : 9512 �̸� : ������ �г� : 3 ���� : ���� ���� : 42 �а��� : ��Ƽ�̵����а�
�й� : 9513 �̸� : ������ �г� : 3 ���� : ���� ���� : 42 �а��� : �����а�
�й� : 9514 �̸� : ������ �г� : 3 ���� : ���� ���� : 42 �а��� : ���������а�
�й� : 9515 �̸� : �Ӽ��� �г� : 3 ���� : ���� ���� : 42 �а��� : ���ڰ��а�
�й� : 9611 �̸� : ������ �г� : 2 ���� : ���� ���� : 41 �а��� : ��ǻ�Ͱ��а�
�й� : 9612 �̸� : ������ �г� : 2 ���� : ���� ���� : 41 �а��� : ��Ƽ�̵����а�
�й� : 9613 �̸� : �ȱ��� �г� : 2 ���� : ���� ���� : 41 �а��� : ���ڰ��а�
�й� : 9614 �̸� : �蹮ȣ �г� : 2 ���� : ���� ���� : 41 �а��� : ���ڰ��а�
�й� : 9615 �̸� : ����ȣ �г� : 2 ���� : ���� ���� : 41 �а��� : ���������а�
�й� : 9711 �̸� : ������ �г� : 1 ���� : ���� ���� : 40 �а��� : ��ǻ�Ͱ��а�
�й� : 9712 �̸� : ������ �г� : 1 ���� : ���� ���� : 40 �а��� : ���ڰ��а�
�й� : 9713 �̸� : �ο��� �г� : 1 ���� : ���� ���� : 40 �а��� : ���ڰ��а�
�й� : 9714 �̸� : ������ �г� : 1 ���� : ���� ���� : 40 �а��� : ��Ƽ�̵����а�
�й� : 9715 �̸� : ��� �г� : 1 ���� : ���� ���� : 40 �а��� : ����Ʈ������а�


�� �а��� �޾� �Ҽ��а��� �л�����, ���������� ���


CREATE OR REPLACE PROCEDURE display_student
	(v_dname department.dname%TYPE)
IS
	v_deptno department.deptno%TYPE;
CURSOR c1 IS
	SELECT studno, s.name, grade, DECODE(SUBSTR(jumin,7,1),1,'����','����') sex,
	TO_CHAR(sysdate, 'YYYY') - TO_CHAR(birthday, 'YYYY') age, p.name professor
	FROM student s FULL OUTER JOIN professor p
	USING (profno)
	WHERE deptno1 = v_deptno;
BEGIN
	SELECT deptno
	INTO v_deptno
	FROM department
	WHERE dname = v_dname;

	FOR prof_rec IN c1
	LOOP
		DBMS_OUTPUT.PUT_LINE('�й� : ' ||prof_rec.studno||' �̸� : '||prof_rec.name||' �г� : '||prof_rec.grade
		||' ���� : '||prof_rec.sex||' ���� : '||prof_rec.age||' �������� : '||prof_rec.professor);
END LOOP;
END;
/

Procedure created.

SQL> EXEC display_student('��ǻ�Ͱ��а�')
�й� : 9411 �̸� : ������ �г� : 4 ���� : ���� ���� : 43 �������� : ������
�й� : 9511 �̸� : ��ſ� �г� : 3 ���� : ���� ���� : 42 �������� : �ڽ°�
�й� : 9611 �̸� : ������ �г� : 2 ���� : ���� ���� : 41 �������� : �ڽ°�
�й� : 9711 �̸� : ������ �г� : 1 ���� : ���� ���� : 40 �������� :


�� �⸻ ��� ���� 1

CREATE OR REPLACE PROCEDURE pro_01
	(vdname department.dname%TYPE)
IS
	v_studcount NUMBER;
	v_profcount NUMBER;
	v_deptno department.deptno%TYPE;
CURSOR c1 IS
	SELECT studno, name, grade
	FROM student
	WHERE deptno1 = v_deptno;
CURSOR c2 IS
	SELECT profno, name, position
	FROM professor
	WHERE deptno = v_deptno;
BEGIN
	SELECT deptno
	INTO v_deptno
	FROM department
	WHERE dname = vdname;

	SELECT COUNT(*)
	INTO v_studcount
	FROM student
	WHERE deptno1 = v_deptno;

	SELECT COUNT(*)
	INTO v_profcount
	FROM professor
	WHERE deptno = v_deptno;
	
	DBMS_OUTPUT.PUT_LINE(vdname || ' �л��� �� ' || v_studcount || '���Դϴ�.');

	FOR stud_rec IN c1
	LOOP
	DBMS_OUTPUT.PUT_LINE('�й� : ' || stud_rec.studno || ' �л��̸� : ' || stud_rec.name || ' �г� : '|| stud_rec.grade);
	END LOOP;
	
	DBMS_OUTPUT.PUT_LINE(vdname || ' ������ �� ' || v_profcount || '���Դϴ�.');	

	FOR prof_rec IN c2
	LOOP
	DBMS_OUTPUT.PUT_LINE('������ȣ : ' || prof_rec.profno || ' �����̸� : ' || prof_rec.name || ' ���� : '|| prof_rec.position);
	END LOOP;	

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('�ش� �а��� �����ϴ�.');
END ;
/


SQL> EXEC pro_01('Computer Engineering');
Computer Engineering �л��� �� 4���Դϴ�.
�й� : 9411 �л��̸� : James Seo �г� : 4
�й� : 9511 �л��̸� : Billy Crystal �г� : 3
�й� : 9611 �л��̸� : Richard Dreyfus �г� : 2
�й� : 9711 �л��̸� : Danny Devito �г� : 1
Computer Engineering ������ �� 3���Դϴ�.
������ȣ : 1001 �����̸� : Audie Murphy ���� : a full professor
������ȣ : 1002 �����̸� : Angela Bassett ���� : assistant professor
������ȣ : 1003 �����̸� : Jessica Lange ���� : instructor

PL/SQL procedure successfully completed.


�� �⸻ ��� ���� 2

CREATE OR REPLACE TRIGGER t_count
	AFTER INSERT ON professor
	FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	v_deptno department.deptno%TYPE;
	v_dname department.dname%TYPE;
CURSOR c1 IS
	SELECT grade, count(*) �л���
	FROM student
	WHERE deptno1 = v_deptno
	GROUP BY grade
	ORDER BY grade;
BEGIN
	v_deptno := :new.deptno;

	SELECT dname
	INTO v_dname
	FROM department
	WHERE deptno = v_deptno;

	FOR stud_rec IN c1
	LOOP
		DBMS_OUTPUT.PUT_LINE('�а��� : ' || v_dname || ' �г� : ' || stud_rec.grade || ' �л��� : ' || stud_rec.�л���);
	END LOOP;
END;
/


insert into professor
values(9998,'JUN HAN','JUM','a full professor',550,to_date('1980-06-23','YYYY-MM-DD'),100,101,'captain@abc.net','http://www.abc.net');

insert into professor
values(9999,'ME RONG','ME','a full professor',550,to_date('1980-06-23','YYYY-MM-DD'),100,102,'captain@abc.net','http://www.abc.net');

select * from student;
select * from professor;

SQL> insert into professor
  2  values(9998,'JUN HAN','JUM','a full professor',550,to_date('1980-06-23','YYYY-MM-DD'),100,101,'captain@abc.net','http://www.abc.net');
�а��� : Computer Engineering �г� : 1 �л��� : 1
�а��� : Computer Engineering �г� : 2 �л��� : 1
�а��� : Computer Engineering �г� : 3 �л��� : 1
�а��� : Computer Engineering �г� : 4 �л��� : 1

1 row created.

SQL>
SQL> insert into professor
  2  values(9999,'ME RONG','ME','a full professor',550,to_date('1980-06-23','YYYY-MM-DD'),100,102,'captain@abc.net','http://www.abc.net');
�а��� : Multimedia Engineering �г� : 1 �л��� : 1
�а��� : Multimedia Engineering �г� : 2 �л��� : 1
�а��� : Multimedia Engineering �г� : 3 �л��� : 1
�а��� : Multimedia Engineering �г� : 4 �л��� : 1

1 row created.


�� �⸻ ��� ���� 3

CREATE OR REPLACE FUNCTION wage
	(f_profno professor.profno%TYPE)
	RETURN NUMBER
IS
	v_pay professor.pay%TYPE;
	v_bonus professor.bonus%TYPE;
	v_bonus2 NUMBER;
	v_tax NUMBER;
	v_payment NUMBER;
BEGIN
	SELECT pay, NVL(bonus,0)
	INTO v_pay, v_bonus
	FROM professor
	WHERE profno = f_profno;
	
	v_bonus2 := (v_pay + v_bonus)*0.5;
	v_tax := (v_pay + v_bonus + v_bonus2)*0.2;
	v_payment := v_pay + v_bonus + v_bonus2 - v_tax;

	RETURN v_payment;
END;
/

SQL> SELECT profno ������ȣ, name �̸�, position ����, wage(profno) ����
  2  FROM professor
  3  /

  ������ȣ �̸�                 ����                       ����
---------- -------------------- -------------------- ----------
      1001 Audie Murphy         a full professor            780
      1002 Angela Bassett       assistant professor         528
      1003 Jessica Lange        instructor                  324
      2001 Winona Ryder         instructor                  300
      2002 Michelle Pfeiffer    assistant professor         516
      2003 Whoopi Goldberg      a full professor            696
      3001 Emma Thompson        a full professor            768
      3002 Julia Roberts        assistant professor         456
      3003 Sharon Stone         instructor                  348
      4001 Meryl Streep         a full professor            840
      4002 Susan Sarandon       assistant professor         396
      4003 Nicole Kidman        assistant professor         432
      4004 Holly Hunter         instructor                  312
      4005 Meg Ryan             a full professor            696
      4006 Andie Macdowell      instructor                  264
      4007 Jodie Foster         assistant professor         384
      9998 JUN HAN              a full professor            780
      9999 ME RONG              a full professor            780


�� ���� ���� Ȱ��

CREATE OR REPLACE FUNCTION wage
	(v_pay professor.pay%TYPE,
	v_bonus professor.bonus%TYPE)
	RETURN NUMBER
IS
	v_bonus2 NUMBER;
	v_tax NUMBER;
	v_payment NUMBER;
BEGIN
	v_bonus2 := (v_pay + v_bonus)*0.5;
	v_tax := (v_pay + v_bonus + v_bonus2)*0.2;
	v_payment := v_pay + v_bonus + v_bonus2 - v_tax;

	RETURN v_payment;
END;
/

select profno, name, position, wage(pay, NVL(bonus,0))
from professor
/



�� Ʈ���� �α� ����� (delete�� ����!)

drop table emp2_log cascade constraint ;

CREATE TABLE EMP2_LOG (
 EMPNO       NUMBER  PRIMARY KEY,
 NAME        VARCHAR2(30) NOT NULL,
 BIRTHDAY    DATE,
 DEPTNO      VARCHAR2(06) NOT NULL,
 EMP_TYPE    VARCHAR2(30),
 TEL         VARCHAR2(15),
 HOBBY       VARCHAR2(30),
 PAY         NUMBER,
 POSITION    VARCHAR2(30),
 PEMPNO      NUMBER,
 o_DEPTNO      VARCHAR2(06) NOT NULL,
 o_PAY         NUMBER,
 o_POSITION    VARCHAR2(30),
 FLAG        CHAR(3) DEFAULT 'X'
);

CREATE OR REPLACE TRIGGER emp2_log_trigger
	after update or delete on emp2
	for each row
BEGIN
	if DELETING then
		insert into emp2_log(empno, name, birthday, deptno, emp_type, tel, hobby, pay, position, pempno, o_deptno, o_pay, o_position, flag)
		values (:old.empno, :old.name, :old.birthday, :old.deptno, :old.emp_type, :old.tel, :old.hobby, :old.pay, :old.position, :old.pempno, :old.deptno, :old.pay, :old.position, 'D');
	elsif UPDATING then
		insert into emp2_log(empno, name, birthday, deptno, emp_type, tel, hobby, pay, position, pempno, o_deptno, o_pay, o_position, flag)
		values (:old.empno, :old.name, :old.birthday, :new.deptno, :old.emp_type, :old.tel, :old.hobby, :new.pay, :new.position, :old.pempno, :old.deptno, :old.pay, :old.position, 'U');
	end if;
END;
/


INSERT INTO EMP2 VALUES (20000211,'Donald Trump',TO_DATE('19801215','YYYYMMDD'),'1005','Intern','031)345-3456','Reading book', 20000000,'',19960303);

UPDATE EMP2 SET deptno = '1004' WHERE empno = 20000211;

DELETE FROM EMP2 WHERE empno = 20000211;
