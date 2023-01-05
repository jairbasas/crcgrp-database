Create Procedure SECURITY.PROFILE_insert_update
(
      @poi_profile_id int    output,
      @piv_profile_name varchar(100)    ,
      @pii_state int    ,
      @pii_system_id int    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From SECURITY.PROFILE Where profile_id= @poi_profile_id)
	Begin

		Insert Into SECURITY.PROFILE
		(
			profile_name,
			state,
			system_id,
			register_user_id,
			register_user_fullname,
			register_datetime,
			update_user_id,
			update_user_fullname,
			update_datetime
		)
		Values
		(
			@piv_profile_name,
			@pii_state,
			@pii_system_id,
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

		Update SECURITY.PROFILE Set
			profile_name = @piv_profile_name,
			state = @pii_state,
			system_id = @pii_system_id,
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