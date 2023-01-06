Create Procedure EMPLOYEES.EMPLOYEE_insert_update
(
      @poi_employee_id int    output,
      @piv_code varchar(20)    ,
      @piv_name varchar(200)    ,
      @piv_father_last_name varchar(200)    ,
      @piv_mother_last_name varchar(200)    ,
      @piv_category_name varchar(20)    ,
      @piv_situation_id varchar(20)    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_update datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From EMPLOYEES.EMPLOYEE Where employee_id= @poi_employee_id)
	Begin

		Insert Into EMPLOYEES.EMPLOYEE
		(
			code,
			name,
			father_last_name,
			mother_last_name,
			category_name,
			situation_id,
			register_user_id,
			register_user_fullname,
			register_update,
			update_user_id,
			update_user_fullname,
			update_datetime
		)
		Values
		(
			@piv_code,
			@piv_name,
			@piv_father_last_name,
			@piv_mother_last_name,
			@piv_category_name,
			@piv_situation_id,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_update,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		Set @poi_employee_id = SCOPE_IDENTITY();

	End
	Begin

		Update EMPLOYEES.EMPLOYEE Set
			code = @piv_code,
			name = @piv_name,
			father_last_name = @piv_father_last_name,
			mother_last_name = @piv_mother_last_name,
			category_name = @piv_category_name,
			situation_id = @piv_situation_id,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_update = @pid_register_update,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
		Where employee_id = @poi_employee_id;

	End;

End;
Go