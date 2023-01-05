Create Procedure TRANSVERSAL.COMPANY_USERS_find_all
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
Declare @docXML int,@pii_company_user_id int;

-- VARIABLES DE PAGINACION
Declare @paginaDesde varchar(10),@paginaHasta varchar(10);

Begin

	--EXECUTE TRANSVERSAL.COMPANY_USERS_find_all '<Record> <company_user_id>1</company_user_id> </Record>',0,0,'',NULL;

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