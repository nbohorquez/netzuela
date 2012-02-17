SELECT 'LlamadasAlSistema.sql';
USE spuria;
GO

/*
*************************************************************
*							Insertar				        *
*************************************************************
*/

CREATE PROCEDURE [dbo].[Insertar]
   @a_Creador int,
   @a_Parroquia int,
   @a_CorreoElectronico varchar(45),
   @a_Contrasena varchar(45),
   @a_Estatus char(9),
   @a_Privilegios varchar(45),
   @a_Nombre varchar(45),
   @a_Apellido varchar(45),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON
      SET  NOCOUNT  ON
      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int, 
         @v_Usuario_P int, 
         @AdministradorID int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarUsuario$IMPL @a_Parroquia, @a_CorreoElectronico, @a_Contrasena, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Usuario_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value$2

      INSERT dbo.administrador(
         dbo.administrador.Rastreable_P, 
         dbo.administrador.Usuario_P, 
         dbo.administrador.Estatus, 
         dbo.administrador.Privilegios, 
         dbo.administrador.Nombre, 
         dbo.administrador.Apellido)
         VALUES (
            @v_Rastreable_P, 
            @v_Usuario_P, 
            @a_Estatus, 
            @a_Privilegios, 
            @a_Nombre, 
            @a_Apellido)

      SET @returnvalue = scope_identity()
   END
GO

CREATE PROCEDURE `Insertar` (a_Parametros TEXT)
BEGIN
    DECLARE TiendaID INT;
    DECLARE Codigo CHAR(15);
    DECLARE Descripcion VARCHAR(45);
    DECLARE Precio DECIMAL(10,2);
    DECLARE Cantidad INT;

    DECLARE Creador INT;
    DECLARE Resultado INT;
    DECLARE PrecioViejo DECIMAL(10,2);
    DECLARE CantidadVieja INT;

    /*START TRANSACTION;*/

    CALL SepararString(`a_Parametros`, ",");

    SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
    SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO Codigo;
    SELECT CONVERT(Valor, CHAR) FROM Parametros WHERE ID = 3 INTO Descripcion;
    SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
    SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	
    DROP TEMPORARY TABLE IF EXISTS Parametros;

    SELECT Cliente.Rastreable_P
    FROM Cliente, Tienda
    WHERE Tienda.TiendaID = TiendaID AND Cliente.RIF = Tienda.Cliente_P
    INTO Creador;

    SELECT InsertarInventario(Creador, TiendaID, Codigo, Descripcion, 'Ambos visibles', NULL, Precio, Cantidad) INTO Resultado;

    /* COMMIT; */
END$$

/*
*************************************************************
*                          Actualizar				        *
*************************************************************
*/

DROP PROCEDURE IF EXISTS `Actualizar`;
SELECT 'Actualizar';

DELIMITER $$

CREATE PROCEDURE `Actualizar` (a_Parametros TEXT)
BEGIN
    DECLARE TiendaID INT;
    DECLARE Codigo CHAR(15);
    DECLARE Descripcion VARCHAR(45);
    DECLARE Precio DECIMAL(10,2);
    DECLARE Cantidad INT;

    DECLARE Resultado INT;
    DECLARE PrecioViejo DECIMAL(10,2);
    DECLARE CantidadVieja INT;

    /*START TRANSACTION;*/
    
    CALL SepararString(`a_Parametros`, ",");

    SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
    SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO Codigo;
    SELECT CONVERT(Valor, CHAR) FROM Parametros WHERE ID = 3 INTO Descripcion;
    SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
    SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	
    DROP TEMPORARY TABLE IF EXISTS Parametros;
	
    SELECT PrecioCantidad.Precio, PrecioCantidad.Cantidad
    FROM PrecioCantidad 
    WHERE PrecioCantidad.TiendaID = TiendaID AND PrecioCantidad.Codigo = Codigo AND FechaFin IS NULL
    INTO PrecioViejo, CantidadVieja;

    IF (PrecioViejo != Precio OR CantidadVieja != Cantidad) THEN 
        SET Resultado = PrecioCantidadCrear(TiendaID, Codigo, Precio, Cantidad);
    END IF;

    UPDATE Inventario
    SET Inventario.Descripcion = Descripcion
    WHERE Inventario.TiendaID = TiendaID AND Inventario.Codigo = Codigo;

    /*COMMIT;*/
END$$

/*
*************************************************************
*                           Borrar 				            *
*************************************************************
*/

DELIMITER ;

DROP PROCEDURE IF EXISTS `Eliminar`;
SELECT 'Eliminar';

DELIMITER $$

CREATE PROCEDURE `Eliminar` (a_Parametros TEXT)
BEGIN   
    DECLARE TiendaID INT;
    DECLARE Codigo CHAR(15);
    DECLARE Descripcion VARCHAR(45);
    DECLARE Precio DECIMAL(10,2);
    DECLARE Cantidad INT;

    /*START TRANSACTION;*/

    CALL SepararString(`a_Parametros`, ",");

    SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 1 INTO TiendaID;
    SELECT CONVERT(Valor, CHAR(15)) FROM Parametros WHERE ID = 2 INTO Codigo;
    SELECT CONVERT(Valor, CHAR) FROM Parametros WHERE ID = 3 INTO Descripcion;
    SELECT CONVERT(Valor, DECIMAL(10,2)) FROM Parametros WHERE ID = 4 INTO Precio;
    SELECT CONVERT(Valor, SIGNED) FROM Parametros WHERE ID = 5 INTO Cantidad;
	
    DROP TEMPORARY TABLE IF EXISTS Parametros;

    DELETE 
    FROM Inventario
    WHERE Inventario.TiendaID = TiendaID AND Inventario.Codigo = Codigo;

    /* COMMIT; */
END$$