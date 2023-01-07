DECLARE @parameter_state_entity VARCHAR(100) = 'ESTADO ENTIDAD';
DECLARE @parameter_state_entity_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.PARAMETER WHERE parameter_name = @parameter_state_entity)
BEGIN
    INSERT INTO SECURITY.PARAMETER
    (
        parameter_name,
        state
    )
    VALUES
    (   @parameter_state_entity, -- parameter_name - varchar(300)
        1  -- state - int
        );
	SET @parameter_state_entity_id = SCOPE_IDENTITY();

	INSERT INTO	 SECURITY.PARAMETER_DETAIL
	(
	    description,
	    parameter_id
	)
	VALUES
	(   'Activo', -- field_description_1 - varchar(200)
	    @parameter_state_entity_id  -- parameter_id - int
	    );

	INSERT INTO	 SECURITY.PARAMETER_DETAIL
	(
	    description,
	    parameter_id
	)
	VALUES
	(   'Inactivo', -- field_description_1 - varchar(200)
	    @parameter_state_entity_id  -- parameter_id - int
	    );

END;


DECLARE @system_name VARCHAR(100) = 'Sistema de Gestión Laboral';
DECLARE @system_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.SYSTEMS WHERE system_name = @system_name)
BEGIN
    INSERT INTO SECURITY.SYSTEMS
    (
        system_name,
        state,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @system_name, -- system_name - varchar(200)
        1, -- state - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - datetime
        );
	SET @system_id = SCOPE_IDENTITY();
END
ELSE
BEGIN
    SELECT @system_id = system_id FROM SECURITY.SYSTEMS WHERE system_name = @system_name
END;

DECLARE @profile_admin VARCHAR(100) = 'Administrador';
DECLARE @profile_admin_id INT;

DECLARE @profile_supervisor VARCHAR(100) = 'Supervidor';
DECLARE @profile_cliente VARCHAR(100) = 'Cliente';

IF NOT EXISTS (SELECT * FROM SECURITY.PROFILE WHERE profile_name = @profile_admin)
BEGIN
    INSERT INTO	 SECURITY.PROFILE
    (
        profile_name,
        state,
        system_id,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @profile_admin, -- profile_name - varchar(200)
        1, -- state - int
        1, -- system_id - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - datetime
        );
	SET @profile_admin_id = SCOPE_IDENTITY();
END
ELSE
BEGIN
    SELECT @profile_admin_id = profile_id FROM SECURITY.PROFILE WHERE profile_name = @profile_admin
END

DECLARE @profile_admin_cliente VARCHAR(100) = 'Administrador Cliente';

IF NOT EXISTS (SELECT * FROM SECURITY.PROFILE WHERE profile_name = @profile_admin_cliente)
BEGIN
    INSERT INTO	 SECURITY.PROFILE
    (
        profile_name,
        state,
        system_id,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @profile_admin_cliente, -- profile_name - varchar(200)
        1, -- state - int
        1, -- system_id - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - datetime
        )
END;

IF NOT EXISTS (SELECT * FROM SECURITY.PROFILE WHERE profile_name = @profile_supervisor)
BEGIN
    INSERT INTO	 SECURITY.PROFILE
    (
        profile_name,
        state,
        system_id,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @profile_supervisor, -- profile_name - varchar(200)
        1, -- state - int
        1, -- system_id - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - datetime
        )
END;

IF NOT EXISTS (SELECT * FROM SECURITY.PROFILE WHERE profile_name = @profile_cliente)
BEGIN
    INSERT INTO	 SECURITY.PROFILE
    (
        profile_name,
        state,
        system_id,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @profile_cliente, -- profile_name - varchar(200)
        1, -- state - int
        1, -- system_id - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - datetime
        )
END;

