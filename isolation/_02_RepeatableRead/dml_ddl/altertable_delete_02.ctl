/*
Test Case: alter table & delete
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/dml_ddl/altertable_delete_01.ctl
Author: Lily

Test Point:
-    Alter table: SCH_M_LOCK on the table object
-    Delete: X_LOCK acquired on current instance. 
C1 alter table, C2 delete rows, then C2 is blocked.
when C1 committed, C2 failed delete(because of the column is deleted). 

NUM_CLIENTS = 2
C1: ALTER TABLE tb1 DROP COLUMN col; 
C2: DELETE FROM tb1 WHERE col = 'efg';
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1(id INT PRIMARY KEY,col VARCHAR(10), grade INT);
C1: INSERT INTO tb1 VALUES(1,'abc',10);
C1: INSERT INTO tb1 VALUES(2,'efg',11);
C1: INSERT INTO tb1 VALUES(3,'hijk',12);
C1: commit work;

/* test case */
C1: DELETE FROM tb1 WHERE id =1;
C1: ALTER TABLE tb1 DROP COLUMN col;
C1: insert into tb1 VALUES(4,11);
MC: wait until C1 ready;

C2: DELETE FROM tb1 WHERE id=2;
MC: wait until C2 blocked;

C1: commit work;
MC: wait until C1 ready;
MC: wait until C2 ready;

C2: select * from tb1 order by id,2;
C2: commit work;
C2: select * from tb1 order by id,2;
C2: commit work;
MC: wait until C2 ready;

C2: quit;
C1: quit;
