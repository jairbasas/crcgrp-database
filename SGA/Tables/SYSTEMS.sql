CREATE TABLE SECURITY.SYSTEMS
( 
	system_id            integer IDENTITY ( 1,1 ) ,
	system_name          varchar(300)  NULL ,
	state                integer  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE SECURITY.SYSTEMS
	ADD CONSTRAINT PK_SECURITY_SYSTEMS PRIMARY KEY  CLUSTERED (system_id ASC)
go
