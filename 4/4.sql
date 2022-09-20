--1.5
select * from v$pdbs;
--2
select * from v$instance;
--3
select * from product_component_version;
--4 pdb config
--6
create tablespace SED_PDB_TS
datafile 'C:\Лабы\4\SED_PDB_TS.dbf'
size 7m
reuse autoextend on next 5m
maxsize 20m;
commit;

drop tablespace SED_PDB_TS including contents

create temporary tablespace SED_PDB_TEMP_TS
tempfile 'C:\Лабы\4\SED_PDB_TEMP_TS.dbf'
size 7m
reuse autoextend on next 3m
maxsize 30m;
commit;

alter session set "_ORACLE_SCRIPT"= true;
create role SED_RL_PDB;
grant create session, create table,
create view, create procedure,
drop any table, drop any view, 
create tablespace,
drop any procedure to SED_RL_PDB;
      
alter session set container = cdb$root;
create profile SED_PDB_PF limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30;
  commit;
    
  create user U1_SED_PDB identified by 12344
  default tablespace SED_PDB_TS quota unlimited on SED_PDB_TS
  temporary tablespace  SED_PDB_TEMP_TS
  profile SED_PDB_PF
  account unlock;
  grant SED_RL_PDB to U1_SED_PDB;
  commit;


--7
create table Person
(name char(30),
age number(3));
insert into Person values('Kate', 19);
commit;
select * from Person;

drop table person
--8
select * from ALL_USERS;
select * from DBA_TABLESPACES;
select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;
select * from DBA_ROLES;
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;
select * from DBA_PROFILES;


--9
create user c##SED identified by 1111;
grant create session to c##SED
drop user c##SED;

select *from v$session
