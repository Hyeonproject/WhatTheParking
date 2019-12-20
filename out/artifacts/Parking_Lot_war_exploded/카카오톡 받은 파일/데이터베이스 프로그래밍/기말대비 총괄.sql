※ PL/SQL 활성화 (필수!!!)

SET SERVEROUTPUT ON;


※ DECLARE 이용해서 학번이 9411인 학생의 학번, 이름을 검색하여 출력 557p

DECLARE
	vstudno NUMBER(4);
	vname VARCHAR2(15);
BEGIN
	SELECT studno, name
	INTO vstudno, vname
	FROM student
	WHERE studno = 9411;
	
	DBMS_OUTPUT.PUT_LINE('===== 결과 =====');
	DBMS_OUTPUT.PUT_LINE('학번 : '||vstudno||' 이름: '||vname);
END ;
/

===== 결과 =====
학번 : 9411 이름: 서진수


※ 프로시저 (PROCEDURE)

CREATE OR REPLACE PROCEDURE display_name
	(vstudno student.studno%TYPE)
IS
	vname student.name%TYPE;
BEGIN
	SELECT name
	INTO vname
	FROM student
	WHERE studno = vstudno;
	
	DBMS_OUTPUT.PUT_LINE('===== 결과 =====');
	DBMS_OUTPUT.PUT_LINE('학번 : '||vstudno||' 이름: '||vname);
END ;
/

EXEC display_name(9411);

===== 결과 =====
학번 : 9411 이름: 서진수


※ '컴퓨터공학과'를 입력하여 학생의 수를 출력, 예외처리 617p

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
	
	DBMS_OUTPUT.PUT_LINE('===== 결과 =====');
	DBMS_OUTPUT.PUT_LINE(vdname||' 학생의 수는 '||vcount||'명 입니다.');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('해당 학과가 없습니다.');
END ;
/

EXEC count_dept('할로윈과');		//예외처리
EXEC count_dept('컴퓨터공학과');

===== 결과 =====
컴퓨터공학과 학생의 수는 4명 입니다.


※ 교수번호를 입력해서 교수이름, 월급, 수당, 세금, 지급액 출력

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

	DBMS_OUTPUT.PUT_LINE('===== 결과 =====');
	DBMS_OUTPUT.PUT_LINE('이름 : '||vname);
	DBMS_OUTPUT.PUT_LINE('월급 : '||vpay);
	DBMS_OUTPUT.PUT_LINE('수당 : '||vbonus);
	DBMS_OUTPUT.PUT_LINE('세금 : '||vtax);
	DBMS_OUTPUT.PUT_LINE('지급액 :'||vpayment);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('해당 교수번호가 없습니다.');
END ;
/

EXEC display_salary(1001);

===== 결과 =====
이름 : 조인형
월급 : 550
수당 : 100
세금 : 156
지급액 :494


※ 커서를 이용하여 해당부서의 사원정보 출력

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
		DBMS_OUTPUT.PUT_LINE('번호 : '||vempno||' 이름: '||vename||' 직업: '||vjob||' 연봉: '||vsal);
	END LOOP;
	CLOSE c1;
END;
/

EXEC display_emp(30);

번호 : 7499 이름: ALLEN 직업: SALESMAN 연봉: 1600
번호 : 7521 이름: WARD 직업: SALESMAN 연봉: 1250
번호 : 7654 이름: MARTIN 직업: SALESMAN 연봉: 1250
번호 : 7698 이름: BLAKE 직업: MANAGER 연봉: 2850
번호 : 7844 이름: TURNER 직업: SALESMAN 연봉: 1500
번호 : 7900 이름: JAMES 직업: CLERK 연봉: 950


※ 학과이름을 입력하여 월급, 수당, 세금, 지급액 출력 (시험문제!!!) FETCH사용 (패치사용)

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

	DBMS_OUTPUT.PUT_LINE('이름 : '||vname||' 월급 : '||vpay||' 수당 : '||vbonus||
				' 세금 : '||vtax||' 지급액 :'||vpayment);

	END LOOP;
	CLOSE c1;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('해당 학과가 없습니다.');
END ;
/

EXEC display_prof('Computer Engineering');

이름 : 조인형 월급 : 550 수당 : 100 세금 : 156 지급액 :494
이름 : 박승곤 월급 : 380 수당 : 60 세금 : 105.6 지급액 :334.4
이름 : 송도권 월급 : 270 수당 : 0 세금 : 40.5 지급액 :229.5


