--1 полный список фоновых процессов
select * from v$bgprocess;

--2	Определите фоновые процессы, которые запущены и работают в настоящий момент.
select * from v$process ; 

--3	Определите, сколько процессов DBWn работает в настоящий момент.
select * from v$process where pname like 'DBW%';

--4 перечень текущих соединений с экземпляром.
select * from v$instance;

--5 Определите режимы этих соединений.
select username, server from v$session where username is not null;

--6 Определите сервисы.
select * from v$services;    

--7	Получите известные вам параметры диспетчера и их значений.
show parameter DISPATCHERS;

--8 Укажите в списке Windows-сервисов сервис, реализующий процесс LISTENER.

--9 Получите перечень текущих соединений с инстансом. (dedicated, shared). 
select username, server from v$session where username is not null;

--10	Продемонстрируйте и поясните содержимое файла LISTENER.ORA. 
--C:\app\oracl\product\12.1.0\dbhome_1\NETWORK\ADMIN

--11	Запустите утилиту lsnrctl и поясните ее основные команды. 
--start, stop,status,services, version, reload 
--save_config, trace, exit, quit, help, set, show

--12 Получите список служб инстанса, обслуживаемых процессом LISTENER. 
--lsnrctl status, start, stop