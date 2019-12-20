※ PL/SQL 활성화 (필수!!!)

SET SERVEROUTPUT ON;


※ 예외처리 617p

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
	DBMS_OUTPUT.PUT_LINE(vdname||' 학생의 수는 '||vcount||'명 입니다.');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('해당 학과가 없습니다.');
END ;
/

EXEC count_dept('할로윈과');		//예외처리
EXEC count_dept('컴퓨터공학과');


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

	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('이름 : '||vname);
	DBMS_OUTPUT.PUT_LINE('월급 : '||vpay);
	DBMS_OUTPUT.PUT_LINE('수당 : '||vbonus);
	DBMS_OUTPUT.PUT_LINE('세금 : '||vtax);
	DBMS_OUTPUT.PUT_LINE('지급액 :'||vpayment);
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('해당 교수번호가 없습니다.');
END ;
/

EXEC display_salary(1001);


















