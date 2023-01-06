Create Procedure EMPLOYEES.REMUNERATIVE_PERIODICITY_insert_update
(
      @poi_employee_id int    output,
      @piv_periodicity_id varchar(20)    ,
      @piv_payment_type_id varchar(20)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.REMUNERATIVE_PERIODICITY Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.REMUNERATIVE_PERIODICITY
		(
			employee_id,
			periodicity_id,
			payment_type_id,
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
			@piv_periodicity_id,
			@piv_payment_type_id,
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

		Update EMPLOYEES.REMUNERATIVE_PERIODICITY Set
			periodicity_id = @piv_periodicity_id,
			payment_type_id = @piv_payment_type_id,
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