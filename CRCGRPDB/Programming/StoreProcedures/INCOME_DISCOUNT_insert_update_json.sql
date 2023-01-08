CREATE PROCEDURE EMPLOYEES.INCOME_DISCOUNT_insert_update_json
(
	@jsonData NTEXT
)
AS
BEGIN
    MERGE INTO EMPLOYEES.INCOME_DISCOUNT [TBL]
	USING (
		SELECT * FROM OPENJSON(@jsonData)
		WITH (
			employeeid INT,
			code VARCHAR(20),
			description VARCHAR(200),
			currencyId VARCHAR(20),
			amount DECIMAL(18,4),
			state BIT,
			registerUserId INT,
			registerUserFullname VARCHAR(250),
			registerDatetime DATETIME
		)
	)[TMP]
	(
		employeeId, code, description, currencyId, amount, state, registerUserId, registerUserFullname, registerDatetime
	)
	ON
	(
		TBL.employee_id = TMP.employeeId AND TBL.code = TMP.code
	)
	WHEN NOT MATCHED THEN
	INSERT
	(
		employee_id,
		code,
		description,
		currency_id,
		amount,
		state,
		register_user_id,
		register_user_fullname,
		register_datetime
	)
	VALUES (
		TMP.employeeId,
		TMP.code,
		TMP.description,
		TMP.currencyId,
		TMP.amount,
		TMP.state,
		TMP.registerUserId,
		TMP.registerUserFullname,
		TMP.registerDatetime
	)
	WHEN MATCHED THEN
	UPDATE SET
		TBL.description = tmp.description,
		TBL.amount = TMP.amount,
		TBL.currency_id = TMP.currencyId,
		TBL.state = tmp.state,
		TBL.update_user_id = TMP.registerUserId,
		TBL.update_user_fullname = TMP.registerUserFullname,
		TBL.update_datetime = tmp.registerDatetime;
END;