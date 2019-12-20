�� ������ �л��� ���� ���

select name, substr(jumin,3,4)"Birthday"
from student
where substr(jumin,7,1)=1
/

NAME                           Birthday
------------------------------ ------------
������                         1023
�����                         0224
�����                         1225
�ڵ�ȣ                         0303
������                         1129
������                         0402
�ȱ���                         0913
�蹮ȣ                         0226
����ȣ                         1214
������                         0105
�ο���                         0809
������                         0324


�� ������ �л��� ���� ��� (�ڼ��ϰ�)

select name, substr(jumin,3,2)||'�� '||substr(jumin,5,2)||'��'"Birthday"
from student
where substr(jumin,7,1)=1
/

NAME                           Birthday
------------------------------ ---------------
������                         10�� 23��
�����                         02�� 24��
�����                         12�� 25��
�ڵ�ȣ                         03�� 03��
������                         11�� 29��
������                         04�� 02��
�ȱ���                         09�� 13��
�蹮ȣ                         02�� 26��
����ȣ                         12�� 14��
������                         01�� 05��
�ο���                         08�� 09��
������                         03�� 24��


�� '��ǻ�������к�'�� �Ҽӵ� �а��̸� ���ڸ� 3�� ���

select SUBSTR(dname,1,3) "OUTPUT"
from department
where part = (select deptno from department where dname='��ǻ�������к�')
/

OUTPUT
------------------------
��ǻ��
��Ƽ��
����Ʈ


�� ������ 201���� �л��� ��ȭ��ȣ �� ������ȣ ���

select name, tel, SUBSTR(tel,1,INSTR(tel, ')')-1) "AREA CODE"
from student
where deptno1 = 201
/

NAME                           TEL                            AREA CODE
------------------------------ ------------------------------ --------------
�����                         02)6255-9875                   02
�Ӽ���                         02)312-9838                    02
�ȱ���                         053)736-4981                   053
�蹮ȣ                         02)6175-3945                   02
������                         02)381-5440                    02
�ο���                         031)345-5677                   031


�� '��ǻ���������к�'�� �Ҽӵ� �а��̸� ��3�ڸ� ���� �� ���

select REPLACE(dname, SUBSTR(dname,1,3),'') "OUTPUT"
from department
where part = (select deptno from department where dname='��ǻ�������к�')
/

OUTPUT
---------------------
���а�
�����а�
������а�


�� �л����� �̸�, ��ȭ��ȣ, ���� �κи� '*'�� ó���Ͽ� ���

SELECT name, tel,
REPLACE(tel, SUBSTR(tel, INSTR(tel, ')')+1,INSTR(tel,'-')-INSTR(tel, ')')-1),SUBSTR('****',1,INSTR(tel,'-')-INSTR(tel, ')')-1)) "OUTPUT"
FROM student
/

NAME                           TEL                            OUTPUT
------------------------------ ------------------------------ ---------------
������                         055)381-2158                   055)***-2158
�����                         051)426-1700                   051)***-1700
�̹̰�                         053)266-8947                   053)***-8947
�����                         02)6255-9875                   02)****-9875
�ڵ�ȣ                         031)740-6388                   031)***-6388
��ſ�                         055)333-6328                   055)***-6328
������                         051)418-9627                   051)***-9627
������                         051)724-9618                   051)***-9618
������                         055)296-3784                   055)***-3784
�Ӽ���                         02)312-9838                    02)***-9838
������                         02)6788-4861                   02)****-4861
������                         055)488-2998                   055)***-2998
�ȱ���                         053)736-4981                   053)***-4981
�蹮ȣ                         02)6175-3945                   02)****-3945
����ȣ                         051)785-6984                   051)***-6984
������                         055)278-3649                   055)***-3649
������                         02)381-5440                    02)***-5440
�ο���                         031)345-5677                   031)***-5677
������                         055)423-9870                   055)***-9870
���                           02)6122-2345                   02)****-2345


�� deptno�� 10���� ������� ����̸��� �� 9����Ʈ�� ����ϵ� ���ڸ����� ���ڷ� ä���� ���

select LPAD(ename,9,SUBSTR('123456789',1,9-lengthb(ename))) "OUTPUT"
from emp
where deptno = 10
/

OUTPUT
---------------
1234CLARK
12345KING
123MILLER


�� ���� �ð� ���

SELECT sysdate
FROM dual
/

SYSDATE
--------
18/10/20


�� ������� ������ �������� Ȯ��

SELECT sysdate - TO_DATE('2018/09/01', 'YYYY/MM/DD') "DATE"
FROM dual
/

      DATE
----------
49.6930093


�� ������ 1~6�� ������ �л� ���

select studno, name, birthday
from student
where TO_CHAR(birthday,'MM') BETWEEN 1 AND 6
/

    STUDNO NAME                           BIRTHDAY
---------- ------------------------------ --------
      9412 �����                         75/02/24
      9413 �̹̰�                         75/06/15
      9415 �ڵ�ȣ                         75/03/03
      9511 ��ſ�                         76/01/23
      9512 ������                         76/04/12
      9514 ������                         76/01/20
      9612 ������                         77/04/02
      9614 �蹮ȣ                         77/02/26
      9712 ������                         78/01/05
      9714 ������                         78/03/24
      9715 ���                           78/02/23


�� 1,2,3�� �߿� �Ի��� ��� ���

select empno, ename, hiredate
from emp
where TO_CHAR(hiredate,'MM') IN (1,2,3)
/

     EMPNO ENAME                HIREDATE
---------- -------------------- --------
      7499 ALLEN                81/02/20
      7521 WARD                 82/02/22
      7934 MILLER               82/01/23


�� ���ڿ� ǥ�õ��� �ʴ� ���ڴ� �ݿø��ؼ� ���

select TO_CHAR(12345.6789, '99,999.99') �ݿø�
from dual
/

�ݿø�
--------------------
 12,345.68


�� ��ȭ�� ǥ��

select TO_CHAR(12345.6789, 'L99999.999') ��ȭ
from dual
/

��ȭ
----------------------------------------
        ��12345.679


�� �޷�ȭ�� ǥ��

select TO_CHAR(12345.6789, '$99999.999') �޷�ȭ
from dual
/

