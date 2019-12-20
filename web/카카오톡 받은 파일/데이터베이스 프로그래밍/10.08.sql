<풀 아우터 조인>

SELECT s.name, p.name
FROM student s FULL OUTER JOIN professor p
ON s.profno = p.profno
/


<250p. 부서번호가 '20'인 사원의 사원번호, 이름, 급여를 보여주고, 다른 부서의 정보도 출력하라>

SELECT e.empno, e.ename, e.sal, deptno
FROM emp e LEFT OUTER JOIN dept d
USING (deptno)
WHERE deptno = 20
/




<학번, 이름, 학년, 지도교수 이름 출력 단, 지도교수가 없는 학생도 출력>

SELECT s.studno 학번, s.name 학생명, s.grade 학년, p.name 지도교수
FROM student s LEFT OUTER JOIN professor p
USING (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/


SELECT s.studno, s.name, s.grade, p.name 지도교수
FROM student s, professor p
WHERE s.profno = p.profno(+)
AND s.deptno1 IN (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/



<학번, 이름, 학년, 지도교수 이름 출력 단, 지도학생이 없는 교수도 출력>
=====WHERE문 안에 d.deptno1이 아닌 p.deptno를 사용!!!=====

SELECT studno 학번, s.name 학생명, grade 학년, p.name 지도교수명
FROM student s RIGHT OUTER JOIN professor p
USING (profno)
WHERE p.deptno = (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/


SELECT s.studno, s.name, s.grade, p.name 지도교수
FROM student s, professor p
WHERE s.profno(+) = p.profno
AND p.deptno IN (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/


<위의 두 문제 풀 아우터 조인 사용>

SELECT s.studno, s.name, s.grade, p.name 지도교수
FROM student s FULL OUTER JOIN professor p
USING (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
OR p.deptno IN (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/


SELECT s.studno, s.name, s.grade, p.name 지도교수
FROM student s FULL OUTER JOIN professor p
USING (profno)
WHERE (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
IN (deptno1, p.deptno)
/


SELECT s.studno, s.name, s.grade, p.name 지도교수
FROM student s, professor p
WHERE s.profno = p.profno(+)
AND s.deptno1 IN (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
UNION
SELECT s.studno, s.name, s.grade, p.name 지도교수
FROM student s, professor p
WHERE s.profno(+) = p.profno
AND p.deptno IN (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/

<10번 부서의 사원이름, 직책, 월급, 상관이름을 출력>


↓KING이 출력이 되지 않는다
SELECT e1.ename 사원이름, e1.job 직책, e1.sal 월급, e2.ename 상관
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.deptno = 10
/


↓KING이 출력이 되게 해보자!
SELECT e1.ename 사원이름, e1.job 직책, e1.sal 월급, e2.ename 상관
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.deptno = 10
/


<255p. 부서번호, 부서이름, 소속명 출력. 단, 공과대학에 소속된 학부만 (공과대학도 제외)>

SELECT d1.deptno 부서번호, d1.dname 부서이름, d2.dname 소속명
FROM department d1 JOIN department d2
ON d1.part = d2.deptno
WHERE (SELECT deptno FROM department WHERE dname='공과대학') IN (d1.part, d2.part)
/














