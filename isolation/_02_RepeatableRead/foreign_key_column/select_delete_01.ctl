/*
Test Case: delete & select
Priority: 1
Reference case: 
Author: Lily

Test Point:
B reference A,  test the behavior
select B,then delete A

NUM_CLIENTS = 2
C1: select from referenced table where sleep(1,col); 
C2: delete from reference table;
C2: commit;
C1: commit;
*/
MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;
C2: commit;
/* preparation */
C1: DROP TABLE IF EXISTS t_foreign;
C1: DROP TABLE IF EXISTS t_primary;
C1: CREATE TABLE t_primary(id INT PRIMARY KEY,col VARCHAR(10));
C1: CREATE TABLE t_foreign(id INT,col VARCHAR(10),FOREIGN KEY(id) REFERENCES t_primary(id) ON DELETE CASCADE);
C1: INSERT INTO t_primary VALUES(1,'a');
C1: INSERT INTO t_primary VALUES(2,'b');
C1: INSERT INTO t_foreign VALUES(1,'test');
C1: INSERT INTO t_foreign VALUES(1,'do');
C1: INSERT INTO t_foreign VALUES(2,'make');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: SELECT t_foreign.* FROM (select sleep(2)) x, t_foreign order by 1,2;
MC: sleep 1;
C2: DELETE FROM t_primary WHERE id=1;
MC: wait until C2 ready;
C2: commit;
MC: sleep 1;
C1: SELECT * FROM t_primary ORDER BY 1,2;
C1: SELECT * FROM t_foreign ORDER BY 1,2;
C1: commit;
C1: SELECT * FROM t_primary ORDER BY 1,2;
C1: SELECT * FROM t_foreign ORDER BY 1,2;
C1: commit;

C2: quit;
C1: quit;

