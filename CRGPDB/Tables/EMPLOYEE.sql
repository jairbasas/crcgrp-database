CREATE TABLE EMPLOYEES.EMPLOYEE
( 
	employee_id          integer IDENTITY ( 1,1 ) ,
	code                 varchar(20)  NULL ,
	name                 varchar(200)  NULL ,
	father_last_name     varchar(200)  NULL ,
	mother_last_name     varchar(200)  NULL ,
	category_name        varchar(20)  NULL ,
	situation_id         varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_update      datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.EMPLOYEE
	ADD CONSTRAINT PK_EMPLOYEES_EMPLOYEE PRIMARY KEY  CLUSTERED (employee_id ASC)
go
