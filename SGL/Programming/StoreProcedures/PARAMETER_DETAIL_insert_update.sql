Create Procedure TRANSVERSAL.PARAMETER_DETAIL_insert_update
(
      @poi_parameter_detail_id int    output,
      @piv_description varchar(300)    ,
      @piv_field_value_1 varchar(300)    ,
      @piv_field_description_1 varchar(300)    ,
      @piv_field_value_2 varchar(300)    ,
      @piv_field_description_2 varchar(300)    ,
      @piv_field_value_3 varchar(300)    ,
      @piv_field_description_3 varchar(300)    ,
      @pii_parameter_id int    
)
As
Begin

	If Not Exists (Select 1 From TRANSVERSAL.PARAMETER_DETAIL Where parameter_detail_id= @poi_parameter_detail_id)
	Begin

		Insert Into TRANSVERSAL.PARAMETER_DETAIL
		(
			description,
			field_value_1,
			field_description_1,
			field_value_2,
			field_description_2,
			field_value_3,
			field_description_3,
			parameter_id
		)
		Values
		(
			@piv_description,
			@piv_field_value_1,
			@piv_field_description_1,
			@piv_field_value_2,
			@piv_field_description_2,
			@piv_field_value_3,
			@piv_field_description_3,
			@pii_parameter_id
		);

		Set @poi_parameter_detail_id = SCOPE_IDENTITY();

	End
	Begin

		Update TRANSVERSAL.PARAMETER_DETAIL Set
			description = @piv_description,
			field_value_1 = @piv_field_value_1,
			field_description_1 = @piv_field_description_1,
			field_value_2 = @piv_field_value_2,
			field_description_2 = @piv_field_description_2,
			field_value_3 = @piv_field_value_3,
			field_description_3 = @piv_field_description_3,
			parameter_id = @pii_parameter_id
		Where parameter_detail_id = @poi_parameter_detail_id;

	End;

End;
Go