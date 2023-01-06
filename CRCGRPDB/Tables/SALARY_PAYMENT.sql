CREATE TABLE EMPLOYEES.SALARY_PAYMENT
( 
	employee_id          integer  NOT NULL ,
	account_number       varchar(50)  NULL ,
	interbank_account    varchar(50)  NULL ,
	bank_id              varchar(20)  NULL ,
	account_type_id      varchar(20)  NULL ,
	currency_id          varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.SALARY_PAYMENT
	ADD CONSTRAINT PK_EMPLOYEES_SALARY_PAYMENT PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.SALARY_PAYMENT
	ADD CONSTRAINT FK_SALARY_PAYMENT_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go