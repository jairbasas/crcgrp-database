Create Procedure SECURITY.PROFILE_MENU_insert_update
(
      @poi_profile_id int    output,
      @pii_menu_id int    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From SECURITY.PROFILE_MENU Where profile_id= @poi_profile_id)
	Begin

		Insert Into SECURITY.PROFILE_MENU
		(
			profile_id,
			menu_id,
			register_user_id,
			register_user_fullname,
			register_datetime,
			update_user_id,
			update_user_fullname,
			update_datetime
		)
		Values
		(
			@poi_profile_id,
			@pii_menu_id,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		Set @poi_profile_id = SCOPE_IDENTITY();

	End
	Begin

		Update SECURITY.PROFILE_MENU Set
			menu_id = @pii_menu_id,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_datetime = @pid_register_datetime,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
		Where profile_id = @poi_profile_id;

	End;

End;
Go