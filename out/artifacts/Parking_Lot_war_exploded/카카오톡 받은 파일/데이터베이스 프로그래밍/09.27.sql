<166p. ������ ������ �μ��� ��ձ޿��� ���>

SELECT deptno, AVG(sal+NVL(comm,0))
FROM emp
WHERE job != 'PRESIDENT'
GROUP BY deptno
/

�鰰�� ���, ��õ!
SELECT deptno, AVG(sal+NVL(comm,0))"AVG_SAL"
FROM emp
WHERE job <> 'PRESIDENT'
GROUP BY deptno
/

    DEPTNO   AVG(SAL)
---------- ----------
        30 1566.66667
        20       2175
        10       1875


<166p. ������ ������ �μ��� ��ձ޿��� 2000�̻��� �μ� ���>

SELECT deptno, AVG(sal+NVL(comm,0))"AVG_SAL"
FROM emp
WHERE job <> 'PRESIDENT'
GROUP BY deptno
HAVING AVG(sal+NVL(comm,0)) >= 2000
/


��421p. �����ؼ� �ζ��� �並 �̿��� ���

SELECT *
FROM (SELECT deptno, AVG(sal+NVL(comm,0))"AVG_SAL"
	FROM emp
	WHERE job <> 'PRESIDENT'
	GROUP BY deptno)
where AVG_SAL >= 2000
/


��with���� �̿��� ���
with e
as (SELECT deptno, AVG(sal+NVL(comm,0))"AVG_SAL"
	FROM emp
	WHERE job <> 'PRESIDENT'
	GROUP BY deptno)
SELECT *
FROM e
WHERE AVG_SAL >= 2000
/


    DEPTNO    AVG_SAL
---------- ----------
        20       2175


<167p. ����!!! ���л� ���Ű�� ���� ū �а��� �̸��� ���Ű�� ���>


with e
as ( select max(avg(height))
	from student
	where substr(jumin,7,1)=1
	group by deptno1)
select dname, avg(height) "MAX_AVG_HEIGHT"
from student JOIN department ON (deptno1 = deptno)
where substr(jumin,7,1)=1
group by dname
having avg(height) = (select * from e)
/


���� �� ����� ��� ���� ��
with e
as ( select deptno1, AVG(height)"AVG"
	from student
	where substr(jumin,7,1)=1
	group by deptno1)
select dname "�а���", AVG "���Ű"
from e JOIN department ON (deptno1=deptno)
where AVG=(select max(AVG) from e)
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

