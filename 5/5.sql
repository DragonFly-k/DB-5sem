drop tablespace sed_qdata including contents and datafiles;
alter pluggable database sed_pdb close;

-- 1
select tablespace_name, file_name from dba_data_files; 
select tablespace_name, file_name from dba_temp_files; 
-- 2
create tablespace sed_qdata 
datafile 'sed_qdata.dbf'
size 10m
extent management local
offline;

alter tablespace sed_qdata online;
-----
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
select *from DBA_USERS; 
--drop user sed cascade;
create user sed identified by 12345;
grant create session,create table, create view, 
create procedure,drop any table,drop any view,
drop any procedure to sed;
-------------
alter user sed quota 2m on sed_qdata;
-- соединение sed к orcl
create table SED_T1(
x number(20) primary key,
y number(20)) tablespace sed_qdata;
grant insert on sed_t1 to sed;

insert into sed_t1 values (1, 101);
insert into sed_t1 values (2, 102);
insert into sed_t1 values (3, 103);
select * from sed_t1;
-- 3--cdb
select * from dba_segments where tablespace_name = 'SED_QDATA';
select * from dba_segments;
-- 4 --used
drop table SED_T1;
select * from user_recyclebin;
-- 5
flashback table sed_t1 to before drop;
SELECT * FROM sed_t1;
-- 6
begin
for x in 4..10004
loop
insert into sed_T1 values(x, x);
end loop;
commit;
end;

select count(*) from sed_t1;
-- 7 --sed
select * from DBA_EXTENTS where SEGMENT_NAME like 'sed_t1';
select extent_id, blocks, bytes from DBA_EXTENTS where SEGMENT_NAME like 'sed_t1';
select * from DBA_EXTENTS;
-- 8
drop tablespace sed_qdata including contents and datafiles;
-- 9
select * from v$log;
-- 10
select * from v$logfile;

-- 11-- 29.09.22
alter system switch logfile;
select * from v$log;

-- 12
alter database add logfile group 4 'C:\app\orcl\oradata\orcl\REDO04.LOG' size 50m blocksize 512;
alter database add logfile member 'C:\app\orcl\oradata\orcl\REDO041.LOG'  to group 4;
alter database add logfile member 'C:\app\orcl\oradata\orcl\REDO042.LOG'  to group 4;

select * from v$logfile;
select group#, sequence#, bytes, members, status, first_change# from v$log;
-- 13
alter database drop logfile member 'C:\app\orcl\oradata\orcl\REDO041.LOG';
alter database drop logfile member 'C:\app\orcl\oradata\orcl\REDO042.LOG';
alter database clear unarchived logfile group 4;
alter database drop logfile group 4;

select group#, sequence#, bytes, members, status, first_change# from v$log;
select * from v$logfile;
-- 14
select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;
-- 15
select * from v$archived_log;
-- 16 
-- включить архивирование через sqlplus на сервере
-- connect / as sysdba;
-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;
select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;
-- 17
ALTER SYSTEM SET LOG_ARCHIVE_DEST_1 ='LOCATION=C:\app\orcl\oradata\orcl\archive.arc';
alter system switch logfile;
select * from v$archived_log;
-- 18
-- alter database noarchivelog;
select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;
-- 19
select * from v$controlfile;
-- 20
show parameter control;
-- 21
-- C:\app\orcl\product\12.1.0\dbhome_1\database
-- 22 
create pfile = 'sed_pfile.ora' from spfile;
-- C:\app\orcle\product\12.1.0\dbhome_1\database\sed_pfile.ora
-- 23
-- C:\app\orcl\product\12.1.0\dbhome_1\database\PWDorcl.ora
select * from v$pwfile_users;
-- 24
select * from v$diag_info;
-- 25
-- C:\app\orcl\diag\rdbms\orcl\orcl\alert\log.xml