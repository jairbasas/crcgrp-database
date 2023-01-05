CREATE PROCEDURE SECURITY.PROFILE_MENU_delete_by_profile
(
	@pii_profile_id INT
)
AS
BEGIN
    DELETE SECURITY.PROFILE_MENU WHERE profile_id = @pii_profile_id
END