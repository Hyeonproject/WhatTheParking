<Ǯ �ƿ��� ����>

SELECT s.name, p.name
FROM student s FULL OUTER JOIN professor p
ON s.profno = p.profno
/


<250p. �μ���ȣ�� '20'�� ����� �����ȣ, �̸�, �޿��� �����ְ�, �ٸ� �μ��� ������ ����϶�>

SELECT e.empno, e.ename, e.sal, deptno
FROM emp e LEFT OUTER JOIN dept d
USING (deptno)
WHERE deptno = 20
/




<�й�, �̸�, �г�, �������� �̸� ��� ��, ���������� ���� �л��� ���>

SELECT s.studno �й�, s.name �л���, s.grade �г�, p.name ��������
FROM student s LEFT OUTER JOIN professor p
USING (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/


SELECT s.studno, s.name, s.grade, p.name ��������
FROM student s, professor p
WHERE s.profno = p.profno(+)
AND s.deptno1 IN (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/



<�й�, �̸�, �г�, �������� �̸� ��� ��, �����л��� ���� ������ ���>
=====WHERE�� �ȿ� d.deptno1�� �ƴ� p.deptno�� ���!!!=====

SELECT studno �й�, s.name �л���, grade �г�, p.name ����������
FROM student s RIGHT OUTER JOIN professor p
USING (profno)
WHERE p.deptno = (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/


SELECT s.studno, s.name, s.grade, p.name ��������
FROM student s, professor p
WHERE s.profno(+) = p.profno
AND p.deptno IN (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/


<���� �� ���� Ǯ �ƿ��� ���� ���>

SELECT s.studno, s.name, s.grade, p.name ��������
FROM student s FULL OUTER JOIN professor p
USING (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
OR p.deptno IN (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/


SELECT s.studno, s.name, s.grade, p.name ��������
FROM student s FULL OUTER JOIN professor p
USING (profno)
WHERE (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
IN (deptno1, p.deptno)
/


SELECT s.studno, s.name, s.grade, p.name ��������
FROM student s, professor p
WHERE s.profno = p.profno(+)
AND s.deptno1 IN (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
UNION
SELECT s.studno, s.name, s.grade, p.name ��������
FROM student s, professor p
WHERE s.profno(+) = p.profno
AND p.deptno IN (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/

<10�� �μ��� ����̸�, ��å, ����, ����̸��� ���>


��KING�� ����� ���� �ʴ´�
SELECT e1.ename ����̸�, e1.job ��å, e1.sal ����, e2.ename ���
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.deptno = 10
/


��KING�� ����� �ǰ� �غ���!
SELECT e1.ename ����̸�, e1.job ��å, e1.sal ����, e2.ename ���
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.deptno = 10
/


<255p. �μ���ȣ, �μ��̸�, �ҼӸ� ���. ��, �������п� �Ҽӵ� �кθ� (�������е� ����)>

SELECT d1.deptno �μ���ȣ, d1.dname �μ��̸�, d2.dname �ҼӸ�
FROM department d1 JOIN department d2
ON d1.part = d2.deptno
WHERE (SELECT deptno FROM department WHERE dname='��������') IN (d1.part, d2.part)
/














