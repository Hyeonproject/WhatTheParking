<120p 4�������� case������ ��ȯ>

SELECT name, tel,
	CASE(SUBSTR(tel,1,INSTR(tel,')')-1)) WHEN '055' THEN '����'
					WHEN '02' THEN '����'
					WHEN '031' THEN '���'
					WHEN '051' THEN '�λ�'
					WHEN '052' THEN '���'
					WHEN '053' THEN '�뱸'
						ELSE 'ETC'
	END "LOC"
FROM student
WHERE deptno1 IN (SELECT deptno
		FROM department
		WHERE part IN (SELECT deptno 
			FROM department 
			WHERE dname='��ǻ�������к�'))
ORDER BY name
/

NAME                           TEL                            LOC
------------------------------ ------------------------------ ------------
��ſ�                         055)333-6328                   ����
������                         055)423-9870                   ����
������                         055)488-2998                   ����
�����                         051)426-1700                   �λ�
������                         055)381-2158                   ����
������                         051)418-9627                   �λ�
�̹̰�                         053)266-8947                   �뱸
������                         055)278-3649                   ����
������                         02)6788-4861                   ����
���                           02)6122-2345                   ����


<123p ����1�� ������ �̸�, ����, ���ʽ�, ���� ���>
�� �������� ���ʽ�, ���� ���

SELECT name, pay, NVL(bonus,0) bonus,
	CASE 	WHEN (pay*12)+(NVL(bonus,0)*6) <= 4500 THEN (((pay*12)+(NVL(bonus,0)*6))*0.15)/12
		WHEN (pay*12)+(NVL(bonus,0)*6) <= 8800 THEN (((pay*12)+(NVL(bonus,0)*6))*0.24)/12
		ELSE (((pay*12)+(NVL(bonus,0)*6))*0.35)/12
	END "����"
from professor
/


NAME                                  PAY      BONUS       ����
------------------------------ ---------- ---------- ----------
������                                550        100        144
�ڽ°�                                380         60       98.4
�۵���                                270          0       40.5
�缱��                                250          0       37.5
�迵��                                350         80       93.6
�ֽ���                                490         90      128.4
�赵��                                530        110      140.4
���ѿ�                                330         50      53.25
������                                290          0       43.5
�ɽ�                                  570        130      152.4
�ֽ���                                330          0       49.5
�ڿ���                                310         50      50.25
����ö                                260          0         39
�ٺ�                                  500         80      129.6
����                                  220          0         33
����                                  290         30      45.75


SELECT name, pay, NVL(bonus,0) bonus,
	CASE WHEN ((pay*12)+(bonus*6)) <= 4500 THEN (((pay*12)+(NVL(bonus,0)*6))*0.15)/12
		WHEN ((pay*12)+(bonus*6)) <= 8800 THEN (((pay*12)+(NVL(bonus,0)*6))*0.24)/12
		ELSE (((pay*12)+NVL(bonus,0)*6))*0.35)/12
	END tax
from professor
/




<162p ���� 1��>

SELECT d.dname"�μ���",
	SUM(sal+NVL(comm,0))"�ΰǺ�",
	ROUND(AVG(sal+NVL(comm,0)),2)"���"
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
ORDER BY ��� DESC
/


��� ���� ���ι��, ���!!!
SELECT dname"�μ���",
	SUM(sal+NVL(comm,0))"�ΰǺ�",
	ROUND(AVG(sal+NVL(comm,0)),2)"���"
FROM emp NATURAL JOIN dept
GROUP BY dname
ORDER BY ��� DESC
/


��ٸ����, comm�� 0�� �ִ� ����� �־ ������ �� �� �ʿ�
SELECT d.dname"�μ���",
	SUM(sal+NVL(DECODE(comm,0,null,comm),0))"�ΰǺ�",
	ROUND(AVG(sal+(NVL(DECODE(comm,0,null,comm),0))),2)"���"
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
ORDER BY ��� DESC
/

�μ���                           �ΰǺ�       ���
---------------------------- ---------- ----------
ACCOUNTING                         8750    2916.67
RESEARCH                          10875       2175
SALES                             11600    1933.33





