create table SED_t ( x number(3), s varchar2(50) PRIMARY KEY);

--INSERT (3 строки), + COMMIT
insert into SED_t (x, s) values  (1, 'FIRST');
insert into SED_t (x, s) values  (2, 'SECOND');
insert into SED_t (x, s) values  (3, 'THIRD');
commit;

select * from SED_t;

--UPDATE(2) + commit
update SED_t set x = 3, s = 'NEW' where x=1;
update SED_t set x = 4, s = 'STRING' where x=2;
commit;

select * from sed_t;

--select (по усл, агрег.ф-ции)
select x, s from SED_tt where x = 3;
select sum (x * 10) from SED_t; 
select avg (x) from SED_t;        

--delete(1) + commit
delete from SED_t where x = 4;
commit;

select * from SED_t;

--создать табл xxx_t1, связ.отнош.внешн.ключа с табл.ххх_t
create table SED_t1
(z number(3) PRIMARY KEY, b varchar2(50),
FOREIGN KEY (b)  REFERENCES SED_t (s));

insert  into SED_t1(z, b) values (5, 'NEW');
 
select * from SED_t1;

--select (левое и правое соед)
--внутр-> все строки, кот.удовл.усл.
select x, s, z , b
    from SED_t inner join SED_t1 on x = z;
    
--левое-> все строки слева от ON и те из другой, где поля равны
select x, s, z , b
    from SED_t left outer join SED_t1 on x = z;

--правое внешн
select x, s, z , b
    from SED_t right outer join SED_t1 on x = z;
    
--полное внешн
select x, s, z , b
    from SED_t full outer join SED_t1 on x = z;
    
--drop  для 2х таблиц
drop table SED_t1;
drop table SED_t;