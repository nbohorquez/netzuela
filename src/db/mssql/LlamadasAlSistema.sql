SELECT 'LlamadasAlSistema.sql';
USE spuria;
GO

/*
*************************************************************
*						  Parametros				        *
*************************************************************
*/

/* 
 * Para poder usar una tabla temporal en varios SP hay que crearla primero
 * http://manuals.sybase.com/onlinebooks/group-as/asg1250e/sqlug/@Generic__BookTextView/43597;pt=43674
 */

IF object_id('tempdb..#Parametros') IS NOT NULL 
	DROP TABLE #Parametros;
ELSE
	CREATE TABLE #Parametros (
		ID INT NOT NULL IDENTITY(1,1),
		Valor VARCHAR(100) NOT NULL
	);
GO
	
/*
*************************************************************
*			            SepararString				        *
*************************************************************
*/

/* 
 * Codigo importado
 * ================
 * 
 * Autor: Jay Pipes
 * Titulo: Split a Delimited String in SQL
 * Licencia: 
 * Fuente: http://forge.mysql.com/tools/tool.php?id=4
 * 
 * Tipo de uso
 * ===========
 * 
 * Textual                                              []
 * Adaptado                                             [X]
 * Solo se cambiaron los nombres de las variables       []
 * 
 */

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SepararString]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[SepararString]
GO

CREATE PROCEDURE [dbo].[SepararString]
	@input VARCHAR(1000), 
	@delimiter VARCHAR(10),
	@returnvalue int OUTPUT	
AS
	BEGIN
		DECLARE @cur_position int = 1;
		DECLARE @remainder VARCHAR(1000);
		DECLARE @cur_string VARCHAR(1000);
		DECLARE @delimiter_length TINYINT;

		SET @remainder = @input;
		SET @delimiter_length = LEN(@delimiter);

		WHILE (LEN(@remainder) > 0 AND @cur_position > 0)
		BEGIN
			SET @cur_position = CHARINDEX(@delimiter, @remainder);
			
			IF @cur_position = 0
				SET @cur_string = @remainder;
			ELSE
				SET @cur_string = LEFT(@remainder, @cur_position - 1);
			
			IF RTRIM(LTRIM(@cur_string)) != ''
				INSERT #Parametros (Valor) VALUES (@cur_string);

			SET @remainder = SUBSTRING(@remainder, @cur_position + @delimiter_length, LEN(@remainder) - (@cur_position + @delimiter_length) + 1);			
		END
		
		SET @returnvalue = 1;
	END
GO

/*
*************************************************************
*						  ~Parametros				        *
*************************************************************
*/
IF object_id('tempdb..#Parametros') IS NOT NULL 
	DROP TABLE #Parametros;
GO

/*
*************************************************************
*							Insertar				        *
*************************************************************
*/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Insertar]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[Insertar]
GO

CREATE PROCEDURE [dbo].[Insertar]
   @a_Funcion varchar(45),
   @a_Parametros varchar(45),
   @returnvalue int OUTPUT
