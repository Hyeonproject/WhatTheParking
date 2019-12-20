과제 시 글씨체는 '고딕', sql에 실행한 그대로 복붙


<리포터 문제>
SELECT job, count(*) 인원수 
FROM emp
GROUP BY job
HAVING count(*) >= 4
/

<168p 숙제1>

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


<213p 숙제2>

SELECT deptno,
coalesce(CLERK, 0)CCLERK,
coalesce(CLERK, 0)CCLERK,
coalesce(CLERK, 0)CCLERK,
coalesce(CLERK, 0)CCLERK,
coalesce(CLERK, 0)CCLERK,
coalesce(CLERK, 0)CCLERK,...


SELECT * FROM (SELECT deptno, NVL(job, 'TOTAL') job, sum(sal) sal
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


<169p 지도학생이 없는 교수이름을 출력>

with e
as (	SELECT profno
	FROM professor
	MINUS (	select profno
		from student)
	)
SELECT profno, name
FROM e NATURAL JOIN professor
/





