
¡Ø p.562

CREATE TABLE p1_test
( no 	NUMBER,
  name	VARCHAR2(10));

CREATE SEQUENCE p1_seq;

BEGIN
	INSERT INTO p1_test
	VALUES(p1_seq.NEXTVAL,'AAA');
END;
/

/

SELECT * FROM p1_test;

COMMIT;

¡Ø p.563

CREATE TABLE p1_test2
( no	NUMBER,
  name	VARCHAR2(10),
  addr	VARCHAR2(10));

SET VERIFY OFF

DECLARE
	v_no NUMBER := '&no';
	v_name VARCHAR2(10) := '&name';
	v_addr VARCHAR2(10) := '&addr';
BEGIN
	INSERT INTO p1_test2
	VALUES(v_no, v_name, v_addr);
END;
/

SELECT * FROM p1_test2;