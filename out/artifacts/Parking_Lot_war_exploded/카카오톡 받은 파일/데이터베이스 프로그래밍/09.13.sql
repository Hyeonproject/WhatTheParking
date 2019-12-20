<현재 시간>
select sysdate
from dual
/

SYSDATE
--------
18/09/14

<포맷까지 한번에 지금까지 몇일이 지났는지 확인>
select sysdate - to_date('18/09/01') "DATE"
from dual
/

↓이걸 추천!
select sysdate - to_date('2018/09/01', 'YYYY/MM/DD') "DATE"
from dual
/

      DATE
----------
13.8719676

<실습1>
select studno, name, birthday
from student
where TO_CHAR(birthday,'MM')<7
/

↓이걸 추천!
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

<실습2>
select empno, ename, hiredate
from emp
where TO_CHAR(hiredate,'MM')<=3
/

↓이걸 추천!
select empno, ename, hiredate
from emp
where TO_CHAR(hiredate,'MM') IN (1,2,3);
/

     EMPNO ENAME                HIREDATE
---------- -------------------- --------
      7499 ALLEN                81/02/20
      7521 WARD                 82/02/22
      7934 MILLER               82/01/23

<자릿수가 잘못되었기 때문에 오류가 된다>
select TO_CHAR(123456789, '99,999') from dual
/

TO_CHAR(123456
--------------
#######

<점뒤에 표시되지 않는 숫자는 반올림한다>
select TO_CHAR(12345.6789, '99,999.99') from dual
/

TO_CHAR(12345.6789,'
--------------------
 12,345.68

<원화로 표시>
select TO_CHAR(12345.6789, 'L999.999') from dual
/

TO_CHAR(12345.6789,'L99,999.99')
----------------------------------------
        ￦12,345.68

<108p. 실습>
select empno, ename, TO_CHAR(hiredate,'RRRR-MM-DD') "hiredate",
	TO_CHAR((sal*12)+NVL(comm,0),'$999,999') "sal",
	TO_CHAR(((sal*12)+NVL(comm,0))*1.15,'$999,999') "15% up"
from emp
where deptno = (select deptno 
		from dept 
		where dname='SALES')
/

↓틀린것, comm이 NULL인 경우 빈칸으로 나와버린다. (NVL을 이용하여 comm의 NULL값들을 0으로 바꿔주자)
select empno, ename, TO_CHAR(hiredate,'RRRR-MM-DD') "hiredate", TO_CHAR((sal*12)+comm,'$999,999') "sal", TO_CHAR(((sal*12)+comm)*1.15,'$999,999') "15% up"
from emp
where deptno = (select deptno from dept where dname='SALES')
/

     EMPNO ENAME                hiredate             sal                15% up
---------- -------------------- -------------------- ------------------ ------------------
      7499 ALLEN                1981-02-20             $19,500            $22,425
      7521 WARD                 1982-02-22             $15,500            $17,825
      7654 MARTIN               1981-09-28             $16,400            $18,860
      7698 BLAKE                1981-05-01             $34,200            $39,330
      7844 TURNER               1981-09-08             $18,000            $20,700
      7900 JAMES                1981-12-03             $11,400            $13,110











