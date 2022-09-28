--1 ���������� ����� ������ ������� SGA
select sum(value) from v$sga;

--2 ���������� ������� ������� �������� ����� SGA
select * from v$sga_dynamic_components

--3 ���������� ������� ��� ������� ����
select component, granule_size from v$sga_dynamic_components

--4 ���������� ����� ��������� ��������� ������ � SGA
select current_size from v$sga_dynamic_free_memory;

--5 ���������� ������� ����� KEEP, DEFAULT, RECYCLE ��������� ����
select component, current_size, min_size
from v$sga_dynamic_components 
where component ='KEEP buffer cache' 
or component = 'DEFAULT buffer cache' 
or component = 'RECYCLE buffer cache';

--6 �������� �������, ������� ����� ���������� � ��� KEEP.
--����������������� ������� �������
create table Keept(x int) storage(buffer_pool keep);

select segment_name, segment_type, tablespace_name, buffer_pool 
from sys.user_segments 
where segment_name='Keept';

--7 �������� �������, ������� ����� ������������ � ���� default.
--������������������ ������ �������
create table Deft(x int) cache storage(buffer_pool default);

select segment_name, segment_type, tablespace_name, buffer_pool 
from sys.user_segments 
where segment_name='Deft';

--8 ������� ������ ������ �������� �������
show parameter log_buffer;

--9 ����� 10 ����� ������� �������� � ����������� ����
select pool, name, bytes 
from v$sgastat 
where pool = 'shared pool' 
order by bytes desc
fetch first 10 rows only;

--10 ������� ������ ��������� ������ � ������� ����
select pool, name, bytes 
from v$sgastat 
where pool = 'large pool' and name = 'free memory';

--11 �������� �������� ������� ���������� � ���������
select * from v$session;

--12 ���������� ������ ������� ��������� � ���������
select username, server from v$session;

--13*
select name
from v$db_object_cache  --��� ������� ������� ����������
order by executions desc ;
