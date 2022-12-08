create user c##sed identified by Ks7631738;

GRANT CREATE DATABASE LINK TO c##sed;
grant drop database link to c##sed;
GRANT CREATE PUBLIC DATABASE LINK TO c##sed;
select * from all_db_links;

drop database link con11;

CREATE DATABASE LINK con1
CONNECT TO system
IDENTIFIED BY Ks7631738
USING '(DESCRIPTION =
(ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.155.4)(PORT = 1521))
(CONNECT_DATA =(SERVER = DEDICATED)(SERVICE_NAME = orcl)))';
  
select * from faculty@con1;
insert into faculty@con1 values('dfkj','jdkj');
update faculty@con1 set faculty='skldk' where faculty_name ='jdkj';
delete faculty@con1 where faculty='skldk';
begin
system.teachers.get_teachers_by_faculty@con1('PAP');
dbms_output.put_line('------------------');
dbms_output.put_line(system.TEACHERS.GET_NUM_TEACHERS@con1('PAP'));
end; 
  
select * from dba_db_links;
drop public database link con2;


CREATE PUBLIC DATABASE LINK con2
CONNECT TO system
IDENTIFIED BY root
USING 'WIN-6IHV1UBSKKP:1521/orcl';
 
select * from faculty@con2;
insert into faculty@con2 values('dfkj','jdkj');
update faculty@con2 set faculty='skldk' where faculty_name ='jdkj';
delete faculty@con2 where faculty='skldk';
begin
teachers.get_teachers_by_faculty@CON2(FCODE=>'PAP');
dbms_output.put_line('------------------');
dbms_output.put_line(TEACHERS.GET_NUM_TEACHERS@CON2('PAP'));
end;