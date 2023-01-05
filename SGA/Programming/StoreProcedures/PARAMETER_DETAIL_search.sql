Create Procedure SECURITY.PARAMETER_DETAIL_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_parameter_detail_id INT, @parameter_id INT;

Begin

	--EXECUTE SECURITY.PARAMETER_DETAIL_search '<Record> <parameter_detail_id>1</parameter_detail_id> </Record>', '';

	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

  End;

	--OBTENGO LOS FILTROS
	Begin

		--parameter_detail_id
		Begin Try
			Set @pii_parameter_detail_id = 
			(
				Select parameter_detail_id
				From OpenXML (@docXML, 'Record',2)
				With (parameter_detail_id int)
			);
		End Try
		Begin Catch
			Set @pii_parameter_detail_id = 0;
		End Catch;

		--parameter_id
		Begin Try
			Set @parameter_id = 
			(
				Select parameter_id
				From OpenXML (@docXML, 'Record',2)
				With (parameter_id int)
			);
		End Try
		Begin Catch
			Set @parameter_id = 0;
		End Catch;

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.parameter_detail_id			[parameter_detail_id],
			DB.description			[description],
			DB.field_value_1			[field_value_1],
			DB.field_description_1			[field_description_1],
			DB.field_value_2			[field_value_2],
			DB.field_description_2			[field_description_2],
			DB.field_value_3			[field_value_3],
			DB.field_description_3			[field_description_3],
			DB.parameter_id			[parameter_id]'
			Set @sqlJoin = '
			From SECURITY.PARAMETER_DETAIL [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--parameter_detail_id
			If @pii_parameter_detail_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.parameter_detail_id = ' + Cast(@pii_parameter_detail_id As Varchar) + ''
			End;

			--parameter_id
			If @parameter_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.parameter_id = ' + Cast(@parameter_id As Varchar) + ''
			End;

		End;

		--ORDER BY
		Begin
			If @piv_orderBy = ''
			Begin
				Set @piv_orderBy = 'parameter_detail_id ASC';
			End;

			Set @piv_orderBy = '
			Order By ' + @piv_orderBy;
		End;

	End;

	--EJECUTO LA CONSULTA SQL
	Begin

		--Print(@sqlBody + @sqlJoin + @sqlWhere + @piv_orderBy);

		Execute(@sqlBody + @sqlJoin + @sqlWhere + @piv_orderBy);

	End;

End;

Go