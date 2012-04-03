USE spuria

/* Creacion del usuario 'Valeria' */
IF EXISTS (SELECT name FROM sys.server_principals WHERE name = 'Valeria') DROP LOGIN Valeria;
CREATE LOGIN Valeria WITH PASSWORD = '#25pAz7_?Xx#OR9?';

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Valeria') DROP USER Valeria;
CREATE USER Valeria FOR LOGIN Valeria;

GRANT SELECT (TiendaID, Codigo, Descripcion, Precio, Cantidad) ON OBJECT::dbo.inventariotienda TO Valeria;
GRANT SELECT (AccesoID, CorreoElectronico, Contrasena) ON OBJECT::dbo.acceso TO Valeria;
GRANT SELECT (TiendaID, Cliente_P) ON OBJECT::dbo.tienda TO Valeria;
GRANT SELECT (RIF, Usuario_P) ON OBJECT::dbo.cliente TO Valeria;
GRANT EXECUTE ON OBJECT::dbo.InsertarInventario$IMPL TO Valeria;

/* Creacion del usuario 'Paris' */
IF EXISTS (SELECT name FROM sys.server_principals WHERE name = 'Paris') DROP LOGIN Paris;
CREATE LOGIN Paris WITH PASSWORD = '#37KhVFmG1_Lp@#j?R4';

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Paris') DROP USER Paris;
CREATE USER Paris FOR LOGIN Paris;

GO
