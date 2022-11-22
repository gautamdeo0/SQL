create database labins;
use labins;
show tables;
create table PERSON(
 driver_id varchar(20),
 Namee varchar(20),
 address varchar(50),
 primary key(driver_id)
 );
 create table CAR(
 reg_num varchar(20),
 model varchar(20),
 years date,
 primary key(reg_num)
 );
 create table ACCIDENT(
 report_num varchar(15),
 accident_date date,
 location varchar(20),
 primary key(report_num)
 );
 create table OWNS(
 driver_id varchar(30),
 reg_num varchar(20),
 primary key(driver_id,reg_num),
 foreign key(driver_id) references PERSON(driver_id),
 foreign key(reg_num) references CAR(reg_num)
 );
 create table PARTCIPATED(
 driver_id varchar(30),
 reg_num varchar(20),
 report_num varchar(15),
 damage_amount float,
 primary key(driver_id,reg_num,report_num),
 foreign key(driver_id) references PERSON(driver_id),
 foreign key(reg_num) references CAR(reg_num),
 foreign key(report_num) references ACCIDENT(report_num)
);
insert into PERSON
values("1","Raj","B_26/5 banglore"),
("2","shiva","C_54/5 banglore"),
("3","shayam","B_26/23banglore"),
("4","prem","D_54/5 banglore"),
("5","param","E_21/3 banglore");

insert into Car
values("12","swift102","2013-02-25"),
("22","evo203","2014-05-12"),
("32","rover22","2009-12-02"),
("42","classic101","2008-01-23"),
("52","disk17","2021-02-22");

insert into ACCIDENT
values("1232","2021-03-25","banglore"),
("2234","2020-06-12","Delhi"),
("3267","2018-11-02","banglore"),
("4276","2017-10-23","Mumbai"),
("5267","2022-09-22","Delhi");

insert into OWNS
values("1","12"),
("2","22"),
("3","32"),
("4","42"),
("5","52");

insert into  PARTCIPATED
values("1","12","1232","20000"),
("2","22","2234","26000"),
("3","32","3267","50000"),
("4","42","4276","90000"),
("5","52","5267","150000");

select * from PERSON;

select accident_date,location
from ACCIDENT;

select driver_id
from PARTCIPATED
where damage_amount>25000;

update PARTCIPATED
set damage_amount = 25000
where reg_num=12 AND report_num=1232;

insert into ACCIDENT
values("1298","2020-03-26","Delhi");

select*
from car
order by years asc;

select count(p.reg_num)
from car c, PARTCIPATED p
where p.reg_num=c.reg_num AND c.model="evo203";

select count(distinct p.driver_id)
from ACCIDENT a, PARTCIPATED p
where p.report_num = a.report_num;

select
avg(damage_amount) as damage_amount
from PARTCIPATED;

delete from PARTCIPATED where damage_amount<56000;






 
 
 
 
 
 
 
 
