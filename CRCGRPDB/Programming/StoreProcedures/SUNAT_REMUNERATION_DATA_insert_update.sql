Create Procedure EMPLOYEES.SUNAT_REMUNERATION_DATA_insert_update
(
      @poi_employee_id int    output,
      @pii_parameter_detail_id int    ,
      @pib_state bit    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.SUNAT_REMUNERATION_DATA Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.SUNAT_REMUNERATION_DATA
		(
			employee_id,
			parameter_detail_id,
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
			@poi_employee_id,
			@pii_parameter_detail_id,
			@pib_state,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		Set @poi_employee_id = SCOPE_IDENTITY();

	End
	Begin

		Update EMPLOYEES.SUNAT_REMUNERATION_DATA Set
			parameter_detail_id = @pii_parameter_detail_id,
			state = @pib_state,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_datetime = @pid_register_datetime,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
		Where employee_id = @poi_employee_id;

	End;

End;
Go