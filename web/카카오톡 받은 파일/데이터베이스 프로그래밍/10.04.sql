<조인의 다양한 방법>

SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
/

SELECT e.empno, e.ename, d.dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno
/

SELECT empno, ename, dname
FROM emp NATURAL JOIN dept
/

<위의 3가지를 이용해 부서가 시카고에 있는 사원정보>

SELECT e.empno, e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.loc='CHICAGO'
/

SELECT e.empno, e.ename, d.dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE d.loc='CHICAGO'
/

SELECT empno, ename, dname
FROM emp NATURAL JOIN dept
WHERE loc='CHICAGO'
/


<238p. 예제 3 학생이름,학년,학과명,교수이름 출력 USING사용>

SELECT s.name 학생이름, s.grade 학년, d.dname 학과명, p.name 교수이름
FROM student s JOIN department d
ON s.deptno1 = d.deptno
JOIN professor p
USING  (profno)
ORDER BY 학과명
/


<239p. 예제 4 컴퓨터공학과 학생들의 이름,학년,지도교수이름 출력>

SELECT s.name 학생이름, s.grade 학년, p.name 교수이름
FROM student s JOIN professor p
USING  (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
ORDER BY 학년
/


<241p. 예제 1>

SELECT c.gname 고객이름, TO_CHAR(c.point, '999,999') 포인트, g.gname 선물이름
FROM gogak c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end
/

SELECT c.gname 고객이름, TO_CHAR(c.point, '999,999') 포인트, g.gname 선물이름
FROM gogak c JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end
/

<243p. 숙제 학번, 이름, 점수, 학점 출력> ==USING으로 참조한 칼럼은 앞에 테이블 명시X

SELECT studno 학번, s.name 이름, e.total 점수, h.grade 학점
FROM student s JOIN exam_01 e USING (studno)
		JOIN hakjum h
		ON e.total BETWEEN h.min_point AND h.max_point
/

↓이렇게 하면 틀린 것!
SELECT s.studno 학번, s.name 이름, e.total 점수, h.grade 학점
FROM student s JOIN exam_01 e USING (studno)
		JOIN hakjum h
		ON e.total BETWEEN h.min_point AND h.max_point
/



