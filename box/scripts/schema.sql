-- Set database into single user mode
ALTER DATABASE db CONNECTION LIMIT 1;

-- disconnect all users
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'db';

-- drop database
DROP DATABASE IF EXISTS db;

-- Create the database	
CREATE DATABASE db with OWNER = postgres ENCODING = 'UTF8';	
\connect db;