�޷�ȭ
----------------------
 $12345.679


�� 'SALES'�μ��� ���� ������� ����, �λ� ���

SELECT empno, ename, TO_CHAR(hiredate,'RRRR-MM-DD') �Ի���,
	TO_CHAR((sal*12)+NVL(comm,0),'$999,999') ����,
	TO_CHAR(((sal*12)+NVL(comm,0))*1.15,'$999,999') "15% �λ�"
FROM emp
WHERE deptno = (SELECT deptno 
		FROM dept 
		WHERE dname='SALES')
/

     EMPNO ENAME                �Ի���               ����               15% �λ�
---------- -------------------- -------------------- ------------------ ------------------
      7499 ALLEN                1981-02-20             $19,500            $22,425
      7521 WARD                 1982-02-22             $15,500            $17,825
      7654 MARTIN               1981-09-28             $16,400            $18,860
      7698 BLAKE                1981-05-01             $34,200            $39,330
      7844 TURNER               1981-09-08             $18,000            $20,700
      7900 JAMES                1981-12-03             $11,400            $13,110


�� ������� comm�� ������ x2, ������ sal/2�� ���ʽ��� �ְ� ���� ���
(����, comm�� 0�� ������� �����ϴ� DECODE�� �̿��� NULL�� ��ȯ������)

SELECT empno, ename, sal, comm,
NVL2(DECODE(comm,0,null,comm), comm*2, sal/2) BONUS,
sal+NVL2(DECODE(comm,0,null,comm), comm*2, sal/2) TOTAL
FROM emp
/

     EMPNO ENAME                       SAL       COMM      BONUS      TOTAL
---------- -------------------- ---------- ---------- ---------- ----------
      7369 SMITH                       800                   400       1200
      7499 ALLEN                      1600        300        600       2200
      7521 WARD                       1250        500       1000       2250
      7566 JONES                      2975                1487.5     4462.5
      7654 MARTIN                     1250       1400       2800       4050
      7698 BLAKE                      2850                  1425       4275
      7782 CLARK                      2450                  1225       3675
      7788 SCOTT                      3000                  1500       4500
      7839 KING                       5000                  2500       7500
      7844 TURNER                     1500          0        750       2250
      7876 ADAMS                      1100                   550       1650
      7900 JAMES                       950                   475       1425
      7902 FORD                       3000                  1500       4500
      7934 MILLER                     1300                   650       1950


�� 101�� �����л� �� �ֹι�ȣ�� ���� ���� ���

select name, jumin, DECODE(SUBSTR(jumin,7,1),1,'����',2,'����',3,'����',4,'����')"Gender"
from student
where deptno1 = 101
/

NAME                           JUMIN                      Gender
------------------------------ -------------------------- ------------
������                         7510231901810              ����
��ſ�                         7601232186327              ����
������                         7711291186223              ����
������                         7808192157498              ����


�� 101�� �����л� �� ������ȣ�� ���� �ش����� ��� (����, ���ܸ� �׻� ����)

SELECT name, tel, DECODE(SUBSTR(tel,1,INSTR(tel, ')')-1),055,'����',
							02, '����',
							031,'���',
							051,'�λ�',
							052,'���',
							053,'�뱸','�׿�����')"LOC"
from student
where deptno1 = 101
/

NAME                           TEL                            LOC
------------------------------ ------------------------------ ------------------------
������                         055)381-2158                   ����
��ſ�                         055)333-6328                   ����
������                         02)6788-4861                   ����
������                         055)278-3649                   ����


�� '��ǻ�������к�'�� �Ҽӵ� �л����� ���� ���

SELECT name, jumin, DECODE(SUBSTR(jumin,7,1),1,'����','����') ����
FROM student
WHERE deptno1 IN (select deptno
		from department
		where part = (select deptno 
			from department 
			where dname='��ǻ�������к�'))
ORDER BY name
/

NAME                           JUMIN                      ����
------------------------------ -------------------------- ------------
��ſ�                         7601232186327              ����
������                         7803241981987              ����
������                         7704021358674              ����
�����                         7502241128467              ����
������                         7510231901810              ����
������                         7604122298371              ����
�̹̰�                         7506152123648              ����
������                         7808192157498              ����
������                         7711291186223              ����
���                           7802232116780              ����


�� '��ǻ�������к�'�� �Ҽӵ� �л����� ���� ���

SELECT name, tel, DECODE(SUBSTR(tel,1,INSTR(tel, ')')-1),055,'����',
							02, '����',
							031,'���',
							051,'�λ�',
							052,'���',
							053,'�뱸','�׿�����')"LOC"
FROM student
WHERE deptno1 IN (select deptno
		from department
		where part IN (select deptno 
			from department 
			where dname='��ǻ�������к�'))
ORDER BY name
/

NAME                           TEL                            LOC
------------------------------ ------------------------------ ------------------------
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


�� '��ǻ�������к�'�� �Ҽӵ� �л����� ���� ��� (CASE�� ���)

SELECT name, tel,
	CASE (SUBSTR(tel,1,INSTR(tel,')')-1))	 WHEN '055' THEN '����'
						WHEN '02' THEN '����'
						WHEN '031' THEN '���'
						WHEN '051' THEN '�λ�'
						WHEN '052' THEN '���'
						WHEN '053' THEN '�뱸'
						ELSE 'ETC'
	END "LOC"
