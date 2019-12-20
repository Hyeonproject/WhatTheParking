※ PL/SQL 활성화 (필수!!!)

SET SERVEROUTPUT ON;


※ DECLARE 이용해서 학번이 9411인 학생의 학번, 이름을 검색하여 출력 557p

DECLARE
	vstudno NUMBER(4);
	vname VARCHAR2(15);
BEGIN
	SELECT studno, name INTO vstudno, vname
	FROM student
	WHERE studno = 9411;
	
	DBMS_OUTPUT.PUT_LINE('===== 결과 =====');
	DBMS_OUTPUT.PUT_LINE('학번 : '||vstudno||' 이름: '||vname);
END ;
/


===== 결과 =====
학번 : 9411 이름: 서진수


※ 프로시저 (PROCEDURE) 625p

CREATE OR REPLACE PROCEDURE display_name
	(vstudno NUMBER)
IS
	vname VARCHAR2(15);
BEGIN
	SELECT name INTO vname
	FROM student
	WHERE studno = vstudno;
	
	DBMS_OUTPUT.PUT_LINE('===== 결과 =====');
	DBMS_OUTPUT.PUT_LINE('학번 : '||vstudno||' 이름: '||vname);
END ;
/

show errors;			//에러 내용 보기

EXEC display_name(9411);	//실행문
EXEC display_name(9412);


※ 참조변수를 이용 (%TYPE 무조건 사용!)

CREATE OR REPLACE PROCEDURE display_name
	(vstudno student.studno%TYPE)
IS
	vname student.name%TYPE;
BEGIN
	SELECT name INTO vname
	FROM student
	WHERE studno = vstudno;
	
	DBMS_OUTPUT.PUT_LINE('===== 결과 =====');
	DBMS_OUTPUT.PUT_LINE('학번 : '||vstudno||' 이름: '||vname);
END ;
/

EXEC display_name(9411);


※ '컴퓨터공학과'를 입력하여 학생의 수를 출력 (서브쿼리, 조인사용 X)

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
	
	DBMS_OUTPUT.PUT_LINE('========== 결과 ==========');
	DBMS_OUTPUT.PUT_LINE(vdname||' 학생의 수는 '||vcount||'명 입니다.');
END ;
/

EXEC count_dept('컴퓨터공학과');
EXEC count_dept('소프트웨어공학과');
EXEC count_dept('전기공학과');	//없는 학과이기 때문에 0명이 아닌 오류가 떠야 정상!
				//예외처리가 필요하다
