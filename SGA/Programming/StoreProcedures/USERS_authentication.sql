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
		FROM SECURITY.users U
		WHERE U.login = @pi_login AND DECRYPTBYPASSPHRASE('password', U.password)  = @pi_password;

END;