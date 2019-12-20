<������ �پ��� ���>

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

<���� 3������ �̿��� �μ��� ��ī�� �ִ� �������>

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


<238p. ���� 3 �л��̸�,�г�,�а���,�����̸� ��� USING���>

SELECT s.name �л��̸�, s.grade �г�, d.dname �а���, p.name �����̸�
FROM student s JOIN department d
ON s.deptno1 = d.deptno
JOIN professor p
USING  (profno)
ORDER BY �а���
/


<239p. ���� 4 ��ǻ�Ͱ��а� �л����� �̸�,�г�,���������̸� ���>

SELECT s.name �л��̸�, s.grade �г�, p.name �����̸�
FROM student s JOIN professor p
USING  (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
ORDER BY �г�
/


<241p. ���� 1>

SELECT c.gname ���̸�, TO_CHAR(c.point, '999,999') ����Ʈ, g.gname �����̸�
FROM gogak c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end
/

SELECT c.gname ���̸�, TO_CHAR(c.point, '999,999') ����Ʈ, g.gname �����̸�
FROM gogak c JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end
/

<243p. ���� �й�, �̸�, ����, ���� ���> ==USING���� ������ Į���� �տ� ���̺� ���X

SELECT studno �й�, s.name �̸�, e.total ����, h.grade ����
FROM student s JOIN exam_01 e USING (studno)
		JOIN hakjum h
		ON e.total BETWEEN h.min_point AND h.max_point
/

���̷��� �ϸ� Ʋ�� ��!
SELECT s.studno �й�, s.name �̸�, e.total ����, h.grade ����
FROM student s JOIN exam_01 e USING (studno)
		JOIN hakjum h
		ON e.total BETWEEN h.min_point AND h.max_point
/



