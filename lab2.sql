create database unidb;
use unidb;
create table department(
deptid int primary key,
deptname varchar(15));
create table student(
usn varchar(20) primary key,
sname varchar(20) not null,
deptid int,
dob date,
foreign key (deptid) references department(deptid));
show databases;
desc department;
desc student;
create table coursereg(
usn varchar(20),
courseid varchar(10),
primary key (usn,courseid));
alter table coursereg
add column semester int;     
alter table coursereg
add constraint foreign key(usn) references student(usn);  
alter table coursereg
add constraint foreign key(courseid) references course(courseid);
create table marks(
usn varchar(20),
score int,
foreign key (usn) references course(courseid));
create table course(
courseid varchar(10) primary key,
coursename varchar(20) not null,
credits int,
deptid int,
foreign key(deptid) references department(deptid));
insert into department values
(1,'phy'),
(2,'cs');
insert into student values 
('24SCS0016','harry',1,'2002-02-19'),
('24SCS0017','snape',2,'2003-07-04');
insert into course values
('cs201','hogwards',4,1),
('cs202','potions',3,2);
insert into coursereg values
('24SCS0016','cs201',2),
('24SCS0017','cs202',2);
desc coursereg;
insert into marks values
('24SCS0016','cs201',86);
insert into marks values
('24SCS0017','cs201',99);
select * from student;
select * from course;
select * from coursereg;
select * from department;
select * from marks;





      