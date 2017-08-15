/*
Test Case: delete & delete 
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/index_column/common_index/basic_sql/delete_delete_09.ctl
Author: Ray

Test Plan: 
Test DELETE locks (X_LOCK on instance) if the delete instances of the transactions are overlapped (with single index)

Test Scenario:
C1 delete, C2 delete, the affected rows are overlapped (based on where clause)
C1,C2 where clause are not on index (i.e. heap scan)
C1 delete instances contain the instances from C2 delete 
C1 rollback, C2 commit
Metrics: data size = small, index = single index, where clause = simple, DELETE state = single table deletion

Test Point:
1) C2 needs to wait C1 completed
2) The instances of C1 won't be deleted since rollback, the instances of C2 will be deleted
   (i.e.the version won't be updated, the C2 search condition is totally satisfied) 

NUM_CLIENTS = 3
C1: delete from table t1;  
C2: delete from table t1;  
C3: select on table t1; C3 is used to check the updated result
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS t1;
C1: CREATE TABLE t1(id INT, col VARCHAR(10));
C1: CREATE INDEX idx_id on t1(id);
C1: INSERT INTO t1 VALUES(1,'abc');INSERT INTO t1 VALUES(2,'def');INSERT INTO t1 VALUES(3,'ghi');INSERT INTO t1 VALUES(4,'jkl');INSERT INTO t1 VALUES(5,'mno');INSERT INTO t1 VALUES(6,'pqr');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: DELETE FROM t1 WHERE col = 'abc' or col = 'def' or col = 'pqr';
MC: wait until C1 ready;
C2: DELETE FROM t1 WHERE col = 'abc' or col = 'def';
/* expect: C2 needs to wait until C1 completed */
MC: wait until C2 blocked;
/* expect: C1 select - id = 1,2,6 are deleted */
C1: SELECT * FROM t1 order by 1,2;
C1: rollback;
/* expect: 2 rows deleted message should generated once C2 ready, C2 select - id = 1,2 are deleted */
MC: wait until C2 ready;
C2: SELECT * FROM t1 order by 1,2;
C2: commit;
/* expect: the instances of id = 1,2 are deleted */
C3: select * from t1 order by 1,2;

C3: commit;
C1: quit;
C2: quit;
C3: quit;