. /home/informix/.bashrc
dbaccess -e - << EOF
DROP DATABASE testdb;

CREATE DATABASE testdb with log;
CREATE SEQUENCE test_id_seq;
CREATE TABLE informix.test  ( 
	id        	INTEGER NOT NULL,
	first_name	VARCHAR(50),
	PRIMARY KEY(id)
	ENABLED
)
LOCK MODE ROW;

CREATE SEQUENCE test_increm_id_seq;
CREATE TABLE test_increm  ( 
	id        	INTEGER NOT NULL,
	first_name	VARCHAR(50) NOT NULL,
	UPDATE_TS DATETIME YEAR TO SECOND DEFAULT current year to second NOT NULL,
	PRIMARY KEY(id)
	ENABLED
)
LOCK MODE ROW;

SELECT * FROM test;
SELECT * FROM test_increm;
EOF
