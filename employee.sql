show databases;
use emp1;
create table dept(
deptno varchar(20),
dname varchar(20),
dloc varchar(20),
primary key(deptno)
);

create table project(
pno varchar(20),
ploc varchar(20),
pname varchar(20),
primary key(pno)
);

create table employee(
empno varchar(20),
ename varchar(20),
mgr_no varchar(20),
hiredate date,
sal float,
deptno varchar(20),
primary key(empno,mgr_no),
foreign key(deptno) references dept(deptno)
);

create table incentives(
empno varchar(20),
incentive_date date,
incentive_amount float,
primary key(incentive_date),
foreign key(empno) references employee(empno)
);

create table assignedto(
empno varchar(20),
pno varchar(20),
job_role varchar(20),
primary key(empno),
foreign key(empno) references employee(empno),
foreign key(pno) references project(pno)
);

insert into dept values (1,'Accounts','Bangalore'),
 (2,'Accounts','Hyderabad'),
 (3,'Software','Bangalore'),
 (4,'Hardware','Hyderabad'),
 (5,'Sales','Bangalore'),
 (6,'Sales','Hyderabad'),
 (7,'Sales','Mysuru'),
 (8,'Maunfacture','Bangalore'),
 (9,'Maunfacture','Hyderabad');
 
insert into dept values (10,'Software','Hyderabad'),
(11,'Software','Mysuru');
 
insert into project values (1,'Bangalore','Pluton'),
(2,'Hyderabad','Poseidon'),
(3,'Mysuru','Uranus');
 
 insert into employee values(1,'luffy',10,'2020-01-12',90000,8),
(2,'zoro',12,'2020-11-12',80000,1),
(3,'nami',13,'2020-01-30',65000,9),
(4,'sanji',11,'2020-02-19',70000,5),
(5,'ussop',13,'2020-04-02',80000,7),
(6,'robin',14,'2021-08-05',95000,3),
(7,'chopper',16,'2021-07-05',90000,4),
(8,'franky',14,'2021-07-17',80000,4),
(9,'brook',16,'2021-06-04',100000,3),
(10,'kaido',13,'2019-09-07',990000,6),
(11,'shanks',12,'2019-12-12',98000,2),
(12,'big mom',10,'2019-01-13',97000,8),
(13,'whitebeard',11,'2019-01-25',99000,9);

insert into incentives values (1,'2022-02-18',4000),
(2,'2022-01-12',5000),
(12,'2022-02-19',7000),
(6,'2022-09-9',3000),
(9,'2022-07-2',6000);

insert into assignedto values (1,1,'Computer Scientist'),
(2,1,'Computer Scientist'),
(9,2,'Senior Developer'),
(4,2,'Junior Developer'),
(6,2,'Junior Developer'),
(5,3,'Junior Developer'),
(7,3,'Senior Developer');

select a.empno, p.ploc 
from assignedto a, project p 
where a.pno = p.pno and p.ploc in ('Bangalore','Hyderabad','Mysuru');

select empno 
from employee 
where empno not in (select empno from incentives) 
order by empno;

select e.empno, e.ename, d.dname, p.pname, p.ploc, d.dloc 
from dept d, employee e, project p, assignedto a 
where e.deptno = d.deptno 
	and e.empno = a.empno and a.pno = p.pno and p.ploc = d.dloc;











