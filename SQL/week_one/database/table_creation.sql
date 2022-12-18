-- Schema name is cards_ingest. You can use own schema
create table cards_ingest.dept(
  deptno     int,
  dname      varchar(14),
  loc        varchar(13)
);

create table cards_ingest.emp(
  empno    int,
  ename    varchar(10),
  job      varchar(9),
  mgr      int,
  hiredate date,
  sal      decimal(7,2),
  comm     decimal(7,2),
  deptno   int
);