※ 학과이름을 입력하여 월급, 수당, 세금, 지급액 출력 (실기 시험문제!!!) FOR사용

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

	DBMS_OUTPUT.PUT_LINE('이름 : ' || prof_rec.name ||' 월급 : ' || prof_rec.pay||' 수당 : '||prof_rec.bonus
        ||' 세금 : ' || vtax || ' 지급액 : ' || vpayment);
	END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('해당 학과는 존재하지않습니다.');
END;
/

EXEC display_prof('Computer Engineering')

이름 : 조인형 월급 : 550 수당 : 100 세금 : 156 지급액 : 494
이름 : 박승곤 월급 : 380 수당 : 60 세금 : 105.6 지급액 : 334.4
이름 : 송도권 월급 : 270 수당 : 0 세금 : 40.5 지급액 : 229.5


※ FUNCTION을 이용하여 부서별 최고월급 출력

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

SELECT dname 부서이름 , max_sal(deptno) 최고월급
FROM dept
WHERE deptno IN (SELECT DISTINCT deptno FROM emp)
/

부서이름                       최고월급
---------------------------- ----------
ACCOUNTING                         5000
RESEARCH                           5000
SALES                              2850


※ 세금명세서를 FUNCTION을 이용하여 출력

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
      DBMS_OUTPUT.PUT_LINE('해당 교수는 존재하지않습니다.');
END;
/

SELECT name 이름, pay 월급, bonus 수당, tax(pay, NVL(bonus,0)) 세금,
	(pay+NVL(bonus,0))-tax(pay, NVL(bonus,0)) 지급액
FROM professor
/

이름                                 월급       수당       세금     지급액
------------------------------ ---------- ---------- ---------- ----------
조인형                                550        100        156        494
박승곤                                380         60      105.6      334.4
송도권                                270                  40.5      229.5
양선희                                250                  37.5      212.5
김영조                                350         80      103.2      326.8
주승재                                490         90      139.2      440.8
김도형                                530        110      153.6      486.4
나한열                                330         50         57        323
김현정                                290                  43.5      246.5
심슨                                  570        130        168        532
최슬기                                330                  49.5      280.5
박원범                                310         50         54        306
차범철                                260                    39        221
바비                                  500         80      139.2      440.8
전민                                  220                    33        187
허은                                  290         30         48        272


※ 1학년 학생들의 비만도를 구하여라. (학번이 아닌 키, 몸무게를 입력)
비만지수가 아닌 분류를 보여준다.

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
	   	WHEN (v_bmi < 18.5) THEN '저체중'
		WHEN (v_bmi < 23) THEN '정상'
		WHEN (v_bmi < 25) THEN '위험체중'
		WHEN (v_bmi < 30) THEN '1단계비만'
		ELSE '2단계비만'
		END;

	RETURN v_result;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('해당 학생은 존재하지않습니다.');
END;
/

SELECT name 이름, weight 몸무게, height 키, bmi(weight, height) 비만도
FROM student
WHERE grade = 1
/

이름                               몸무게         키 비만도
------------------------------ ---------- ---------- ---------------
이윤나                                 48        162 저체중
안은수                                 63        175 정상
인영민                                 69        173 위험체중
김주현                                 81        179 1단계비만
허우                                   51        163 정상


※ 트리거 (torder테이블 생성 후 사용하자)

CREATE TABLE torder
( no		NUMBER,
  ord_code	VARCHAR2(10),
  ord_date	DATE);

CREATE OR REPLACE TRIGGER t_order
	BEFORE INSERT ON torder
BEGIN
	IF (TO_CHAR(sysdate, 'HH24:MI') NOT BETWEEN '13:50' AND '14:00') THEN
		RAISE_APPLICATION_ERROR(-20100, '허용시간 아닙니다.');
	END IF;
END;
/

INSERT INTO torder VALUES (1, 'C100', SYSDATE);
INSERT INTO torder VALUES (2, 'C200', SYSDATE);
INSERT INTO torder VALUES (3, 'C300', SYSDATE);

DROP trigger t_order;
DROP table torder purge;


※ 트리거 2
(delete는 new가 없기 떄문에 첫번째 if문이 실행이 안된다.)

CREATE OR REPLACE TRIGGER t_order
	BEFORE insert or update on torder
	FOR EACH ROW
BEGIN
	IF (:new.ord_code) not in ('C100') THEN
		IF Updating THEN
			DBMS_OUTPUT.PUT_LINE(:old.ord_code);
		END IF;
		RAISE_APPLICATION_ERROR(-20200, '제품코드가 틀립니다.');
	END IF;
