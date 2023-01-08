Create Procedure EMPLOYEES.LABOR_DATA_insert_update
(
      @poi_employee_id int    output,
      @pid_salary_advance decimal(4, 2)    ,
      @piv_reference varchar(400)    ,
      @pid_test_end_date datetime    ,
      @piv_employee_type_id varchar(20)    ,
      @piv_educational_situation_id varchar(20)    ,
      @piv_occupation_id varchar(20)    ,
      @piv_position_id varchar(20)    ,
      @piv_cost_center_id varchar(20)    ,
      @piv_special_situation_id varchar(20)    ,
      @piv_labor_regime_id varchar(20)    ,
      @piv_essalud_vida_id varchar(20)    ,
      @piv_service_unit_id varchar(20)    ,
      @piv_area_seccion_id varchar(20)    ,
      @piv_trust_position_id varchar(20)    ,
      @piv_account_category_id varchar(20)    ,
      @piv_work_type_id varchar(20)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.LABOR_DATA Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.LABOR_DATA
		(
			employee_id,
			salary_advance,
			reference,
			test_end_date,
			employee_type_id,
			educational_situation_id,
			occupation_id,
			position_id,
			cost_center_id,
			special_situation_id,
			labor_regime_id,
			essalud_vida_id,
			service_unit_id,
			area_seccion_id,
			trust_position_id,
			account_category_id,
			work_type_id,
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
			@pid_salary_advance,
			@piv_reference,
			@pid_test_end_date,
			@piv_employee_type_id,
			@piv_educational_situation_id,
			@piv_occupation_id,
			@piv_position_id,
			@piv_cost_center_id,
			@piv_special_situation_id,
			@piv_labor_regime_id,
			@piv_essalud_vida_id,
			@piv_service_unit_id,
			@piv_area_seccion_id,
			@piv_trust_position_id,
			@piv_account_category_id,
			@piv_work_type_id,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		--Set @poi_employee_id = SCOPE_IDENTITY();

	End
	Begin

		Update EMPLOYEES.LABOR_DATA Set
			salary_advance = @pid_salary_advance,
			reference = @piv_reference,
			test_end_date = @pid_test_end_date,
			employee_type_id = @piv_employee_type_id,
			educational_situation_id = @piv_educational_situation_id,
			occupation_id = @piv_occupation_id,
			position_id = @piv_position_id,
			cost_center_id = @piv_cost_center_id,
			special_situation_id = @piv_special_situation_id,
			labor_regime_id = @piv_labor_regime_id,
			essalud_vida_id = @piv_essalud_vida_id,
			service_unit_id = @piv_service_unit_id,
			area_seccion_id = @piv_area_seccion_id,
			trust_position_id = @piv_trust_position_id,
			account_category_id = @piv_account_category_id,
			work_type_id = @piv_work_type_id,
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