CREATE OR REPLACE PROCEDURE ccccc
	(p_college department.dname%TYPE)
IS
	v_deptno department.deptno%TYPE;
	v_max_height student.height%TYPE;
	CURSOR c1 IS
		SELECT deptno, dname
		FROM department
		WHERE part = v_deptno;
	CURSOR c2(p_deptno department.deptno%TYPE) IS
		SELECT studno, name, grade, height, deptno, dname, part
		FROM student JOIN department ON (deptno1 = deptno)
		WHERE substr(jumin, 7, 1) = '2'
                  AND part = p_deptno;
BEGIN
	SELECT deptno INTO v_deptno
	FROM department
	WHERE dname = p_college;
	FOR v_rec1 IN c1
		LOOP
			SELECT MAX(height) INTO v_max_height
			FROM student
			WHERE deptno1 IN (SELECT deptno
                                          FROM department
                                          WHERE part = v_rec1.deptno)
                          AND substr(jumin, 7, 1) = '2';
			DBMS_OUTPUT.PUT_LINE(v_rec1.dname);
			FOR v_rec2 IN c2(v_rec1.deptno)
				LOOP
					IF (v_rec2.height = v_max_height) THEN
                   				DBMS_OUTPUT.PUT_LINE(v_rec2.studno || ' ' || v_rec2.name || ' ' || v_rec2.grade || ' ' || v_rec2.height || ' ' || v_rec2.deptno || ' ' || v_rec2.dname);
					END IF;
				END LOOP;
		END LOOP;
END;
/











CREATE OR REPLACE PROCEDURE ppppp
   (p_college department.dname%TYPE)
IS
   v_college_no department.deptno%TYPE;
   CURSOR c1 IS
           SELECT DISTINCT position
           FROM professor;
   CURSOR c2(p_position professor.position%TYPE) IS
   SELECT name, position, dname, pay+NVL(bonus, 0) sal
   FROM professor NATURAL JOIN department
   WHERE position = p_position
     AND deptno IN (SELECT deptno
                                 FROM department
                                 WHERE part IN (SELECT deptno
                                                FROM department
                                                WHERE part = v_college_no))
   ORDER BY sal DESC;
BEGIN
   SELECT deptno INTO v_college_no
   FROM department
   WHERE dname = p_college;
   FOR v_rec1 IN c1
           LOOP
                   DBMS_OUTPUT.PUT_LINE(v_rec1.position);
              FOR v_rec2 IN c2(v_rec1.position)
                           LOOP
                   DBMS_OUTPUT.PUT_LINE(v_rec2.name || ' ' || v_rec2.position || ' ' || v_rec2.dname || ' ' || v_rec2.sal);
END LOOP;
           END LOOP;
END;
