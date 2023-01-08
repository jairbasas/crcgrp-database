CREATE PROCEDURE EMPLOYEES.LABOR_TAX_DATA_insert_update_json
(
	@jsonData NTEXT
)
AS
BEGIN
    MERGE INTO EMPLOYEES.LABOR_TAX_DATA [TBL]
	USING (
		SELECT * FROM OPENJSON(@jsonData)
		WITH (
			employeeId INT,
			parameterDetailId int,
			state BIT,
			registerUserId INT,
			registerUserFullname VARCHAR(250),
			registerDatetime DATETIME
		)
	)[TMP]
	(
		employeeId, parameterDetailId, state, registerUserId, registerUserFullname, registerDatetime
	)
	ON (
		TBL.employee_id = TMP.employeeId AND tbl.parameter_detail_id = TMP.parameterDetailId
	)
	WHEN NOT MATCHED THEN
	INSERT
	(
		employee_id,
		parameter_detail_id,
		state,
		register_user_id,
		register_user_fullname,
		register_datetime
	)
	VALUES (
		TMP.employeeId,
		TMP.parameterDetailId,
		TMP.state,
		TMP.registerUserId,
		TMP.registerUserFullname,
		TMP.registerDatetime
	)
	WHEN MATCHED THEN
	UPDATE SET
		TBL.state = TMP.state,
		TBL.update_user_id = TMP.registerUserId,
		TBL.update_user_fullname = TMP.registerUserFullname,
		TBL.update_datetime = TMP.registerDatetime;
END;