※ PL/SQL 활성화 (필수!!!)

SET SERVEROUTPUT ON;


※ 대학이름을 입력하여 '학부'별로 키가 가장 큰 여학생들을 찾아라. (용지 1번)
학부명, 학번, 이름, 학년, 키, 학과명을 출력하라
(키가 제일 큰 학생부터 출력)

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

		IF(v_max=stud_rec.height ) THEN
		DBMS_OUTPUT.PUT_LINE( stud_rec.studno ||' 학번 '|| stud_rec.name||' 이름 '|| v_max ||' 키 '|| stud_rec.dname||' 학과명 ' );
		END IF;
	END LOOP;
EXCEPTION
	WHEN  NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE(' 해당 번호는 없습니다.');
END;
/


SET SERVEROUTPUT ON 
EXEC display_stud;


※ 용지 2번

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



※ 수습사원 문제를 FUNCTION으로 바꿔보자!





















