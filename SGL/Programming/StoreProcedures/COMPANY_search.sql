Create Procedure TRANSVERSAL.COMPANY_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_company_id INT, @state INT;

Begin

	--EXECUTE TRANSVERSAL.COMPANY_search '<Record> <company_id>1</company_id> </Record>', '';

	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

  End;

	--OBTENGO LOS FILTROS
	Begin

		--company_id
		Begin Try
			Set @pii_company_id = 
			(
				Select company_id
				From OpenXML (@docXML, 'Record',2)
				With (company_id int)
			);
		End Try
		Begin Catch
			Set @pii_company_id = 0;
		End Catch;

		--state
		Begin Try
			Set @state = 
			(
				Select state
				From OpenXML (@docXML, 'Record',2)
				With (state int)
			);
		End Try
		Begin Catch
			Set @state = 0;
		End Catch;

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.company_id			[company_id],
			DB.business_name			[business_name],
			DB.tradename			[tradename],
			DB.document_number			[document_number],
			DB.state			[state],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From TRANSVERSAL.COMPANY [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--company_id
			If @pii_company_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.company_id = ' + Cast(@pii_company_id As Varchar) + ''
			End;

			--state
			If @state > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.state = ' + Cast(@state As Varchar) + ''
			End;

		End;

		--ORDER BY
		Begin
			If @piv_orderBy = ''
			Begin
				Set @piv_orderBy = 'company_id ASC';
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