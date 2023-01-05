CREATE TABLE SECURITY.PROFILE_MENU
( 
	profile_id           integer  NOT NULL ,
	menu_id              integer  NOT NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE SECURITY.PROFILE_MENU
	ADD CONSTRAINT PK_SECURITY_PROFILE_MENU PRIMARY KEY  CLUSTERED (profile_id ASC,menu_id ASC)
go

ALTER TABLE SECURITY.PROFILE_MENU
	ADD CONSTRAINT FK_PROFILE FOREIGN KEY (profile_id) REFERENCES SECURITY.PROFILE(profile_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE SECURITY.PROFILE_MENU
	ADD CONSTRAINT FK_MENU FOREIGN KEY (menu_id) REFERENCES SECURITY.MENU(menu_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go