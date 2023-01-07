CREATE PROCEDURE SECURITY.USERS_authentication
(
	@pi_login VARCHAR(50),
	@pi_password VARCHAR(200)
)
AS
BEGIN

	SELECT
			U.user_id
		   ,U.user_name
		   ,U.father_last_name
		   ,U.mother_last_name
		   ,U.email
		   ,U.state
		   ,UP.profile_id
		FROM SECURITY.users U INNER JOIN SECURITY.USERS_PROFILE UP ON UP.user_id = U.user_id
		WHERE U.login = @pi_login AND DECRYPTBYPASSPHRASE('password', U.password)  = @pi_password;

END;