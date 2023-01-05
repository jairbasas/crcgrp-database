CREATE TABLE SECURITY.PROFILE
( 
	profile_id           integer IDENTITY ( 1,1 ) ,
	profile_name         varchar(100)  NULL ,
	state                integer  NULL ,
	system_id            integer  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL
)
go

ALTER TABLE SECURITY.PROFILE
	ADD CONSTRAINT PK_SECURITY_PROFILE PRIMARY KEY  CLUSTERED (profile_id ASC)
go

ALTER TABLE SECURITY.PROFILE
	ADD CONSTRAINT FK_SYSTEM FOREIGN KEY (system_id) REFERENCES SECURITY.SYSTEMS(system_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go