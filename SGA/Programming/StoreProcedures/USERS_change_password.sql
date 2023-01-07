Create Procedure SECURITY.USERS_change_password
(
  @pii_user_id INT,
  @piv_password VARCHAR(200),
  @pii_reset_password INT,
  @pii_update_user_id INT,
  @piv_update_user_fullname VARCHAR(250),
  @pid_update_datetime DATETIME
)
AS
BEGIN

  UPDATE SECURITY.users 
  SET password = ENCRYPTBYPASSPHRASE('password', @piv_password)
	 ,reset_password = @pii_reset_password
     ,update_user_id = @pii_update_user_id
     ,update_user_fullname = @piv_update_user_fullname
     ,update_datetime = @pid_update_datetime
  WHERE user_id = @pii_user_id;  

END