END;
/

INSERT INTO torder VALUES (2, 'C100', SYSDATE);
INSERT INTO torder VALUES (3, 'C300', SYSDATE);
UPDATE torder set ord_code = 'c200' WHERE no = 2;


※ 트리거 이용하여 로그 남기기

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


※ emp2 테이블 참조해서 AL pacino를 지운고 난뒤, 1000번의 부서 사람 수는 1명입니다를 출력
(insert한 후는 다시 2명이 되게해라)
(안됌~!~!~!~!)

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

	DBMS_OUTPUT.PUT_LINE(v_deptno || '번 부서의 인원 수 : ' || v_count);
END;
/


DELETE FROM EMP2 WHERE name = 'AL Pacino';

INSERT INTO EMP2 VALUES (19960101,'AL Pacino',TO_DATE('19730322','YYYYMMDD'),'1000','Permanent employee','02)6255-8000','reading',72000000,'Department head',19900101);


※ 대학이름을 입력하여 '학부'별로 키가 가장 큰 여학생들을 찾아서 학부명, 학번, 이름, 학년, 키, 학과명을 출력하라
(용지1번. 키가 제일 큰 학생부터 출력) 시험문제!!!

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
		DBMS_OUTPUT.PUT_LINE( stud_rec.studno ||' 학번 '|| stud_rec.name||' 이름 '|| v_max ||' 키 '|| stud_rec.dname||' 학과명 ' );
		END IF;
	END LOOP;
EXCEPTION
	WHEN  NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE(' 해당 번호는 없습니다.');
END;
/


SET SERVEROUTPUT ON 
EXEC display_stud2('College of Engineering');
EXEC display_stud2('College of Liberal Arts');
SET SERVEROUTPUT ON 
EXEC display_stud2('공과대학');
EXEC display_stud2('인문대학');

=====결과=====
9513 학번 오나라 이름 177 키 기계공학과 학과명
9413 학번 이미경 이름 168 키 소프트웨어공학과 학과명


※ 위의 문제 입력없이 학부별 키가 제일 큰 여학생들 출력


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
		DBMS_OUTPUT.PUT_LINE( stud_rec.studno ||' 학번 '|| stud_rec.name||' 이름 '|| v_max ||' 키 '|| stud_rec.dname||' 학과명 ' );
		END IF;
	END LOOP;
EXCEPTION
	WHEN  NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE(' 해당 번호는 없습니다.');
END;
/

EXEC display_stud;

=====결과=====
9513 학번 오나라 이름 177 키 기계공학과 학과명
9413 학번 이미경 이름 168 키 소프트웨어공학과 학과명
9514 학번 구유미 이름 160 키 문헌정보학과 학과명


※ 입력된 대학에 소속된 '직위'별 급여가 가장 많은 교수들을 출력
(용지2번) 시험문제!!!

CREATE OR REPLACE PROCEDURE display_sal
	(v_college department.dname%TYPE)
IS
	v_max NUMBER;
	v_deptno department.deptno%TYPE;
CURSOR c1 IS
	SELECT name, position, d1.dname 학과, pay+NVL(bonus,0) 급여
	FROM professor
	JOIN department d1 USING (deptno)
	JOIN department d2 ON (d1.part = d2.deptno)
	WHERE d2.part = v_deptno
	ORDER BY 급여 DESC;
BEGIN
	SELECT deptno INTO v_deptno
	FROM department
	WHERE dname = v_college;

	FOR prof_rec IN c1
	LOOP
		SELECT MAX(pay+NVL(bonus,0)) INTO v_max
		FROM professor
		WHERE position = prof_rec.position;

		IF (v_max = prof_rec.급여) THEN	
			v_max := v_max*10000;
			DBMS_OUTPUT.PUT_LINE('이름 : '|| prof_rec.name || ' 직급명 : '|| prof_rec.position || ' 학과명 : '|| prof_rec.학과 || ' 급여 : '|| v_max);
		END IF; 
	END LOOP;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('해당 학과는 존재하지않습니다.');
END;
/

EXEC display_sal('공과대학');

=====결과=====
이름 : 심슨 직급명 : 정교수 학과명 : 전자공학과 급여 : 7000000
이름 : 박승곤 직급명 : 조교수 학과명 : 컴퓨터공학과 급여 : 4400000
이름 : 김현정 직급명 : 전임강사 학과명 : 소프트웨어공학과 급여 : 2900000


