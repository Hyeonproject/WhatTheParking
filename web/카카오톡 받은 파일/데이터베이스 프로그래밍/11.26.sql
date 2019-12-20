※ 이론시험 답은 의미, 쓰는 이유, 활용분야등 적기 (문제보다 답을 길게)


※ PL/SQL 활성화 (필수!!!)

SET SERVEROUTPUT ON;


※ 트리거 이용하여 로그 남기기

CREATE TABLE EMP2_LOG (
  SEQ_NO       NUMBER PRIMARY KEY,
  EMPNO       NUMBER,
  NAME        VARCHAR2(30) NOT NULL,
  N_DEPTNO      VARCHAR2(06),
  N_PAY         NUMBER,
  N_POSITION    VARCHAR2(30),
  O_DEPTNO      VARCHAR2(06),
  O_PAY         NUMBER,
  O_POSITION    VARCHAR2(30),
  FLAG	     CHAR(06),
  LOGTIME     DATE	
);

CREATE SEQUENCE log_seq
     INCREMENT BY 1 
     START WITH 1
     CACHE 2 ;  

create or replace trigger emp2_log_trigger
	after insert or update or delete on emp2
	for each row
begin
	if INSERTING then
		insert into emp2_log(seq_no, empno, name, n_deptno, n_pay, n_position, flag, logtime)
		values (log_seq.nextval, :new.empno, :new.name, :new.deptno, :new.pay, :new.position, 'I', sysdate);
	elsif UPDATING then
		insert into emp2_log(seq_no, empno, name,  n_deptno, n_pay, n_position, o_deptno, o_pay, o_position, flag, logtime)
		values (log_seq.nextval, :new.empno, :new.name, :new.deptno, :new.pay, :new.position, :old.deptno, :old.pay, :old.position, 'U', sysdate);
	elsif DELETING then
		insert into emp2_log(seq_no, empno, name, o_deptno, o_pay, o_position, flag, logtime)
		values (log_seq.nextval, :old.empno, :old.name, :old.deptno, :old.pay, :old.position, 'D', sysdate);
	end if;
end;
/

INSERT INTO EMP2 VALUES (20000211,'Donald Trump',TO_DATE('19801215','YYYYMMDD'),'1005','Intern','031)345-3456','Reading book', 20000000,'',19960303);

UPDATE EMP2 SET deptno = '1004' WHERE empno = 20000211;

DELETE FROM EMP2 WHERE empno = 20000211;


※ emp2 테이블 참조해서 AL pacino를 지운고 난뒤, 1000번의 부서 사람 수는 1명입니다를 출력
(insert한 후는 다시 2명이 되게해라)
(★ PRAGMA AUTONOMOUS_TRANSACTION; 문을 사용하는 이유 : 테이블 수정 이후 select로 같은 테이블을 볼려고 하니 발생하는 오류 예방)
(★ 트리거 안에서 고치고 있는 테이블을 건드리면 안되는 이유 : )
(★ 트리거안에 commit이나 rollback을 쓰면 안된다 : 밖에서 insert 등이 commit과 rollback을 해줄꺼기 때문에)
CREATE OR REPLACE TRIGGER emp2_cnt_trigger
	AFTER INSERT OR DELETE ON emp2
	FOR EACH ROW
DECLARE
	PRAGMA AUTONOMOUS_TRANSACTION;
	v_count NUMBER;
	v_deptno NUMBER;
BEGIN
	CASE
	 WHEN INSERTING THEN
		v_deptno := :new.deptno;
	 WHEN DELETING THEN
		v_deptno := :old.deptno;
	END CASE;

	SELECT count(*)
	INTO v_count
	FROM emp2
	WHERE deptno = v_deptno;

	CASE
	 WHEN INSERTING THEN
		v_count := v_count+1;
	 WHEN DELETING THEN
		v_count := v_count-1;
	END CASE;

	DBMS_OUTPUT.PUT_LINE(v_deptno || '번 부서의 인원 수 : ' || v_count);
END;
/


DELETE FROM EMP2 WHERE name = 'AL Pacino';

INSERT INTO EMP2 VALUES (19960101,'AL Pacino',TO_DATE('19730322','YYYYMMDD'),'1000','Permanent employee','02)6255-8000','reading',72000000,'Department head',19900101);


※시험예상 문제들

스토어 프로시저는 단연코 커서
펑션은 셀렉트 파라미터 값 유의
트리거 뉴, 올드, 폴이치로우

