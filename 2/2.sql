--������� ��������� ��-�� ��� ����.�-� � ���.���-��
create tablespace ts_SED
datafile 'C:\����\2\ts_SED.dbf'
size 7M
reuse autoextend on next 5M
maxsize 20M;

--����.����.��-�� ��� ����.�-� � ���.���-��
create temporary tablespace ts_SED_TEMP
tempfile 'C:\����\2\ts_SED_TEMP.dbf'
size 5M
reuse autoextend on next 3M
maxsize 30M;

--�����.��� ����.��-�� � ���.select-������� � �������
select tablespace_name, contents logging from SYS.DBA_TABLESPACES;

--������� ���� (���������� - ������.�� ����.� ��������; ���� ����, ���������, ��������� � �-���)
--alter session set "_ORACLE_SCRIPT"=true;
create role RL_SEDCORE;
commit;

grant 
create session,
create table, 
create view, 
create procedure to RL_SEDCORE;
      
grant 
drop any table,
drop any view,
drop any procedure to RL_SEDCORE;

--� ���.������-������� ����� ���� � ������� � �� ����������
SELECT grantee, privilege 
FROM SYS.dba_sys_privs 
where grantee = 'RL_SEDCORE';

--�������� ������� ���-��� � ������� ��� �� ��
create profile PF_SEDCORE limit
    password_life_time 180      --���-�� ���� ����� ������
    sessions_per_user 3         --���-�� ������ ��� �����
    failed_login_attempts 7     --���-�� ������� �����
    password_lock_time 1        --���-�� ���� ����� ����� ������
    password_reuse_time 10      --����� ���� ���� ����� ��������� ������
    password_grace_time default --���-�� ���� ����������.� ����� ������
    connect_time 180            --����� ���� (���)
    idle_time 30 ;              --���-�� ��� ������� 
    
--select: ��� �������, ��� ���-�� ������ ������, ��� ���-�� ������� default
select profile from dba_profiles;
select * from dba_profiles where profile = 'PF_SEDCORE';
select * from dba_profiles where profile = 'DEFAULT';

--������� �����.� ��� ���-��:
create user SEDCORE identified by 12345
default tablespace ts_SED quota unlimited on ts_SED
temporary tablespace ts_SED_TEMP
profile PF_SEDCORE
account unlock
password expire;

grant RL_SEDCORE to SEDCORE;
grant CREATE TABLESPACE, ALTER TABLESPACE to SEDCORE;

drop user SEDCORE cascade;

create tablespace SED_QDATA OFFLINE
datafile 'C:\����\2\SED_QDATA.txt'
size 10M reuse
autoextend on next 5M
maxsize 20M;

alter tablespace SED_QDATA online;

ALTER USER SEDCORE QUOTA 2M ON SED_QDATA;

CREATE TABLE t (c NUMBER);

INSERT INTO t(c) VALUES(3);
INSERT INTO t(c) VALUES(1);
INSERT INTO t(c) VALUES(2);

SELECT * FROM t;