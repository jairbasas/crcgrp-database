Create Procedure TRANSVERSAL.COMPANY_USERS_insert_update
(
      @poi_company_user_id int    output,
      @pii_user_id int    ,
      @pii_company_id int    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    ,
      @pii_state int    
)
As
Begin

	If Not Exists (Select 1 From TRANSVERSAL.COMPANY_USERS Where company_user_id= @poi_company_user_id)
	Begin

		Insert Into TRANSVERSAL.COMPANY_USERS
		(
			user_id,
			company_id,
			register_user_id,
			register_user_fullname,
			register_datetime,
			update_user_id,
			update_user_fullname,
			update_datetime,
			state
		)
		Values
		(
			@pii_user_id,
			@pii_company_id,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime,
			@pii_state
		);

		Set @poi_company_user_id = SCOPE_IDENTITY();

	End
	Begin

		Update TRANSVERSAL.COMPANY_USERS Set
			user_id = @pii_user_id,
			company_id = @pii_company_id,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_datetime = @pid_register_datetime,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime,
			state = @pii_state
		Where company_user_id = @poi_company_user_id;

	End;

End;
Go