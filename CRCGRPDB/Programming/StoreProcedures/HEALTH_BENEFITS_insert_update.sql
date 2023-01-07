Create Procedure EMPLOYEES.HEALTH_BENEFITS_insert_update
(
      @poi_employee_id int    output,
      @pib_affiliate_eps bit    ,
      @piv_eps_number varchar(50)    ,
      @pid_registration_date datetime    ,
      @piv_family_plan varchar(20)    ,
      @pid_disenrollment_date datetime    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.HEALTH_BENEFITS Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.HEALTH_BENEFITS
		(
			employee_id,
			affiliate_eps,
			eps_number,
			registration_date,
			family_plan,
			disenrollment_date,
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
			@pib_affiliate_eps,
			@piv_eps_number,
			@pid_registration_date,
			@piv_family_plan,
			@pid_disenrollment_date,
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

		Update EMPLOYEES.HEALTH_BENEFITS Set
			affiliate_eps = @pib_affiliate_eps,
			eps_number = @piv_eps_number,
			registration_date = @pid_registration_date,
			family_plan = @piv_family_plan,
			disenrollment_date = @pid_disenrollment_date,
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