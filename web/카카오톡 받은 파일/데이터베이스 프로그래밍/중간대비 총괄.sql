※ 남자인 학생의 생일 출력

select name, substr(jumin,3,4)"Birthday"
from student
where substr(jumin,7,1)=1
/

NAME                           Birthday
------------------------------ ------------
서진수                         1023
서재수                         0224
김재수                         1225
박동호                         0303
일지매                         1129
김진욱                         0402
안광훈                         0913
김문호                         0226
노정호                         1214
안은수                         0105
인영민                         0809
김주현                         0324


※ 남자인 학생의 생일 출력 (자세하게)

select name, substr(jumin,3,2)||'월 '||substr(jumin,5,2)||'일'"Birthday"
from student
where substr(jumin,7,1)=1
/

NAME                           Birthday
------------------------------ ---------------
서진수                         10월 23일
서재수                         02월 24일
김재수                         12월 25일
박동호                         03월 03일
일지매                         11월 29일
김진욱                         04월 02일
안광훈                         09월 13일
김문호                         02월 26일
노정호                         12월 14일
안은수                         01월 05일
인영민                         08월 09일
김주현                         03월 24일


※ '컴퓨터정보학부'에 소속된 학과이름 앞자리 3개 출력

select SUBSTR(dname,1,3) "OUTPUT"
from department
where part = (select deptno from department where dname='컴퓨터정보학부')
/

OUTPUT
------------------------
컴퓨터
멀티미
소프트


※ 전공이 201번인 학생의 전화번호 앞 지역번호 출력

select name, tel, SUBSTR(tel,1,INSTR(tel, ')')-1) "AREA CODE"
from student
where deptno1 = 201
/

NAME                           TEL                            AREA CODE
------------------------------ ------------------------------ --------------
김재수                         02)6255-9875                   02
임세현                         02)312-9838                    02
안광훈                         053)736-4981                   053
김문호                         02)6175-3945                   02
안은수                         02)381-5440                    02
인영민                         031)345-5677                   031


※ '컴퓨터정보공학부'에 소속된 학과이름 앞3자리 삭제 후 출력

select REPLACE(dname, SUBSTR(dname,1,3),'') "OUTPUT"
from department
where part = (select deptno from department where dname='컴퓨터정보학부')
/

OUTPUT
---------------------
공학과
디어공학과
웨어공학과


※ 학생들의 이름, 전화번호, 국번 부분만 '*'로 처리하여 출력

SELECT name, tel,
REPLACE(tel, SUBSTR(tel, INSTR(tel, ')')+1,INSTR(tel,'-')-INSTR(tel, ')')-1),SUBSTR('****',1,INSTR(tel,'-')-INSTR(tel, ')')-1)) "OUTPUT"
FROM student
/

NAME                           TEL                            OUTPUT
------------------------------ ------------------------------ ---------------
서진수                         055)381-2158                   055)***-2158
서재수                         051)426-1700                   051)***-1700
이미경                         053)266-8947                   053)***-8947
김재수                         02)6255-9875                   02)****-9875
박동호                         031)740-6388                   031)***-6388
김신영                         055)333-6328                   055)***-6328
신은경                         051)418-9627                   051)***-9627
오나라                         051)724-9618                   051)***-9618
구유미                         055)296-3784                   055)***-3784
임세현                         02)312-9838                    02)***-9838
일지매                         02)6788-4861                   02)****-4861
김진욱                         055)488-2998                   055)***-2998
안광훈                         053)736-4981                   053)***-4981
김문호                         02)6175-3945                   02)****-3945
노정호                         051)785-6984                   051)***-6984
이윤나                         055)278-3649                   055)***-3649
안은수                         02)381-5440                    02)***-5440
인영민                         031)345-5677                   031)***-5677
김주현                         055)423-9870                   055)***-9870
허우                           02)6122-2345                   02)****-2345


※ deptno가 10번인 사원들의 사원이름을 총 9바이트로 출력하되 빈자리에는 숫자로 채워서 출력

select LPAD(ename,9,SUBSTR('123456789',1,9-lengthb(ename))) "OUTPUT"
from emp
where deptno = 10
/

OUTPUT
---------------
1234CLARK
12345KING
123MILLER


※ 현재 시간 출력

SELECT sysdate
FROM dual
/

SYSDATE
--------
18/10/20


※ 현재까지 몇일이 지났는지 확인

SELECT sysdate - TO_DATE('2018/09/01', 'YYYY/MM/DD') "DATE"
FROM dual
/

      DATE
----------
49.6930093


※ 생일이 1~6월 사이인 학생 출력

