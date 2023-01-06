Create Procedure EMPLOYEES.LABOR_DATA_search
(
     @pit_parametrosXML		ntext,
     @piv_orderBy			varchar(100)
)
As

-- VARIABLES SQL
Declare @sqlBody varchar(max),@sqlJoin varchar(max),@sqlWhere varchar(max);

-- VARIABLES DE FILTRO
Declare @docXML int,@pii_employee_id int

Begin

	--EXECUTE EMPLOYEES.LABOR_DATA_search '<Record> <employee_id>1</employee_id> </Record>', '';

	--INICIALIZO LAS VARIABLES
  Begin

		--INICIALIZO LOS XML
		EXEC sp_xml_preparedocument @docXML output, @pit_parametrosXML;

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

	End;

	--CONSTRUYO LA CONSULTA SQL
	Begin

		--BODY SQL
		Begin
			Set @sqlBody = '
			Select
			DB.employee_id			[employee_id],
			DB.salary_advance			[salary_advance],
			DB.reference			[reference],
			DB.test_end_date			[test_end_date],
			DB.employee_type_id			[employee_type_id],
			DB.educational_situation_id			[educational_situation_id],
			DB.occupation_id			[occupation_id],
			DB.position_id			[position_id],
			DB.cost_center_id			[cost_center_id],
			DB.special_situation_id			[special_situation_id],
			DB.labor_regime_id			[labor_regime_id],
			DB.essalud_vida_id			[essalud_vida_id],
			DB.service_unit_id			[service_unit_id],
			DB.area_seccion_id			[area_seccion_id],
			DB.trust_position_id			[trust_position_id],
			DB.account_category_id			[account_category_id],
			DB.work_type_id			[work_type_id],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From EMPLOYEES.LABOR_DATA [DB]'
		End;
		--WHERE SQL
		Begin

			Set @sqlWhere = '
			Where (1=1)';

			--employee_id
			If @pii_employee_id > 0
			Begin
				Set @sqlWhere = @sqlWhere + '
				And DB.employee_id = ' + Cast(@pii_employee_id As Varchar) + ''
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

		Execute(@sqlBody + @sqlJoin + @sqlWhere + @piv_orderBy);

	End;

End;

Go