DECLARE @menu_security_name VARCHAR(100) = 'Seguridad';
DECLARE @menu_security_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.menu WHERE menu_name = @menu_security_name)
BEGIN

	INSERT INTO SECURITY.menu (menu_name, level, url, icon, [order], menu_parent_id, state, register_user_id, register_user_fullname, register_datetime)
						VALUES(@menu_security_name, 1, NULL,'setting', 1, null, 1, 0, 'SYSTEM', GETDATE());

	SET @menu_security_id = SCOPE_IDENTITY()

END
ELSE
BEGIN
	SELECT @menu_security_id = menu_id FROM SECURITY.menu WHERE menu_name = @menu_security_name
END

DECLARE @menu_user_name VARCHAR(100) = 'Usuarios';
DECLARE @menu_user_id INT;
IF NOT EXISTS (SELECT * FROM SECURITY.menu WHERE menu_name = @menu_user_name)
BEGIN

	INSERT INTO SECURITY.menu (menu_name, level, url, icon, [order], menu_parent_id, state, register_user_id, register_user_fullname, register_datetime)
						VALUES(@menu_user_name, 2, '/users-tray','user', 2, @menu_security_id, 1, 0, 'SYSTEM', GETDATE());
	SET @menu_user_id = SCOPE_IDENTITY()
END

DECLARE @menu_name VARCHAR(200) = 'Menú';
DECLARE @menu_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.menu WHERE menu_name = @menu_name)
BEGIN

	INSERT INTO SECURITY.menu (menu_name, level, url, icon, menu_parent_id, [order], state, register_user_id, register_user_fullname, register_datetime)
						VALUES(@menu_name, 2, '/menus-tray', 'apartment', @menu_security_id, 5, 1, 0, 'SYSTEM', GETDATE());
	SET @menu_id = SCOPE_IDENTITY();

END

DECLARE @profile_menu VARCHAR(200) = 'Perfil Menú';
DECLARE @profile_menu_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.menu WHERE menu_name = @profile_menu)
BEGIN

	INSERT INTO SECURITY.menu (menu_name, level, url, icon, menu_parent_id, [order], state, register_user_id, register_user_fullname, register_datetime)
						VALUES(@profile_menu, 2, '/profiles-menu-tray', 'node-expand', @menu_security_id, 6, 1, 0, 'SYSTEM', GETDATE());
	SET @profile_menu_id = SCOPE_IDENTITY();

END

DECLARE @user_profile VARCHAR(200) = 'Usuario Perfil';
DECLARE @user_profile_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.menu WHERE menu_name = @user_profile)
BEGIN

	INSERT INTO SECURITY.menu (menu_name, level, url, icon, menu_parent_id, [order], state, register_user_id, register_user_fullname, register_datetime)
						VALUES(@user_profile, 2, '/users-profile-tray', 'team', @menu_security_id, 7, 1, 0, 'SYSTEM', GETDATE());
	SET @user_profile_id = SCOPE_IDENTITY();

END;


DECLARE @user_id INT;
DECLARE @user_name VARCHAR(100) = 'Jair Antonio';

IF NOT EXISTS (SELECT * FROM SECURITY.USERS WHERE user_name = @user_name)
BEGIN
    INSERT INTO SECURITY.USERS
    (
        user_name,
        father_last_name,
        mother_last_name,
        document_number,
        email,
        login,
        password,
        reset_password,
        state,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @user_name, -- user_name - varchar(300)
        'Basas', -- father_last_name - varchar(300)
        'Mallaupoma', -- mother_last_name - varchar(300)
        '45236982', -- document_number - varchar(20)
        'demo@gmail.com', -- email - varchar(100)
        'demo@gmail.com', -- login - varchar(100)
        ENCRYPTBYPASSPHRASE('password', '123456'), -- password - varbinary(8000)
        0, -- reset_password - int
        1, -- state - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - datetime
        );
	SET @user_id = SCOPE_IDENTITY();
END
ELSE
BEGIN
    SELECT @user_id = user_id FROM SECURITY.USERS WHERE user_name = @user_name;
END;

