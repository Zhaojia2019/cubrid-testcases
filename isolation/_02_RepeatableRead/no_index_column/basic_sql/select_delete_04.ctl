/*
Test Case: delete & select
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/no_index_column/basic_sql/select_delete.ctl 
Author: Lily

Test Point:
C1 select a row, C2 delete same row. overlapped

NUM_CLIENTS = 1
C1: SELECT * FROM tb1 WHERE name='Jonh' ORDER BY dept_id,name;
C1: DELETE FROM tb1 WHERE name='Jonh';
*/
MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;
/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1(dept_id INT NOT NULL, name VARCHAR(20), sex ENUM('F', 'M') );
C1: INSERT INTO tb1 VALUES(102,'Lucy','F');
C1: INSERT INTO tb1 VALUES(102,'Tom','M');
C1: INSERT INTO tb1 VALUES(101,'Mike','F');
C1: INSERT INTO tb1 VALUES(102,'Jonh','M');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: SELECT * FROM tb1 WHERE name='Jonh' ORDER BY dept_id,name;
MC: wait until C1 ready;
C2: DELETE FROM tb1 WHERE name='Jonh';
C2: SELECT * FROM tb1 ORDER BY dept_id,name;
C2: commit;
MC: wait until C2 ready;
C1: SELECT * FROM tb1 WHERE name='Jonh' ORDER BY dept_id,name;
C1: commit;
C1: SELECT * FROM tb1 WHERE name='Jonh' ORDER BY dept_id,name;

C1: SELECT * FROM tb1 WHERE name='Lucy' ORDER BY dept_id,name;
MC: wait until C1 ready;
C2: DELETE FROM tb1 WHERE name='Lucy';
C2: SELECT * FROM tb1 ORDER BY dept_id,name;
C2: rollback;
C2: SELECT * FROM tb1 ORDER BY dept_id,name;
MC: wait until C2 ready;
C1: SELECT * FROM tb1 ORDER BY dept_id,name;
C1: commit work;

C2: commit;
C2: quit;
C1: quit;
