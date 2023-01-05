﻿CREATE TABLE TRANSVERSAL.PARAMETER_DETAIL
( 
	parameter_detail_id  integer IDENTITY ( 1,1 ) ,
	description          varchar(300)  NULL ,
	field_value_1        varchar(300)  NULL ,
	field_description_1  varchar(300)  NULL ,
	field_value_2        varchar(300)  NULL ,
	field_description_2  varchar(300)  NULL ,
	field_value_3        varchar(300)  NULL ,
	field_description_3  varchar(300)  NULL ,
	parameter_id         integer  NULL 
)
go

ALTER TABLE TRANSVERSAL.PARAMETER_DETAIL
	ADD CONSTRAINT PK_TRANSVERSAL_PARAMETER_DETAIL PRIMARY KEY  CLUSTERED (parameter_detail_id ASC)
go

ALTER TABLE TRANSVERSAL.PARAMETER_DETAIL
	ADD CONSTRAINT FK_PARAMETER_DETAIL_PARAMETER FOREIGN KEY (parameter_id) REFERENCES TRANSVERSAL.PARAMETER(parameter_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
