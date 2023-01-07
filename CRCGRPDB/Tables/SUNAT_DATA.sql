CREATE TABLE EMPLOYEES.SUNAT_DATA
( 
	employee_id          integer  NOT NULL ,
	essalud_code         varchar(50)  NULL ,
	mixed_commission     bit  NULL ,
	registration_date    datetime  NULL ,
	pension_type_id      varchar(20)  NULL ,
	pension_scheme_id    varchar(20)  NULL ,
	worker_situation_id  varchar(20)  NULL ,
	occupational_category_id varchar(20)  NULL ,
	affiliate_type_id    varchar(20)  NULL ,
	double_taxation_id   varchar(20)  NULL ,
	afp_exoneration_type_id varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.SUNAT_DATA
	ADD CONSTRAINT PK_EMPLOYEES_SUNAT_DATA PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.SUNAT_DATA
	ADD CONSTRAINT FK_SUNAT_DATA_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go