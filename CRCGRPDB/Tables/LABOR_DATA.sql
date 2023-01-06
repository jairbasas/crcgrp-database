CREATE TABLE EMPLOYEES.LABOR_DATA
( 
	employee_id          integer  NOT NULL ,
	salary_advance       numeric(4,2)  NULL ,
	reference            varchar(400)  NULL ,
	test_end_date        datetime  NULL ,
	employee_type_id     varchar(20)  NULL ,
	educational_situation_id varchar(20)  NULL ,
	occupation_id        varchar(20)  NULL ,
	position_id          varchar(20)  NULL ,
	cost_center_id       varchar(20)  NULL ,
	special_situation_id varchar(20)  NULL ,
	labor_regime_id      varchar(20)  NULL ,
	essalud_vida_id      varchar(20)  NULL ,
	service_unit_id      varchar(20)  NULL ,
	area_seccion_id      varchar(20)  NULL ,
	trust_position_id    varchar(20)  NULL ,
	account_category_id  varchar(20)  NULL ,
	work_type_id         varchar(20)  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.LABOR_DATA
	ADD CONSTRAINT PK_EMPLOYEES_LABOR_DATA PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.LABOR_DATA
	ADD CONSTRAINT FK_LABOR_DATA_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go