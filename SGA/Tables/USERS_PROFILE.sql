CREATE TABLE SECURITY.USERS_PROFILE
( 
	user_id              integer  NOT NULL ,
	profile_id           integer  NOT NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE SECURITY.USERS_PROFILE
	ADD CONSTRAINT PK_SECURITY_USERS_PROFILE PRIMARY KEY  CLUSTERED (user_id ASC,profile_id ASC)
go

ALTER TABLE SECURITY.USERS_PROFILE
	ADD CONSTRAINT FK_USER FOREIGN KEY (user_id) REFERENCES SECURITY.USERS(user_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE SECURITY.USERS_PROFILE
	ADD CONSTRAINT FK_USERS_PROFILE FOREIGN KEY (profile_id) REFERENCES SECURITY.PROFILE(profile_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go