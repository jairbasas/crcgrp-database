CREATE TABLE SECURITY.PARAMETER
( 
	parameter_id         integer IDENTITY ( 1,1 ) ,
	parameter_name       varchar(300)  NULL ,
	state                integer  NULL 
)
go



ALTER TABLE SECURITY.PARAMETER
	ADD CONSTRAINT PK_SECURITY_PARAMETER PRIMARY KEY  CLUSTERED (parameter_id ASC)
go