※ FUNCTION (e.* 조심!!!)


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
as (	SELECT studno, studname, grade, toeic, favg(korean,english,math) 평균성적
	FROM STUDENT2018)
SELECT e.*, ftotal(평균성적, toeic) 총점
FROM e
ORDER BY 총점 DESC
/


※ Anonymous Procedure 구구단 2단 (레포트 1번)

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


※ Stored 함수 세금, 지급액 출력 (레포트 2번)


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
		DBMS_OUTPUT.PUT_LINE('해당 사원은 존재하지않습니다.');
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
		DBMS_OUTPUT.PUT_LINE('해당 사원은 존재하지않습니다.');
END;
/

Function created.

SQL> SELECT empno 사원번호, ename 이름, sal 월급, comm 수당, tax(empno) 세금, payment(empno) 지급액
  2  FROM emp
  3  /

  사원번호 이름                       월급       수당       세금     지급액
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


※ Stored Procedure 모든 학생들의 정보 출력


CREATE OR REPLACE PROCEDURE display_student

IS

CURSOR c1 IS
	SELECT studno, name, grade, DECODE(SUBSTR(jumin,7,1),1,'남자','여자') sex,
	TO_CHAR(sysdate, 'YYYY') - TO_CHAR(birthday, 'YYYY') age, d.dname department
	FROM student s JOIN department d
	ON s.deptno1 = d.deptno;
BEGIN
	FOR prof_rec IN c1
	LOOP
		DBMS_OUTPUT.PUT_LINE('학번 : ' ||prof_rec.studno||' 이름 : '||prof_rec.name||' 학년 : '||prof_rec.grade
		||' 성별 : '||prof_rec.sex||' 나이 : '||prof_rec.age||' 학과명 : '||prof_rec.department);
	END LOOP;
END;
/

Procedure created.

SQL> EXEC display_student()
학번 : 9411 이름 : 서진수 학년 : 4 성별 : 남자 나이 : 43 학과명 : 컴퓨터공학과
학번 : 9412 이름 : 서재수 학년 : 4 성별 : 남자 나이 : 43 학과명 : 멀티미디어공학과
학번 : 9413 이름 : 이미경 학년 : 4 성별 : 여자 나이 : 43 학과명 : 소프트웨어공학과
학번 : 9414 이름 : 김재수 학년 : 4 성별 : 남자 나이 : 43 학과명 : 전자공학과
학번 : 9415 이름 : 박동호 학년 : 4 성별 : 남자 나이 : 43 학과명 : 기계공학과
학번 : 9511 이름 : 김신영 학년 : 3 성별 : 여자 나이 : 42 학과명 : 컴퓨터공학과
학번 : 9512 이름 : 신은경 학년 : 3 성별 : 여자 나이 : 42 학과명 : 멀티미디어공학과
학번 : 9513 이름 : 오나라 학년 : 3 성별 : 여자 나이 : 42 학과명 : 기계공학과
학번 : 9514 이름 : 구유미 학년 : 3 성별 : 여자 나이 : 42 학과명 : 문헌정보학과
학번 : 9515 이름 : 임세현 학년 : 3 성별 : 여자 나이 : 42 학과명 : 전자공학과
학번 : 9611 이름 : 일지매 학년 : 2 성별 : 남자 나이 : 41 학과명 : 컴퓨터공학과
학번 : 9612 이름 : 김진욱 학년 : 2 성별 : 남자 나이 : 41 학과명 : 멀티미디어공학과
학번 : 9613 이름 : 안광훈 학년 : 2 성별 : 남자 나이 : 41 학과명 : 전자공학과
학번 : 9614 이름 : 김문호 학년 : 2 성별 : 남자 나이 : 41 학과명 : 전자공학과
학번 : 9615 이름 : 노정호 학년 : 2 성별 : 남자 나이 : 41 학과명 : 문헌정보학과
학번 : 9711 이름 : 이윤나 학년 : 1 성별 : 여자 나이 : 40 학과명 : 컴퓨터공학과
학번 : 9712 이름 : 안은수 학년 : 1 성별 : 남자 나이 : 40 학과명 : 전자공학과
학번 : 9713 이름 : 인영민 학년 : 1 성별 : 남자 나이 : 40 학과명 : 전자공학과
학번 : 9714 이름 : 김주현 학년 : 1 성별 : 남자 나이 : 40 학과명 : 멀티미디어공학과
학번 : 9715 이름 : 허우 학년 : 1 성별 : 여자 나이 : 40 학과명 : 소프트웨어공학과


※ 학과를 받아 소속학과의 학생정보, 지도교수명 출력


