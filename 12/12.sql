--1 
set serveroutput on size unlimited
--alter table TEACHER drop column BIRTHDAY;
--alter table TEACHER drop column SALARY;
alter table TEACHER add BIRTHDAY date;
alter table TEACHER add SALARY number(6,2);

declare
cursor cur is select TEACHER, BIRTHDAY, SALARY from TEACHER;
bd TEACHER.BIRTHDAY % type;
sal TEACHER.SALARY % type;
begin
for row_teacher in cur
loop
bd := TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2000-01-01','J'),TO_CHAR(DATE '2005-12-31','J'))),'J');
sal := Round(DBMS_RANDOM.Value(20000, 200000)) / 100;
update TEACHER set TEACHER.BIRTHDAY = bd, TEACHER.SALARY = sal where TEACHER.TEACHER = row_teacher.TEACHER;
end loop;
end;

select * from teacher;
--2
select teacher_name from TEACHER;
select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||
substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'. '||
substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'. '
from teacher;
--3 
select * from teacher where TO_CHAR((birthday), 'd') = 2;
--4
create view NextMonthBirth as 
select * from TEACHER 
where to_char(BIRTHDAY,'Month') = to_char(sysdate + 30,'Month');

select * from NextMonthBirth;
-- drop view NextMonthBirth; 
--5
create view COUNT_BIRTHDAY_TEACHER as 
select to_char(birthday, 'Month') Месяц, count(*) Количество
from teacher
group by to_char(birthday, 'Month')
having count(*)>=1;

select * from COUNT_BIRTHDAY_TEACHER;
-- drop view COUNT_BIRTHDAY_TEACHER;
--6
cursor TeacherBirtday(teacher%rowtype) 
return teacher%rowtype is
select * from teacher
where MOD((TO_CHAR(sysdate,'yyyy') - TO_CHAR(birthday, 'yyyy')+1), 10)=0;
--7
cursor Salary(teacher%rowtype) return salary%type is
select pulpit,floor(avg(salary)) from teacher
group by pulpit;

select P.faculty, round(AVG(T.salary),3)
from teacher T inner join pulpit P on T.pulpit = P.pulpit
group by P.faculty
union
select teacher.pulpit, floor(avg(salary)) 
from teacher
group by teacher.pulpit
order by faculty;
    
select round(avg(salary),3) from teacher;
--8
declare
type contacts is record( 
email VARCHAR2(50),
phone number(13));
type person is record(
name teacher.teacher_name%type,
pulpit teacher.pulpit%type,
contact contacts);
per1 PERSON;
begin
per1.name:= 'dszfsd';
per1.pulpit:='FIT';
per1.contact.email := 'isjdk@mail.ru';
per1.contact.phone := 5562564;
dbms_output.put_line( per1.name||' '|| per1.pulpit||' '|| per1.contact.email||'  '|| per1.contact.phone);
end;