Create Procedure EMPLOYEES.WORKING_PERIOD_insert_update
(
      @poi_employee_id int    output,
      @pid_date_admission datetime    ,
      @pid_hour_day decimal(4, 2)    ,
      @piv_shift_id varchar(20)    ,
      @pii_tareo_diario int    ,
      @pii_extra_hour_tareo int    ,
      @piv_tareo_group_id varchar(20)    ,
      @pid_termination_date datetime    ,
      @piv_reason_termination_id varchar(20)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.WORKING_PERIOD Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.WORKING_PERIOD
		(
			employee_id,
			date_admission,
			hour_day,
			shift_id,
			tareo_diario,
			extra_hour_tareo,
			tareo_group_id,
			termination_date,
			reason_termination_id,
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
			@pid_date_admission,
			@pid_hour_day,
			@piv_shift_id,
			@pii_tareo_diario,
			@pii_extra_hour_tareo,
			@piv_tareo_group_id,
			@pid_termination_date,
			@piv_reason_termination_id,
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

		Update EMPLOYEES.WORKING_PERIOD Set
			date_admission = @pid_date_admission,
			hour_day = @pid_hour_day,
			shift_id = @piv_shift_id,
			tareo_diario = @pii_tareo_diario,
			extra_hour_tareo = @pii_extra_hour_tareo,
			tareo_group_id = @piv_tareo_group_id,
			termination_date = @pid_termination_date,
			reason_termination_id = @piv_reason_termination_id,
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