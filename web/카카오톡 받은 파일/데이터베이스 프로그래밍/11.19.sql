※ PL/SQL 활성화 (필수!!!)

SET SERVEROUTPUT ON;


※ 트리거

CREATE TABLE torder
( no		NUMBER,
  ord_code	VARCHAR2(10),
  ord_date	DATE);

CREATE OR REPLACE TRIGGER t_order
	BEFORE INSERT ON torder
BEGIN
	IF (TO_CHAR(sysdate, 'HH24:MI') NOT BETWEEN '13:50' AND '14:00') THEN
		RAISE_APPLICATION_ERROR(-20100, '허용시간 아닙니다.');
	END IF;
END;
/

INSERT INTO torder VALUES (1, 'C100', SYSDATE);
INSERT INTO torder VALUES (2, 'C200', SYSDATE);
INSERT INTO torder VALUES (3, 'C300', SYSDATE);

DROP trigger t_order;
DROP table torder purge;

※ 트리거 2
(delete는 new가 없기 떄문에 첫번째 if문이 실행이 안된다.)

CREATE OR REPLACE TRIGGER t_order
	BEFORE insert or update on torder
FOR EACH ROW
BEGIN
	IF (:new.ord_code) not in ('C100') THEN
		IF Updating THEN
			DBMS_OUTPUT.PUT_LINE(:old.ord_code);
		END IF;
		RAISE_APPLICATION_ERROR(-20200, '제품코드가 틀립니다.');
	END IF;
END;
/

INSERT INTO torder VALUES (2, 'C100', SYSDATE);
INSERT INTO torder VALUES (3, 'C300', SYSDATE);
UPDATE torder set ord_code = 'c200' WHERE no = 2;


※ 레포트 8번

CREATE OR REPLACE TRIGGER t_emp
	AFTER INSERT ON emp
FOR EACH ROW
BEGIN
	SELECT COUNT(*), AVG(sal)
	INTO v_count, v_sal
	FROM emp
	WHERE deptno = :new.deptno
	GROUP BY deptno
	
	DBMS_OUTPUT.PUT_LINE(v_count);
	DBMS_OUTPUT.PUT_LINE(v_sal);
END;
/

	



























	