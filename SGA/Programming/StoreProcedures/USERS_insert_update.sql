Create Procedure SECURITY.USERS_insert_update
(
      @poi_user_id int    output,
      @piv_user_name varchar(300)    ,
      @piv_father_last_name varchar(300)    ,
      @piv_mother_last_name varchar(300)    ,
      @piv_document_number varchar(20)    ,
      @piv_email varchar(100)    ,
      @piv_login varchar(100)    ,
      @piv_password varchar(200)    ,
      @pii_reset_password int    ,
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

	If Not Exists (Select 1 From SECURITY.USERS Where user_id= @poi_user_id)
	Begin

		Insert Into SECURITY.USERS
		(
			user_name,
			father_last_name,
			mother_last_name,
			document_number,
			email,
			login,
			password,
			reset_password,
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
			@piv_user_name,
			@piv_father_last_name,
			@piv_mother_last_name,
			@piv_document_number,
			@piv_email,
			@piv_login,
			ENCRYPTBYPASSPHRASE('password', @piv_password),
			@pii_reset_password,
			@pii_state,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		Set @poi_user_id = SCOPE_IDENTITY();

	End
	Begin

		Update SECURITY.USERS Set
			user_name = @piv_user_name,
			father_last_name = @piv_father_last_name,
			mother_last_name = @piv_mother_last_name,
			document_number = @piv_document_number,
			email = @piv_email,
			login = @piv_login,
			reset_password = @pii_reset_password,
			state = @pii_state,
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