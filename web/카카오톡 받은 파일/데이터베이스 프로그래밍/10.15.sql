333p 제약조건의 종류

INSERT INTO EMP2 VALUES (20000310,'김신라',TO_DATE('19801215','YYYYMMDD'),'1025','인턴직','031)345-3456','독서', 20000000,'',19960303);

SELECT empno, name, emp_type, dname
FROM emp2 LEFT OUTER JOIN dept2 ON (deptno = dcode)
/

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT2 (DCODE);	//외래키 설정
(외래키 설정을 하기위해 썼지만 이미 오류인 레코드가 있기 때문에 수정 후 다시 해주자)


UPDATE EMP2
SET deptno = '1005'
WHERE empno = 20000310
/
(내용 수정)


INSERT INTO EMP2 VALUES (20000311,'이가야',TO_DATE('19801215','YYYYMMDD'),'1025','인턴직','031)345-3456','독서', 20000000,'',19960303);
(외래키를 설정해주었기 때문에 부모테이블에 없는 값이기 때문에 오류!)

ALTER TABLE EMP2 DROP CONSTRAINT EMP2_DEPTNO_FK //외래키 삭제

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT2 (DCODE) ON DELETE CASCADE;	//캐스캐이드 설정

DELETE FROM dept2
WHERE dcode = '1005'
/

rollback; //복원


ALTER TABLE EMP2 DROP CONSTRAINT EMP2_DEPTNO_FK //외래키 삭제

ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT2 (DCODE) ON DELETE SET NULL; //온딜리트셋널 설정


DELETE FROM dept2
WHERE dcode = '1005'
/
(제약조건이 NOT NULL로 되어있기 때문에 NULL로 변경이 안되니 오류!)



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

INSERT INTO V_EMP1 VALUES (20000315,'성춘향','인턴직','S/W지원');
(조인했던 뷰에 삽입은 오류! 두개의 테이블에 삽입을 다 못하므로~)

INSERT INTO V_EMP2 VALUES (20000315,'성춘향','인턴직',1005);
(단순 뷰에는 삽입 가능, emp2테이블 나머지 부분은 NULL로 바뀐다!!!)


CREATE OR REPLACE VIEW v_emp3
AS
  SELECT empno, name, emp_type, deptno
  FROM emp2
  WHERE deptno = '1005'
/

INSERT INTO V_EMP3 VALUES (20000316,'이몽룡','인턴직',1006);
(삽입은 되지만 보이진 않는다)


delete from emp2 where empno = 20000316;


CREATE OR REPLACE VIEW v_emp3
AS
  SELECT empno, name, emp_type, deptno
  FROM emp2
  WHERE deptno = '1005'
  WITH CHECK OPTION
/

INSERT INTO V_EMP3 VALUES (20000316,'이몽룡','인턴직',1006);
(WITH CHECK OPTION으로 인해 삽입시, WHERE절을 검사하기 때문에 오류라고 뜬다!)



































