CREATE PROCEDURE EMPLOYEES.SCTR_insert_update_json
(
	@jsonData NTEXT
)
AS
BEGIN
    MERGE INTO EMPLOYEES.SCTR [TBL]
	USING (
		SELECT * FROM OPENJSON(@jsonData)
		WITH (
			employeeId INT,
			parameterDetailId INT,
			sctrCode VARCHAR(20),
			tasa VARCHAR(20),			
			registerUserId INT,
			registerUserFullname VARCHAR(250),
			registerDatetime DATETIME
		)
	)[TMP]
	(
		employeeId, parameterDetailId, sctrCode, tasa, registerUserId, registerUserFullname, registerDatetime
	)
	ON
	(
		TBL.employee_id = tmp.employeeId AND tbl.parameter_detail_id = TMP.parameterDetailId
	)
	WHEN NOT MATCHED THEN
	INSERT
	(
		employee_id,
		parameter_detail_id,
		sctr_code,
		tasa,
		register_user_id,
		register_user_fullname,
		register_datetime
	)
	VALUES
	(
		TMP.employeeId,
		TMP.parameterDetailId,
		TMP.sctrCode,
		TMP.tasa,
		TMP.registerUserId,
		TMP.registerUserFullname,
		TMP.registerDatetime
	)
	WHEN MATCHED THEN
	UPDATE SET
		TBL.sctr_code = TMP.sctrCode,
		TBL.tasa = TMP.tasa,
		TBL.update_user_id = TMP.registerUserId,
		TBL.update_user_fullname = TMP.registerUserFullname,
		TBL.update_datetime = TMP.registerDatetime;
END;