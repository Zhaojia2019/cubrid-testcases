-- This testcase use modified Oracle samples. See below for the license:
-- Copyright (c) 2015 Oracle
-- Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.
drop table if exists emp; 

CREATE TABLE emp ("EMPNO" NUMERIC(4,0),  "ENAME" VARCHAR(10), "JOB" VARCHAR(9), "MGR" NUMERIC(4,0),  "TEST_DATE" DATE, 
  "SAL" NUMERIC(7,2), "COMM" NUMERIC(7,2), "DEPTNO" NUMERIC(2,0),"SAL2" INTEGER);

INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7839,'KING','PRESIDENT',null,to_date('1981/11/17','YYYY/MM/DD'),5000,null,10, 5000);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7698,'BLAKE','MANAGER',7839,to_date('1981/05/01','YYYY/MM/DD'),2850,null,30, 2850);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7782,'CLARK','MANAGER',7839,to_date('1981/06/09','YYYY/MM/DD'),2450,null,10, 2450);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7566,'JONES','MANAGER',7839,to_date('1981/04/02','YYYY/MM/DD'),2975,null,20, 2975);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7788,'SCOTT','ANALYST',7566,to_date('1982/12/09','YYYY/MM/DD'),3000,null,20, 3000);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7902,'FORD','ANALYST',7566,to_date('1981/12/03','YYYY/MM/DD'),3000,null,20, 3000);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7369,'SMITH','CLERK',7902,to_date('1980/12/17','YYYY/MM/DD'),800,null,20, 800);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7499,'ALLEN','SALESMAN',7698,to_date('1981/02/20','YYYY/MM/DD'),1600,300,30, 1600);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7521,'WARD','SALESMAN',7698,to_date('1981/02/22','YYYY/MM/DD'),1250,500,30, 1250);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7654,'MARTIN','SALESMAN',7698,to_date('1981/09/28','YYYY/MM/DD'),1250,1400,30, 1250);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7844,'TURNER','SALESMAN',7698,to_date('1981/09/08','YYYY/MM/DD'),1500,0,30, 1500);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7876,'ADAMS','CLERK',7788,to_date('1983/01/12','YYYY/MM/DD'),1100,null,20, 1100);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7900,'JAMES','CLERK',7698,to_date('1981/12/03','YYYY/MM/DD'),950,null,30, 950);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7934,'MILLER','CLERK',7782,to_date('1982/01/23','YYYY/MM/DD'),1300,null,10, 1300);


SELECT DISTINCT e.deptno
  ,COUNT(e.empno) OVER(PARTITION BY e.deptno) AS dept_emp_count
  ,COUNT(e.empno) OVER(PARTITION BY 1) AS overall_emp_count
  ,ROUND(((COUNT(e.empno) OVER (PARTITION BY e.deptno) * 100) / COUNT(e.empno) OVER(PARTITION BY 1)), 2) AS deptno_emp_perc
FROM emp e
ORDER BY deptno;

SELECT DISTINCT e.deptno
  ,COUNT(e.empno) OVER(PARTITION BY e.deptno) AS dept_emp_count
  ,COUNT(e.empno) OVER(PARTITION BY 1) AS overall_emp_count
  ,ROUND(((COUNT(e.empno) OVER (PARTITION BY e.deptno) * 100) / COUNT(e.empno) OVER(PARTITION BY 1)), 2) AS deptno_emp_perc
FROM emp e 
ORDER BY deptno;

SELECT DISTINCT deptno
	,(COUNT(empno) OVER(PARTITION BY deptno))*100  AS overall_emp_count100
	,COUNT(empno) OVER(PARTITION BY 1)  AS overall_emp_count
	,COUNT(empno) OVER(PARTITION BY deptno)  AS overall_emp_count
FROM emp ORDER BY deptno;

SELECT DISTINCT e.deptno
  ,COUNT(e.empno) OVER(PARTITION BY e.deptno) AS dept_emp_count
  ,COUNT(e.empno) OVER() AS overall_emp_count
  ,ROUND(((COUNT(e.empno) OVER (PARTITION BY e.deptno) * 100) / COUNT(e.empno) OVER()), 2) AS deptno_emp_perc
FROM emp e
ORDER BY deptno;

drop table emp; 