IF NOT EXISTS (SELECT * FROM SECURITY.USERS_PROFILE WHERE user_id = @user_id)
BEGIN
    INSERT INTO	 SECURITY.USERS_PROFILE
    (
        user_id,
        profile_id,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @user_id,    -- user_id - int
        @profile_admin_id,    -- profile_id - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - datetime
        );
END

IF NOT EXISTS (SELECT * FROM SECURITY.PROFILE_MENU WHERE profile_id = @profile_admin_id)
BEGIN
    INSERT SECURITY.PROFILE_MENU
	SELECT @profile_admin_id, menu_id, 0, 'SYSTEM', GETDATE(), 0, 'SYSTEM', GETDATE() FROM SECURITY.MENU
END;

DECLARE @menu_cliente VARCHAR(100) = 'Clientes';
DECLARE @menu_cliente_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.MENU M WHERE M.menu_name = @menu_cliente)
BEGIN
    INSERT INTO SECURITY.MENU
    (
        menu_name,
        level,
        url,
        icon,
        [order],
        menu_parent_id,
        state,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @menu_cliente, -- menu_name - varchar(300)
        1, -- level - int
        NULL, -- url - varchar(300)
        'icard',   -- icon - varchar(300)
        1, -- order - int
        NULL, -- menu_parent_id - int
        1, -- state - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - varchar(20)
        );
	SET @menu_cliente_id = SCOPE_IDENTITY();

	INSERT INTO SECURITY.MENU
    (
        menu_name,
        level,
        url,
        icon,
        [order],
        menu_parent_id,
        state,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   'Bandeja Clientes', -- menu_name - varchar(300)
        2, -- level - int
        '/customers-tray', -- url - varchar(300)
        'team',   -- icon - varchar(300)
        1, -- order - int
        @menu_cliente_id, -- menu_parent_id - int
        1, -- state - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - varchar(20)
        );

	INSERT INTO SECURITY.MENU
    (
        menu_name,
        level,
        url,
        icon,
        [order],
        menu_parent_id,
        state,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   'Bandeja Asignación Cliente', -- menu_name - varchar(300)
        2, -- level - int
        '/customer-assignment-tray', -- url - varchar(300)
        'user-switch',   -- icon - varchar(300)
        2, -- order - int
        @menu_cliente_id, -- menu_parent_id - int
        1, -- state - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - varchar(20)
        );
END;

DECLARE @menu_trabajador VARCHAR(100) = 'Trabajadores';
DECLARE @menu_trabajador_id INT;

IF NOT EXISTS (SELECT * FROM SECURITY.MENU M WHERE M.menu_name = @menu_trabajador)
BEGIN
    INSERT INTO SECURITY.MENU
    (
        menu_name,
        level,
        url,
        icon,
        [order],
        menu_parent_id,
        state,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   @menu_trabajador, -- menu_name - varchar(300)
        1, -- level - int
        NULL, -- url - varchar(300)
        'icard',   -- icon - varchar(300)
        1, -- order - int
        NULL, -- menu_parent_id - int
        1, -- state - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - varchar(20)
        );
	SET @menu_trabajador_id = SCOPE_IDENTITY();

	INSERT INTO SECURITY.MENU
    (
        menu_name,
        level,
        url,
        icon,
        [order],
        menu_parent_id,
        state,
        register_user_id,
        register_user_fullname,
        register_datetime,
        update_user_id,
        update_user_fullname,
        update_datetime
    )
    VALUES
    (   'Bandeja Trabajadores', -- menu_name - varchar(300)
        1, -- level - int
        '/employees-tray', -- url - varchar(300)
        'team',   -- icon - varchar(300)
        1, -- order - int
        @menu_trabajador_id, -- menu_parent_id - int
        1, -- state - int
        0, -- register_user_id - int
        'SYSTEM', -- register_user_fullname - varchar(250)
        GETDATE(), -- register_datetime - datetime
        0, -- update_user_id - int
        'SYSTEM', -- update_user_fullname - varchar(250)
        GETDATE()  -- update_datetime - varchar(20)
        );
END;