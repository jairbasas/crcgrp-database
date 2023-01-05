Create Procedure SECURITY.SYSTEMS_insert_update
(
      @poi_system_id int    output,
      @piv_system_name varchar(300)    ,
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

	If Not Exists (Select 1 From SECURITY.SYSTEMS Where system_id= @poi_system_id)
	Begin

		Insert Into SECURITY.SYSTEMS
		(
			system_name,
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
			@piv_system_name,
			@pii_state,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		Set @poi_system_id = SCOPE_IDENTITY();

	End
	Begin

		Update SECURITY.SYSTEMS Set
			system_name = @piv_system_name,
			state = @pii_state,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_datetime = @pid_register_datetime,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
		Where system_id = @poi_system_id;

	End;

End;
Go