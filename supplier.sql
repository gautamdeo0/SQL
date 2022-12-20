create database sup9;
use sup9;

create table supplier (
	sid int,
    sname varchar(30),
    city varchar(30),
    primary key (sid)
);

create table parts (
	pid int,
    pname varchar(30),
    color varchar(30),
    primary key (pid)
);

create table catalog (
	sid int,
    pid int, 
    cost double,
    foreign key (sid) 
		references supplier (sid)
        on delete cascade
        on update cascade,
	foreign key (pid)
		references parts (pid)
        on delete cascade
        on update cascade
);


insert into supplier values (10001,'Acme Widget','Bangalore');
insert into supplier values (10002,'Johns','Kolkata');
insert into supplier values (10003,'Vimal','Mumbai');
insert into supplier values (10004,'Reliance','Delhi');

insert into parts values (20001,'Book','Red');
insert into parts values (20002,'Pen','Red');
insert into parts values (20003,'Pencil','Green');
insert into parts values (20004,'Mobile','Green');
insert into parts values (20005,'Charger','Black');

insert into catalog values (10001,20001,10);
insert into catalog values (10001,20002,10);
insert into catalog values (10001,20003,30);
insert into catalog values (10001,20004,10);
insert into catalog values (10001,20005,10);
insert into catalog values (10002,20001,10);
insert into catalog values (10002,20002,20);
insert into catalog values (10003,20003,30);
insert into catalog values (10004,20003,40);

select pname 
from parts P
 where exists (select pid 
               from catalog 
               where catalog.pid=P.pid);
               
 select s.sname
 from supplier s
 where (( select count(p.pid) 
           from parts p) =(select count(c.pid)
                            from catalog c
                            where c.sid=s.sid));
   
select s.sname 
from supplier s, catalog c 
where s.sid = c.sid
and c.pid in (select pid 
				from parts 
				where color = 'red')
				group by (s.sname)
				having count(c.pid) = (select count(pid) 
										from parts 
										where color = 'red');
  
select pname
 from parts
 where pid not in(select pid
                   from catalog
                   where sid != (select sid
				                 from supplier
                                 where sname='Acme Widget'));
select s.sid 
from supplier s, parts P 
where s.sid in 
		(select c.sid 
          from catalog c 
		  where cost > (select avg(cost) 
                        from catalog 
                        where pid = P.pid)
						and c.pid = P.pid);                                          
                                        
select P.pid, P.pname, s.sname 
from supplier s, parts P 
where s.sid in 
		(select c.sid 
          from catalog c 
		  where cost = (select max(cost) 
                        from catalog 
                        where pid = P.pid)
						and c.pid = P.pid);                                   
   