CREATE TABLE emp ("EMPNO" NUMERIC(4,0),  "ENAME" VARCHAR(10), "JOB" VARCHAR(9), "MGR" NUMERIC(4,0),  "TEST_DATE" DATE, 
  "SAL" NUMERIC(7,2), "COMM" NUMERIC(7,2), "DEPTNO" NUMERIC(2,0),"SAL2" INTEGER) partition by hash(ENAME) partitions 3;

INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7839,'KING','PRESIDENT',null,to_date('1981/11/17','YYYY/MM/DD'),5000,null,10, 5000);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7698,'BLAKE','MANAGER',7839,to_date('1981/05/01','YYYY/MM/DD'),2850,null,30, 2850);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7782,'CLARK','MANAGER',7839,to_date('1981/06/09','YYYY/MM/DD'),2450,null,10, 2450);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7566,'JONES','MANAGER',7839,to_date('1981/04/02','YYYY/MM/DD'),2975,null,20, 2975);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7788,'SCOTT','ANALYST',7566,to_date('1982/12/09','YYYY/MM/DD'),3000,null,20, 3000);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7902,'FORD','ANALYST',7566,to_date('1981/12/03','YYYY/MM/DD'),3000,null,20, 3000);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7369,'SMITH','CLERK',7902,to_date('1980/12/17','YYYY/MM/DD'),800,null,20, 800);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7499,'ALLEN','SALESMAN',7698,to_date('1981/02/20','YYYY/MM/DD'),1600,300,30, 1600);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7521,'WARD','SALESMAN',7698,to_date('1981/02/22','YYYY/MM/DD'),1250,500,30, 1250);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7654,'MARTIN','SALESMAN',7698,to_date('1981/09/28','YYYY/MM/DD'),1250,1400,30, 1250);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7844,'TURNER','SALESMAN',7698,to_date('1981/09/08','YYYY/MM/DD'),1500,0,30, 1500);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7876,'ADAMS','CLERK',7788,to_date('1983/01/12','YYYY/MM/DD'),1100,null,20, 1100);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7900,'JAMES','CLERK',7698,to_date('1981/12/03','YYYY/MM/DD'),950,null,30, 950);
INSERT INTO emp (EMPNO,ENAME,JOB,MGR,TEST_DATE,SAL,COMM,DEPTNO,sal2) VALUES (7934,'MILLER','CLERK',7782,to_date('1982/01/23','YYYY/MM/DD'),1300,null,10, 1300);

SELECT DISTINCT e.deptno
  ,COUNT(e.empno) OVER(PARTITION BY e.deptno) AS dept_emp_count
  ,COUNT(e.empno) OVER(PARTITION BY 1) AS overall_emp_count
  ,ROUND(((COUNT(e.empno) OVER (PARTITION BY e.deptno) * 100) / COUNT(e.empno) OVER(PARTITION BY 1)), 2) AS deptno_emp_perc
FROM emp e
ORDER BY deptno;

SELECT DISTINCT e.deptno
  ,COUNT(e.empno) OVER(PARTITION BY e.deptno) AS dept_emp_count
  ,COUNT(e.empno) OVER(PARTITION BY 1) AS overall_emp_count
  ,ROUND(((COUNT(e.empno) OVER (PARTITION BY e.deptno) * 100) / COUNT(e.empno) OVER(PARTITION BY 1)), 2) AS deptno_emp_perc
FROM emp e
ORDER BY deptno;

SELECT DISTINCT deptno
	,(COUNT(empno) OVER(PARTITION BY deptno))*100  AS overall_emp_count100
	,COUNT(empno) OVER(PARTITION BY 1)  AS overall_emp_count
	,COUNT(empno) OVER(PARTITION BY deptno)  AS overall_emp_count
FROM emp ORDER BY deptno;

SELECT DISTINCT e.deptno
  ,COUNT(e.empno) OVER(PARTITION BY e.deptno) AS dept_emp_count
  ,COUNT(e.empno) OVER() AS overall_emp_count
  ,ROUND(((COUNT(e.empno) OVER (PARTITION BY e.deptno) * 100) / COUNT(e.empno) OVER()), 2) AS deptno_emp_perc
FROM emp e
ORDER BY deptno;

drop table emp; 

