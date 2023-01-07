﻿Create Procedure TRANSVERSAL.USERS_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_user_id INT, @company_id INT;

Begin

	--EXECUTE TRANSVERSAL.USERS_search '<Record> <user_id>1</user_id> </Record>', '';
	--EXECUTE TRANSVERSAL.USERS_search '<Record> <company_id>3</company_id> </Record>', '';
	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

  End;

	--OBTENGO LOS FILTROS
	Begin

		--user_id
		Begin Try
			Set @pii_user_id = 
			(
				Select user_id
				From OpenXML (@docXML, 'Record',2)
				With (user_id int)
			);
		End Try
		Begin Catch
			Set @pii_user_id = 0;
		End Catch;

		--company_id
		Begin Try
			Set @company_id = 
			(
				Select company_id
				From OpenXML (@docXML, 'Record',2)
				With (company_id int)
			);
		End Try
		Begin Catch
			Set @company_id = 0;
		End Catch;

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.user_id			[user_id],
			DB.user_name			[user_name],
			DB.father_last_name			[father_last_name],
			DB.mother_last_name			[mother_last_name],
			DB.document_number			[document_number],
			DB.email			[email],
			DB.state			[state],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From TRANSVERSAL.USERS [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--user_id
			If @pii_user_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.user_id = ' + Cast(@pii_user_id As Varchar) + ''
			End;

			--company_id
			If @company_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.user_id IN (SELECT CU.user_id FROM TRANSVERSAL.COMPANY_USERS CU WHERE CU.company_id = ' + Cast(@company_id As Varchar) + ' AND CU.state = 1)'
			End;
		End;

		--ORDER BY
		Begin
			If @piv_orderBy = ''
			Begin
				Set @piv_orderBy = 'user_id ASC';
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