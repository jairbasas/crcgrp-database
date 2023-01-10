﻿Create Procedure SECURITY.USERS_find_all
(
	@pit_parametrosXML		ntext,
	@pii_paginaActual		int,
	@pii_cantidadMostrar	int,
	@piv_orderBy			varchar(100),
	@poi_totalRegistros		int output
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(MAX),@sqlJoin varchar(MAX),@sqlWhere varchar(MAX),@sqlCount nvarchar(MAX);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_user_id INT, @user_name VARCHAR(200), @state int;

-- VARIABLES DE PAGINACION
Declare @paginaDesde varchar(10),@paginaHasta varchar(10);

Begin

	--EXECUTE SECURITY.USERS_find_all '<Record> <user_name>soto</user_name> </Record>',0,0,'',NULL;

	--INICIALIZO LAS VARIABLES
	Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

		--INICIALIZO PAGINACION
		Set @paginaDesde = Cast((((@pii_paginaActual - 1) * @pii_cantidadMostrar) + 1) As varchar);
		Set @paginaHasta = Cast((@pii_paginaActual * @pii_cantidadMostrar) As varchar);

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

		--user_name
		Begin Try
			Set @user_name = 
			(
				Select user_name
				From OpenXML (@docXML, 'Record',2)
				With (user_name VARCHAR(200))
			);
		End Try
		Begin Catch
			Set @user_name = '';
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
			DB.user_id			[user_id],
			DB.user_name			[user_name],
			DB.father_last_name			[father_last_name],
			DB.mother_last_name			[mother_last_name],
			DB.document_number			[document_number],
			DB.email			[email],
			DB.login			[login],
			DB.password			[password],
			DB.reset_password			[reset_password],
			DB.state			[state],
			PD.description		[state_name],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From SECURITY.USERS [DB]
			INNER JOIN SECURITY.PARAMETER_DETAIL PD ON db.state = pd.parameter_detail_id '
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

			--user_name
			If @user_name <> ''
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.user_name + SPACE(1) + DB.father_last_name + SPACE(1) + DB.mother_last_name  Like ''%' + Cast(@user_name As VARCHAR(200)) + '%'''
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
				Set @piv_orderBy = 'user_id ASC';
			End;

			Set @piv_orderBy = '
			Order By ' + @piv_orderBy;
		End;

	End;

	--EJECUTO LA CONSULTA SQL
	Begin

		Print(@sqlBody + @sqlJoin + @sqlWhere + @piv_orderBy);

		If @pii_paginaActual > 0 --CONSULTA CON PAGINACION
		Begin

			--OBTENGO EL TOTAL DE REGISTROS
			Set @sqlCount = N'SELECT @COUNT = COUNT(1) ' + @sqlJoin + @sqlWhere;

			Execute sp_executesql @sqlCount,N'@COUNT INT OUTPUT',@COUNT=@poi_totalRegistros OUTPUT;

			Execute('SELECT * FROM (SELECT ROW_NUMBER() OVER (' + @piv_orderBy + ') [ROWNUM],* FROM (' + @sqlBody + @sqlJoin + @sqlWhere + ') [TMP] ) [PAG] WHERE ROWNUM >= ' + @paginaDesde + ' And ROWNUM <= ' + @paginaHasta)

		End
		Else
		Begin

			SET @poi_totalRegistros = 0;

			Execute(@sqlBody + @sqlJoin + @sqlWhere + @piv_orderBy);

		End;

	End;
End;

Go