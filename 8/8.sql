--1
--C:\app\oracl\product\12.1.0\dbhome_1\NETWORK\ADMIN

--2
show parameter instance

--3
--sqlplus /nolog
--connect system/Ks7631738@//localhost:1521/PDB
select * from v$tablespace;
select * from sys.dba_data_files;
select * from dba_role_privs;
select * from all_users;

--4 regedit

--5,6 
--connect sed/12345@sed_pdb

--7
select * from sed_t1;

--8
help timing
timi start
timi show
select * from t;
timi stop

--9
describe sed_t1

--10
select *from dba_segments where owner = 'sed'; -- sed
select * from user_segments;  --tns

--11
create view L8 as
select count(*) as count,
    sum(extents) as count_extents,
    sum(blocks) as count_blocks,
    sum(bytes) as Kb from user_segments;
    
select * from l8;