FROM student
WHERE deptno1 IN (	SELECT deptno
			FROM department
			WHERE part IN (	SELECT deptno 
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


�� �μ���, �ΰǺ�, ��� ���

SELECT 	dname"�μ���",
	SUM(sal+NVL(comm,0))"�ΰǺ�",
	ROUND(AVG(sal+NVL(comm,0)),2)"���"
FROM emp NATURAL JOIN dept
GROUP BY dname
ORDER BY ��� DESC
/

�μ���                           �ΰǺ�       ���
---------------------------- ---------- ----------
ACCOUNTING                         8750    2916.67
RESEARCH                          10875       2175
SALES                             11600    1933.33

�� ������ ������ �μ��� ��ձ޿� ���

SELECT deptno, ROUND(AVG(sal+NVL(comm,0)),2) ��ձ޿�
FROM emp
WHERE job != 'PRESIDENT'
GROUP BY deptno
/

    DEPTNO   ��ձ޿�
---------- ----------
        30    1933.33
        20       2175
        10       1875


�� ������ ������ �μ��� ��ձ޿��� 2000�̻��� �μ� ���

SELECT deptno, ROUND(AVG(sal+NVL(comm,0)),2) ��ձ޿�
FROM emp
WHERE job <> 'PRESIDENT'
GROUP BY deptno
HAVING ROUND(AVG(sal+NVL(comm,0)),2) >= 2000
/

SELECT *
FROM (SELECT deptno, ROUND(AVG(sal+NVL(comm,0)),2) ��ձ޿�
	FROM emp
	WHERE job <> 'PRESIDENT'
	GROUP BY deptno)
WHERE ��ձ޿� >= 2000
/

with e
as (SELECT deptno, AVG(sal+NVL(comm,0)) ��ձ޿�
	FROM emp
	WHERE job <> 'PRESIDENT'
	GROUP BY deptno)
SELECT *
FROM e
WHERE ��ձ޿� >= 2000
/

    DEPTNO   ��ձ޿�
---------- ----------
        20       2175


�� ���л� ���Ű�� ���� ū �а��� �̸��� ���Ű ���

with e
as ( select deptno1, AVG(height) "AVG"
	from student
	where substr(jumin,7,1)=1
	group by deptno1)
select dname "�а���", AVG "���Ű"
from e JOIN department ON (deptno1=deptno)
where AVG=(select MAX(AVG) from e)
/

�鳻�� ���� (��ҹ��� ����!)
with e
as ( select deptno1 "DEPTNO", AVG(height)"AVG"
	from student
	where substr(jumin,7,1)=1
	group by deptno1)
select dname "�а���", AVG "���Ű"
from e NATURAL JOIN department
where AVG=(select max(AVG) from e)
/

DNAME                                                        MAX_AVG_HEIGHT
------------------------------------------------------------ --------------
���������а�                                                            184


�� �μ���, ������ �޿� ��� (GROUPING SETS ���) 168p.

SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(deptno, job, (deptno, job), ())
ORDER BY deptno, job
/

    DEPTNO JOB                       SAL
---------- ------------------ ----------
        10 CLERK                    1300
        10 MANAGER                  2450
        10 PRESIDENT                5000
        10                          8750
        20 ANALYST                  6000
        20 CLERK                    1900
        20 MANAGER                  2975
        20                         10875
        30 CLERK                     950
        30 MANAGER                  2850
        30 SALESMAN                 5600
        30                          9400
           ANALYST                  6000
           CLERK                    4150
           MANAGER                  8275
           PRESIDENT                5000
           SALESMAN                 5600
                                   29025


�� �μ���, ���޺��� �޿� �հ� ���

SELECT *
FROM (SELECT deptno, NVL(job, 'TOTAL') job, sum(sal) sal
	FROM emp
	GROUP BY CUBE(deptno,job))
PIVOT
(
	SUM(sal) FOR job IN ('CLERK' AS "CLERK",
				'MANAGER' AS "MANAGER",
				'PRESIDENT' AS "PRESIDENT",
				'ANALYST' AS "ANALYST",
				'SALESMAN' AS "SALESMAN",
				'TOTAL' AS "TOTAL")
)
ORDER BY deptno
/

    DEPTNO      CLERK    MANAGER  PRESIDENT    ANALYST   SALESMAN      TOTAL
---------- ---------- ---------- ---------- ---------- ---------- ----------
        10       1300       2450       5000                             8750
        20       1900       2975                  6000                 10875
        30        950       2850                             5600       9400
                 4150       8275       5000       6000       5600      29025


�� �����л��� ���� ������ ��ȣ, �̸� ���

with e
as (	SELECT profno
	FROM professor
	MINUS (	select profno
		from student))
SELECT profno, name
FROM e NATURAL JOIN professor
/

SELECT profno, name
FROM professor
WHERE profno IN (SELECT profno
		FROM professor
		MINUS (	SELECT profno
			FROM student))
/

    PROFNO NAME
---------- ------------------------------
      1003 �۵���
      2003 �ֽ���
      3001 �赵��
      3003 ������
      4004 ����ö
      4005 �ٺ�
      4006 ����


�� USING�� �̿��Ͽ� ���̺�2�� ����

SELECT s.name �л��̸�, s.grade �г�, p.name �����̸�
FROM student s JOIN professor p
USING  (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
ORDER BY �г�
/

�л��̸�              �г� �����̸�
--------------- ---------- ------------------------------
������                   2 �ڽ°�
��ſ�                   3 �ڽ°�
������                   4 ������


�� USING�� �̿��Ͽ� ���̺�3�� ����

SELECT s.name �л��̸�, s.grade �г�, d.dname �а���, p.name �����̸�
FROM student s JOIN department d
ON s.deptno1 = d.deptno
JOIN professor p
USING  (profno)
ORDER BY �а���
/

�л��̸�              �г� �а���               �����̸�
--------------- ---------- -------------------- ------------------------------
�ڵ�ȣ                   4 �����а�           �ڿ���
������                   3 �����а�           �ڿ���
������                   2 ��Ƽ�̵����а�     �缱��
�����                   4 ��Ƽ�̵����а�     �缱��
������                   3 ��Ƽ�̵����а�     �迵��
������                   3 ���������а�         ����
����ȣ                   2 ���������а�         ����
�̹̰�                   4 ����Ʈ������а�     ���ѿ�
�ȱ���                   2 ���ڰ��а�           �ֽ���
�����                   4 ���ڰ��а�           �ɽ�
�Ӽ���                   3 ���ڰ��а�           �ɽ�
�蹮ȣ                   2 ���ڰ��а�           �ڿ���
������                   4 ��ǻ�Ͱ��а�         ������
��ſ�                   3 ��ǻ�Ͱ��а�         �ڽ°�
������                   2 ��ǻ�Ͱ��а�         �ڽ°�


�� ���� ����Ʈ�� ���� ������Ʈ ���

SELECT c.gname ���̸�, TO_CHAR(c.point, '999,999') ����Ʈ, g.gname �����̸�
FROM gogak c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end
/

SELECT c.gname ���̸�, TO_CHAR(c.point, '999,999') ����Ʈ, g.gname �����̸�
FROM gogak c JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end
/

���̸�                       ����Ʈ           �����̸�
------------------------------ ---------------- ------------------------------------
�����                           65,000         ��ġ��Ʈ
�����                           73,000         ��ġ��Ʈ
������                           99,000         ��ġ��Ʈ
�ּ���                          110,000         ��Ǫ��Ʈ
��ſ�                          153,000         ��Ǫ��Ʈ
�ڵ�ȣ                          180,000         ��Ǫ��Ʈ
�Ӽ���                          265,000         ������ǰ��Ʈ
������                          273,000         ������ǰ��Ʈ
��ȯ                          298,000         ������ǰ��Ʈ
������                          315,000         �ֹ��ǰ��Ʈ
�̹̰�                          320,000         �ֹ��ǰ��Ʈ
����ȣ                          420,000         ��ǿ�������
�ȱ���                          470,000         ��ǿ�������
�輳��                          542,000         LCD�����
������                          598,000         LCD�����
������                          625,000         ��Ʈ��
�ο���                          670,000         ��Ʈ��
���                            730,000         ������TV
������                          770,000         ������TV
������                          980,000         ���ʹ������


�� ������ ���� ���� ���
(����, USING�� ����� �÷��տ� ���̺�� �ȉ�! �������, s.studno ����!)

SELECT studno �й�, s.name �̸�, e.total ����, h.grade ����
FROM student s JOIN exam_01 e USING (studno)
		JOIN hakjum h
		ON e.total BETWEEN h.min_point AND h.max_point
/

      �й� �̸�                                 ���� ����
---------- ------------------------------ ---------- ------
      9411 ������                                 97 A+
      9515 �Ӽ���                                 95 A0
      9511 ��ſ�                                 92 A0
      9711 ������                                 91 A0
      9611 ������                                 89 B+
      9712 ������                                 88 B+
      9415 �ڵ�ȣ                                 88 B+
      9512 ������                                 87 B+
      9615 ����ȣ                                 87 B+
      9613 �ȱ���                                 86 B+
      9715 ���                                   84 B0
      9413 �̹̰�                                 83 B0
      9714 ������                                 83 B0
      9614 �蹮ȣ                                 82 B0
      9713 �ο���                                 82 B0
      9513 ������                                 81 B0
      9514 ������                                 79 C+
      9412 �����                                 78 C+
      9612 ������                                 77 C+
      9414 �����                                 62 D


�� Ǯ �ƿ��� ����

SELECT s.name, p.name
FROM student s FULL OUTER JOIN professor p
ON s.profno = p.profno
/

NAME                           NAME
------------------------------ ------------------------------
������                         ������
�����                         �缱��
�̹̰�                         ���ѿ�
�����                         �ɽ�
�ڵ�ȣ                         �ڿ���
��ſ�                         �ڽ°�
������                         �迵��
������                         �ڿ���
������                         ����
�Ӽ���                         �ɽ�
������                         �ڽ°�
������                         �缱��
�ȱ���                         �ֽ���
�蹮ȣ                         �ڿ���
����ȣ                         ����
������
������
�ο���
������
���
                               �赵��
                               ����
                               �ֽ���
                               �ٺ�
                               ������
                               �۵���
                               ����ö


�� ���������� ���� �л��� ���������� ��� (����, WHERE�� �ȿ� s.deptno1 ���!)

SELECT s.studno �й�, s.name �л���, s.grade �г�, p.name ��������
FROM student s LEFT OUTER JOIN professor p
USING (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/

      �й� �л���                               �г� ��������
---------- ------------------------------ ---------- ------------------------------
      9411 ������                                  4 ������
      9511 ��ſ�                                  3 �ڽ°�
      9611 ������                                  2 �ڽ°�
      9711 ������                                  1


�� �����л��� ���� ���������� ��� (����, WHERE�� �ȿ� p.deptno ���!)

SELECT studno �й�, s.name �л���, grade �г�, p.name ����������
FROM student s RIGHT OUTER JOIN professor p
USING (profno)
WHERE p.deptno = (SELECT deptno FROM department WHERE dname='��ǻ�Ͱ��а�')
/

      �й� �л���                               �г� ����������
---------- ------------------------------ ---------- ------------------------------
      9411 ������                                  4 ������
      9511 ��ſ�                                  3 �ڽ°�
      9611 ������                                  2 �ڽ°�
                                                     �۵���


�� �����л�, ���������� ���� �л�, ���������� ��� ���

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

    STUDNO NAME                                GRADE ��������
---------- ------------------------------ ---------- ------------------------------
      9411 ������                                  4 ������
      9511 ��ſ�                                  3 �ڽ°�
      9611 ������                                  2 �ڽ°�
      9711 ������                                  1
                                                     �۵���


�� 10�� �μ��� ����̸�, ����̸� ��� (��������) =KING�� ��¾ȵȴ�?=

SELECT e1.ename ����̸�, e1.job ��å, e1.sal ����, e2.ename ���
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.deptno = 10
/

����̸�             ��å                     ���� ���
-------------------- ------------------ ---------- --------------------
MILLER               CLERK                    1300 CLARK
CLARK                MANAGER                  2450 KING


�� �������� �Ҽӵ� �а�, �к� ��� ��� (��, ���������� ������� ����)

SELECT d1.deptno �μ���ȣ, d1.dname �μ��̸�, d2.dname �ҼӸ�
FROM department d1 JOIN department d2
ON d1.part = d2.deptno
WHERE (SELECT deptno FROM department WHERE dname='��������') IN (d1.part, d2.part)
/

  �μ���ȣ �μ��̸�             �ҼӸ�
---------- -------------------- --------------------
       100 ��ǻ�������к�       ��������
       200 ��īƮ�δн��к�     ��������
       103 ����Ʈ������а�     ��ǻ�������к�
       101 ��ǻ�Ͱ��а�         ��ǻ�������к�
       102 ��Ƽ�̵����а�     ��ǻ�������к�
       203 ȭ�а��а�           ��īƮ�δн��к�
       201 ���ڰ��а�           ��īƮ�δн��к�
       202 �����а�           ��īƮ�δн��к�


�� �� �μ��� ��� ������ ���ϰ� ���߿��� ��� ������ ���� ���� �μ��� ��տ�������
���� �޴� �������� ���� ���
(������ �Լ��� 1��)
with e
as (	SELECT MIN(AVG(pay)) AVG
	FROM emp2
	GROUP BY deptno)
SELECT d2.dname, e2.name, e2.pay
FROM emp2 e2 JOIN dept2 d2
ON e2.deptno = d2.dcode
JOIN e
ON e2.pay < e.AVG
/

DNAME                                    NAME                        PAY
---------------------------------------- -------------------- ----------
����1��                                  ���Ͼ�                 22000000
����2��                                  ������                 22000000
����3��                                  ���ֿ�                 22000000
����4��                                  ������                 20000000
H/W����                                  ��ݰ�                 20000000
S/W����                                  ���Ѷ�                 20000000
S/W����                                  ��Ŷ�                 20000000


�� �� �μ��� ��� ������ ���ϰ� ���߿��� ��� ������ ���� ���� �μ��� �Ҽӵ� ���� �̸�, ����, ���� ���
(������ �Լ��� 2��)

with e
as (	SELECT deptno, AVG(pay) AVG
	FROM emp2
	GROUP BY deptno
	HAVING AVG(pay) = (     SELECT MIN(AVG(pay))
				FROM emp2
				GROUP BY deptno))
SELECT d2.dname, e2.name, e2.pay
FROM emp2 e2 JOIN dept2 d2
ON e2.deptno = d2.dcode
JOIN e
USING (deptno)
/

with e
as ( select deptno, AVG(pay) "AVG"
	from emp2
	group by deptno)
select d2.dname, e2.name, e2.pay
from emp2 e2 JOIN dept2 d2
ON e2.deptno = d2.dcode
JOIN e
USING (deptno)
where AVG=(select MIN(AVG) from e)
/

DNAME                                    NAME                        PAY
---------------------------------------- -------------------- ----------
S/W����                                  �蹮ȣ                 35000000
����4��                                  ������                 30000000
����4��                                  ������                 20000000
S/W����                                  ���Ѷ�                 20000000
S/W����                                  ��Ŷ�                 20000000
S/W����                                  ������


�� �г⺰�� �ִ� �����Ը� ���� �л����� �г�, �̸�, ������ ���

SELECT grade, name, weight
FROM student
WHERE (grade, weight) IN (	SELECT grade, MAX(weight)
				FROM student
				GROUP BY grade)
ORDER BY grade
/

     GRADE NAME                               WEIGHT
---------- ------------------------------ ----------
         1 ������                                 81
         2 �ȱ���                                 82
         3 ������                                 58
         4 �����                                 83


�� �а��� �Ի����� ���� ������ ������ ��ȣ, �̸�, �Ի���, �а��� ���

SELECT profno, name, TO_CHAR(hiredate,'RRRR-MM-DD') �Ի���, dname
FROM professor NATURAL JOIN department
WHERE (deptno, hiredate) IN (	SELECT deptno, MIN(hiredate)
				FROM professor
				GROUP BY deptno)
/

    PROFNO NAME            �Ի���               DNAME
---------- --------------- -------------------- --------------------
      1001 ������          1980-06-23           ��ǻ�Ͱ��а�
      2003 �ֽ���          1982-04-29           ��Ƽ�̵����а�
      3001 �赵��          1981-10-23           ����Ʈ������а�
      4001 �ɽ�            1981-10-23           ���ڰ��а�
      4003 �ڿ���          1999-12-01           �����а�
      4005 �ٺ�            1985-09-18           ȭ�а��а�
      4007 ����            2001-05-23           ���������а�


�� ���޺��� �ش� ���޿��� �ִ� ������ �޴� ������ �̸�, ����, ���� ���

SELECT name, position, TO_CHAR(pay, '$999,999,999') SALARY
FROM emp2
WHERE (position, pay) IN (	SELECT position, MAX(pay)
				FROM emp2
				GROUP BY position)
ORDER BY SALARY
/

NAME                 POSITION                 SALARY
-------------------- ------------------------ --------------------------
�蹮ȣ               �븮                       $35,000,000
õ����               ����                       $56,000,000
�����               ����                       $60,000,000
������               ����                       $75,000,000
������               ��ǥ�̻�                  $100,000,000


�� �г⺰ ��պ��� �����԰� ���� ������ �л� ��� (��ȣ ���� ���)

with e
as (	SELECT grade, AVG(weight) AVG
	FROM student
	GROUP BY grade)
SELECT grade, s.name, s.weight
FROM student s JOIN e
USING (grade)
WHERE s.weight > e.AVG
/

SELECT grade, name, weight
FROM student s1
WHERE weight >= (	SELECT AVG(weight)
			FROM student s2
			WHERE s1.grade = s2.grade)
/ 

     GRADE NAME                               WEIGHT
---------- ------------------------------ ----------
         4 ������                                 72
         4 �����                                 83
         4 �ڵ�ȣ                                 70
         3 ������                                 55
         3 ������                                 58
         3 �Ӽ���                                 54
         2 ������                                 72
         2 ������                                 70
         2 �ȱ���                                 82
         1 ������                                 63
         1 �ο���                                 69
         1 ������                                 81


�� �ڽ��� ������ ��տ����� ���ų� ���� �޴� ��� ��� (��ȣ ���� ���)

with e
as (	SELECT position, AVG(pay) AVG
	FROM emp2
	GROUP BY position)
SELECT name, position, TO_CHAR(pay, '$999,999,999') SALARY
FROM emp2 JOIN e
USING (position)
WHERE emp2.pay >= e.AVG
/

SELECT name, position, TO_CHAR(pay, '$999,999,999') SALARY
FROM emp2 a
WHERE pay >= (	SELECT AVG(pay)
		FROM emp2 b
		WHERE a.position = b.position)
/

NAME                 POSITION                 SALARY
-------------------- ------------------------ --------------------------
������               ��ǥ�̻�                  $100,000,000
������               ����                       $72,000,000
�����               ����                       $60,000,000
õ����               ����                       $56,000,000
������               ����                       $75,000,000
�蹮ȣ               �븮                       $35,000,000


�� �ڽź��� �Ի����� ���� ��� �ο��� ���

SELECT p1.profno, p1.name, TO_CHAR(p1.hiredate,'RRRR-MM-DD') �Ի���, COUNT(p2.hiredate) COUNT
FROM professor p1 JOIN professor p2
ON p1.hiredate > p2.hiredate(+)
GROUP BY p1.profno, p1.name, p1.hiredate
ORDER BY COUNT
/

SELECT p1.profno, p1.name, TO_CHAR(p1.hiredate,'RRRR-MM-DD') �Ի���, COUNT(p2.hiredate) COUNT
FROM professor p1 LEFT OUTER JOIN professor p2
ON p1.hiredate > p2.hiredate
GROUP BY p1.profno, p1.name, p1.hiredate
ORDER BY COUNT
/

    PROFNO NAME            �Ի���                    COUNT
---------- --------------- -------------------- ----------
      1001 ������          1980-06-23                    0
      3001 �赵��          1981-10-23                    1
      4001 �ɽ�            1981-10-23                    1
      2003 �ֽ���          1982-04-29                    3
      4005 �ٺ�            1985-09-18                    4
      2002 �迵��          1985-11-30                    5
      1002 �ڽ°�          1987-01-30                    6
      3002 ���ѿ�          1997-07-01                    7
      1003 �۵���          1998-03-22                    8
      4003 �ڿ���          1999-12-01                    9
      4007 ����            2001-05-23                   10
      2001 �缱��          2001-09-01                   11
      3003 ������          2002-02-24                   12
      4004 ����ö          2009-01-28                   13
      4002 �ֽ���          2009-08-30                   14
      4006 ����            2010-06-28                   15


�� �ڽź��� �Ի����� ���� ��� �ο��� ���

SELECT e1.empno, e1.ename, e1.hiredate, COUNT(e2.hiredate) COUNT
FROM emp e1 LEFT OUTER JOIN emp e2
ON e1.hiredate < e2.hiredate
GROUP BY e1.empno, e1.ename, e1.hiredate
ORDER BY COUNT
/

     EMPNO ENAME                HIREDATE      COUNT
---------- -------------------- -------- ----------
      7876 ADAMS                87/05/23          0
      7788 SCOTT                87/04/17          1
      7521 WARD                 82/02/22          2
      7934 MILLER               82/01/23          3
      7902 FORD                 81/12/03          4
      7900 JAMES                81/12/03          4
      7839 KING                 81/11/17          6
      7654 MARTIN               81/09/28          7
      7844 TURNER               81/09/08          8
      7782 CLARK                81/06/09          9
      7698 BLAKE                81/05/01         10
      7566 JONES                81/04/02         11
      7499 ALLEN                81/02/20         12
      7369 SMITH                80/12/17         13


�� �μ��� �ִ� �޿� ��� (�ζ��� ��)

with e
as (	SELECT deptno, MAX(sal) sal
	FROM emp
	GROUP BY deptno)
SELECT deptno, dname, e.sal
FROM e JOIN dept
USING (deptno)
/

SELECT e.deptno, d.dname, e.sal
FROM (	SELECT deptno, MAX(sal) sal
	FROM emp
	GROUP BY deptno) e, dept d
WHERE e.deptno = d.deptno
/

    DEPTNO DNAME                               SAL
---------- ---------------------------- ----------
        10 ACCOUNTING                         5000
        20 RESEARCH                           3000
        30 SALES                              2850


�� �����Ͽ� �� ����

CREATE OR REPLACE VIEW v_prof_dept2
AS
  SELECT p.profno, p.name, d.dname
  FROM professor p JOIN department d
  USING (deptno)
/

select * from v_prof_dept2;

    PROFNO NAME                           DNAME
---------- ------------------------------ --------------------
      1001 ������                         ��ǻ�Ͱ��а�
      1002 �ڽ°�                         ��ǻ�Ͱ��а�
      1003 �۵���                         ��ǻ�Ͱ��а�
      2001 �缱��                         ��Ƽ�̵����а�
      2002 �迵��                         ��Ƽ�̵����а�
      2003 �ֽ���                         ��Ƽ�̵����а�
      3001 �赵��                         ����Ʈ������а�
      3002 ���ѿ�                         ����Ʈ������а�
      3003 ������                         ����Ʈ������а�
      4001 �ɽ�                           ���ڰ��а�
      4002 �ֽ���                         ���ڰ��а�
      4003 �ڿ���                         �����а�
      4004 ����ö                         �����а�
      4005 �ٺ�                           ȭ�а��а�
      4006 ����                           ���������а�
      4007 ����                           ���������а�


�� �а��� �ִ�Ű�� �ش��ϴ� �а��� �л� ���

with e
as (	SELECT deptno1, MAX(height) MAX_HEIGHT
	FROM student
	GROUP BY deptno1)
SELECT dname, e.MAX_HEIGHT, s.name, s.height 
FROM student s JOIN department d
ON s.deptno1 = d.deptno
JOIN e
ON s.height = e.MAX_HEIGHT 
/

DNAME                MAX_HEIGHT NAME                               HEIGHT
-------------------- ---------- ------------------------------ ----------
��Ƽ�̵����а�            179 ������                                179
�����а�                  177 ������                                177
���ڰ��а�                  177 �����                                177
���������а�                184 ����ȣ                                184
�����а�                  182 �ڵ�ȣ                                182
��ǻ�Ͱ��а�                182 ������                                182
�����а�                  182 �ڵ�ȣ                                182
��ǻ�Ͱ��а�                182 ������                                182
����Ʈ������а�            168 �̹̰�                                168


�� �ش� �г��� ��� Ű���� ū �л� ��� (�ζ��� ��)

with e
as (	SELECT grade, AVG(height) AVG_HEIGHT
	FROM student
	GROUP BY grade)
SELECT grade, name, height, e.AVG_HEIGHT
FROM student s JOIN e
USING (grade)
WHERE s.height > e.AVG_HEIGHT
ORDER BY grade
/

SELECT s.grade, s.name, s.height, e.AVG_HEIGHT
FROM (	SELECT grade, AVG(height) AVG_HEIGHT
	FROM student
	GROUP BY grade) e, student s
WHERE s.grade = e.grade AND s.height > e.AVG_HEIGHT
ORDER BY grade
/

     GRADE NAME                               HEIGHT AVG_HEIGHT
---------- ------------------------------ ---------- ----------
         1 ������                                175      170.4
         1 �ο���                                173      170.4
         1 ������                                179      170.4
         2 ������                                182      175.6
         2 ����ȣ                                184      175.6
         3 ������                                177      166.6
         3 �Ӽ���                                171      166.6
         4 ������                                180      175.8
         4 �����                                177      175.8
         4 �ڵ�ȣ                                182      175.8


�� �޿��� ���� ������� ����(��ũ) 5����� ���

SELECT rownum, name, pay
FROM (SELECT name, pay FROM professor ORDER BY 2 DESC)
WHERE rownum BETWEEN 1 AND 5
/

   RANKING NAME                                  PAY
---------- ------------------------------ ----------
         1 �ɽ�                                  570
         2 ������                                550
         3 �赵��                                530
         4 �ٺ�                                  500
         5 �ֽ���                                490


�� ���� ��ȣ ������ �� 3�Ǿ� �и��ؼ� �޿� �հ�, ��� ���

SELECT rownum, profno, name, pay, SUM(pay), ROUND(AVG(pay), 1) ���
FROM (SELECT profno, name, pay, rownum FROM professor)
GROUP BY CEIL(rownum/3), ROLLUP((profno, name, pay, rownum))
ORDER BY CEIL(rownum/3)
/

    ROWNUM     PROFNO NAME                   PAY   SUM(PAY)       ���
---------- ---------- --------------- ---------- ---------- ----------
         1       1001 ������                 550        550        550
         2       1002 �ڽ°�                 380        380        380
         3       1003 �۵���                 270        270        270
                                                       1200        400
         4       2001 �缱��                 250        250        250
         5       2002 �迵��                 350        350        350
         6       2003 �ֽ���                 490        490        490
                                                       1090      363.3
         7       3001 �赵��                 530        530        530
         8       3002 ���ѿ�                 330        330        330
         9       3003 ������                 290        290        290
                                                       1150      383.3
        10       4001 �ɽ�                   570        570        570
        11       4002 �ֽ���                 330        330        330
        12       4003 �ڿ���                 310        310        310
                                                       1210      403.3
        13       4004 ����ö                 260        260        260
        14       4005 �ٺ�                   500        500        500
        15       4006 ����                   220        220        220
                                                        980      326.7
        16       4007 ����                   290        290        290
                                                        290        290


�� ���� ��� 1

drop table STUDENT2018 purge ; // ���̺� ���� ����

CREATE TABLE STUDENT2018 (
  studno NUMBER(9) primary key,
  studname CHAR(15) not null,
  grade NUMBER(1) check(grade between 1 and 4),
  korean NUMBER(3),
  english NUMBER(3),
  math NUMBER(3),
  toeic NUMBER(3)
);

insert into STUDENT2018 values (201695112,'������',1,60,90,70,300);
insert into STUDENT2018 values (201695109,'�ڹ̰�',1,60,50,50,400);
insert into STUDENT2018 values (201695107,'�̵���',1,60,70,80,700);
insert into STUDENT2018 values (201395114,'������',2,90,80,40,500);
insert into STUDENT2018 values (201395101,'������',2,90,90,90,900);
insert into STUDENT2018 values (201295111,'�̸���',3,80,80,70,500);
insert into STUDENT2018 values (201295105,'������',4,50,60,70,700);
insert into STUDENT2018 values (201095125,'������',4,90,90,90,900);
insert into STUDENT2018 values (201364007,'������',3,80,90,90,800);

    STUDNO NAME                 GRADE      KOREA    ENGLISH       MATH      TOEIC
---------- --------------- ---------- ---------- ---------- ---------- ----------
 201695112 ������                   1         60         90         70        300
 201695109 �ڹ̰�                   1         60         50         50        400
 201695107 �̵���                   1         60         70         80        700
 201395114 ������                   2         90         80         40        500
 201395101 ������                   2         90         90         90        900
 201295111 �̸���                   3         80         80         70        500
 201295105 ������                   4         50         60         70        700
 201095125 ������                   4         90         90         90        900
 201364007 ������                   3         80         90         90        800


�� ���� ��� 2

SELECT studno, studname, grade, toeic,
ROUND(��ռ���,1) ��ռ���,
ROUND(��ռ���*0.8+(toeic/10)*0.2) ����
FROM (SELECT studno, studname, grade, toeic, (korean+english+math)/3 ��ռ���
	FROM STUDENT2018)
ORDER BY ���� DESC
/

with e
as (	SELECT studno, studname, grade, toeic, (korean+english+math)/3 ��ռ���
	FROM STUDENT2018)
SELECT studno, studname, grade, toeic, ROUND(��ռ���,1) ��ռ���, ROUND(��ռ���*0.8+(toeic/10)*0.2) ����
FROM e
ORDER BY ���� DESC
/

    STUDNO STUDNAME             GRADE      TOEIC   ��ռ���       ����
---------- --------------- ---------- ---------- ---------- ----------
 201395101 ������                   2        900         90         90
 201095125 ������                   4        900         90         90
 201364007 ������                   3        800       86.7         85
 201295111 �̸���                   3        500       76.7         71
 201695107 �̵���                   1        700         70         70
 201395114 ������                   2        500         70         66
 201695112 ������                   1        300       73.3         65
 201295105 ������                   4        700         60         62
 201695109 �ڹ̰�                   1        400       53.3         51


�� ���� ��� 3 (������ �Լ��� 2��)

SELECT empno, ename, sal+NVL(comm, 0) Salary, dname
FROM emp NATURAL JOIN dept
WHERE deptno IN (SELECT deptno
		FROM emp
		GROUP BY deptno
		HAVING SUM(sal+NVL(comm,0)) = (SELECT MAX(SUM(sal+NVL(comm,0)))
						FROM emp
						GROUP BY deptno))
/

with e
as (	SELECT deptno, SUM(sal+NVL(comm,0))
	FROM emp
	GROUP BY deptno
	HAVING SUM(sal+NVL(comm,0)) = (SELECT MAX(SUM(sal+NVL(comm,0)))
					FROM emp
					GROUP BY deptno))
SELECT empno, ename, sal+NVL(comm, 0) Salary, dname
FROM emp JOIN e
USING (deptno)
NATURAL JOIN dept
/

�鰡�� �ùٸ� ���!!!
WITH e
AS ( select deptno, SUM(sal+NVL(comm,0)) SUM
	from emp
	group by deptno)
SELECT empno, ename, SUM "SALARY", dname
FROM emp JOIN e
USING (deptno)
NATURAL JOIN dept
WHERE SUM=(select MAX(SUM) from e)
/

     EMPNO ENAME                    SALARY DNAME
---------- -------------------- ---------- --------------------
      7499 ALLEN                      1900 SALES
      7521 WARD                       1750 SALES
      7654 MARTIN                     2650 SALES
      7698 BLAKE                      2850 SALES
      7844 TURNER                     1500 SALES
      7900 JAMES                       950 SALES


�� ���� ��� 4

with e
as (	SELECT studno, name, height, weight, height-110 ǥ��ü��,
	(weight-(height-110))/(height-110)*100 ������
	FROM student)
SELECT studno, name, height, weight, ǥ��ü��, ������,
	CASE 	WHEN ������ >= 20 THEN '��'
		WHEN ������ >= 10 THEN '��ü��'
		ELSE '����'
	END "������"
FROM e
/

�� �� �����ϰ� �̻�
SELECT studno, name, height, weight,
	height-110 ǥ��ü��,
	(weight-(height-110))/(height-110)*100 ������,
	CASE 	WHEN (weight-(height-110))/(height-110)*100 >= 20 THEN '��'
		WHEN (weight-(height-110))/(height-110)*100 >= 10 THEN '��ü��'
		ELSE '����'
	END "������"
FROM student
/

    STUDNO NAME                HEIGHT     WEIGHT   ǥ��ü��   ������ ������
---------- --------------- ---------- ---------- ---------- ---------- ------------------
      9411 ������                 180         72         70 2.85714286 ����
      9412 �����                 172         64         62 3.22580645 ����
      9413 �̹̰�                 168         52         58 -10.344828 ����
      9414 �����                 177         83         67  23.880597 ��
      9415 �ڵ�ȣ                 182         70         72 -2.7777778 ����
      9511 ��ſ�                 164         48         54 -11.111111 ����
      9512 ������                 161         42         51 -17.647059 ����
      9513 ������                 177         55         67 -17.910448 ����
      9514 ������                 160         58         50         16 ��ü��
      9515 �Ӽ���                 171         54         61  -11.47541 ����
      9611 ������                 182         72         72          0 ����
      9612 ������                 171         70         61 14.7540984 ��ü��
      9613 �ȱ���                 175         82         65 26.1538462 ��
      9614 �蹮ȣ                 166         51         56 -8.9285714 ����
      9615 ����ȣ                 184         62         74 -16.216216 ����
      9711 ������                 162         48         52 -7.6923077 ����
      9712 ������                 175         63         65 -3.0769231 ����
      9713 �ο���                 173         69         63 9.52380952 ����
      9714 ������                 179         81         69 17.3913043 ��ü��
      9715 ���                   163         51         53 -3.7735849 ����


�� �Ի��Ϻ��� ���ݱ��� ��¥ �� ���

SELECT ename �̸�, hiredate �Ի���, sysdate ������,
	TRUNC(sysdate-hiredate) �ٹ��ϼ�,
	TRUNC(MONTHS_BETWEEN(sysdate, hiredate)/12) �ٹ����,
	TRUNC(MONTHS_BETWEEN(sysdate, hiredate)) �ٹ�����,
	TRUNC((sysdate-hiredate)/7) �ٹ��ּ�
FROM emp
/

�̸�                 �Ի���   ������     �ٹ��ϼ�   �ٹ����   �ٹ�����   �ٹ��ּ�
-------------------- -------- -------- ---------- ---------- ---------- ----------
SMITH                80/12/17 18/10/22      13823         37        454       1974
ALLEN                81/02/20 18/10/22      13758         37        452       1965
WARD                 82/02/22 18/10/22      13391         36        440       1913
JONES                81/04/02 18/10/22      13717         37        450       1959
MARTIN               81/09/28 18/10/22      13538         37        444       1934
BLAKE                81/05/01 18/10/22      13688         37        449       1955
CLARK                81/06/09 18/10/22      13649         37        448       1949
SCOTT                87/04/17 18/10/22      11511         31        378       1644
KING                 81/11/17 18/10/22      13488         36        443       1926
TURNER               81/09/08 18/10/22      13558         37        445       1936
ADAMS                87/05/23 18/10/22      11475         31        376       1639
JAMES                81/12/03 18/10/22      13472         36        442       1924
FORD                 81/12/03 18/10/22      13472         36        442       1924
MILLER               82/01/23 18/10/22      13421         36        440       1917


�� �Ի��Ϻ��� 90����, 6���� �� �� ��¥ ���

SELECT ename ����, hiredate �Ի�����, (hiredate+90) "�Ի���90����",
	ADD_MONTHS(hiredate, 6) "�Ի���6������",
	ADD_MONTHS(sysdate, 6) "����6������",
	LAST_DAY(hiredate)-hiredate "�Ի��Ѵ��Ǳٹ��ϼ�",
	NEXT_DAY(hiredate+60,'��') "60�����Ŀ�����",
	TO_CHAR(hiredate, 'YYYY"�� "MM"�� "DD"��"') �Ի���
FROM emp
/


�� �̸��� 6�� �̻��� ��� ��3���� �ҹ��� ���

SELECT LOWER(SUBSTR(ename,1,3)) �̸�
FROM emp
WHERE LENGTH(ename) >= 6
/

�̸�
------------------------
mar
tur
mil


��  10�� �μ� �߿��� 30�� �μ����� ���� ������ �ϴ� ��� ���

SELECT empno �����ȣ, ename �̸�, dname �μ���, hiredate �Ի���, loc ����
FROM emp NATURAL JOIN dept
WHERE deptno =10 AND job NOT IN (SELECT job FROM emp WHERE deptno=30)
/


��  	INITCAP() ù���ڸ� �빮�� ������ �ҹ���
	LOWER() ���� �ҹ���
	UPPER() ���� �빮��
	LENGTH() / LENGTHB() ���ڿ��� ����(����Ʈ��) ���
	







