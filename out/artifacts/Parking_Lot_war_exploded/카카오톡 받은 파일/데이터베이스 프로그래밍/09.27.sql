<166p. 사장을 제외한 부서별 평균급여를 출력>

SELECT deptno, AVG(sal+NVL(comm,0))
FROM emp
WHERE job != 'PRESIDENT'
GROUP BY deptno
/

↓같은 방법, 추천!
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


<166p. 사장을 제외한 부서의 평균급여중 2000이상인 부서 출력>

SELECT deptno, AVG(sal+NVL(comm,0))"AVG_SAL"
FROM emp
WHERE job <> 'PRESIDENT'
GROUP BY deptno
HAVING AVG(sal+NVL(comm,0)) >= 2000
/


↓421p. 참조해서 인라인 뷰를 이용한 방법

SELECT *
FROM (SELECT deptno, AVG(sal+NVL(comm,0))"AVG_SAL"
	FROM emp
	WHERE job <> 'PRESIDENT'
	GROUP BY deptno)
where AVG_SAL >= 2000
/


↓with문을 이용한 방법
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


<167p. 시험!!! 남학생 평균키가 제일 큰 학과의 이름과 평균키를 출력>


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


↓좀 더 깔끔한 방법 조인 온
with e
as ( select deptno1, AVG(height)"AVG"
	from student
	where substr(jumin,7,1)=1
	group by deptno1)
select dname "학과명", AVG "평균키"
from e JOIN department ON (deptno1=deptno)
where AVG=(select max(AVG) from e)
/


↓내츄럴 조인 (대소문자 구분!)
with e
as ( select deptno1 "DEPTNO", AVG(height)"AVG"
	from student
	where substr(jumin,7,1)=1
	group by deptno1)
select dname "학과명", AVG "평균키"
from e NATURAL JOIN department
where AVG=(select max(AVG) from e)
/

DNAME                                                        MAX_AVG_HEIGHT
------------------------------------------------------------ --------------
문헌정보학과                                                            184