AS 
	BEGIN
		SET XACT_ABORT ON;
		SET NOCOUNT ON;
		SET @returnvalue = NULL;

		DECLARE @TiendaID int;
		DECLARE @Codigo char(15);
		DECLARE @Descripcion varchar(45);
		DECLARE @Precio decimal(10,2);
		DECLARE @Cantidad int;

		DECLARE @Creador int;
		DECLARE @Resultado int;
		DECLARE @PrecioViejo decimal(10,2);
		DECLARE @CantidadVieja int;
		
		DECLARE @resultadoOperacion int;
		
		IF @a_Funcion != N'InsertarInventario'
			RETURN

		/* BEGIN TRANSACTION */
		
		CREATE TABLE #Parametros (
			ID int NOT NULL IDENTITY(1,1),
			Valor varchar(100) NOT NULL
		);
			
		EXEC dbo.SepararString @input = @a_Parametros, @delimiter = N',', @returnvalue = @resultadoOperacion OUTPUT;

		SET @TiendaID = (SELECT CAST(Valor AS CHAR) FROM #Parametros WHERE ID = 1);
		SET @Codigo = (SELECT CAST(Valor as CHAR) FROM #Parametros WHERE ID = 2);
		SET @Descripcion = (SELECT CAST(Valor as CHAR) FROM #Parametros WHERE ID = 3);
		SET @Precio = (SELECT CAST(Valor as DECIMAL(10,2)) FROM #Parametros WHERE ID = 4);
		SET @Cantidad = (SELECT CAST(Valor as INT) FROM #Parametros WHERE ID = 5);
		
		DROP TABLE #Parametros;

		SET @Creador =
		(
			SELECT Cliente.Rastreable_P
			FROM Cliente, Tienda
			WHERE Tienda.TiendaID = @TiendaID AND Cliente.RIF = Tienda.Cliente_P
		);

		EXEC dbo.InsertarInventario$IMPL 
			@a_Creador = @Creador, 
			@a_TiendaID = @TiendaID, 
			@a_Codigo = @Codigo, 
			@a_Descripcion = @Descripcion, 
			@a_Visibilidad = 'Ambos visibles', 
			@a_ProductoID = NULL, 
			@a_Precio = @Precio, 
			@a_Cantidad = @Cantidad, 
			@returnvalue = @resultadoOperacion OUTPUT;
	
		SET @returnvalue = @resultadoOperacion;
		
		/* COMMIT TRANSACTION; */
   END
GO

/*
*************************************************************
*                          Actualizar				        *
*************************************************************
*/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Actualizar]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[Actualizar]
GO

CREATE PROCEDURE [dbo].[Actualizar]
   @a_Funcion varchar(45),
   @a_Parametros varchar(45),
   @returnvalue int OUTPUT
AS 
	BEGIN
		SET XACT_ABORT ON;
		SET NOCOUNT ON;
		SET @returnvalue = NULL;
		
		DECLARE @TiendaID CHAR;
		DECLARE @Codigo CHAR(15);
		DECLARE @Descripcion VARCHAR(45);
		DECLARE @Precio DECIMAL(10,2);
		DECLARE @Cantidad INT;

		DECLARE @Resultado INT;
		DECLARE @PrecioViejo DECIMAL(10,2);
		DECLARE @CantidadVieja INT;
		
		DECLARE @resultadoOperacion int;
		
		IF @a_Funcion != N'ActualizarInventario'
			RETURN

		/*BEGIN TRANSACTION;*/
	    
		CREATE TABLE #Parametros (
			ID int NOT NULL IDENTITY(1,1),
			Valor varchar(100) NOT NULL
		);
			
		EXEC dbo.SepararString @input = @a_Parametros, @delimiter = N',', @returnvalue = @resultadoOperacion OUTPUT;

		SET @TiendaID = (SELECT CAST(Valor AS CHAR) FROM #Parametros WHERE ID = 1);
		SET @Codigo = (SELECT CAST(Valor as CHAR) FROM #Parametros WHERE ID = 2);
		SET @Descripcion = (SELECT CAST(Valor as CHAR) FROM #Parametros WHERE ID = 3);
		SET @Precio = (SELECT CAST(Valor as DECIMAL(10,2)) FROM #Parametros WHERE ID = 4);
		SET @Cantidad = (SELECT CAST(Valor as INT) FROM #Parametros WHERE ID = 5);
		
		DROP TABLE #Parametros;
		
		DECLARE @t TABLE
		(
			Precio int,
			Cantidad int
		);

		INSERT @t
		SELECT PrecioCantidad.Precio, PrecioCantidad.Cantidad
		FROM PrecioCantidad 
		WHERE PrecioCantidad.TiendaID = @TiendaID AND PrecioCantidad.Codigo = Codigo AND FechaFin IS NULL
		
		SET @PrecioViejo = (SELECT Precio FROM @t);
		SET @CantidadVieja = (SELECT Cantidad FROM @t);

		IF (@PrecioViejo != @Precio OR @CantidadVieja != @Cantidad)
			EXEC dbo.InsertarPrecioCantidad$IMPL 
				@a_TiendaID = @TiendaID, 
				@a_Codigo = @Codigo, 
				@a_Precio = @Precio, 
				@a_Cantidad = @Cantidad, 
				@returnvalue = @Resultado OUTPUT;

		UPDATE Inventario
		SET Inventario.Descripcion = Descripcion
		WHERE Inventario.TiendaID = @TiendaID AND Inventario.Codigo = @Codigo;

		SET @returnvalue = @Resultado;
		
		/*COMMIT TRANSACTION;*/
	END
GO

/*
*************************************************************
*                          Eliminar 				        *
*************************************************************
*/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Actualizar]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[Actualizar]
GO

CREATE PROCEDURE [dbo].[Actualizar]
   @a_Funcion varchar(45),
   @a_Parametros varchar(45),
   @returnvalue int OUTPUT
AS
	BEGIN
		SET XACT_ABORT ON;
		SET NOCOUNT ON;
		SET @returnvalue = NULL;
		
		DECLARE @TiendaID INT;
		DECLARE @Codigo CHAR(15);
		DECLARE @Descripcion VARCHAR(45);
		DECLARE @Precio DECIMAL(10,2);
		DECLARE @Cantidad INT;

		DECLARE @resultadoOperacion int;
		
		IF @a_Funcion != N'EliminarInventario'
			RETURN
			
		/* BEGIN TRANSACTION;*/

		CREATE TABLE #Parametros (
			ID int NOT NULL IDENTITY(1,1),
			Valor varchar(100) NOT NULL
		);
			
		EXEC dbo.SepararString @input = @a_Parametros, @delimiter = N',', @returnvalue = @resultadoOperacion OUTPUT;

		SET @TiendaID = (SELECT CAST(Valor AS CHAR) FROM #Parametros WHERE ID = 1);
		SET @Codigo = (SELECT CAST(Valor as CHAR) FROM #Parametros WHERE ID = 2);
		SET @Descripcion = (SELECT CAST(Valor as CHAR) FROM #Parametros WHERE ID = 3);
		SET @Precio = (SELECT CAST(Valor as DECIMAL(10,2)) FROM #Parametros WHERE ID = 4);
		SET @Cantidad = (SELECT CAST(Valor as INT) FROM #Parametros WHERE ID = 5);
		
		DROP TABLE #Parametros;
		
		DELETE 
		FROM Inventario
		WHERE Inventario.TiendaID = @TiendaID AND Inventario.Codigo = @Codigo;

		/* COMMIT TRANSACTION; */
	END
GO