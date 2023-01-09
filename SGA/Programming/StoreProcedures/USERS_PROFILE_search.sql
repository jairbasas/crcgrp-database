Create Procedure SECURITY.USERS_PROFILE_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_user_id INT, @profile_id INT, @system_id INT;

Begin

	--EXECUTE SECURITY.USERS_PROFILE_search '<Record> <user_id>1</user_id> </Record>', '';

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

		--profile_id
		Begin Try
			Set @profile_id = 
			(
				Select profile_id
				From OpenXML (@docXML, 'Record',2)
				With (profile_id int)
			);
		End Try
		Begin Catch
			Set @profile_id = 0;
		End Catch;

		--system_id
		Begin Try
			Set @system_id = 
			(
				Select system_id
				From OpenXML (@docXML, 'Record',2)
				With (system_id int)
			);
		End Try
		Begin Catch
			Set @system_id = 0;
		End Catch;

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.user_id			[user_id],
			DB.profile_id			[profile_id],
			P.system_id				[system_id],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From SECURITY.USERS_PROFILE [DB]
			INNER JOIN SECURITY.PROFILE P ON P.profile_id = DB.profile_id '
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

			--profile_id
			If @profile_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.profile_id = ' + Cast(@profile_id As Varchar) + ''
			End;

			--system_id
			If @system_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And P.system_id = ' + Cast(@system_id As Varchar) + ''
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