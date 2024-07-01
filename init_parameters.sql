-- init_parameters.sql
-- This script sets essential initialization parameters for the Oracle Database.

-- Set the database block size
ALTER SYSTEM SET db_block_size = 8192 SCOPE = SPFILE;

-- Set the size of the database cache
ALTER SYSTEM SET db_cache_size = 512M SCOPE = SPFILE;

-- Set the size of the shared pool
ALTER SYSTEM SET shared_pool_size = 256M SCOPE = SPFILE;

-- Set the size of the large pool
ALTER SYSTEM SET large_pool_size = 128M SCOPE = SPFILE;

-- Set the size of the Java pool
ALTER SYSTEM SET java_pool_size = 128M SCOPE = SPFILE;

-- Set the PGA aggregate target
ALTER SYSTEM SET pga_aggregate_target = 256M SCOPE = SPFILE;

-- Set the SGA target
ALTER SYSTEM SET sga_target = 1G SCOPE = SPFILE;

-- Set the maximum number of processes
ALTER SYSTEM SET processes = 300 SCOPE = SPFILE;

-- Set the maximum number of sessions
ALTER SYSTEM SET sessions = 335 SCOPE = SPFILE;

-- Enable automatic memory management
ALTER SYSTEM SET memory_target = 2G SCOPE = SPFILE;
ALTER SYSTEM SET memory_max_target = 2G SCOPE = SPFILE;

-- Set the character set for the database
ALTER SYSTEM SET nls_language = 'AMERICAN' SCOPE = SPFILE;
ALTER SYSTEM SET nls_territory = 'AMERICA' SCOPE = SPFILE;

-- Enable ARCHIVELOG mode
ALTER SYSTEM SET log_archive_dest_1 = 'LOCATION=/u01/app/oracle/oradata/archivelog' SCOPE = SPFILE;
ALTER SYSTEM SET log_archive_format = 'ARC%S_%R.%T' SCOPE = SPFILE;

-- Set the undo tablespace
ALTER SYSTEM SET undo_tablespace = 'UNDOTBS1' SCOPE = SPFILE;
ALTER SYSTEM SET undo_retention = 900 SCOPE = SPFILE;

-- Set the open cursors parameter
ALTER SYSTEM SET open_cursors = 300 SCOPE = SPFILE;

-- Set the audit trail parameter
ALTER SYSTEM SET audit_trail = 'DB' SCOPE = SPFILE;
ALTER SYSTEM SET audit_file_dest = '/u01/app/oracle/admin/orcl/adump' SCOPE = SPFILE;

-- Print out confirmation
SELECT name, value FROM v$parameter WHERE name IN (
  'db_block_size', 'db_cache_size', 'shared_pool_size', 'large_pool_size',
  'java_pool_size', 'pga_aggregate_target', 'sga_target', 'processes',
  'sessions', 'memory_target', 'memory_max_target', 'nls_language',
  'nls_territory', 'log_archive_dest_1', 'log_archive_format', 'undo_tablespace',
  'undo_retention', 'open_cursors', 'audit_trail', 'audit_file_dest'
);

-- Restart the database to apply the changes
SHUTDOWN IMMEDIATE;
STARTUP;
