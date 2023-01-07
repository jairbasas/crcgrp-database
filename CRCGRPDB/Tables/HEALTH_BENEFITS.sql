CREATE TABLE EMPLOYEES.HEALTH_BENEFITS
( 
	employee_id          integer  NOT NULL ,
	affiliate_eps        bit  NULL ,
	eps_number           varchar(50)  NULL ,
	registration_date    datetime  NULL ,
	family_plan          varchar(20)  NULL ,
	disenrollment_date   datetime  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.HEALTH_BENEFITS
	ADD CONSTRAINT PK_EMPLOYEES_HEALTH_BENEFITS PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.HEALTH_BENEFITS
	ADD CONSTRAINT FK_HEALTH_BENEFITS_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
