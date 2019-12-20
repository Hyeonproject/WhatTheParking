-- KIM, LEE 사용자 생성하기
CREATE USER KIM IDENTIFIED BY bluesky
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp;

CREATE USER LEE IDENTIFIED BY oradb
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp;

-- Grant 명령으로 접속, 사용 권한 주기
grant connect, resource, create session, create view to KIM;
grant connect, resource, create session, create view to LEE;

drop table 테이블명 purge;
purge recyclebin;
