--создать табличное пр-во для пост.д-х с зад.пар-ми
create tablespace ts_SED
datafile 'C:\Лабы\2\ts_SED.dbf'
size 7M
reuse autoextend on next 5M
maxsize 20M;

--созд.табл.пр-во для врем.д-х с зад.пар-ми
create temporary tablespace ts_SED_TEMP
tempfile 'C:\Лабы\2\ts_SED_TEMP.dbf'
size 5M
reuse autoextend on next 3M
maxsize 30M;

--получ.все табл.пр-ва с пом.select-запроса к словарю
select tablespace_name, contents logging from SYS.DBA_TABLESPACES;

--создать роль (привилегии - разреш.на соед.с сервером; созд табл, представл, процедуры и ф-ции)
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

--с пом.селект-запроса найти роль в словаре и ее привилегии
SELECT grantee, privilege 
FROM SYS.dba_sys_privs 
where grantee = 'RL_SEDCORE';

--созздать профиль без-сти с опциями как на лк
create profile PF_SEDCORE limit
    password_life_time 180      --кол-во дней жизни пароля
    sessions_per_user 3         --кол-во сессий для юзера
    failed_login_attempts 7     --кол-во попыток ввода
    password_lock_time 1        --кол-во дней блока после ошибок
    password_reuse_time 10      --через скок дней можно повторить пароль
    password_grace_time default --кол-во дней предупрежд.о смене пароля
    connect_time 180            --время соед (мин)
    idle_time 30 ;              --кол-во мин простоя 
    
--select: все профили, все пар-ры нашего пофиля, все пар-ры профиля default
select profile from dba_profiles;
select * from dba_profiles where profile = 'PF_SEDCORE';
select * from dba_profiles where profile = 'DEFAULT';

--создать польз.с зад пар-ми:
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
datafile 'C:\Лабы\2\SED_QDATA.txt'
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