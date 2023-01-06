CREATE TABLE EMPLOYEES.CONTRACT
( 
	employee_id          integer  NOT NULL ,
	start_date           datetime  NULL ,
	end_date             datetime  NULL ,
	contract_type_id     varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.CONTRACT
	ADD CONSTRAINT PK_EMPLOYEE_CONTRACT PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.CONTRACT
	ADD CONSTRAINT FK_CONTRACT_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
