-- network_config.sql
-- This script configures the network settings for the Oracle Database.

-- Listener Configuration
-- Create a listener for the Oracle Database
BEGIN
  DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);
END;
/

-- Set the listener parameters
ALTER SYSTEM SET local_listener='(ADDRESS = (PROTOCOL = TCP)(HOST = your-hostname)(PORT = 1521))' SCOPE=BOTH;

-- Verify listener configuration
SELECT name, value FROM v$parameter WHERE name = 'local_listener';

-- Service Names Configuration
-- Set the service names for the database
ALTER SYSTEM SET service_names='your-service-name' SCOPE=BOTH;

-- Verify service names configuration
SELECT name, value FROM v$parameter WHERE name = 'service_names';

-- Configure TNSNAMES.ORA
-- Adding entry for the TNSNAMES.ORA file
DECLARE
  l_tnsnames_entry VARCHAR2(32767);
BEGIN
  l_tnsnames_entry := 
    'your-service-name = ' ||
    '(DESCRIPTION = ' ||
    '  (ADDRESS = (PROTOCOL = TCP)(HOST = your-hostname)(PORT = 1521)) ' ||
    '  (CONNECT_DATA = ' ||
    '    (SERVER = DEDICATED) ' ||
    '    (SERVICE_NAME = your-service-name) ' ||
    '  ) ' ||
    ')';
  
  DBMS_NETWORK_ACL_ADMIN.append_host_ace (
    host => 'your-hostname',
    lower_port => 1521,
    upper_port => 1521,
    acl => 'tns_admin',
    principal => 'PUBLIC',
    privilege => 'connect',
    is_grant => TRUE
  );
END;
/

-- Restart the listener
BEGIN
  DBMS_XDB.restart_listener;
END;
/

-- Confirmation
SELECT * FROM v$parameter WHERE name IN ('local_listener', 'service_names');
