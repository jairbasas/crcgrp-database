CREATE TABLE EMPLOYEES.MAIN_DATA
( 
	employee_id          integer  NOT NULL ,
	document_number      varchar(20)  NULL ,
	birth_date           datetime  NULL ,
	ubigeo_birth         varchar(20)  NULL ,
	postal_code          varchar(20)  NULL ,
	phone_number         varchar(20)  NULL ,
	email                varchar(100)  NULL ,
	domiciled            bit  NULL ,
	route_type_number    varchar(20)  NULL ,
	department           varchar(20)  NULL ,
	inside               varchar(20)  NULL ,
	mz                   varchar(20)  NULL ,
	route_name           varchar(200)  NULL ,
	lt                   varchar(20)  NULL ,
	km                   varchar(20)  NULL ,
	block                varchar(20)  NULL ,
	zone_name            varchar(200)  NULL ,
	stage                varchar(20)  NULL ,
	reference            varchar(300)  NULL ,
	ubigeo               varchar(20)  NULL ,
	document_type_id     varchar(20)  NULL ,
	nationality_id       varchar(20)  NULL ,
	sex_id               varchar(20)  NULL ,
	civil_status         varchar(20)  NULL ,
	route_type_id        varchar(20)  NULL ,
	zone_type_id         varchar(20)  NULL ,	
	observation          varchar(400)  NULL ,	
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE EMPLOYEES.MAIN_DATA
	ADD CONSTRAINT PK_EMPLOYEES_MAIN_DATA PRIMARY KEY  CLUSTERED (employee_id ASC)
go

ALTER TABLE EMPLOYEES.MAIN_DATA
	ADD CONSTRAINT FK_MAIN_DATA_EMPLOYEE FOREIGN KEY (employee_id) REFERENCES EMPLOYEES.EMPLOYEE(employee_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go