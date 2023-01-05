Create Procedure SECURITY.MENU_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_menu_id INT, @menu_id_list VARCHAR(max), @state INT;

Begin

	--EXECUTE SECURITY.MENU_search '<Record> <menu_id>1</menu_id> </Record>', '';
	--EXECUTE SECURITY.MENU_search '<Record> <menu_id_list>1,2</menu_id_list> </Record>', '';

	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

  End;

	--OBTENGO LOS FILTROS
	Begin

		--menu_id
		Begin Try
			Set @pii_menu_id = 
			(
				Select menu_id
				From OpenXML (@docXML, 'Record',2)
				With (menu_id int)
			);
		End Try
		Begin Catch
			Set @pii_menu_id = 0;
		End Catch;

		--menu_id_list
		Begin Try
			Set @menu_id_list = 
			(
				Select menu_id_list
				From OpenXML (@docXML, 'Record',2)
				With (menu_id_list VARCHAR(max))
			);
		End Try
		Begin Catch
			Set @menu_id_list = '';
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
			DB.menu_id			[menu_id],
			DB.menu_name			[menu_name],
			DB.level			[level],
			DB.url			[url],
			DB.icon			[icon],
			DB.[order]			[order],
			DB.menu_parent_id	[menu_parent_id],
			DB.state			[state],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From SECURITY.MENU [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--menu_id
			If @pii_menu_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.menu_id = ' + Cast(@pii_menu_id As Varchar) + ''
			End;

			--state
			If @menu_id_list <> ''
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.menu_id IN (SELECT value FROM STRING_SPLIT(''' + @menu_id_list + ''', '',''))'
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
				Set @piv_orderBy = 'menu_id ASC';
			End;

			Set @piv_orderBy = '
			Order By ' + @piv_orderBy;
		End;

	End;

	--EJECUTO LA CONSULTA SQL
	Begin

		Print(@sqlBody + @sqlJoin + @sqlWhere + @piv_orderBy);

		Execute(@sqlBody + @sqlJoin + @sqlWhere + @piv_orderBy);

	End;

End;

Go