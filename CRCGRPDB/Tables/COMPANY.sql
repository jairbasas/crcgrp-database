CREATE TABLE TRANSVERSAL.COMPANY
( 
	company_id           integer IDENTITY ( 1,1 ) ,
	business_name        varchar(300)  NULL ,
	tradename            varchar(300)  NULL ,
	document_number      varchar(20)  NULL ,
	state                integer  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      datetime  NULL 
)
go

ALTER TABLE TRANSVERSAL.COMPANY
	ADD CONSTRAINT PK_TRANSVERSAL_COMPANY PRIMARY KEY  CLUSTERED (company_id ASC)
go