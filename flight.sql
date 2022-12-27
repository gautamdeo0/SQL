create database flight_database;
use flight_database;

create table flights (
 flno int,
 D_from varchar(30),
 A_to varchar(30),
 distance int,
 departs time,
 arrives time,
 price int,
 primary key (flno)
 );
 
create table aircraft (
aid int,
aname varchar(30),
cruising_range int,
primary key (aid)		
);

create table employees (
eid int,
ename varchar(30),
salary int,
primary key (eid)
);

create table certified (
eid int,
aid int,
foreign key (eid) references employees (eid) on delete cascade on update cascade,
foreign key (aid) references aircraft (aid) on delete cascade on update cascade
);

 insert into flights values (1,'Bengaluru','New Delhi',500,'6:00:00','9:00:00',5000),
(2,'Bengaluru','Chennai',300,'7:00:00','8:30:00',3000),
(3,'Trivandrum','New Delhi',800,'8:00:00','11:30:00',6000),
(4,'Bengaluru','Frankfurt',10000,'6:00:00','23:30:00',50000),
(5,'Kolkata','New Delhi',2400,'11:00:00','3:30:00',9000),
(6,'Bengaluru','Frankfurt',8000,'9:00:00','23:00:00',40000);

insert into aircraft values (1,'Airbus',2000),
(2,'Boeing',700),
(3,'JetAirways',550),
(4,'Indigo',5000),
(5,'Boeing',4500),
(6,'Airbus',2200);

insert into employees values (101,'Avinash',50000),
(102,'Lokesh',60000),
(103,'Rakesh',70000),
(104,'Santhosh',82000),
(105,'Tilak',5000);

insert into certified values (101,2),
(101,4),
(101,5),
(101,6),
(102,1),
(102,3),
(102,5),
(103,2),
(103,3),
(103,5),
(103,6),
(104,6),
(104,1),
(104,3),
(105,3);

select aname 
from aircraft 
where aid 
in (select c.aid 
    from certified c, employees e 
	where c.eid=e.eid and e.salary>80000);
    
 select C.eid, MAX(A.cruising_range)
 from certified c, aircraft a 
 where a.aid=c.aid 
 group by c.eid
 having count(c.aid>=3);   
 
 select ename 
 from employees 
 where salary < (select min(price) 
                 from flights
                 where D_from = 'Bengaluru' and A_to = 'Frankfurt');
                 
select a.aid, a.aname, avg (e.salary)
from aircraft a, certified c, employees e
where a.aid = c.aid 
and c.eid = e.eid 
and a.cruising_range>1000
group by a.aid, a.aname ;       

select ename 
from employees 
where eid 
in (select eid 
    from certified c, aircraft a 
    where c.aid=a.aid 
    and a.aname = 'Boeing');
    
  select aid 
  from aircraft 
  where cruising_range >= (select distance 
                           from flights 
                           where D_from = 'Bengaluru' and A_to ='New Delhi');  
    
    
         
