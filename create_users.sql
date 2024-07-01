-- create_users.sql
-- This script creates database users and assigns appropriate privileges.

-- Create a user for general use
CREATE USER general_user IDENTIFIED BY password
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

-- Grant necessary privileges to the general user
GRANT CONNECT, RESOURCE TO general_user;
GRANT CREATE SESSION TO general_user;
GRANT CREATE TABLE TO general_user;
GRANT CREATE VIEW TO general_user;
GRANT CREATE PROCEDURE TO general_user;
GRANT CREATE SEQUENCE TO general_user;
GRANT CREATE TRIGGER TO general_user;

-- Create a user with administrative privileges
CREATE USER admin_user IDENTIFIED BY password
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

-- Grant necessary privileges to the admin user
GRANT CONNECT, RESOURCE, DBA TO admin_user;

-- Create a read-only user
CREATE USER read_only_user IDENTIFIED BY password
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON users;

-- Grant read-only privileges to the read-only user
GRANT CONNECT TO read_only_user;
GRANT SELECT ANY TABLE TO read_only_user;

-- Verify the creation and privileges of the users
SELECT username, account_status FROM dba_users WHERE username IN ('GENERAL_USER', 'ADMIN_USER', 'READ_ONLY_USER');
SELECT grantee, granted_role FROM dba_role_privs WHERE grantee IN ('GENERAL_USER', 'ADMIN_USER', 'READ_ONLY_USER');
SELECT grantee, privilege FROM dba_sys_privs WHERE grantee IN ('GENERAL_USER', 'ADMIN_USER', 'READ_ONLY_USER');
SELECT grantee, owner, table_name, privilege FROM dba_tab_privs WHERE grantee IN ('GENERAL_USER', 'ADMIN_USER', 'READ_ONLY_USER');
