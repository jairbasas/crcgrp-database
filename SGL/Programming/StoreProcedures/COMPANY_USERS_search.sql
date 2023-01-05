Create Procedure TRANSVERSAL.COMPANY_USERS_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_company_user_id int

Begin

	--EXECUTE TRANSVERSAL.COMPANY_USERS_search '<Record> <company_user_id>1</company_user_id> </Record>', '';

	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

  End;

	--OBTENGO LOS FILTROS
	Begin

		--company_user_id
		Begin Try
			Set @pii_company_user_id = 
			(
				Select company_user_id
				From OpenXML (@docXML, 'Record',2)
				With (company_user_id int)
			);
		End Try
		Begin Catch
			Set @pii_company_user_id = 0;
		End Catch;

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.company_user_id			[company_user_id],
			DB.user_id			[user_id],
			DB.company_id			[company_id],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime],
			DB.state			[state]'
			Set @sqlJoin = '
			From TRANSVERSAL.COMPANY_USERS [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--company_user_id
			If @pii_company_user_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.company_user_id = ' + Cast(@pii_company_user_id As Varchar) + ''
			End;
		End;

		--ORDER BY
		Begin
			If @piv_orderBy = ''
			Begin
				Set @piv_orderBy = 'company_user_id ASC';
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