Create database bank_database;
use bank_database;
Create Table branch(
	BranchName varchar(30),
	BranchCity varchar(30),
    Assets real,
    primary key (BranchName)
);
Create table BankAccount(
	Accno int,
    BranchName varchar(30),
    Balance real,
    primary key(Accno),
    Foreign key(BranchName)
		references branch(BranchName)
);
CREATE TABLE bankCustomer (
    CustomerName VARCHAR(30),
    CustomerStreet VARCHAR(30),
    City VARCHAR(30),
    PRIMARY KEY (CustomerName)
);
Create Table depositer(
	CustomerName varchar(30),
    Accno int,
    Foreign key(CustomerName)
		references bankCustomer(CustomerName)
        on delete cascade,
	Foreign key(Accno)
		references BankAccount(Accno)
        on delete cascade
);

Create Table Loan(
	LoanNumber int,
    BranchName varchar(30),
    Amount real,
    primary key (LoanNumber),
    Foreign key(BranchName)
		references branch(Branchname)
);

insert into branch values('SBI_chamarajpet','Bangalore',50000);
insert into branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into branch values('SBI_ShivajiRoad','Bombay',20000);
insert into branch values('SBI_ParliamentRoad','Delhi',10000);
insert into branch values('SBI_Jantarmantar','Delhi',20000);
insert into branch values('SBI_MantiMarg','Delhi',200000);

insert into BankAccount values(1,'SBI_chamarajpet',2000);
insert into BankAccount values(2,'SBI_ResidencyRoad',5000);
insert into BankAccount values(3,'SBI_ShivajiRoad',6000);
insert into BankAccount values(4,'SBI_ParliamentRoad',9000);
insert into BankAccount values(5,'SBI_Jantarmantar',8000);
insert into BankAccount values(6,'SBI_ShivajiRoad',4000);
insert into BankAccount values(7,'SBI_Jantarmantar',4000);
insert into BankAccount values(8,'SBI_ResidencyRoad',3000);
insert into BankAccount values(9,'SBI_ParliamentRoad',5000);
insert into BankAccount values(10,'SBI_ResidencyRoad',3000);
insert into BankAccount values(11,'SBI_Jantarmantar',2000);
insert into BankAccount values(12,'SBI_MantiMarg',2000);

insert into BankCustomer values('Avinash','Bull_temple_road','Bangalore');
insert into BankCustomer values('Dinesh','Bannerghatta_road','Bangalore');
insert into BankCustomer values('Mohan','National_college_road','Bangalore');
insert into BankCustomer values('Nikil','Akbar_road','Delhi');
insert into BankCustomer values('Ravi','Prithviraj_road','Delhi');

insert into depositer values('Avinash',1);
insert into depositer values('Dinesh',2);
insert into depositer values('Nikil',4);
insert into depositer values('Ravi',5);
insert into depositer values('Avinash',8);
insert into depositer values('Nikil',9);
insert into depositer values('Dinesh',10);

insert into depositer values('Nikil',12);
delete from depositer where accno = 11;
insert into depositer values('Nikil',11);

insert into loan values(1,'SBI_chamarajpet',1000);
insert into loan values(2,'SBI_ResidencyRoad',1000);
insert into loan values(3,'SBI_ShivajiRoad',1000);
insert into loan values(4,'SBI_ParliamentRoad',1000);
insert into loan values(5,'SBI_Jantarmantar',1000);

create table Borrower(
Customername varchar(20),
Loannumber int,
primary key(Customername,Loannumber),
foreign key(customername) references BankCustomer(customername),
foreign key(Loannumber) references Loan(Loannumber)
);

insert into Borrower
values("Avinash",1),
("Dinesh",2),
("Mohan",3),
("Nikil",4),
("Ravi",5);

select Customername 
from Depositer
where Accno in (select Accno from Bankaccount where Branchname in (select Branchname from Branch where Branchcity = 'Delhi')) 
	group by Customername 
    having count(Accno)>(select count(distinct Branchname) 
    from Branch where Branchcity='Delhi');

  select Customername 
	from Borrower 
	where Customername 
    not in (select Customername from Depositer);
    
 select distinct Customername 
  from Depositer 
  where Accno in 
	(select Accno from Bankaccount b, Branch br where b.Branchname = br.Branchname and br.Branchcity = 'Bangalore') 
      and Customername in
		(select Customername from Borrower);

 select Branchname 
 from Branch
 where Assets > (select max(Assets) from Branch 
                     where Branchcity = 'Bangalore');
                     
delete from Bankaccount 
where Branchname 
in (select Branchname from Branch where Branchcity = 'Bombay');
select * from Bankaccount;                    
