CREATE PROCEDURE SECURITY.PROFILE_MENU_delete
(
	@pii_profile_id INT,
	@pii_menu_id INT
)
AS
BEGIN
    DELETE SECURITY.PROFILE_MENU WHERE profile_id = @pii_profile_id AND menu_id = @pii_menu_id;
END