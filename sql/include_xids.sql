\set VERBOSITY terse

-- predictability
SET synchronous_commit = on;

DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (id int);

SELECT 'init' FROM pg_create_logical_replication_slot('regression_slot', 'wal2json');

-- One row should have three records and one xids
INSERT INTO tbl VALUES (1);
SELECT count(*) = 3, count(distinct ((data::json)->'xid')::text) = 1 FROM pg_logical_slot_get_changes('regression_slot', NULL, NULL, 'include-xids', '1');

-- Two rows should have six records and two xids
INSERT INTO tbl VALUES (2);
INSERT INTO tbl VALUES (3);
SELECT count(*) = 6, count(distinct ((data::json)->'xid')::text) = 2 FROM pg_logical_slot_get_changes('regression_slot', NULL, NULL, 'include-xids', '1');

-- Two rows in one transaction should have four records and three times the same id
INSERT INTO tbl VALUES (4), (5);
SELECT count(*) = 4, count(((data::json)->'xid')::text) = 3 FROM pg_logical_slot_get_changes('regression_slot', NULL, NULL, 'include-xids', '1');

SELECT 'stop' FROM pg_drop_replication_slot('regression_slot');

