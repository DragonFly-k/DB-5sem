--1 ������ ������ ������� ���������
select * from v$bgprocess;

--2	���������� ������� ��������, ������� �������� � �������� � ��������� ������.
select * from v$process ; 

--3	����������, ������� ��������� DBWn �������� � ��������� ������.
select * from v$process where pname like 'DBW%';

--4 �������� ������� ���������� � �����������.
select * from v$instance;

--5 ���������� ������ ���� ����������.
select username, server from v$session where username is not null;

--6 ���������� �������.
select * from v$services;    

--7	�������� ��������� ��� ��������� ���������� � �� ��������.
show parameter DISPATCHERS;

--8 ������� � ������ Windows-�������� ������, ����������� ������� LISTENER.

--9 �������� �������� ������� ���������� � ���������. (dedicated, shared). 
select username, server from v$session where username is not null;

--10	����������������� � �������� ���������� ����� LISTENER.ORA. 
--C:\app\oracl\product\12.1.0\dbhome_1\NETWORK\ADMIN

--11	��������� ������� lsnrctl � �������� �� �������� �������. 
--start, stop,status,services, version, reload 
--save_config, trace, exit, quit, help, set, show

--12 �������� ������ ����� ��������, ������������� ��������� LISTENER. 
--lsnrctl status, start, stop