CREATE OR REPLACE PROCEDURE display_student
	(v_dname department.dname%TYPE)
IS
	v_deptno department.deptno%TYPE;
CURSOR c1 IS
	SELECT studno, s.name, grade, DECODE(SUBSTR(jumin,7,1),1,'남자','여자') sex,
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
		DBMS_OUTPUT.PUT_LINE('학번 : ' ||prof_rec.studno||' 이름 : '||prof_rec.name||' 학년 : '||prof_rec.grade
		||' 성별 : '||prof_rec.sex||' 나이 : '||prof_rec.age||' 지도교수 : '||prof_rec.professor);
END LOOP;
END;
/

Procedure created.

SQL> EXEC display_student('컴퓨터공학과')
학번 : 9411 이름 : 서진수 학년 : 4 성별 : 남자 나이 : 43 지도교수 : 조인형
학번 : 9511 이름 : 김신영 학년 : 3 성별 : 여자 나이 : 42 지도교수 : 박승곤
학번 : 9611 이름 : 일지매 학년 : 2 성별 : 남자 나이 : 41 지도교수 : 박승곤
학번 : 9711 이름 : 이윤나 학년 : 1 성별 : 여자 나이 : 40 지도교수 :


※ 기말 대비 문제 1

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
	
	DBMS_OUTPUT.PUT_LINE(vdname || ' 학생은 총 ' || v_studcount || '명입니다.');

	FOR stud_rec IN c1
	LOOP
	DBMS_OUTPUT.PUT_LINE('학번 : ' || stud_rec.studno || ' 학생이름 : ' || stud_rec.name || ' 학년 : '|| stud_rec.grade);
	END LOOP;
	
	DBMS_OUTPUT.PUT_LINE(vdname || ' 교수는 총 ' || v_profcount || '명입니다.');	

	FOR prof_rec IN c2
	LOOP
	DBMS_OUTPUT.PUT_LINE('교수번호 : ' || prof_rec.profno || ' 교수이름 : ' || prof_rec.name || ' 직급 : '|| prof_rec.position);
	END LOOP;	

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('해당 학과가 없습니다.');
END ;
/


SQL> EXEC pro_01('Computer Engineering');
Computer Engineering 학생은 총 4명입니다.
학번 : 9411 학생이름 : James Seo 학년 : 4
학번 : 9511 학생이름 : Billy Crystal 학년 : 3
학번 : 9611 학생이름 : Richard Dreyfus 학년 : 2
학번 : 9711 학생이름 : Danny Devito 학년 : 1
Computer Engineering 교수는 총 3명입니다.
교수번호 : 1001 교수이름 : Audie Murphy 직급 : a full professor
교수번호 : 1002 교수이름 : Angela Bassett 직급 : assistant professor
교수번호 : 1003 교수이름 : Jessica Lange 직급 : instructor

PL/SQL procedure successfully completed.


※ 기말 대비 문제 2

CREATE OR REPLACE TRIGGER t_count
	AFTER INSERT ON professor
	FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	v_deptno department.deptno%TYPE;
	v_dname department.dname%TYPE;
CURSOR c1 IS
	SELECT grade, count(*) 학생수
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
		DBMS_OUTPUT.PUT_LINE('학과명 : ' || v_dname || ' 학년 : ' || stud_rec.grade || ' 학생수 : ' || stud_rec.학생수);
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
학과명 : Computer Engineering 학년 : 1 학생수 : 1
학과명 : Computer Engineering 학년 : 2 학생수 : 1
학과명 : Computer Engineering 학년 : 3 학생수 : 1
학과명 : Computer Engineering 학년 : 4 학생수 : 1

1 row created.

SQL>
SQL> insert into professor
  2  values(9999,'ME RONG','ME','a full professor',550,to_date('1980-06-23','YYYY-MM-DD'),100,102,'captain@abc.net','http://www.abc.net');
학과명 : Multimedia Engineering 학년 : 1 학생수 : 1
학과명 : Multimedia Engineering 학년 : 2 학생수 : 1
학과명 : Multimedia Engineering 학년 : 3 학생수 : 1
학과명 : Multimedia Engineering 학년 : 4 학생수 : 1

1 row created.


※ 기말 대비 문제 3

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

SQL> SELECT profno 교수번호, name 이름, position 직급, wage(profno) 월급
  2  FROM professor
  3  /

  교수번호 이름                 직급                       월급
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


※ 위의 문제 활용

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



※ 트리거 로그 남기기 (delete시 오류!)

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
