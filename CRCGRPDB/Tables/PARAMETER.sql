CREATE TABLE TRANSVERSAL.PARAMETER
( 
	parameter_id         integer IDENTITY ( 1,1 ) ,
	parameter_name       varchar(300)  NULL ,
	state                integer  NULL 
)
go

ALTER TABLE TRANSVERSAL.PARAMETER
	ADD CONSTRAINT PK_TRANSVERSAL_PARAMETER PRIMARY KEY  CLUSTERED (parameter_id ASC)
go