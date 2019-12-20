<112p. 시험문제>
select empno, ename, sal, comm, NVL2(DECODE(comm,0,null,comm), comm*2, sal/2)"BONUS", sal+NVL2(DECODE(comm,0,null,comm), comm*2, sal/2)"TOTAL"
from emp
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

<120p. 퀴즈1> ===3,4일 경우까지 생각해서 만들어 보자!!!===
select name, jumin, DECODE(SUBSTR(jumin,7,1),1,'남자','여자')"Gender"
from student
where deptno1 = 101
/

↓where절 안쓰고 만들지만 나머지 학생 공란 생성
select name, jumin, DECODE(deptno1,101,DECODE(SUBSTR(jumin,7,1),1,'남자','여자'))"Gender"
from student
/

NAME                           JUMIN                      Gender
------------------------------ -------------------------- ------------
서진수                         7510231901810              남자
김신영                         7601232186327              여자
일지매                         7711291186223              남자
이윤나                         7808192157498              여자

<120p. 퀴즈2> ==항상 else를 추가해줘야 한다. (나머지 지역)==
select name, tel, DECODE(SUBSTR(tel,1,INSTR(tel, ')')-1),055,'강남',
						02, '서울',
						031,'경기',
						051,'부산',
						052,'울산',
						053,'대구')"LOC"
from student
where deptno1 = 101
/

NAME                           TEL                            LOC
------------------------------ ------------------------------ ------------
서진수                         055)381-2158                   강남
김신영                         055)333-6328                   강남
일지매                         02)6788-4861                   서울
이윤나                         055)278-3649                   강남

<120p. 퀴즈3> =을 IN으로 해도 가능! 차이점은???
select name, jumin, DECODE(SUBSTR(jumin,7,1),1,'남자','여자')"Gender"
from student
where deptno1 IN (select deptno
		from department
		where part = (select deptno 
			from department 
			where dname='컴퓨터정보학부'))
ORDER BY name
/

NAME                           JUMIN                      Gender
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

<120p. 퀴즈4>
select name, tel, DECODE(SUBSTR(tel,1,INSTR(tel, ')')-1),055,'강남',
						02, '서울',
						031,'경기',
						051,'부산',
						052,'울산',
						053,'대구')"LOC"
from student
where deptno1 IN (select deptno
		from department
		where part IN (select deptno 
			from department 
			where dname='컴퓨터정보학부'))
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




