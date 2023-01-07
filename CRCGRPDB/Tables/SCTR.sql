CREATE TABLE EMPLOYEES.SCTR
( 
	employee_id          integer  NOT NULL ,
	parameter_detail_id  integer  NOT NULL ,
	sctr_code            varchar(20)  NULL ,
	tasa                 varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.SCTR
	ADD CONSTRAINT PK_EMPLOYEES_SCTR PRIMARY KEY  CLUSTERED (employee_id ASC,parameter_detail_id ASC)
go

ALTER TABLE EMPLOYEES.SCTR
	ADD CONSTRAINT FK_SCTR_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
