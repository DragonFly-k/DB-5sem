sqlplus /nolog
connect sys/Ks7631738@//localhost:1521/orcl as sysdba
alter pluggable database all open;
connect sed/12345@sed_pdb

SET SERVEROUTPUT ON;
--1
begin
null;
end;
--2 
declare 
x char(20) :=  'Hello world';
begin
dbms_output.put_line(x);
end;
/

declare 
z number (10, 2);
begin 
z := 5/0;
dbms_output.put_line('Hello world');
EXCEPTION
when OTHERS
then dbms_output.put_line('sqlcode - ' || sqlcode|| chr(10) || 'sqlerrn - ' || sqlerrm);
end;
--3 
declare
z number(10 , 2) := 3;
begin
dbms_output.put_line('z = '||z);
begin
z := z/0;
exception
when OTHERS
then dbms_output.put_line('sqlcode - ' || sqlcode|| chr(10) || 'sqlerrn - ' || sqlerrm);
end;
dbms_output.put_line('z = '||z);
end;
--4 
show parameter plsql_warnings;
--5 
select keyword from v$reserved_words where length = 1 and keyword != 'A';
--6
select keyword from v$reserved_words where length > 1 and keyword != 'A' order by keyword;
--7 
select name,value from v$parameter where name like 'plsql%';
show parameter plsql;
--8

-- 9-16
declare
n1 number(3):= 25;  --9
n2 number(3):= 10;
div number(10,2); --10
f1 number(10,2)    := 3.14; --11
f2 number(8,3)    := 188.555;
o1 number(7, -2) := 1254567.89; --12
o2 number(8,-4) := 123456789.985;
bf binary_float:= 123456789.12345678911;--13
bd binary_double    := 123456789.12345678911; --14
e1 number := 0.95e-10; --15
e2 number := 12.345e-10;
b1 boolean:= true;   --16
b2 boolean := false;
begin
dbms_output.put_line('целые числа:');  --9
dbms_output.put_line('n1 = ' || n1);
dbms_output.put_line('n2 = ' || n2);
dbms_output.put_line('арифметические операции с челыми числами:');--10
dbms_output.put_line('n1+n2 = '||(n1+n2));
dbms_output.put_line('n1-n = '||(n1-n2));
dbms_output.put_line('n1*n2 = '||(n1*n2));
dbms_output.put_line('n1/n2 = '||n1/n2);
div:= mod(n1,n2);
dbms_output.put_line('n1%n2 = '||div);
dbms_output.put_line('числа с фиксированной точкой:'); --11
dbms_output.put_line('f1 = ' || f1);
dbms_output.put_line('f2 = ' || f2);
dbms_output.put_line('числа с фикс.точкой и отриц.масштабом(округление):');--12
dbms_output.put_line('1254567.89(7,-2) = '||o1);
dbms_output.put_line('123456789.985(8,-4) = '||o2);
dbms_output.put_line('BINARY_FLOAT: '); --13
dbms_output.put_line('bf = ' || bf); 
dbms_output.put_line('BINARY_DOUBLE: '); --14
dbms_output.put_line('bd = '||bd);
dbms_output.put_line('числа с точкой и применением символа E'); --15
dbms_output.put_line('0.95e-10 = ' || e1);
dbms_output.put_line('12.345e-10 = ' || e2);
if b1     then dbms_output.put_line('b1 = ' || 'true'); end if; --16
if not b2 then dbms_output.put_line ('b2 = ' || 'false'); end if; 
end;
--17
declare
n constant number(5) := 9;
v constant varchar2(5) := '2 hi';
c constant char(5) := 'hello';
begin
dbms_output.put_line('const n = '||n);
dbms_output.put_line('const n + n = '||(n+n));    
dbms_output.put_line('const n * 5 = '||(n*5)); 
dbms_output.put_line('const v = '||v);
dbms_output.put_line('const c = '||c);
end;
-- 18-19
select * from faculty;
declare
b char(5) := 'hello';
g b%TYPE := 'world';   
r faculty%ROWTYPE; 
begin
dbms_output.put_line('b = '||b);
dbms_output.put_line('g = '||g);
r.faculty := 'best';
dbms_output.put_line(r.faculty);
end;
--20
declare
x number := 20;
begin
if x<10 then
dbms_output.put_line('10 > '||x);
elsif x=10 then 
dbms_output.put_line('10 = '||x);
else 
dbms_output.put_line('10 < '||x);
end if;
end;
--22
declare
x number := 22;
begin
case x
when 22 then dbms_output.put_line('22');
else dbms_output.put_line('else');
end case;
case
when x=13 then dbms_output.put_line('13 ='||x);
when x between 14 and 55 then dbms_output.put_line('14 <= '||x||' <= 55');
else dbms_output.put_line('else');
end case;
end;
-- 23 -25
declare 
i number(3) := 0;
begin
loop
dbms_output.put_line(i); --23
i := i + 1;
exit when i > 5;
end loop;
dbms_output.put_line('-------------------');
while(i>0) --24
loop
dbms_output.put_line(i);
i := i - 1;
end loop;
dbms_output.put_line('-------------------');
for k in 1..5 --25
loop
dbms_output.put_line(k);
end loop;
end;