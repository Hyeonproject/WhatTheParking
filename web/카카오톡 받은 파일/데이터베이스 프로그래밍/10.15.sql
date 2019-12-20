333p ���������� ����

INSERT INTO EMP2 VALUES (20000310,'��Ŷ�',TO_DATE('19801215','YYYYMMDD'),'1025','������','031)345-3456','����', 20000000,'',19960303);

SELECT empno, name, emp_type, dname
FROM emp2 LEFT OUTER JOIN dept2 ON (deptno = dcode)
/

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT2 (DCODE);	//�ܷ�Ű ����
(�ܷ�Ű ������ �ϱ����� ������ �̹� ������ ���ڵ尡 �ֱ� ������ ���� �� �ٽ� ������)


UPDATE EMP2
SET deptno = '1005'
WHERE empno = 20000310
/
(���� ����)


INSERT INTO EMP2 VALUES (20000311,'�̰���',TO_DATE('19801215','YYYYMMDD'),'1025','������','031)345-3456','����', 20000000,'',19960303);
(�ܷ�Ű�� �������־��� ������ �θ����̺� ���� ���̱� ������ ����!)

ALTER TABLE EMP2 DROP CONSTRAINT EMP2_DEPTNO_FK //�ܷ�Ű ����

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT2 (DCODE) ON DELETE CASCADE;	//ĳ��ĳ�̵� ����

DELETE FROM dept2
WHERE dcode = '1005'
/

rollback; //����


ALTER TABLE EMP2 DROP CONSTRAINT EMP2_DEPTNO_FK //�ܷ�Ű ����

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT2 (DCODE) ON DELETE SET NULL; //�µ���Ʈ�³� ����


DELETE FROM dept2
WHERE dcode = '1005'
/
(���������� NOT NULL�� �Ǿ��ֱ� ������ NULL�� ������ �ȵǴ� ����!)



CREATE OR REPLACE VIEW v_emp2
AS
  SELECT empno, name, emp_type, deptno
  FROM emp2
/


CREATE OR REPLACE VIEW v_emp1
AS
  SELECT empno, name, emp_type, dname
  FROM emp2 LEFT OUTER JOIN dept2 ON (deptno = dcode)
/

INSERT INTO V_EMP1 VALUES (20000315,'������','������','S/W����');
(�����ߴ� �信 ������ ����! �ΰ��� ���̺� ������ �� ���ϹǷ�~)

INSERT INTO V_EMP2 VALUES (20000315,'������','������',1005);
(�ܼ� �信�� ���� ����, emp2���̺� ������ �κ��� NULL�� �ٲ��!!!)


CREATE OR REPLACE VIEW v_emp3
AS
  SELECT empno, name, emp_type, deptno
  FROM emp2
  WHERE deptno = '1005'
/

INSERT INTO V_EMP3 VALUES (20000316,'�̸���','������',1006);
(������ ������ ������ �ʴ´�)


delete from emp2 where empno = 20000316;


CREATE OR REPLACE VIEW v_emp3
AS
  SELECT empno, name, emp_type, deptno
  FROM emp2
  WHERE deptno = '1005'
  WITH CHECK OPTION
/

INSERT INTO V_EMP3 VALUES (20000316,'�̸���','������',1006);
(WITH CHECK OPTION���� ���� ���Խ�, WHERE���� �˻��ϱ� ������ ������� ���!)



































