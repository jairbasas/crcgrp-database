CREATE Procedure EMPLOYEES.EMPLOYEE_find_all
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
Declare @docXML int,@pii_employee_id INT, @company_id INT, @code VARCHAR(20), @name VARCHAR(max);

-- VARIABLES DE PAGINACION
Declare @paginaDesde varchar(10),@paginaHasta varchar(10);

Begin

	--EXECUTE EMPLOYEES.EMPLOYEE_find_all '<Record> <employee_id>9</employee_id> </Record>',1,10,'',NULL;

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

		--employee_id
		Begin Try
			Set @pii_employee_id = 
			(
				Select employee_id
				From OpenXML (@docXML, 'Record',2)
				With (employee_id int)
			);
		End Try
		Begin Catch
			Set @pii_employee_id = 0;
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

		--code
		Begin Try
			Set @code = 
			(
				Select code
				From OpenXML (@docXML, 'Record',2)
				With (code VARCHAR(20))
			);
		End Try
		Begin Catch
			Set @code = '';
		End Catch;

		--name
		Begin Try
			Set @name = 
			(
				Select name
				From OpenXML (@docXML, 'Record',2)
				With (name VARCHAR(max))
			);
		End Try
		Begin Catch
			Set @name = '';
		End Catch;

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.employee_id			[employee_id],
			DB.code			[code],
			DB.name			[name],
			DB.father_last_name			[father_last_name],
			DB.mother_last_name			[mother_last_name],
			DB.category_name			[category_name],
			DB.situation_id			[situation_id],
			ST.description			[situation_name],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_update			[register_update],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime],
			s.description [sex_name],
			DT.description [document_type_name],
			CV.description [civil_status_name],
			N.description [nationality_name],
			c.business_name [business_name],
			A.description [area_section_name],
			CA.description [charge_name],
			CEN.description [center_cost_name],
			CON.start_date [start_date],
			CON.end_date [end_date],
			CC.description [cost_center_name],
			WP.termination_date [termination_date]'
			Set @sqlJoin = '
			From EMPLOYEES.EMPLOYEE [DB]
			INNER JOIN EMPLOYEES.EMPLOYEE_COMPANY EC ON EC.employee_id = DB.employee_id AND ec.state = 1
			INNER JOIN TRANSVERSAL.COMPANY C ON C.company_id = EC.company_id AND c.state = 1
			INNER JOIN TRANSVERSAL.PARAMETER_DETAIL ST ON ST.parameter_id = 2 AND ST.field_value_1 = DB.situation_id
			LEFT JOIN EMPLOYEES.MAIN_DATA MD ON MD.employee_id = DB.employee_id
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL S ON s.parameter_id = 4 AND md.sex_id = s.field_value_1
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL DT ON DT.parameter_id = 3 AND DT.field_value_1 = MD.document_type_id
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL CV ON CV.parameter_id = 5 AND CV.field_value_1 = MD.civil_status
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL N ON N.parameter_id = 7 AND N.field_value_1 = MD.nationality_id
			LEFT JOIN EMPLOYEES.LABOR_DATA LD ON LD.employee_id = DB.employee_id
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL CC ON CC.field_value_1 = LD.cost_center_id AND CC.parameter_id = 14
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL A ON A.parameter_id = 9 AND A.field_value_1 = LD.area_seccion_id
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL CA ON ca.parameter_id = 13 AND ca.field_value_1 = ld.position_id
			LEFT JOIN TRANSVERSAL.PARAMETER_DETAIL CEN ON CEN.parameter_id = 14 AND CEN.field_value_1 = LD.cost_center_id
			LEFT JOIN EMPLOYEES.CONTRACT CON ON CON.employee_id = DB.employee_id
			LEFT JOIN EMPLOYEES.WORKING_PERIOD WP ON WP.employee_id = DB.employee_id'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1) AND DB.employee_id NOT IN (SELECT EA.employee_id FROM EMPLOYEES.EMPLOYEE_APPROVAL EA) ';

			--employee_id
			If @pii_employee_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.employee_id = ' + Cast(@pii_employee_id As Varchar) + ''
			End;

			--company_id
			If @company_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And EC.company_id = ' + Cast(@company_id As Varchar) + ''
			End;

			--code
			If @code <> ''
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.code Like ''%' + Cast(@code As VARCHAR(20)) + '%'''
			End;

			--name
			If @name <> ''
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.name + SPACE(1) + DB.father_last_name + SPACE(1) + DB.mother_last_name Like ''%' + Cast(@name As VARCHAR(20)) + '%'''
			End;

		End;

		--ORDER BY
		Begin
			If @piv_orderBy = ''
			Begin
				Set @piv_orderBy = 'employee_id ASC';
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

