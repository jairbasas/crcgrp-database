CREATE TABLE SECURITY.MENU
( 
	menu_id              integer IDENTITY ( 1,1 ) ,
	menu_name            varchar(300)  NULL ,
	level                integer  NULL ,
	url                  varchar(300)  NULL ,
	icon                 varchar(300)  NULL ,
	[order]                integer  NULL ,
	menu_parent_id		 integer NULL,
	state                integer  NULL ,
	register_user_id     integer  NULL ,
	register_user_fullname varchar(250)  NULL ,
	register_datetime    datetime  NULL ,
	update_user_id       integer  NULL ,
	update_user_fullname varchar(250)  NULL ,
	update_datetime      varchar(20)  NULL 
)
go

ALTER TABLE SECURITY.MENU
	ADD CONSTRAINT PK_SECURITY_MENU PRIMARY KEY  CLUSTERED (menu_id ASC)
go