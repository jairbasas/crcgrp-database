Create Procedure SECURITY.USERS_PROFILE_insert_update
(
      @poi_user_id int    output,
      @pii_profile_id int    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From SECURITY.USERS_PROFILE Where user_id= @poi_user_id)
	Begin

		Insert Into SECURITY.USERS_PROFILE
		(
			user_id,
			profile_id,
			register_user_id,
			register_user_fullname,
			register_datetime,
			update_user_id,
			update_user_fullname,
			update_datetime
		)
		Values
		(
			@poi_user_id,
			@pii_profile_id,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		--Set @poi_user_id = SCOPE_IDENTITY();

	End
	Begin

		Update SECURITY.USERS_PROFILE Set
			profile_id = @pii_profile_id,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_datetime = @pid_register_datetime,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
		Where user_id = @poi_user_id;

	End;

End;
Go