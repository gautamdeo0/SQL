create database bankk;
use bankk;

create table Branch(
Branchname varchar(20),
Branchcity varchar(10),
Assets float,
primary key(Branchname)
);

create table BankAccount(
Accno varchar(10),
Branchname varchar(20),
Balance float,
primary key(Accno),
foreign key(Branchname) references Branch(Branchname)
);

create table BankCustomer(
customername varchar(10),
customerstreet varchar(20),
city varchar(20),
primary key(customername)
);

Create table Depositer(
Customername varchar(20),
Accno varchar(10),
primary key(Customername,Accno),
foreign key(customername) references BankCustomer(customername),
foreign key(Accno) references BankAccount(Accno)
);

Create table Loan(
Loannumber int,
Branchname varchar(20),
Ammount float,
primary key(Loannumber,Branchname),
foreign key(Branchname) references Branch(Branchname)
);

insert into Branch
values("SBI_Chamajpet","Banglore",50000),
("SBI_ResidencyRoad","Banglore",10000),
("SBI_ShivajiRoad","Bombay",20000),
("SBI_ParlimentRoad","Delhi",10000),
("SBI_Jantarmantar","Delhi",20000);

insert into BankAccount
values(1,"SBI_Chamajpet",2000),
(2,"SBI_ResidencyRoad",5000),
(3,"SBI_ShivajiRoad",6000),
(4,"SBI_ParlimentRoad",9000),
(5,"SBI_Jantarmantar",8000),
(6,"SBI_ShivajiRoad",4000),
(8,"SBI_ResidencyRoad",4000),
(9,"SBI_ParlimentRoad",3000),
(10,"SBI_ResidencyRoad",5000),
(11,"SBI_Jantarmantar",2000);

insert into BankCustomer
values("Avinash","Bull_Temple_Road","Bangalore"),
("Dinesh","Bannergatta_Road","Bangalore"),
("Mohan","NationalCollege_Road","Bangalore"),
("Nikil","Akbar_Road","Delhi"),
("Ravi","Prithviraj_Road","Delhi");

insert into Depositer
values("Avinash",1),
("Dinesh",2),
("Nikil",4),
("Ravi",5),
("Avinash",8),
("Nikil",9),
("Dinesh",10),
("Nikil",11);

insert into Loan
values(1,"SBI_Chamajpet",1000),
(2,"SBI_ResidencyRoad",2000),
(3,"SBI_ShivajiRoad",3000),
(4,"SBI_ParlimentRoad",4000),
(5,"SBI_Jantarmantar",5000);

select Branchname, Assets/100000 as Assets_in_lakhs
from Branch;

select Customername
from Depositer
where Accno in ( select Accno
from BankAccount
where Branchname="SBI_Residencyroad")
group by Customername
having count(Customername)>=2;

create view Loan_sum as
select Branchname, sum(Amount)as Sum_loan_ammount
from Loan
group by Branchname;
select*
from Loan_sum;
