Create Procedure EMPLOYEES.COMPENSATION_PAYMENT_insert_update
(
      @poi_employee_id int    output,
      @piv_account_number varchar(50)    ,
      @piv_interbank_account varchar(50)    ,
      @piv_bank_id varchar(20)    ,
      @piv_account_type_id varchar(20)    ,
      @piv_currency_id varchar(20)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.COMPENSATION_PAYMENT Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.COMPENSATION_PAYMENT
		(
			employee_id,
			account_number,
			interbank_account,
			bank_id,
			account_type_id,
			currency_id,
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
			@piv_account_number,
			@piv_interbank_account,
			@piv_bank_id,
			@piv_account_type_id,
			@piv_currency_id,
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

		Update EMPLOYEES.COMPENSATION_PAYMENT Set
			account_number = @piv_account_number,
			interbank_account = @piv_interbank_account,
			bank_id = @piv_bank_id,
			account_type_id = @piv_account_type_id,
			currency_id = @piv_currency_id,
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