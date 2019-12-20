<���� �ð�>
select sysdate
from dual
/

SYSDATE
--------
18/09/14

<���˱��� �ѹ��� ���ݱ��� ������ �������� Ȯ��>
select sysdate - to_date('18/09/01') "DATE"
from dual
/

���̰� ��õ!
select sysdate - to_date('2018/09/01', 'YYYY/MM/DD') "DATE"
from dual
/

      DATE
----------
13.8719676

<�ǽ�1>
select studno, name, birthday
from student
where TO_CHAR(birthday,'MM')<7
/

���̰� ��õ!
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

<�ǽ�2>
select empno, ename, hiredate
from emp
where TO_CHAR(hiredate,'MM')<=3
/

���̰� ��õ!
select empno, ename, hiredate
from emp
where TO_CHAR(hiredate,'MM') IN (1,2,3);
/

     EMPNO ENAME                HIREDATE
---------- -------------------- --------
      7499 ALLEN                81/02/20
      7521 WARD                 82/02/22
      7934 MILLER               82/01/23

<�ڸ����� �߸��Ǿ��� ������ ������ �ȴ�>
select TO_CHAR(123456789, '99,999') from dual
/

TO_CHAR(123456
--------------
#######

<���ڿ� ǥ�õ��� �ʴ� ���ڴ� �ݿø��Ѵ�>
select TO_CHAR(12345.6789, '99,999.99') from dual
/

TO_CHAR(12345.6789,'
--------------------
 12,345.68

<��ȭ�� ǥ��>
select TO_CHAR(12345.6789, 'L999.999') from dual
/

TO_CHAR(12345.6789,'L99,999.99')
----------------------------------------
        ��12,345.68

<108p. �ǽ�>
select empno, ename, TO_CHAR(hiredate,'RRRR-MM-DD') "hiredate",
	TO_CHAR((sal*12)+NVL(comm,0),'$999,999') "sal",
	TO_CHAR(((sal*12)+NVL(comm,0))*1.15,'$999,999') "15% up"
from emp
where deptno = (select deptno 
		from dept 
		where dname='SALES')
/

��Ʋ����, comm�� NULL�� ��� ��ĭ���� ���͹�����. (NVL�� �̿��Ͽ� comm�� NULL������ 0���� �ٲ�����)
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











