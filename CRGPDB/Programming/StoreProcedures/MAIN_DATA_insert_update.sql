Create Procedure EMPLOYEES.MAIN_DATA_insert_update
(
      @poi_employee_id int    output,
      @piv_document_number varchar(20)    ,
      @pid_birth_date datetime    ,
      @piv_ubigeo_birth varchar(20)    ,
      @piv_postal_code varchar(20)    ,
      @piv_phone_number varchar(20)    ,
      @piv_email varchar(100)    ,
      @pib_domiciled bit    ,
      @piv_route_type_number varchar(20)    ,
      @piv_department varchar(20)    ,
      @piv_inside varchar(20)    ,
      @piv_mz varchar(20)    ,
      @piv_route_name varchar(200)    ,
      @piv_lt varchar(20)    ,
      @piv_km varchar(20)    ,
      @piv_block varchar(20)    ,
      @piv_zone_name varchar(200)    ,
      @piv_stage varchar(20)    ,
      @piv_reference varchar(300)    ,
      @piv_ubigeo varchar(20)    ,
      @piv_document_type_id varchar(20)    ,
      @piv_nationality_id varchar(20)    ,
      @piv_sex_id varchar(20)    ,
      @piv_civil_status varchar(20)    ,
      @piv_route_type_id varchar(20)    ,
      @piv_zone_type_id varchar(20)    ,
      @piv_observation varchar(400)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.MAIN_DATA Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.MAIN_DATA
		(
			employee_id,
			document_number,
			birth_date,
			ubigeo_birth,
			postal_code,
			phone_number,
			email,
			domiciled,
			route_type_number,
			department,
			inside,
			mz,
			route_name,
			lt,
			km,
			block,
			zone_name,
			stage,
			reference,
			ubigeo,
			document_type_id,
			nationality_id,
			sex_id,
			civil_status,
			route_type_id,
			zone_type_id,
			observation,
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
			@piv_document_number,
			@pid_birth_date,
			@piv_ubigeo_birth,
			@piv_postal_code,
			@piv_phone_number,
			@piv_email,
			@pib_domiciled,
			@piv_route_type_number,
			@piv_department,
			@piv_inside,
			@piv_mz,
			@piv_route_name,
			@piv_lt,
			@piv_km,
			@piv_block,
			@piv_zone_name,
			@piv_stage,
			@piv_reference,
			@piv_ubigeo,
			@piv_document_type_id,
			@piv_nationality_id,
			@piv_sex_id,
			@piv_civil_status,
			@piv_route_type_id,
			@piv_zone_type_id,
			@piv_observation,
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

		Update EMPLOYEES.MAIN_DATA Set
			document_number = @piv_document_number,
			birth_date = @pid_birth_date,
			ubigeo_birth = @piv_ubigeo_birth,
			postal_code = @piv_postal_code,
			phone_number = @piv_phone_number,
			email = @piv_email,
			domiciled = @pib_domiciled,
			route_type_number = @piv_route_type_number,
			department = @piv_department,
			inside = @piv_inside,
			mz = @piv_mz,
			route_name = @piv_route_name,
			lt = @piv_lt,
			km = @piv_km,
			block = @piv_block,
			zone_name = @piv_zone_name,
			stage = @piv_stage,
			reference = @piv_reference,
			ubigeo = @piv_ubigeo,
			document_type_id = @piv_document_type_id,
			nationality_id = @piv_nationality_id,
			sex_id = @piv_sex_id,
			civil_status = @piv_civil_status,
			route_type_id = @piv_route_type_id,
			zone_type_id = @piv_zone_type_id,
			observation = @piv_observation,
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