select studno, name, birthday
from student
where TO_CHAR(birthday,'MM') BETWEEN 1 AND 6
/

    STUDNO NAME                           BIRTHDAY
---------- ------------------------------ --------
      9412 서재수                         75/02/24
      9413 이미경                         75/06/15
      9415 박동호                         75/03/03
      9511 김신영                         76/01/23
      9512 신은경                         76/04/12
      9514 구유미                         76/01/20
      9612 김진욱                         77/04/02
      9614 김문호                         77/02/26
      9712 안은수                         78/01/05
      9714 김주현                         78/03/24
      9715 허우                           78/02/23


※ 1,2,3월 중에 입사한 사원 출력

select empno, ename, hiredate
from emp
where TO_CHAR(hiredate,'MM') IN (1,2,3)
/

     EMPNO ENAME                HIREDATE
---------- -------------------- --------
      7499 ALLEN                81/02/20
      7521 WARD                 82/02/22
      7934 MILLER               82/01/23


※ 점뒤에 표시되지 않는 숫자는 반올림해서 출력

select TO_CHAR(12345.6789, '99,999.99') 반올림
from dual
/

반올림
--------------------
 12,345.68


※ 원화로 표시

select TO_CHAR(12345.6789, 'L99999.999') 원화
from dual
/

원화
----------------------------------------
        ￦12345.679


※ 달러화로 표시

select TO_CHAR(12345.6789, '$99999.999') 달러화
from dual
/

달러화
----------------------
 $12345.679


※ 'SALES'부서에 속한 사원들의 월급, 인상값 출력

SELECT empno, ename, TO_CHAR(hiredate,'RRRR-MM-DD') 입사일,
	TO_CHAR((sal*12)+NVL(comm,0),'$999,999') 월급,
	TO_CHAR(((sal*12)+NVL(comm,0))*1.15,'$999,999') "15% 인상값"
FROM emp
WHERE deptno = (SELECT deptno 
		FROM dept 
		WHERE dname='SALES')
/

     EMPNO ENAME                입사일               월급               15% 인상값
---------- -------------------- -------------------- ------------------ ------------------
      7499 ALLEN                1981-02-20             $19,500            $22,425
      7521 WARD                 1982-02-22             $15,500            $17,825
      7654 MARTIN               1981-09-28             $16,400            $18,860
      7698 BLAKE                1981-05-01             $34,200            $39,330
      7844 TURNER               1981-09-08             $18,000            $20,700
      7900 JAMES                1981-12-03             $11,400            $13,110


※ 사원들중 comm이 있으면 x2, 없으면 sal/2를 보너스로 주고 총합 출력
(주의, comm이 0인 사람들이 존재하니 DECODE를 이용해 NULL로 변환해주자)

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


※ 101번 전공학생 중 주민번호를 보고 성별 출력

select name, jumin, DECODE(SUBSTR(jumin,7,1),1,'남자',2,'여자',3,'남자',4,'여자')"Gender"
from student
where deptno1 = 101
/

NAME                           JUMIN                      Gender
------------------------------ -------------------------- ------------
서진수                         7510231901810              남자
김신영                         7601232186327              여자
일지매                         7711291186223              남자
이윤나                         7808192157498              여자


※ 101번 전공학생 중 지역번호를 보고 해당지역 출력 (주의, 예외를 항상 생각)

SELECT name, tel, DECODE(SUBSTR(tel,1,INSTR(tel, ')')-1),055,'강남',
							02, '서울',
							031,'경기',
							051,'부산',
							052,'울산',
							053,'대구','그외지역')"LOC"
from student
where deptno1 = 101
/

NAME                           TEL                            LOC
------------------------------ ------------------------------ ------------------------
서진수                         055)381-2158                   강남
김신영                         055)333-6328                   강남
일지매                         02)6788-4861                   서울
이윤나                         055)278-3649                   강남


※ '컴퓨터정보학부'에 소속된 학생들의 성별 출력

SELECT name, jumin, DECODE(SUBSTR(jumin,7,1),1,'남자','여자') 성별
FROM student
WHERE deptno1 IN (select deptno
		from department
		where part = (select deptno 
			from department 
			where dname='컴퓨터정보학부'))
ORDER BY name
/

NAME                           JUMIN                      성별
------------------------------ -------------------------- ------------
김신영                         7601232186327              여자
김주현                         7803241981987              남자
김진욱                         7704021358674              남자
서재수                         7502241128467              남자
서진수                         7510231901810              남자
신은경                         7604122298371              여자
이미경                         7506152123648              여자
이윤나                         7808192157498              여자
일지매                         7711291186223              남자
허우                           7802232116780              여자


※ '컴퓨터정보학부'에 소속된 학생들의 지역 출력

