CREATE TABLE EMPLOYEES.WORKING_PERIOD
( 
	employee_id          integer  NOT NULL ,
	date_admission       datetime  NULL ,
	hour_day             decimal(4,2)  NULL ,
	shift_id             varchar(20)  NULL ,
	tareo_diario         integer  NULL ,
	extra_hour_tareo     integer  NULL ,
	tareo_group_id       varchar(20)  NULL ,
	termination_date     datetime  NULL ,
	reason_termination_id varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.WORKING_PERIOD
	ADD CONSTRAINT PK_EMPLOYEES_WORKING_PERIOD PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.WORKING_PERIOD
	ADD CONSTRAINT FK_WORKING_PERIOD_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
