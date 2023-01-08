CREATE TABLE EMPLOYEES.EMPLOYEE_COMPANY
( 
	employee_id          integer  NOT NULL ,
	company_id           integer  NOT NULL ,
	state                integer  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.EMPLOYEE_COMPANY
	ADD CONSTRAINT PK_EMPLOYEES_EMPLOYEE_COMPANY PRIMARY KEY  CLUSTERED (employee_id ASC,company_id ASC)
go

ALTER TABLE EMPLOYEES.EMPLOYEE_COMPANY
	ADD CONSTRAINT FK_EMPLOYEE_COMPANY_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
