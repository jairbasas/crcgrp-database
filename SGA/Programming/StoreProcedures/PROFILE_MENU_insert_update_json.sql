CREATE PROCEDURE SECURITY.PROFILE_MENU_insert_update_json
(
	@jsonData NTEXT
)
AS
BEGIN
    MERGE INTO SECURITY.PROFILE_MENU [TBL]
	USING (
		SELECT * FROM OPENJSON(@jsonData)
		WITH (
			profileId INT,
			menuId INT,
			registerUserId INT,
			registerUserFullname VARCHAR(250),
			registerDatetime DATETIME
		)
	)[TMP]
	(
		profileId, menuId, registerUserId, registerUserFullname, registerDatetime
	)
	ON(
		TBL.profile_id = TMP.profileId AND TBL.menu_id = TMP.menuId
	)
	WHEN NOT MATCHED THEN
	INSERT 
	(
		profile_id,
		menu_id,
		register_user_id,
		register_user_fullname,
		register_datetime
	)
	VALUES
	(
		TMP.profileId,
		TMP.menuId,
		TMP.registerUserId,
		TMP.registerUserFullname,
		TMP.registerDatetime
	)
	WHEN MATCHED THEN
	UPDATE SET
		TBL.menu_id = TMP.menuId,
		TBL.update_user_id = TMP.registerUserId,
		TBL.update_user_fullname = TMP.registerUserFullname,
		TBL.update_datetime = TMP.registerDatetime;
END;