Create Procedure EMPLOYEES.SUNAT_DATA_insert_update
(
      @poi_employee_id int    output,
      @piv_essalud_code varchar(50)    ,
      @pib_mixed_commission bit    ,
      @pid_registration_date datetime    ,
      @piv_pension_type_id varchar(20)    ,
      @piv_pension_scheme_id varchar(20)    ,
      @piv_worker_situation_id varchar(20)    ,
      @piv_occupational_category_id varchar(20)    ,
      @piv_affiliate_type_id varchar(20)    ,
      @piv_double_taxation_id varchar(20)    ,
      @piv_afp_exoneration_type_id varchar(20)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.SUNAT_DATA Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.SUNAT_DATA
		(
			employee_id,
			essalud_code,
			mixed_commission,
			registration_date,
			pension_type_id,
			pension_scheme_id,
			worker_situation_id,
			occupational_category_id,
			affiliate_type_id,
			double_taxation_id,
			afp_exoneration_type_id,
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
			@piv_essalud_code,
			@pib_mixed_commission,
			@pid_registration_date,
			@piv_pension_type_id,
			@piv_pension_scheme_id,
			@piv_worker_situation_id,
			@piv_occupational_category_id,
			@piv_affiliate_type_id,
			@piv_double_taxation_id,
			@piv_afp_exoneration_type_id,
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

		Update EMPLOYEES.SUNAT_DATA Set
			essalud_code = @piv_essalud_code,
			mixed_commission = @pib_mixed_commission,
			registration_date = @pid_registration_date,
			pension_type_id = @piv_pension_type_id,
			pension_scheme_id = @piv_pension_scheme_id,
			worker_situation_id = @piv_worker_situation_id,
			occupational_category_id = @piv_occupational_category_id,
			affiliate_type_id = @piv_affiliate_type_id,
			double_taxation_id = @piv_double_taxation_id,
			afp_exoneration_type_id = @piv_afp_exoneration_type_id,
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