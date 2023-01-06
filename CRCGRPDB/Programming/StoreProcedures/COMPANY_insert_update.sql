Create Procedure TRANSVERSAL.COMPANY_insert_update
(
      @poi_company_id int    output,
      @piv_business_name varchar(300)    ,
      @piv_tradename varchar(300)    ,
      @piv_document_number varchar(20)    ,
      @pii_state int    ,
      @pii_register_user_id int    ,
      @piv_register_user_fullname varchar(250)    ,
      @pid_register_datetime datetime    ,
      @pii_update_user_id int    ,
      @piv_update_user_fullname varchar(250)    ,
      @pid_update_datetime datetime    
)
As
Begin

	If Not Exists (Select 1 From TRANSVERSAL.COMPANY Where company_id= @poi_company_id)
	Begin

		Insert Into TRANSVERSAL.COMPANY
		(
			business_name,
			tradename,
			document_number,
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
			@piv_business_name,
			@piv_tradename,
			@piv_document_number,
			@pii_state,
			@pii_register_user_id,
			@piv_register_user_fullname,
			@pid_register_datetime,
			@pii_update_user_id,
			@piv_update_user_fullname,
			@pid_update_datetime
		);

		Set @poi_company_id = SCOPE_IDENTITY();

	End
	Begin

		Update TRANSVERSAL.COMPANY Set
			business_name = @piv_business_name,
			tradename = @piv_tradename,
			document_number = @piv_document_number,
			state = @pii_state,
			register_user_id = @pii_register_user_id,
			register_user_fullname = @piv_register_user_fullname,
			register_datetime = @pid_register_datetime,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
		Where company_id = @poi_company_id;

	End;

End;
Go