Create Procedure EMPLOYEES.INCOME_DISCOUNT_insert_update
(
      @poi_employee_id int    output,
      @piv_code varchar(20)    ,
      @piv_description varchar(200)    ,
      @piv_currency_id varchar(20)    ,
      @pid_amount decimal(18, 2)    ,
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

	If Not Exists (Select 1 From EMPLOYEES.INCOME_DISCOUNT Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.INCOME_DISCOUNT
		(
			employee_id,
			code,
			description,
			currency_id,
			amount,
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
			@piv_code,
			@piv_description,
			@piv_currency_id,
			@pid_amount,
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

		Update EMPLOYEES.INCOME_DISCOUNT Set
			code = @piv_code,
			description = @piv_description,
			currency_id = @piv_currency_id,
			amount = @pid_amount,
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