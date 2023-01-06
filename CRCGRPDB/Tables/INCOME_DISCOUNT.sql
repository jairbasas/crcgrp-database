CREATE TABLE EMPLOYEES.INCOME_DISCOUNT
( 
	employee_id          integer  NOT NULL ,
	code                 varchar(20)  NULL ,
	description          varchar(200)  NULL ,
	currency_id          varchar(20)  NULL ,
	amount               decimal(18,2)  NULL ,
	state                bit  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.INCOME_DISCOUNT
	ADD CONSTRAINT PK_EMPLOYEES_INCOME_DISCOUNT PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.INCOME_DISCOUNT
	ADD CONSTRAINT FK_INCOME_DISCOUNT_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go