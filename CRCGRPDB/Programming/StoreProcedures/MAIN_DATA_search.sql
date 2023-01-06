﻿Create Procedure EMPLOYEES.MAIN_DATA_search
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

	--EXECUTE EMPLOYEES.MAIN_DATA_search '<Record> <employee_id>1</employee_id> </Record>', '';

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
			DB.document_number			[document_number],
			DB.birth_date			[birth_date],
			DB.ubigeo_birth			[ubigeo_birth],
			DB.postal_code			[postal_code],
			DB.phone_number			[phone_number],
			DB.email			[email],
			DB.domiciled			[domiciled],
			DB.route_type_number			[route_type_number],
			DB.department			[department],
			DB.inside			[inside],
			DB.mz			[mz],
			DB.route_name			[route_name],
			DB.lt			[lt],
			DB.km			[km],
			DB.block			[block],
			DB.zone_name			[zone_name],
			DB.stage			[stage],
			DB.reference			[reference],
			DB.ubigeo			[ubigeo],
			DB.document_type_id			[document_type_id],
			DB.nationality_id			[nationality_id],
			DB.sex_id			[sex_id],
			DB.civil_status			[civil_status],
			DB.route_type_id			[route_type_id],
			DB.zone_type_id			[zone_type_id],
			DB.observation			[observation],
			DB.register_user_id			[register_user_id],
			DB.register_user_fullname			[register_user_fullname],
			DB.register_datetime			[register_datetime],
			DB.update_user_id			[update_user_id],
			DB.update_user_fullname			[update_user_fullname],
			DB.update_datetime			[update_datetime]'
			Set @sqlJoin = '
			From EMPLOYEES.MAIN_DATA [DB]'
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