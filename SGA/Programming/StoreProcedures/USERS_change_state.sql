Create Procedure SECURITY.USERS_change_state
(
	@pii_user_id int,
	@pii_state int,
	@pii_update_user_id int,
	@piv_update_user_fullname varchar(250),
	@pid_update_datetime datetime
)
AS
BEGIN
	
	UPDATE SECURITY.users
		SET state = @pii_state,
			update_user_id = @pii_update_user_id,
			update_user_fullname = @piv_update_user_fullname,
			update_datetime = @pid_update_datetime
	WHERE user_id = @pii_user_id

END;