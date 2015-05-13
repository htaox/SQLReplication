use master
go
create database DBOne
go
use DBOne
go
create table A (
	ID int not null primary key identity(1,1),
	Name varchar(8000) not null default replicate('a',10),
	Moment datetime not null default getdate(),
	ServerName sysname not null default @@servername,
	DatabaseName sysname not null default db_name(db_id()),
	UserName sysname not null default suser_sname()
)

create table B (
	ID int not null primary key identity(1,1),
	FKA int not null references A(ID),
	Name varchar(8000) not null default replicate('b',10),
	Moment datetime not null default getdate(),
	ServerName sysname not null default @@servername,
	DatabaseName sysname not null default db_name(db_id()),
	UserName sysname not null default suser_sname()
)

create table C (
	ID int not null primary key identity(1,1),
	FKB int not null references B(ID),
	Name varchar(8000) not null default replicate('c',10),
	Moment datetime not null default getdate(),
	ServerName sysname not null default @@servername,
	DatabaseName sysname not null default db_name(db_id()),
	UserName sysname not null default suser_sname()
)

insert A default values
go 10

insert B (FKA) 
select top 1 ID from A order by newid()
go 10

insert C (FKB) 
select top 1 ID from B order by newid()
go 10

select * from A
select * from B
select * from C

--delete c
--delete b
--delete a