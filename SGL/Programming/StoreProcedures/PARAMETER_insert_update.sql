Create Procedure TRANSVERSAL.PARAMETER_insert_update
(
      @poi_parameter_id int    output,
      @piv_parameter_name varchar(300)    ,
      @pii_state int    
)
As
Begin

	If Not Exists (Select 1 From TRANSVERSAL.PARAMETER Where parameter_id= @poi_parameter_id)
	Begin

		Insert Into TRANSVERSAL.PARAMETER
		(
			parameter_name,
			state
		)
		Values
		(
			@piv_parameter_name,
			@pii_state
		);

		Set @poi_parameter_id = SCOPE_IDENTITY();

	End
	Begin

		Update TRANSVERSAL.PARAMETER Set
			parameter_name = @piv_parameter_name,
			state = @pii_state
		Where parameter_id = @poi_parameter_id;

	End;

End;
Go