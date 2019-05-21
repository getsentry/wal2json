ALTER SYSTEM SET wal_level = logical;
ALTER SYSTEM SET max_replication_slots = 1;

ALTER SYSTEM SET client_min_messages = NOTICE;
