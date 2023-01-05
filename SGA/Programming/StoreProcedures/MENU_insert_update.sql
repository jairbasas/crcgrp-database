Create Procedure SECURITY.MENU_insert_update
(
      @poi_menu_id int    output,
      @piv_menu_name varchar(300)    ,
      @pii_level int    ,
      @piv_url varchar(300)    ,
      @piv_icon varchar(300)    ,
      @pii_order int    ,
	  @pii_menu_parent_id int,
      @pii_state int    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From SECURITY.MENU Where menu_id= @poi_menu_id)
	Begin

		Insert Into SECURITY.MENU
		(
			menu_name,
			level,
			url,
			icon,
			[order],
			menu_parent_id,
			state,
			register_user_id,
			register_user_fullname,
			register_datetime,
			update_user_id,
			update_user_fullname,
			update_datetime
		)
		Values
		(
			@piv_menu_name,
			@pii_level,
			@piv_url,
			@piv_icon,
			@pii_order,
			@pii_menu_parent_id,
			@pii_state,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		Set @poi_menu_id = SCOPE_IDENTITY();

	End
	Begin

		Update SECURITY.MENU Set
			menu_name = @piv_menu_name,
			level = @pii_level,
			url = @piv_url,
			icon = @piv_icon,
			[order] = @pii_order,
			menu_parent_id = @pii_menu_parent_id,
			state = @pii_state,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_datetime = @pid_register_datetime,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
		Where menu_id = @poi_menu_id;

	End;

End;
Go