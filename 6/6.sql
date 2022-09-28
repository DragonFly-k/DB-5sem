--1 определить общий размер область SGA
select sum(value) from v$sga;

--2 определить текущие размеры основных пулов SGA
select * from v$sga_dynamic_components

--3 определить гранулы для каждого пула
select component, granule_size from v$sga_dynamic_components

--4 определить объем доступной свободной памяти в SGA
select current_size from v$sga_dynamic_free_memory;

--5 определить размеры пулов KEEP, DEFAULT, RECYCLE буферного кэша
select component, current_size, min_size
from v$sga_dynamic_components 
where component ='KEEP buffer cache' 
or component = 'DEFAULT buffer cache' 
or component = 'RECYCLE buffer cache';

--6 создайте таблицу, которая будет помешаться в пул KEEP.
--продемонстрируйте сегмент таблицы
create table Keept(x int) storage(buffer_pool keep);

select segment_name, segment_type, tablespace_name, buffer_pool 
from sys.user_segments 
where segment_name='Keept';

--7 создайте таблицу, которая будет кэшироваться в пуле default.
--Продемонстрировать семент таблицы
create table Deft(x int) cache storage(buffer_pool default);

select segment_name, segment_type, tablespace_name, buffer_pool 
from sys.user_segments 
where segment_name='Deft';

--8 найдите размер буфера журналов повтора
show parameter log_buffer;

--9 найти 10 самых больших объектов в разделяемом пуле
select pool, name, bytes 
from v$sgastat 
where pool = 'shared pool' 
order by bytes desc
fetch first 10 rows only;

--10 найдите размер свободной памяти в большом пуле
select pool, name, bytes 
from v$sgastat 
where pool = 'large pool' and name = 'free memory';

--11 получить перечень текущих соединений с инстансом
select * from v$session;

--12 определите режимы текущих оединений с инстансом
select username, server from v$session;

--13*
select name
from v$db_object_cache  --все обьекты которые кэшируются
order by executions desc ;
