CREATE TABLE TRANSVERSAL.COMPANY_USERS
( 
	company_user_id      integer IDENTITY ( 1,1 ) ,
	user_id              integer  NULL ,
	company_id           integer  NULL ,
	state                integer  NULL,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE TRANSVERSAL.COMPANY_USERS
	ADD CONSTRAINT PK_TRANSVERSAL_COMPANY_USERS PRIMARY KEY  CLUSTERED (company_user_id ASC)
go

ALTER TABLE TRANSVERSAL.COMPANY_USERS
	ADD CONSTRAINT FK_COMPANY_USERS_COMPANY FOREIGN KEY (company_id) REFERENCES TRANSVERSAL.COMPANY(company_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE TRANSVERSAL.COMPANY_USERS
	ADD CONSTRAINT FK_COMPANY_USERS_USERS FOREIGN KEY (user_id) REFERENCES TRANSVERSAL.USERS(user_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