SELECT name, tel, DECODE(SUBSTR(tel,1,INSTR(tel, ')')-1),055,'강남',
							02, '서울',
							031,'경기',
							051,'부산',
							052,'울산',
							053,'대구','그외지역')"LOC"
FROM student
WHERE deptno1 IN (select deptno
		from department
		where part IN (select deptno 
			from department 
			where dname='컴퓨터정보학부'))
ORDER BY name
/

NAME                           TEL                            LOC
------------------------------ ------------------------------ ------------------------
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


※ '컴퓨터정보학부'에 소속된 학생들의 지역 출력 (CASE문 사용)

SELECT name, tel,
	CASE (SUBSTR(tel,1,INSTR(tel,')')-1))	 WHEN '055' THEN '강남'
						WHEN '02' THEN '서울'
						WHEN '031' THEN '경기'
						WHEN '051' THEN '부산'
						WHEN '052' THEN '울산'
						WHEN '053' THEN '대구'
						ELSE 'ETC'
	END "LOC"
FROM student
WHERE deptno1 IN (	SELECT deptno
			FROM department
			WHERE part IN (	SELECT deptno 
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


※ 부서별, 인건비, 평균 출력

SELECT 	dname"부서명",
	SUM(sal+NVL(comm,0))"인건비",
	ROUND(AVG(sal+NVL(comm,0)),2)"평균"
FROM emp NATURAL JOIN dept
GROUP BY dname
ORDER BY 평균 DESC
/

부서명                           인건비       평균
---------------------------- ---------- ----------
ACCOUNTING                         8750    2916.67
RESEARCH                          10875       2175
SALES                             11600    1933.33

※ 사장을 제외한 부서별 평균급여 출력

SELECT deptno, ROUND(AVG(sal+NVL(comm,0)),2) 평균급여
FROM emp
WHERE job != 'PRESIDENT'
GROUP BY deptno
/

    DEPTNO   평균급여
---------- ----------
        30    1933.33
        20       2175
        10       1875


※ 사장을 제외한 부서의 평균급여중 2000이상인 부서 출력

SELECT deptno, ROUND(AVG(sal+NVL(comm,0)),2) 평균급여
FROM emp
WHERE job <> 'PRESIDENT'
GROUP BY deptno
HAVING ROUND(AVG(sal+NVL(comm,0)),2) >= 2000
/

SELECT *
FROM (SELECT deptno, ROUND(AVG(sal+NVL(comm,0)),2) 평균급여
	FROM emp
	WHERE job <> 'PRESIDENT'
	GROUP BY deptno)
WHERE 평균급여 >= 2000
/

with e
as (SELECT deptno, AVG(sal+NVL(comm,0)) 평균급여
	FROM emp
	WHERE job <> 'PRESIDENT'
	GROUP BY deptno)
SELECT *
FROM e
WHERE 평균급여 >= 2000
/

    DEPTNO   평균급여
---------- ----------
        20       2175


※ 남학생 평균키가 제일 큰 학과의 이름과 평균키 출력

with e
as ( select deptno1, AVG(height) "AVG"
	from student
	where substr(jumin,7,1)=1
	group by deptno1)
select dname "학과명", AVG "평균키"
from e JOIN department ON (deptno1=deptno)
where AVG=(select MAX(AVG) from e)
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


※ 부서별, 직업별 급여 출력 (GROUPING SETS 사용) 168p.

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


※ 부서별, 직급별로 급여 합계 출력

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


※ 지도학생이 없는 교수의 번호, 이름 출력

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
      1003 송도권
      2003 주승재
      3001 김도형
      3003 김현정
      4004 차범철
      4005 바비
      4006 전민


※ USING을 이용하여 테이블2개 조인

SELECT s.name 학생이름, s.grade 학년, p.name 교수이름
FROM student s JOIN professor p
USING  (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
ORDER BY 학년
/

학생이름              학년 교수이름
--------------- ---------- ------------------------------
일지매                   2 박승곤
김신영                   3 박승곤
서진수                   4 조인형


※ USING을 이용하여 테이블3개 조인

SELECT s.name 학생이름, s.grade 학년, d.dname 학과명, p.name 교수이름
FROM student s JOIN department d
ON s.deptno1 = d.deptno
JOIN professor p
USING  (profno)
ORDER BY 학과명
/

학생이름              학년 학과명               교수이름
--------------- ---------- -------------------- ------------------------------
박동호                   4 기계공학과           박원범
오나라                   3 기계공학과           박원범
김진욱                   2 멀티미디어공학과     양선희
서재수                   4 멀티미디어공학과     양선희
신은경                   3 멀티미디어공학과     김영조
구유미                   3 문헌정보학과         허은
노정호                   2 문헌정보학과         허은
이미경                   4 소프트웨어공학과     나한열
안광훈                   2 전자공학과           최슬기
김재수                   4 전자공학과           심슨
임세현                   3 전자공학과           심슨
김문호                   2 전자공학과           박원범
서진수                   4 컴퓨터공학과         조인형
김신영                   3 컴퓨터공학과         박승곤
일지매                   2 컴퓨터공학과         박승곤


※ 고객의 포인트에 따른 선물세트 출력

SELECT c.gname 고객이름, TO_CHAR(c.point, '999,999') 포인트, g.gname 선물이름
FROM gogak c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end
/

SELECT c.gname 고객이름, TO_CHAR(c.point, '999,999') 포인트, g.gname 선물이름
FROM gogak c JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end
/

고객이름                       포인트           선물이름
------------------------------ ---------------- ------------------------------------
김재수                           65,000         참치세트
서재수                           73,000         참치세트
정현영                           99,000         참치세트
최순규                          110,000         샴푸세트
김신영                          153,000         샴푸세트
박동호                          180,000         샴푸세트
임세현                          265,000         세차용품세트
신은경                          273,000         세차용품세트
모병환                          298,000         세차용품세트
오나라                          315,000         주방용품세트
이미경                          320,000         주방용품세트
노정호                          420,000         산악용자전거
안광훈                          470,000         산악용자전거
김설희                          542,000         LCD모니터
이윤나                          598,000         LCD모니터
안은수                          625,000         노트북
인영민                          670,000         노트북
허우                            730,000         벽걸이TV
김지영                          770,000         벽걸이TV
서진수                          980,000         양쪽문냉장고


※ 점수에 따른 학점 출력
(주의, USING에 사용한 컬럼앞에 테이블명 안됌! 예를들어, s.studno 오류!)

SELECT studno 학번, s.name 이름, e.total 점수, h.grade 학점
FROM student s JOIN exam_01 e USING (studno)
		JOIN hakjum h
		ON e.total BETWEEN h.min_point AND h.max_point
/

      학번 이름                                 점수 학점
---------- ------------------------------ ---------- ------
      9411 서진수                                 97 A+
      9515 임세현                                 95 A0
      9511 김신영                                 92 A0
      9711 이윤나                                 91 A0
      9611 일지매                                 89 B+
      9712 안은수                                 88 B+
      9415 박동호                                 88 B+
      9512 신은경                                 87 B+
      9615 노정호                                 87 B+
      9613 안광훈                                 86 B+
      9715 허우                                   84 B0
      9413 이미경                                 83 B0
      9714 김주현                                 83 B0
      9614 김문호                                 82 B0
      9713 인영민                                 82 B0
      9513 오나라                                 81 B0
      9514 구유미                                 79 C+
      9412 서재수                                 78 C+
      9612 김진욱                                 77 C+
      9414 김재수                                 62 D


※ 풀 아우터 조인

SELECT s.name, p.name
FROM student s FULL OUTER JOIN professor p
ON s.profno = p.profno
/

NAME                           NAME
------------------------------ ------------------------------
서진수                         조인형
서재수                         양선희
이미경                         나한열
김재수                         심슨
박동호                         박원범
김신영                         박승곤
신은경                         김영조
오나라                         박원범
구유미                         허은
임세현                         심슨
일지매                         박승곤
김진욱                         양선희
안광훈                         최슬기
김문호                         박원범
노정호                         허은
이윤나
안은수
인영민
김주현
허우
                               김도형
                               전민
                               주승재
                               바비
                               김현정
                               송도권
                               차범철


※ 지도교수가 없는 학생의 정보까지도 출력 (주의, WHERE문 안에 s.deptno1 사용!)

SELECT s.studno 학번, s.name 학생명, s.grade 학년, p.name 지도교수
FROM student s LEFT OUTER JOIN professor p
USING (profno)
WHERE s.deptno1 = (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/

      학번 학생명                               학년 지도교수
---------- ------------------------------ ---------- ------------------------------
      9411 서진수                                  4 조인형
      9511 김신영                                  3 박승곤
      9611 일지매                                  2 박승곤
      9711 이윤나                                  1


※ 지도학생이 없는 교수까지도 출력 (주의, WHERE문 안에 p.deptno 사용!)

SELECT studno 학번, s.name 학생명, grade 학년, p.name 지도교수명
FROM student s RIGHT OUTER JOIN professor p
USING (profno)
WHERE p.deptno = (SELECT deptno FROM department WHERE dname='컴퓨터공학과')
/

      학번 학생명                               학년 지도교수명
---------- ------------------------------ ---------- ------------------------------
      9411 서진수                                  4 조인형
      9511 김신영                                  3 박승곤
      9611 일지매                                  2 박승곤
                                                     송도권


※ 지도학생, 지도교수가 없는 학생, 교수까지도 모두 출력

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

    STUDNO NAME                                GRADE 지도교수
---------- ------------------------------ ---------- ------------------------------
      9411 서진수                                  4 조인형
      9511 김신영                                  3 박승곤
      9611 일지매                                  2 박승곤
      9711 이윤나                                  1
                                                     송도권


※ 10번 부서의 사원이름, 상관이름 출력 (셀프조인) =KING이 출력안된다?=

SELECT e1.ename 사원이름, e1.job 직책, e1.sal 월급, e2.ename 상관
FROM emp e1 JOIN emp e2
ON e1.mgr = e2.empno
WHERE e1.deptno = 10
/

사원이름             직책                     월급 상관
-------------------- ------------------ ---------- --------------------
MILLER               CLERK                    1300 CLARK
CLARK                MANAGER                  2450 KING


※ 공과대학 소속된 학과, 학부 모두 출력 (단, 공과대학은 결과에서 제외)

SELECT d1.deptno 부서번호, d1.dname 부서이름, d2.dname 소속명
FROM department d1 JOIN department d2
ON d1.part = d2.deptno
WHERE (SELECT deptno FROM department WHERE dname='공과대학') IN (d1.part, d2.part)
/

  부서번호 부서이름             소속명
---------- -------------------- --------------------
       100 컴퓨터정보학부       공과대학
       200 메카트로닉스학부     공과대학
       103 소프트웨어공학과     컴퓨터정보학부
       101 컴퓨터공학과         컴퓨터정보학부
       102 멀티미디어공학과     컴퓨터정보학부
       203 화학공학과           메카트로닉스학부
       201 전자공학과           메카트로닉스학부
       202 기계공학과           메카트로닉스학부


※ 각 부서별 평균 연봉을 구하고 그중에서 평균 연봉이 가장 적은 부서의 평균연봉보다
적게 받는 직원들의 연봉 출력
(단일행 함수가 1개)
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
영업1팀                                  정북악                 22000000
영업2팀                                  유도봉                 22000000
영업3팀                                  윤주왕                 22000000
영업4팀                                  강월악                 20000000
H/W지원                                  장금강                 20000000
S/W지원                                  나한라                 20000000
S/W지원                                  김신라                 20000000


※ 각 부서별 평균 연봉을 구하고 그중에서 평균 연봉이 가장 적은 부서에 소속된 직원 이름, 직원, 연봉 출력
(단일행 함수가 2개)

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
S/W지원                                  김문호                 35000000
영업4팀                                  박지리                 30000000
영업4팀                                  강월악                 20000000
S/W지원                                  나한라                 20000000
S/W지원                                  김신라                 20000000
S/W지원                                  성춘향


※ 학년별로 최대 몸무게를 가진 학생들의 학년, 이름, 몸무게 출력

SELECT grade, name, weight
FROM student
WHERE (grade, weight) IN (	SELECT grade, MAX(weight)
				FROM student
				GROUP BY grade)
ORDER BY grade
/

     GRADE NAME                               WEIGHT
---------- ------------------------------ ----------
         1 김주현                                 81
         2 안광훈                                 82
         3 구유미                                 58
         4 김재수                                 83


※ 학과별 입사일이 가장 오래된 교수의 번호, 이름, 입사일, 학과명 출력

SELECT profno, name, TO_CHAR(hiredate,'RRRR-MM-DD') 입사일, dname
FROM professor NATURAL JOIN department
WHERE (deptno, hiredate) IN (	SELECT deptno, MIN(hiredate)
				FROM professor
				GROUP BY deptno)
/

    PROFNO NAME            입사일               DNAME
---------- --------------- -------------------- --------------------
      1001 조인형          1980-06-23           컴퓨터공학과
      2003 주승재          1982-04-29           멀티미디어공학과
      3001 김도형          1981-10-23           소프트웨어공학과
      4001 심슨            1981-10-23           전자공학과
      4003 박원범          1999-12-01           기계공학과
      4005 바비            1985-09-18           화학공학과
      4007 허은            2001-05-23           문헌정보학과


※ 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름, 직급, 연봉 출력

SELECT name, position, TO_CHAR(pay, '$999,999,999') SALARY
FROM emp2
WHERE (position, pay) IN (	SELECT position, MAX(pay)
				FROM emp2
				GROUP BY position)
ORDER BY SALARY
/

NAME                 POSITION                 SALARY
-------------------- ------------------------ --------------------------
김문호               대리                       $35,000,000
천만득               과장                       $56,000,000
백원만               차장                       $60,000,000
일지매               부장                       $75,000,000
나사장               대표이사                  $100,000,000


※ 학년별 평균보다 몸무게가 많이 나가는 학생 출력 (상호 연관 사용)

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
         4 서진수                                 72
         4 김재수                                 83
         4 박동호                                 70
         3 오나라                                 55
         3 구유미                                 58
         3 임세현                                 54
         2 일지매                                 72
         2 김진욱                                 70
         2 안광훈                                 82
         1 안은수                                 63
         1 인영민                                 69
         1 김주현                                 81


※ 자신의 직급의 평균연봉과 같거나 많이 받는 사람 출력 (상호 연관 사용)

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
나사장               대표이사                  $100,000,000
전부장               부장                       $72,000,000
백원만               차장                       $60,000,000
천만득               과장                       $56,000,000
일지매               부장                       $75,000,000
김문호               대리                       $35,000,000


※ 자신보다 입사일이 빠른 사람 인원수 출력

SELECT p1.profno, p1.name, TO_CHAR(p1.hiredate,'RRRR-MM-DD') 입사일, COUNT(p2.hiredate) COUNT
FROM professor p1 JOIN professor p2
ON p1.hiredate > p2.hiredate(+)
GROUP BY p1.profno, p1.name, p1.hiredate
ORDER BY COUNT
/

SELECT p1.profno, p1.name, TO_CHAR(p1.hiredate,'RRRR-MM-DD') 입사일, COUNT(p2.hiredate) COUNT
FROM professor p1 LEFT OUTER JOIN professor p2
ON p1.hiredate > p2.hiredate
GROUP BY p1.profno, p1.name, p1.hiredate
ORDER BY COUNT
/

    PROFNO NAME            입사일                    COUNT
---------- --------------- -------------------- ----------
      1001 조인형          1980-06-23                    0
      3001 김도형          1981-10-23                    1
      4001 심슨            1981-10-23                    1
      2003 주승재          1982-04-29                    3
      4005 바비            1985-09-18                    4
      2002 김영조          1985-11-30                    5
      1002 박승곤          1987-01-30                    6
      3002 나한열          1997-07-01                    7
      1003 송도권          1998-03-22                    8
      4003 박원범          1999-12-01                    9
      4007 허은            2001-05-23                   10
      2001 양선희          2001-09-01                   11
      3003 김현정          2002-02-24                   12
      4004 차범철          2009-01-28                   13
      4002 최슬기          2009-08-30                   14
      4006 전민            2010-06-28                   15


※ 자신보다 입사일이 느린 사람 인원수 출력

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


※ 부서별 최대 급여 출력 (인라인 뷰)

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


※ 조인하여 뷰 생성

CREATE OR REPLACE VIEW v_prof_dept2
AS
  SELECT p.profno, p.name, d.dname
  FROM professor p JOIN department d
  USING (deptno)
/

select * from v_prof_dept2;

    PROFNO NAME                           DNAME
---------- ------------------------------ --------------------
      1001 조인형                         컴퓨터공학과
      1002 박승곤                         컴퓨터공학과
      1003 송도권                         컴퓨터공학과
      2001 양선희                         멀티미디어공학과
      2002 김영조                         멀티미디어공학과
      2003 주승재                         멀티미디어공학과
      3001 김도형                         소프트웨어공학과
      3002 나한열                         소프트웨어공학과
      3003 김현정                         소프트웨어공학과
      4001 심슨                           전자공학과
      4002 최슬기                         전자공학과
      4003 박원범                         기계공학과
      4004 차범철                         기계공학과
      4005 바비                           화학공학과
      4006 전민                           문헌정보학과
      4007 허은                           문헌정보학과


※ 학과별 최대키와 해당하는 학과의 학생 출력

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
멀티미디어공학과            179 김주현                                179
기계공학과                  177 오나라                                177
전자공학과                  177 김재수                                177
문헌정보학과                184 노정호                                184
기계공학과                  182 박동호                                182
컴퓨터공학과                182 일지매                                182
기계공학과                  182 박동호                                182
컴퓨터공학과                182 일지매                                182
소프트웨어공학과            168 이미경                                168


※ 해당 학년의 평균 키보다 큰 학생 출력 (인라인 뷰)

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
         1 안은수                                175      170.4
         1 인영민                                173      170.4
         1 김주현                                179      170.4
         2 일지매                                182      175.6
         2 노정호                                184      175.6
         3 오나라                                177      166.6
         3 임세현                                171      166.6
         4 서진수                                180      175.8
         4 김재수                                177      175.8
         4 박동호                                182      175.8


※ 급여가 많은 순서대로 순위(랭크) 5등까지 출력

SELECT rownum, name, pay
FROM (SELECT name, pay FROM professor ORDER BY 2 DESC)
WHERE rownum BETWEEN 1 AND 5
/

   RANKING NAME                                  PAY
---------- ------------------------------ ----------
         1 심슨                                  570
         2 조인형                                550
         3 김도형                                530
         4 바비                                  500
         5 주승재                                490


※ 교수 번호 정렬한 후 3건씩 분리해서 급여 합계, 평균 출력

SELECT rownum, profno, name, pay, SUM(pay), ROUND(AVG(pay), 1) 평균
FROM (SELECT profno, name, pay, rownum FROM professor)
GROUP BY CEIL(rownum/3), ROLLUP((profno, name, pay, rownum))
ORDER BY CEIL(rownum/3)
/

    ROWNUM     PROFNO NAME                   PAY   SUM(PAY)       평균
---------- ---------- --------------- ---------- ---------- ----------
         1       1001 조인형                 550        550        550
         2       1002 박승곤                 380        380        380
         3       1003 송도권                 270        270        270
                                                       1200        400
         4       2001 양선희                 250        250        250
         5       2002 김영조                 350        350        350
         6       2003 주승재                 490        490        490
                                                       1090      363.3
         7       3001 김도형                 530        530        530
         8       3002 나한열                 330        330        330
         9       3003 김현정                 290        290        290
                                                       1150      383.3
        10       4001 심슨                   570        570        570
        11       4002 최슬기                 330        330        330
        12       4003 박원범                 310        310        310
                                                       1210      403.3
        13       4004 차범철                 260        260        260
        14       4005 바비                   500        500        500
        15       4006 전민                   220        220        220
                                                        980      326.7
        16       4007 허은                   290        290        290
                                                        290        290


※ 시험 대비 1

drop table STUDENT2018 purge ; // 테이블 완전 삭제

CREATE TABLE STUDENT2018 (
  studno NUMBER(9) primary key,
  studname CHAR(15) not null,
  grade NUMBER(1) check(grade between 1 and 4),
  korean NUMBER(3),
  english NUMBER(3),
  math NUMBER(3),
  toeic NUMBER(3)
);

insert into STUDENT2018 values (201695112,'전인하',1,60,90,70,300);
insert into STUDENT2018 values (201695109,'박미경',1,60,50,50,400);
insert into STUDENT2018 values (201695107,'이동훈',1,60,70,80,700);
insert into STUDENT2018 values (201395114,'김진영',2,90,80,40,500);
insert into STUDENT2018 values (201395101,'오유석',2,90,90,90,900);
insert into STUDENT2018 values (201295111,'이몽룡',3,80,80,70,500);
insert into STUDENT2018 values (201295105,'성춘향',4,50,60,70,700);
insert into STUDENT2018 values (201095125,'박지수',4,90,90,90,900);
insert into STUDENT2018 values (201364007,'김준한',3,80,90,90,800);

    STUDNO NAME                 GRADE      KOREA    ENGLISH       MATH      TOEIC
---------- --------------- ---------- ---------- ---------- ---------- ----------
 201695112 전인하                   1         60         90         70        300
 201695109 박미경                   1         60         50         50        400
 201695107 이동훈                   1         60         70         80        700
 201395114 김진영                   2         90         80         40        500
 201395101 오유석                   2         90         90         90        900
 201295111 이몽룡                   3         80         80         70        500
 201295105 성춘향                   4         50         60         70        700
 201095125 박지수                   4         90         90         90        900
 201364007 김준한                   3         80         90         90        800


※ 시험 대비 2

SELECT studno, studname, grade, toeic,
ROUND(평균성적,1) 평균성적,
ROUND(평균성적*0.8+(toeic/10)*0.2) 총점
FROM (SELECT studno, studname, grade, toeic, (korean+english+math)/3 평균성적
	FROM STUDENT2018)
ORDER BY 총점 DESC
/

with e
as (	SELECT studno, studname, grade, toeic, (korean+english+math)/3 평균성적
	FROM STUDENT2018)
SELECT studno, studname, grade, toeic, ROUND(평균성적,1) 평균성적, ROUND(평균성적*0.8+(toeic/10)*0.2) 총점
FROM e
ORDER BY 총점 DESC
/

    STUDNO STUDNAME             GRADE      TOEIC   평균성적       총점
---------- --------------- ---------- ---------- ---------- ----------
 201395101 오유석                   2        900         90         90
 201095125 박지수                   4        900         90         90
 201364007 김준한                   3        800       86.7         85
 201295111 이몽룡                   3        500       76.7         71
 201695107 이동훈                   1        700         70         70
 201395114 김진영                   2        500         70         66
 201695112 전인하                   1        300       73.3         65
 201295105 성춘향                   4        700         60         62
 201695109 박미경                   1        400       53.3         51


※ 시험 대비 3 (단일행 함수가 2개)

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

↓가장 올바른 방법!!!
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


※ 시험 대비 4

with e
as (	SELECT studno, name, height, weight, height-110 표준체중,
	(weight-(height-110))/(height-110)*100 비만지수
	FROM student)
SELECT studno, name, height, weight, 표준체중, 비만지수,
	CASE 	WHEN 비만지수 >= 20 THEN '비만'
		WHEN 비만지수 >= 10 THEN '과체중'
		ELSE '정상'
	END "비만정도"
FROM e
/

↓ 더 복잡하고 이상
SELECT studno, name, height, weight,
	height-110 표준체중,
	(weight-(height-110))/(height-110)*100 비만지수,
	CASE 	WHEN (weight-(height-110))/(height-110)*100 >= 20 THEN '비만'
		WHEN (weight-(height-110))/(height-110)*100 >= 10 THEN '과체중'
		ELSE '정상'
	END "비만정도"
FROM student
/

    STUDNO NAME                HEIGHT     WEIGHT   표준체중   비만지수 비만정도
---------- --------------- ---------- ---------- ---------- ---------- ------------------
      9411 서진수                 180         72         70 2.85714286 정상
      9412 서재수                 172         64         62 3.22580645 정상
      9413 이미경                 168         52         58 -10.344828 정상
      9414 김재수                 177         83         67  23.880597 비만
      9415 박동호                 182         70         72 -2.7777778 정상
      9511 김신영                 164         48         54 -11.111111 정상
      9512 신은경                 161         42         51 -17.647059 정상
      9513 오나라                 177         55         67 -17.910448 정상
      9514 구유미                 160         58         50         16 과체중
      9515 임세현                 171         54         61  -11.47541 정상
      9611 일지매                 182         72         72          0 정상
      9612 김진욱                 171         70         61 14.7540984 과체중
      9613 안광훈                 175         82         65 26.1538462 비만
      9614 김문호                 166         51         56 -8.9285714 정상
      9615 노정호                 184         62         74 -16.216216 정상
      9711 이윤나                 162         48         52 -7.6923077 정상
      9712 안은수                 175         63         65 -3.0769231 정상
      9713 인영민                 173         69         63 9.52380952 정상
      9714 김주현                 179         81         69 17.3913043 과체중
      9715 허우                   163         51         53 -3.7735849 정상


※ 입사일부터 지금까지 날짜 수 출력

SELECT ename 이름, hiredate 입사일, sysdate 현재일,
	TRUNC(sysdate-hiredate) 근무일수,
	TRUNC(MONTHS_BETWEEN(sysdate, hiredate)/12) 근무년수,
	TRUNC(MONTHS_BETWEEN(sysdate, hiredate)) 근무월수,
	TRUNC((sysdate-hiredate)/7) 근무주수
FROM emp
/

이름                 입사일   현재일     근무일수   근무년수   근무월수   근무주수
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


※ 입사일부터 90일후, 6개월 후 등 날짜 출력

SELECT ename 성명, hiredate 입사일자, (hiredate+90) "입사일90일후",
	ADD_MONTHS(hiredate, 6) "입사일6개월후",
	ADD_MONTHS(sysdate, 6) "현재6개월후",
	LAST_DAY(hiredate)-hiredate "입사한달의근무일수",
	NEXT_DAY(hiredate+60,'월') "60일이후월요일",
	TO_CHAR(hiredate, 'YYYY"년 "MM"월 "DD"일"') 입사일
FROM emp
/


※ 이름이 6자 이상인 사람 앞3글자 소문자 출력

SELECT LOWER(SUBSTR(ename,1,3)) 이름
FROM emp
WHERE LENGTH(ename) >= 6
/

이름
------------------------
mar
tur
mil


※  10번 부서 중에서 30번 부서에는 없는 업무를 하는 사원 출력

SELECT empno 사원번호, ename 이름, dname 부서명, hiredate 입사일, loc 지역
FROM emp NATURAL JOIN dept
WHERE deptno =10 AND job NOT IN (SELECT job FROM emp WHERE deptno=30)
/


※  	INITCAP() 첫글자만 대문자 나머지 소문자
	LOWER() 전부 소문자
	UPPER() 전부 대문자
	LENGTH() / LENGTHB() 문자열의 길이(바이트수) 계산
	







