※ PL/SQL 활성화 (필수!!!)

SET SERVEROUTPUT ON;


※ 학과이름을 입력하여 월급, 수당, 세금, 지급액 출력 (실기 시험문제 1번!!!) FOR사용
-- Stored procedure 라고 함.

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

	DBMS_OUTPUT.PUT_LINE('이름 : ' || prof_rec.name ||' 월급 : ' || prof_rec.pay||' 수당 : '||prof_rec.bonus
        ||' 세금 : ' || vtax || ' 지급액 : ' || vpayment);
	END LOOP;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('해당 학과는 존재하지않습니다.');
END;
/

EXEC display_prof('컴퓨터공학과')


※ 628p. FUNCTION 기능

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


※ 세금명세서를 FUNCTION을 이용하여 출력 1 (비추천)
(커서는 값의 결과가 여러개일때만 사용!)

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
      DBMS_OUTPUT.PUT_LINE('해당 교수는 존재하지않습니다.');
END;
/

SELECT name 이름, pay 월급, NVL(bonus,0) 수당, tax(profno) 세금,
	(pay+NVL(bonus,0))-tax(profno) 지급액
FROM professor
/


※ 세금명세서를 FUNCTION을 이용하여 출력 2 (추천)

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

SELECT name 이름, pay 월급, NVL(bonus,0) 수당, tax(pay, NVL(bonus,0)) 세금,
	(pay+NVL(bonus,0))-tax(pay, NVL(bonus,0)) 지급액
FROM professor
/


※ 이미 존재하는 오브젝트일 경우 삭제해주고 만들어주자!

DROP procedure tax;


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


※ 








