CREATE TABLE TRANSVERSAL.USERS
( 
	user_id              integer  NOT NULL ,
	user_name            varchar(300)  NULL ,
	father_last_name     varchar(300)  NULL ,
	mother_last_name     varchar(300)  NULL ,
	document_number      varchar(20)  NULL ,
	email                varchar(100)  NULL ,
	state                integer  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE TRANSVERSAL.USERS
	ADD CONSTRAINT PK_TRANSVERSA_USERS PRIMARY KEY  CLUSTERED (user_id ASC)
go