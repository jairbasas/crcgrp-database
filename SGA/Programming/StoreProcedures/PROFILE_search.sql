Create Procedure SECURITY.PROFILE_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_profile_id INT, @system_id INT, @state INT;

Begin

	--EXECUTE SECURITY.PROFILE_search '<Record> <profile_id>1</profile_id> </Record>', '';

	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

  End;

	--OBTENGO LOS FILTROS
	Begin

		--profile_id
		Begin Try
			Set @pii_profile_id = 
			(
				Select profile_id
				From OpenXML (@docXML, 'Record',2)
				With (profile_id int)
			);
		End Try
		Begin Catch
			Set @pii_profile_id = 0;
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
			DB.profile_id			[profile_id],
			DB.profile_name			[profile_name],
			DB.state			[state],
			DB.system_id			[system_id],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From SECURITY.PROFILE [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--profile_id
			If @pii_profile_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.profile_id = ' + Cast(@pii_profile_id As Varchar) + ''
			End;

			--system_id
			If @system_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.system_id = ' + Cast(@system_id As Varchar) + ''
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
				Set @piv_orderBy = 'profile_id ASC';
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