--1
set serveroutput on size unlimited

declare 
fac faculty%rowtype;
begin 
select * into fac from faculty where faculty = 'ИЭФ';
dbms_output.put_line(fac.faculty ||' '||fac.faculty_name);
end;
--2-4
declare 
fac faculty%rowtype;
begin 
--select * into fac from faculty; --кол-во строк > запрош
select * into fac from faculty where faculty='Ф';
dbms_output.put_line(fac.faculty ||' '||fac.faculty_name);
exception
when no_data_found
then dbms_output.put_line('Данные не надйены');
when too_many_rows
then dbms_output.put_line('В результате несколько строк');
when others
then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
--5,7,9
begin
--update auditorium set auditorium = '301-3' where auditorium = '301-1';
--insert into auditorium values ('301-9', '301-1', 90, 'ЛК'); commit;
--insert into auditorium values ('301-8', '301-1', 90, 'ЛК'); rollback;
--delete from auditorium where auditorium = '301-9';
commit;
--rollback;
exception
when others 
then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;

select *from auditorium where auditorium like '301%';
--6,8,10
declare
sub auditorium%rowtype;
begin
--update auditorium set auditorium_capacity='Z' where auditorium='301-1';
--insert into auditorium values ('x', 'x', 'x', 'x');
--delete from auditorium where auditorium_capacity='x';
select * into sub from auditorium where auditorium_name='301-1';
exception
when others 
then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
--11
declare 
cursor cur is select * from teacher;
m_teacher   teacher.teacher%type;
m_teacher_name   teacher.teacher_name%type;
m_pulpit   teacher.pulpit%type;
begin
open cur;
loop
fetch cur into m_teacher, m_teacher_name, m_pulpit;
exit when cur%notfound;
dbms_output.put_line(' ' || cur%rowcount || ' ' || m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
end loop;
close cur;  
end;
--12
declare 
cursor cur is select * from subject;
rec subject%rowtype;
begin
open cur;
fetch cur into rec;
while cur%found
loop
dbms_output.put_line(' ' || cur%rowcount || ' ' || rec.subject || ' ' ||rec.subject_name || ' ' || rec.pulpit);
fetch cur into rec;
end loop;
close cur;
exception
when others
then dbms_output.put_line(sqlcode||' '||sqlerrm);   
end;
--13
declare
cursor cur is select pulpit.pulpit, teacher.teacher_name
from pulpit inner join teacher on pulpit.pulpit=teacher.pulpit;
rec cur%rowtype;
begin
for rec in cur
loop
dbms_output.put_line(cur%rowcount||' '||rec.teacher_name||' '||rec.pulpit);
end loop;
exception
when others
then dbms_output.put_line(sqlcode||' '||sqlerrm); 
end;
--14
declare 
cursor curs (capacity auditorium.auditorium_capacity%type, capacity1 auditorium.auditorium_capacity%type)
is select auditorium, auditorium_capacity, auditorium_type
from auditorium
where auditorium_capacity >= capacity and auditorium_capacity <= capacity1;
begin
dbms_output.put_line('capacity < 20 :');
for aum in curs(0,20)
loop dbms_output.put_line(aum.auditorium||' '); 
end loop;    
dbms_output.put_line('21 < capacity < 30 :');
for aum in curs(21,30)
loop dbms_output.put_line(aum.auditorium||' '); 
end loop;
dbms_output.put_line('31 < capacity < 60 :');
for aum in curs(31,60)
loop dbms_output.put_line(aum.auditorium||' '); 
end loop;  
dbms_output.put_line('61 < capacity < 80 :');
for aum in curs(61,80)
loop dbms_output.put_line(aum.auditorium||' '); 
end loop;
dbms_output.put_line('81 < capacity:');
for aum in curs(81,1000)
loop dbms_output.put_line(aum.auditorium||' ');
end loop;
exception
when others
then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
--15
variable x refcursor;
declare 
type teacher_name is ref cursor return teacher%rowtype;
xcurs teacher_name;
begin
open xcurs for select * from teacher;
:x := xcurs;
end;   

print x;
--16
declare 
cursor curs_aut is select auditorium_type,
cursor (select auditorium from auditorium aum
where aut.auditorium_type = aum.auditorium_type)
from auditorium_type aut;
curs_aum sys_refcursor;
aut auditorium_type.auditorium_type%type;
aum auditorium.auditorium%type;
txt varchar2(1000);
begin
open curs_aut;
fetch curs_aut into aut, curs_aum;
while(curs_aut%found)
loop
txt:=rtrim(aut)||':';
loop
fetch curs_aum into aum;
exit when curs_aum%notfound;
txt := txt||','||rtrim(aum);
end loop;
dbms_output.put_line(txt);
fetch curs_aut into aut, curs_aum;
end loop;
close curs_aut;
end;
--17
declare 
cursor cur(cap1 auditorium.auditorium%type, cap2 auditorium.auditorium%type)
is select auditorium, auditorium_capacity from auditorium
where auditorium_capacity between cap1 and cap2 for update;
aum auditorium.auditorium%type;
cap auditorium.auditorium_capacity%type;
begin
open cur(40,80);
fetch cur into aum, cap;
while(cur%found)
loop
cap := cap * 0.9;
update auditorium
set auditorium_capacity = cap
where current of cur;
dbms_output.put_line(' '||aum||' '||cap);
fetch cur into aum, cap;
end loop;
close cur; 
rollback;
end;
--18
declare 
cursor cur(cap auditorium.auditorium%type,cap1 auditorium.auditorium%type)
is select auditorium, auditorium_capacity from auditorium
where auditorium_capacity between cap and cap1 for update;
aum auditorium.auditorium%type;
cap auditorium.auditorium_capacity%type;
begin
open cur(0,20);
fetch cur into aum, cap;
while(cur%found)
loop
delete auditorium where current of cur;
fetch cur into aum, cap;
end loop;
close cur;    
for a in cur(0,120) loop
dbms_output.put_line(a.auditorium||' '||a.auditorium_capacity);
end loop; 
rollback;
end;
--19 
declare
cursor cur(capacity auditorium.auditorium%type)
is select auditorium, auditorium_capacity, rowid
from auditorium where auditorium_capacity >=capacity for update;
aum auditorium.auditorium%type;
cap auditorium.auditorium_capacity%type;
begin
for xxx in cur(80)
loop
if xxx.auditorium_capacity >= 90
then delete auditorium 
where rowid = xxx.rowid and xxx.auditorium_capacity >= 90;
elsif xxx.auditorium_capacity >= 40
then update auditorium
set auditorium_capacity = auditorium_capacity + 3
where rowid = xxx.rowid;
end if;
end loop;
for yyy in cur(80)
loop
dbms_output.put_line(yyy.auditorium||' '||yyy.auditorium_capacity);
end loop; 
rollback;
end;
--20
declare 
cursor cur is select *from teacher;
m_teacher   teacher.teacher%type;
m_teacher_name   teacher.teacher_name%type;
m_pulpit   teacher.pulpit%type;
begin
open cur;
loop
fetch cur into m_teacher, m_teacher_name, m_pulpit;
exit when cur%notfound;
dbms_output.put_line(' ' || cur%rowcount || ' ' || m_teacher || ' ' || m_teacher_name || ' ' || m_pulpit);
if (mod(cur%rowcount, 3) = 0) then dbms_output.put_line('-----------------------');
end if;
end loop;
close cur;
exception
when others
then dbms_output.put_line(sqlcode||' '||sqlerrm);    
end;