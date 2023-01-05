Create Procedure TRANSVERSAL.PARAMETER_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_parameter_id int

Begin

	--EXECUTE TRANSVERSAL.PARAMETER_search '<Record> <parameter_id>1</parameter_id> </Record>', '';

	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

  End;

	--OBTENGO LOS FILTROS
	Begin

		--parameter_id
		Begin Try
			Set @pii_parameter_id = 
			(
				Select parameter_id
				From OpenXML (@docXML, 'Record',2)
				With (parameter_id int)
			);
		End Try
		Begin Catch
			Set @pii_parameter_id = 0;
		End Catch;

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.parameter_id			[parameter_id],
			DB.parameter_name			[parameter_name],
			DB.state			[state]'
			Set @sqlJoin = '
			From TRANSVERSAL.PARAMETER [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--parameter_id
			If @pii_parameter_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.parameter_id = ' + Cast(@pii_parameter_id As Varchar) + ''
			End;
		End;

		--ORDER BY
		Begin
			If @piv_orderBy = ''
			Begin
				Set @piv_orderBy = 'parameter_id ASC';
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