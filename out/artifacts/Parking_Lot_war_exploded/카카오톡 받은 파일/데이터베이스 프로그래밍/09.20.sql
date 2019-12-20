<120p 4번문제를 case문으로 변환>

SELECT name, tel,
	CASE(SUBSTR(tel,1,INSTR(tel,')')-1)) WHEN '055' THEN '강남'
					WHEN '02' THEN '서울'
					WHEN '031' THEN '경기'
					WHEN '051' THEN '부산'
					WHEN '052' THEN '울산'
					WHEN '053' THEN '대구'
						ELSE 'ETC'
	END "LOC"
FROM student
WHERE deptno1 IN (SELECT deptno
		FROM department
		WHERE part IN (SELECT deptno 
			FROM department 
			WHERE dname='컴퓨터정보학부'))
ORDER BY name
/

NAME                           TEL                            LOC
------------------------------ ------------------------------ ------------
김신영                         055)333-6328                   강남
김주현                         055)423-9870                   강남
김진욱                         055)488-2998                   강남
서재수                         051)426-1700                   부산
서진수                         055)381-2158                   강남
신은경                         051)418-9627                   부산
이미경                         053)266-8947                   대구
이윤나                         055)278-3649                   강남
일지매                         02)6788-4861                   서울
허우                           02)6122-2345                   서울


<123p 퀴즈1번 교수의 이름, 월급, 보너스, 세금 출력>
※ 교수들의 보너스, 세금 출력

SELECT name, pay, NVL(bonus,0) bonus,
	CASE 	WHEN (pay*12)+(NVL(bonus,0)*6) <= 4500 THEN (((pay*12)+(NVL(bonus,0)*6))*0.15)/12
		WHEN (pay*12)+(NVL(bonus,0)*6) <= 8800 THEN (((pay*12)+(NVL(bonus,0)*6))*0.24)/12
		ELSE (((pay*12)+(NVL(bonus,0)*6))*0.35)/12
	END "세금"
from professor
/


NAME                                  PAY      BONUS       세금
------------------------------ ---------- ---------- ----------
조인형                                550        100        144
박승곤                                380         60       98.4
송도권                                270          0       40.5
양선희                                250          0       37.5
김영조                                350         80       93.6
주승재                                490         90      128.4
김도형                                530        110      140.4
나한열                                330         50      53.25
김현정                                290          0       43.5
심슨                                  570        130      152.4
최슬기                                330          0       49.5
박원범                                310         50      50.25
차범철                                260          0         39
바비                                  500         80      129.6
전민                                  220          0         33
허은                                  290         30      45.75


SELECT name, pay, NVL(bonus,0) bonus,
	CASE WHEN ((pay*12)+(bonus*6)) <= 4500 THEN (((pay*12)+(NVL(bonus,0)*6))*0.15)/12
		WHEN ((pay*12)+(bonus*6)) <= 8800 THEN (((pay*12)+(NVL(bonus,0)*6))*0.24)/12
		ELSE (((pay*12)+NVL(bonus,0)*6))*0.35)/12
	END tax
from professor
/




<162p 퀴즈 1번>

SELECT d.dname"부서명",
	SUM(sal+NVL(comm,0))"인건비",
	ROUND(AVG(sal+NVL(comm,0)),2)"평균"
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
ORDER BY 평균 DESC
/


↓더 좋은 조인방법, 깔끔!!!
SELECT dname"부서명",
	SUM(sal+NVL(comm,0))"인건비",
	ROUND(AVG(sal+NVL(comm,0)),2)"평균"
FROM emp NATURAL JOIN dept
GROUP BY dname
ORDER BY 평균 DESC
/


↓다른방법, comm에 0이 있는 사람이 있어서 나누기 할 때 필요
SELECT d.dname"부서명",
	SUM(sal+NVL(DECODE(comm,0,null,comm),0))"인건비",
	ROUND(AVG(sal+(NVL(DECODE(comm,0,null,comm),0))),2)"평균"
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
ORDER BY 평균 DESC
/

부서명                           인건비       평균
---------------------------- ---------- ----------
ACCOUNTING                         8750    2916.67
RESEARCH                          10875       2175
SALES                             11600    1933.33





