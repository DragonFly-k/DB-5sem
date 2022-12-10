ALTER SESSION SET nls_date_format='dd-mm-yyyy';

create table orders
(
 id number(10) primary key, 
 text varchar2(20), 
 date_value date
);

drop table orders;
select * from orders;
delete from orders;

--sqlplus
spool 'export.txt';
select * from orders;
spool off;