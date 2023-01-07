Create Procedure EMPLOYEES.SCTR_insert_update
(
      @poi_employee_id int    output,
      @pii_parameter_detail_id int    ,
      @piv_sctr_code varchar(20)    ,
      @piv_tasa varchar(20)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.SCTR Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.SCTR
		(
			employee_id,
			parameter_detail_id,
			sctr_code,
			tasa,
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
			@piv_sctr_code,
			@piv_tasa,
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

		Update EMPLOYEES.SCTR Set
			parameter_detail_id = @pii_parameter_detail_id,
			sctr_code = @piv_sctr_code,
			tasa = @piv_tasa,
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