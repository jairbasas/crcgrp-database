CREATE TABLE EMPLOYEES.SUNAT_REMUNERATION_DATA
( 
	employee_id          integer  NOT NULL ,
	parameter_detail_id  integer  NOT NULL ,
	state                bit  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.SUNAT_REMUNERATION_DATA
	ADD CONSTRAINT PK_EMPLOYEES_SUNAT_REMUNERATION_DATA PRIMARY KEY  CLUSTERED (employee_id ASC,parameter_detail_id ASC)
go

ALTER TABLE EMPLOYEES.SUNAT_REMUNERATION_DATA
	ADD CONSTRAINT FK_SUNAT_REMUNERATION_DATA_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
