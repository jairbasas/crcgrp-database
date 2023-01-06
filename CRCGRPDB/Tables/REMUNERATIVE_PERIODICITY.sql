CREATE TABLE EMPLOYEES.REMUNERATIVE_PERIODICITY
( 
	employee_id          integer  NOT NULL ,
	periodicity_id       varchar(20)  NULL ,
	payment_type_id      varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.REMUNERATIVE_PERIODICITY
	ADD CONSTRAINT PK_EMPLOYEES_REMUNERATIVE_PERIODICITY PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.REMUNERATIVE_PERIODICITY
	ADD CONSTRAINT FK_REMUNERATIVE_PERIODICITY_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go