
USE spuria
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'dbo')      
     EXEC (N'CREATE SCHEMA dbo')                                   
 GO                                                               

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarAdministrador$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarAdministrador$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarAdministrador$IMPL  
   @a_Creador int,
   @a_Parroquia int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_CorreoElectronico varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Contrasena varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Estatus char(9),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Privilegios varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

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
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarAdministrador',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarAdministrador$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarBuscable$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarBuscable$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarBuscable$IMPL  
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.buscable
         DEFAULT VALUES

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarBuscable',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarBuscable$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarBusqueda$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarBusqueda$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarBusqueda$IMPL  
   @a_Creador int,
   @a_UsuarioID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Contenido varchar(max),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Etiquetable_P int, 
         @v_Rastreable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarEtiquetable$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Etiquetable_P = @procedure_return_value$2

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.busqueda(
         dbo.busqueda.Rastreable_P, 
         dbo.busqueda.Etiquetable_P, 
         dbo.busqueda.Usuario, 
         dbo.busqueda.FechaHora, 
         dbo.busqueda.Contenido)
         VALUES (
            @v_Rastreable_P, 
            @v_Etiquetable_P, 
            @a_UsuarioID, 
            isnull(getdate(), getdate()), 
            @a_Contenido)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarBusqueda',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarBusqueda$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarCalificableSeguible$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarCalificableSeguible$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarCalificableSeguible$IMPL  
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.calificableseguible(dbo.calificableseguible.CalificacionGeneral)
         VALUES (0)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarCalificableSeguible',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarCalificableSeguible$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarCalificacionResena$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarCalificacionResena$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarCalificacionResena$IMPL  
   @a_Creador int,
   @a_CalificableSeguibleID int,
   @a_ConsumidorID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Calificacion char(4),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Resena varchar(max),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Etiquetable_P int, 
         @v_Rastreable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarEtiquetable$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Etiquetable_P = @procedure_return_value$2

      INSERT dbo.calificacionresena(
         Rastreable_P, 
         Etiquetable_P, 
         CalificableSeguibleID, 
         ConsumidorID, 
         Calificacion, 
         Resena)
         VALUES (
            @v_Rastreable_P, 
            @v_Etiquetable_P, 
            @a_CalificableSeguibleID, 
            @a_ConsumidorID, 
            @a_Calificacion, 
            @a_Resena)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarCalificacionResena',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarCalificacionResena$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarCategoria$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarCategoria$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarCategoria$IMPL  
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Nombre char(30),
   @a_HijoDeCategoria int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @v_Etiquetable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarEtiquetable$IMPL @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Etiquetable_P = @procedure_return_value

      SELECT @C = count_big(*)
      FROM dbo.categoria
      WHERE categoria.Nombre = @a_Nombre AND categoria.HijoDeCategoria = @a_HijoDeCategoria

      IF @C = 0
         INSERT dbo.categoria(dbo.categoria.Etiquetable_P, dbo.categoria.Nombre, dbo.categoria.HijoDeCategoria)
            VALUES (@v_Etiquetable_P, @a_Nombre, @a_HijoDeCategoria)
      ELSE 
         BEGIN

            SET @returnvalue = 0

            /*
            *   SSMA informational messages:
            *   M2SS0052: BOOLEAN literal was converted to INT literal
            */

            RETURN 

         END

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarCategoria',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarCategoria$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarCiudad$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarCiudad$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarCiudad$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_RegionGeografica_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRegionGeografica$IMPL @a_Creador, @a_Nombre, @a_Poblacion, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_RegionGeografica_P = @procedure_return_value

      INSERT dbo.ciudad(dbo.ciudad.RegionGeografica_P)
         VALUES (@v_RegionGeografica_P)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarCiudad',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarCiudad$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarCliente$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarCliente$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarCliente$IMPL  
   @a_Creador int,
   @a_Parroquia int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_CorreoElectronico varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Contrasena varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_RIF char(10),
   @a_Categoria int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Estatus char(9),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_NombreLegal varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_NombreComun varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Telefono char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Edificio_CC char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Piso char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Apartamento char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Local char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Casa char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Calle char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Sector_Urb_Barrio char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_PaginaWeb char(40),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Facebook char(80),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Twitter char(80),
   @returnvalue char(10)  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int, 
         @v_Describible_P int, 
         @v_Usuario_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarUsuario$IMPL @a_Parroquia, @a_CorreoElectronico, @a_Contrasena, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Usuario_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value$2

      DECLARE
         @procedure_return_value$3 int

      EXECUTE dbo.InsertarDescribible$IMPL @returnvalue = @procedure_return_value$3  OUTPUT

      SELECT @v_Describible_P = @procedure_return_value$3

      INSERT dbo.cliente(
         Rastreable_P, 
         Describible_P, 
         Usuario_P, 
         RIF, 
         Categoria, 
         Estatus, 
         NombreLegal, 
         NombreComun, 
         Telefono, 
         Edificio_CC, 
         Piso, 
         Apartamento, 
         LocalNo, 
         Casa, 
         Calle, 
         Sector_Urb_Barrio, 
         PaginaWeb, 
         Facebook, 
         Twitter)
         VALUES (
            @v_Rastreable_P, 
            @v_Describible_P, 
            @v_Usuario_P, 
            @a_RIF, 
            @a_Categoria, 
            @a_Estatus, 
            @a_NombreLegal, 
            @a_NombreComun, 
            @a_Telefono, 
            @a_Edificio_CC, 
            @a_Piso, 
            @a_Apartamento, 
            @a_Local, 
            @a_Casa, 
            @a_Calle, 
            @a_Sector_Urb_Barrio, 
            @a_PaginaWeb, 
            @a_Facebook, 
            @a_Twitter)

      SET @returnvalue = @a_RIF

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarCliente',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarCliente$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarCobrable$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarCobrable$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarCobrable$IMPL  
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.cobrable
         DEFAULT VALUES

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarCobrable',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarCobrable$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarConsumidor$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarConsumidor$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarConsumidor$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Apellido varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Estatus char(9),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Sexo char(6),
   @a_FechaDeNacimiento date,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_GrupoDeEdad char(15),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_GradoDeInstruccion char(16),
   @a_Parroquia int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_CorreoElectronico varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Contrasena varchar(45),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int, 
         @v_Interlocutor_P int, 
         @v_UsuarioID int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarUsuario$IMPL @a_Parroquia, @a_CorreoElectronico, @a_Contrasena, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_UsuarioID = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value$2

      DECLARE
         @procedure_return_value$3 int

      EXECUTE dbo.InsertarInterlocutor$IMPL @returnvalue = @procedure_return_value$3  OUTPUT

      SELECT @v_Interlocutor_P = @procedure_return_value$3

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.consumidor(
         dbo.consumidor.Rastreable_P, 
         dbo.consumidor.Interlocutor_P, 
         dbo.consumidor.Usuario_P, 
         dbo.consumidor.Nombre, 
         dbo.consumidor.Apellido, 
         dbo.consumidor.Estatus, 
         dbo.consumidor.Sexo, 
         dbo.consumidor.FechaDeNacimiento, 
         dbo.consumidor.GrupoDeEdad, 
         dbo.consumidor.GradoDeInstruccion)
         VALUES (
            @v_Rastreable_P, 
            @v_Interlocutor_P, 
            @v_UsuarioID, 
            @a_Nombre, 
            @a_Apellido, 
            @a_Estatus, 
            @a_Sexo, 
            isnull(@a_FechaDeNacimiento, getdate()), 
            @a_GrupoDeEdad, 
            @a_GradoDeInstruccion)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarConsumidor',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarConsumidor$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarConsumidorObjetivo$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarConsumidorObjetivo$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarConsumidorObjetivo$IMPL  
   @a_PublicidadID int,
   @a_ConsumidorID int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.consumidorobjetivo(PublicidadID, ConsumidorID)
         VALUES (@a_PublicidadID, @a_ConsumidorID)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarConsumidorObjetivo',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarConsumidorObjetivo$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarContadorDeExhibiciones$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarContadorDeExhibiciones$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarContadorDeExhibiciones$IMPL  
   @a_EstadisticasDeVisitasID int,
   @a_ContadorDeExhibiciones int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int

      SELECT @C = count_big(*)
      FROM dbo.contadordeexhibiciones
      WHERE contadordeexhibiciones.EstadisticasDeVisitasID = @a_EstadisticasDeVisitasID

      IF @C > 0
         UPDATE dbo.contadordeexhibiciones
            SET 
               FechaFin = getdate()
         WHERE contadordeexhibiciones.EstadisticasDeVisitasID = @a_EstadisticasDeVisitasID AND contadordeexhibiciones.FechaFin IS NULL

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.contadordeexhibiciones(EstadisticasDeVisitasID, FechaInicio, FechaFin, ContadorDeExhibiciones)
         VALUES (@a_EstadisticasDeVisitasID, isnull(getdate(), getdate()), NULL, @a_ContadorDeExhibiciones)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarContadorDeExhibiciones',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarContadorDeExhibiciones$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarContinente$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarContinente$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarContinente$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @v_RegionGeografica_P int

      SELECT @C = count_big(*)
      FROM dbo.continente, dbo.regiongeografica
      WHERE regiongeografica.Nombre = @a_Nombre AND regiongeografica.RegionGeograficaID = continente.RegionGeografica_P

      IF @C = 0
         BEGIN

            DECLARE
               @procedure_return_value int

            EXECUTE dbo.InsertarRegionGeografica$IMPL @a_Creador, @a_Nombre, @a_Poblacion, @returnvalue = @procedure_return_value  OUTPUT

            SELECT @v_RegionGeografica_P = @procedure_return_value

            INSERT dbo.continente(dbo.continente.RegionGeografica_P)
               VALUES (@v_RegionGeografica_P)

            SET @returnvalue = scope_identity()

            /*
            *   SSMA warning messages:
            *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
            */

            RETURN 

         END
      ELSE 
         BEGIN

            SET @returnvalue = 0

            /*
            *   SSMA informational messages:
            *   M2SS0052: BOOLEAN literal was converted to INT literal
            */

            RETURN 

         END

      SET @returnvalue = NULL

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarContinente',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarContinente$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarCroquis$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarCroquis$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarCroquis$IMPL  
   @a_Creador int,
   @a_Dibujable int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      INSERT dbo.croquis(Rastreable_P, CroquisID, Area, Perimetro)
         VALUES (@v_Rastreable_P, @a_Dibujable, -1, -1)

      SET @returnvalue = @a_Dibujable

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarCroquis',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarCroquis$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarDescribible$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarDescribible$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarDescribible$IMPL  
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.describible
         DEFAULT VALUES

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarDescribible',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarDescribible$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarDescripcion$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarDescripcion$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarDescripcion$IMPL  
   @a_Creador int,
   @a_Describible int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Contenido varchar(max),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Etiquetable_P int, 
         @v_Rastreable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarEtiquetable$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Etiquetable_P = @procedure_return_value$2

      INSERT dbo.descripcion(dbo.descripcion.Rastreable_P, dbo.descripcion.Etiquetable_P, dbo.descripcion.Describible, dbo.descripcion.Contenido)
         VALUES (@v_Rastreable_P, @v_Etiquetable_P, @a_Describible, @a_Contenido)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarDescripcion',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarDescripcion$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarDibujable$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarDibujable$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarDibujable$IMPL  
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.dibujable
         DEFAULT VALUES

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarDibujable',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarDibujable$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEstadisticas$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEstadisticas$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEstadisticas$IMPL  
   @a_Creador int,
   @a_RegionGeografica int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int, 
         @EstaID int, 
         @Resultado int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      INSERT dbo.estadisticas(dbo.estadisticas.Rastreable_P, dbo.estadisticas.RegionGeografica)
         VALUES (@v_Rastreable_P, @a_RegionGeografica)

      /*
      *   SSMA warning messages:
      *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
      */

      SELECT @EstaID = scope_identity()

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarEstadisticasTemporales$IMPL 
         @EstaID, 
         0, 
         0, 
         0, 
         @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @Resultado = @procedure_return_value$2

      SET @returnvalue = @EstaID

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEstadisticas',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEstadisticas$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEstadisticasDeInfluencia$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEstadisticasDeInfluencia$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEstadisticasDeInfluencia$IMPL  
   @a_Creador int,
   @a_Palabra int,
   @a_RegionGeografica int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Estadisticas_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarEstadisticas$IMPL @a_Creador, @a_RegionGeografica, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Estadisticas_P = @procedure_return_value

      INSERT dbo.estadisticasdeinfluencia(
         dbo.estadisticasdeinfluencia.Estadisticas_P, 
         dbo.estadisticasdeinfluencia.Palabra, 
         dbo.estadisticasdeinfluencia.NumeroDeDescripciones, 
         dbo.estadisticasdeinfluencia.NumeroDeMensajes, 
         dbo.estadisticasdeinfluencia.NumeroDeCategorias, 
         dbo.estadisticasdeinfluencia.NumeroDeResenas, 
         dbo.estadisticasdeinfluencia.NumeroDePublicidades)
         VALUES (
            @v_Estadisticas_P, 
            @a_Palabra, 
            0, 
            0, 
            0, 
            0, 
            0)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEstadisticasDeInfluencia',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEstadisticasDeInfluencia$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEstadisticasDePopularidad$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEstadisticasDePopularidad$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEstadisticasDePopularidad$IMPL  
   @a_Creador int,
   @a_CalificableSeguible int,
   @a_RegionGeografica int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Estadisticas_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarEstadisticas$IMPL @a_Creador, @a_RegionGeografica, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Estadisticas_P = @procedure_return_value

      INSERT dbo.estadisticasdepopularidad(
         dbo.estadisticasdepopularidad.Estadisticas_P, 
         dbo.estadisticasdepopularidad.CalificableSeguible, 
         dbo.estadisticasdepopularidad.NumeroDeCalificaciones, 
         dbo.estadisticasdepopularidad.NumeroDeResenas, 
         dbo.estadisticasdepopularidad.NumeroDeSeguidores, 
         dbo.estadisticasdepopularidad.NumeroDeMenciones, 
         dbo.estadisticasdepopularidad.NumeroDeVendedores, 
         dbo.estadisticasdepopularidad.NumeroDeMensajes)
         VALUES (
            @v_Estadisticas_P, 
            @a_CalificableSeguible, 
            0, 
            0, 
            0, 
            0, 
            0, 
            0)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEstadisticasDePopularidad',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEstadisticasDePopularidad$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEstadisticasDeVisitas$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEstadisticasDeVisitas$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEstadisticasDeVisitas$IMPL  
   @a_Creador int,
   @a_Buscable int,
   @a_RegionGeografica int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Estadisticas_P int, 
         @EstaID int, 
         @Resultado int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarEstadisticas$IMPL @a_Creador, @a_RegionGeografica, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Estadisticas_P = @procedure_return_value

      INSERT dbo.estadisticasdevisitas(dbo.estadisticasdevisitas.Estadisticas_P, dbo.estadisticasdevisitas.Buscable)
         VALUES (@v_Estadisticas_P, @a_Buscable)

      /*
      *   SSMA warning messages:
      *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
      */

      SELECT @EstaID = scope_identity()

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarContadorDeExhibiciones$IMPL @EstaID, 0, @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @Resultado = @procedure_return_value$2

      SET @returnvalue = @EstaID

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEstadisticasDeVisitas',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEstadisticasDeVisitas$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEstadisticasTemporales$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEstadisticasTemporales$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEstadisticasTemporales$IMPL  
   @a_EstadisticasID int,
   @a_Contador int,
   @a_Ranking int,
   @a_Indice int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int

      SELECT @C = count_big(*)
      FROM dbo.estadisticastemporales
      WHERE estadisticastemporales.EstadisticasID = @a_EstadisticasID

      IF @C > 0
         UPDATE dbo.estadisticastemporales
            SET 
               FechaFin = getdate()
         WHERE estadisticastemporales.EstadisticasID = @a_EstadisticasID AND estadisticastemporales.FechaFin IS NULL

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.estadisticastemporales(
         EstadisticasID, 
         FechaInicio, 
         FechaFin, 
         Contador, 
         Ranking, 
         Indice)
         VALUES (
            @a_EstadisticasID, 
            isnull(getdate(), getdate()), 
            NULL, 
            @a_Contador, 
            @a_Ranking, 
            @a_Indice)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEstadisticasTemporales',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEstadisticasTemporales$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEstado$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEstado$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEstado$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @a_Pais int,
   @a_HusoHorarioNormal time,
   @a_HusoHorarioVerano time,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @v_RegionGeografica_P int

      SELECT @C = count_big(*)
      FROM dbo.estado, dbo.regiongeografica
      WHERE regiongeografica.Nombre = @a_Nombre AND estado.Pais = @a_Pais

      IF @C = 0
         BEGIN

            DECLARE
               @procedure_return_value int

            EXECUTE dbo.InsertarRegionGeografica$IMPL @a_Creador, @a_Nombre, @a_Poblacion, @returnvalue = @procedure_return_value  OUTPUT

            SELECT @v_RegionGeografica_P = @procedure_return_value

            INSERT dbo.estado(dbo.estado.RegionGeografica_P, dbo.estado.Pais, dbo.estado.HusoHorarioNormal, dbo.estado.HusoHorarioVerano)
               VALUES (@v_RegionGeografica_P, @a_Pais, @a_HusoHorarioNormal, @a_HusoHorarioVerano)

            SET @returnvalue = scope_identity()

            /*
            *   SSMA warning messages:
            *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
            */

            RETURN 

         END
      ELSE 
         BEGIN

            SET @returnvalue = 0

            /*
            *   SSMA informational messages:
            *   M2SS0052: BOOLEAN literal was converted to INT literal
            */

            RETURN 

         END

      SET @returnvalue = NULL

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEstado',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEstado$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEtiqueta$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEtiqueta$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEtiqueta$IMPL  
   @a_EtiquetableID int,
   @a_PalabraID int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.etiqueta(EtiquetableID, PalabraID)
         VALUES (@a_EtiquetableID, @a_PalabraID)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEtiqueta',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEtiqueta$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarEtiquetable$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarEtiquetable$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarEtiquetable$IMPL  
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.etiquetable
         DEFAULT VALUES

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarEtiquetable',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarEtiquetable$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarFactura$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarFactura$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarFactura$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Cliente char(10),
   @a_InicioDeMedicion datetime2(0),
   @a_FinDeMedicion datetime2(0),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.factura(
         dbo.factura.Rastreable_P, 
         dbo.factura.Cliente, 
         dbo.factura.InicioDeMedicion, 
         dbo.factura.FinDeMedicion, 
         dbo.factura.Subtotal, 
         dbo.factura.Impuestos, 
         dbo.factura.Total)
         VALUES (
            @v_Rastreable_P, 
            @a_Cliente, 
            isnull(@a_InicioDeMedicion, getdate()), 
            isnull(@a_FinDeMedicion, getdate()), 
            0, 
            0, 
            0)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarFactura',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarFactura$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarFoto$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarFoto$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarFoto$IMPL  
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_RutaDeFoto char(80),
   @a_Describible int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.foto(dbo.foto.RutaDeFoto, dbo.foto.Describible)
         VALUES (@a_RutaDeFoto, @a_Describible)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarFoto',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarFoto$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarGradoDeInstruccionObjetivo$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarGradoDeInstruccionObjetivo$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarGradoDeInstruccionObjetivo$IMPL  
   @a_PublicidadID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_GradoDeInstruccion char(16),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.gradodeinstruccionobjetivo(PublicidadID, GradoDeInstruccion)
         VALUES (@a_PublicidadID, @a_GradoDeInstruccion)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarGradoDeInstruccionObjetivo',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarGradoDeInstruccionObjetivo$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarGrupoDeEdadObjetivo$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarGrupoDeEdadObjetivo$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarGrupoDeEdadObjetivo$IMPL  
   @a_PublicidadID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_GrupoDeEdad char(15),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.grupodeedadobjetivo(PublicidadID, GrupoDeEdad)
         VALUES (@a_PublicidadID, @a_GrupoDeEdad)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarGrupoDeEdadObjetivo',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarGrupoDeEdadObjetivo$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarHorarioDeTrabajo$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarHorarioDeTrabajo$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarHorarioDeTrabajo$IMPL  
   @a_TiendaID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Dia char(9),
   @a_Laborable bit,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.horariodetrabajo(TiendaID, Dia, Laborable)
         VALUES (@a_TiendaID, @a_Dia, @a_Laborable)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarHorarioDeTrabajo',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarHorarioDeTrabajo$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarInterlocutor$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarInterlocutor$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarInterlocutor$IMPL  
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.interlocutor
         DEFAULT VALUES

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarInterlocutor',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarInterlocutor$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarInventario$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarInventario$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarInventario$IMPL  
   @a_Creador int,
   @a_TiendaID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Codigo char(15),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Descripcion varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Visibilidad char(16),
   @a_ProductoID int,
   @a_Precio decimal(10, 2),
   @a_Cantidad int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int, 
         @v_Cobrable_P int, 
         @Resultado int, 
         @ResultadoSecundario int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarCobrable$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Cobrable_P = @procedure_return_value$2

      INSERT dbo.inventario(
         Rastreable_P, 
         Cobrable_P, 
         TiendaID, 
         Codigo, 
         Descripcion, 
         Visibilidad, 
         ProductoID)
         VALUES (
            @v_Rastreable_P, 
            @v_Cobrable_P, 
            @a_TiendaID, 
            @a_Codigo, 
            @a_Descripcion, 
            @a_Visibilidad, 
            @a_ProductoID)

      /*
      *   SSMA warning messages:
      *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
      */

      SELECT @Resultado = scope_identity()

      DECLARE
         @procedure_return_value$3 int

      EXECUTE dbo.InsertarPrecioCantidad$IMPL 
         @a_TiendaID, 
         @a_Codigo, 
         @a_Precio, 
         @a_Cantidad, 
         @returnvalue = @procedure_return_value$3  OUTPUT

      SELECT @ResultadoSecundario = @procedure_return_value$3

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarInventario',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarInventario$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarMensaje$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarMensaje$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarMensaje$IMPL  
   @a_Creador int,
   @a_Remitente int,
   @a_Destinatario int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Contenido varchar(max),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int, 
         @v_Etiquetable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarEtiquetable$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Etiquetable_P = @procedure_return_value$2

      INSERT dbo.mensaje(
         dbo.mensaje.Rastreable_P, 
         dbo.mensaje.Etiquetable_P, 
         dbo.mensaje.Remitente, 
         dbo.mensaje.Destinatario, 
         dbo.mensaje.Contenido)
         VALUES (
            @v_Rastreable_P, 
            @v_Etiquetable_P, 
            @a_Remitente, 
            @a_Destinatario, 
            @a_Contenido)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarMensaje',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarMensaje$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarMunicipio$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarMunicipio$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarMunicipio$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @a_Estado int,
   @a_Ciudad int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @v_RegionGeografica_P int

      SELECT @C = count_big(*)
      FROM dbo.municipio, dbo.regiongeografica
      WHERE regiongeografica.Nombre = @a_Nombre AND municipio.Estado = @a_Estado

      IF @C = 0
         BEGIN

            DECLARE
               @procedure_return_value int

            EXECUTE dbo.InsertarRegionGeografica$IMPL @a_Creador, @a_Nombre, @a_Poblacion, @returnvalue = @procedure_return_value  OUTPUT

            SELECT @v_RegionGeografica_P = @procedure_return_value

            INSERT dbo.municipio(dbo.municipio.RegionGeografica_P, dbo.municipio.Estado, dbo.municipio.Ciudad)
               VALUES (@v_RegionGeografica_P, @a_Estado, @a_Ciudad)

            SET @returnvalue = scope_identity()

            /*
            *   SSMA warning messages:
            *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
            */

            RETURN 

         END
      ELSE 
         BEGIN

            SET @returnvalue = 0

            /*
            *   SSMA informational messages:
            *   M2SS0052: BOOLEAN literal was converted to INT literal
            */

            RETURN 

         END

      SET @returnvalue = NULL

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarMunicipio',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarMunicipio$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPais$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPais$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPais$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @a_Continente int,
   @a_Capital int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Idioma char(10),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_MonedaLocal varchar(45),
   @a_MonedaLocal_Dolar decimal(10, 2),
   @a_PIB decimal(15, 0),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @v_RegionGeografica_P int

      SELECT @C = count_big(*)
      FROM dbo.pais, dbo.regiongeografica
      WHERE regiongeografica.Nombre = @a_Nombre AND regiongeografica.RegionGeograficaID = pais.RegionGeografica_P

      IF @C = 0
         BEGIN

            DECLARE
               @procedure_return_value int

            EXECUTE dbo.InsertarRegionGeografica$IMPL @a_Creador, @a_Nombre, @a_Poblacion, @returnvalue = @procedure_return_value  OUTPUT

            SELECT @v_RegionGeografica_P = @procedure_return_value

            INSERT dbo.pais(
               dbo.pais.RegionGeografica_P, 
               dbo.pais.Continente, 
               dbo.pais.Capital, 
               dbo.pais.Idioma, 
               dbo.pais.MonedaLocal, 
               dbo.pais.MonedaLocal_Dolar, 
               dbo.pais.PIB)
               VALUES (
                  @v_RegionGeografica_P, 
                  @a_Continente, 
                  @a_Capital, 
                  @a_Idioma, 
                  @a_MonedaLocal, 
                  @a_MonedaLocal_Dolar, 
                  @a_PIB)

            SET @returnvalue = scope_identity()

            /*
            *   SSMA warning messages:
            *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
            */

            RETURN 

         END
      ELSE 
         BEGIN

            SET @returnvalue = 0

            /*
            *   SSMA informational messages:
            *   M2SS0052: BOOLEAN literal was converted to INT literal
            */

            RETURN 

         END

      SET @returnvalue = NULL

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPais',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPais$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPaisSubcontinente$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPaisSubcontinente$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPaisSubcontinente$IMPL  
   @a_PaisID int,
   @a_SubcontinenteID int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.paissubcontinente(SubcontinenteID, PaisID)
         VALUES (@a_PaisID, @a_SubcontinenteID)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPaisSubcontinente',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPaisSubcontinente$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPalabra$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPalabra$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPalabra$IMPL  
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Palabra_Frase char(15),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.palabra(dbo.palabra.Palabra_Frase)
         VALUES (@a_Palabra_Frase)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPalabra',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPalabra$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarParroquia$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarParroquia$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarParroquia$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @a_Municipio int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_CodigoPostal char(10),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @v_RegionGeografica_P int

      SELECT @C = count_big(*)
      FROM dbo.parroquia, dbo.regiongeografica
      WHERE regiongeografica.Nombre = @a_Nombre AND parroquia.Municipio = @a_Municipio

      IF @C = 0
         BEGIN

            DECLARE
               @procedure_return_value int

            EXECUTE dbo.InsertarRegionGeografica$IMPL @a_Creador, @a_Nombre, @a_Poblacion, @returnvalue = @procedure_return_value  OUTPUT

            SELECT @v_RegionGeografica_P = @procedure_return_value

            INSERT dbo.parroquia(dbo.parroquia.RegionGeografica_P, dbo.parroquia.CodigoPostal, dbo.parroquia.Municipio)
               VALUES (@v_RegionGeografica_P, @a_CodigoPostal, @a_Municipio)

            SET @returnvalue = scope_identity()

            /*
            *   SSMA warning messages:
            *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
            */

            RETURN 

         END
      ELSE 
         BEGIN

            SET @returnvalue = 0

            /*
            *   SSMA informational messages:
            *   M2SS0052: BOOLEAN literal was converted to INT literal
            */

            RETURN 

         END

      SET @returnvalue = NULL

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarParroquia',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarParroquia$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPatrocinante$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPatrocinante$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPatrocinante$IMPL  
   @a_Creador int,
   @a_Parroquia int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_CorreoElectronico varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Contrasena varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_RIF char(10),
   @a_Categoria int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Estatus char(9),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_NombreLegal varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_NombreComun varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Telefono char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Edificio_CC char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Piso char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Apartamento char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Local char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Casa char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Calle char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Sector_Urb_Barrio char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_PaginaWeb char(40),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Facebook char(80),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Twitter char(80),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @v_Cliente_P char(10)

      DECLARE
         @procedure_return_value nvarchar(4000)

      EXECUTE dbo.InsertarCliente$IMPL 
         @a_Creador, 
         @a_Parroquia, 
         @a_CorreoElectronico, 
         @a_Contrasena, 
         @a_RIF, 
         @a_Categoria, 
         @a_Estatus, 
         @a_NombreLegal, 
         @a_NombreComun, 
         @a_Telefono, 
         @a_Edificio_CC, 
         @a_Piso, 
         @a_Apartamento, 
         @a_Local, 
         @a_Casa, 
         @a_Calle, 
         @a_Sector_Urb_Barrio, 
         @a_PaginaWeb, 
         @a_Facebook, 
         @a_Twitter, 
         @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Cliente_P = @procedure_return_value

      INSERT dbo.patrocinante(dbo.patrocinante.Cliente_P)
         VALUES (@v_Cliente_P)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPatrocinante',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPatrocinante$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPrecioCantidad$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPrecioCantidad$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPrecioCantidad$IMPL  
   @a_TiendaID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Codigo char(15),
   @a_Precio decimal(10, 2),
   @a_Cantidad int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int

      SELECT @C = count_big(*)
      FROM dbo.preciocantidad
      WHERE preciocantidad.TiendaID = @a_TiendaID AND preciocantidad.Codigo = @a_Codigo

      IF @C > 0
         UPDATE dbo.preciocantidad
            SET 
               FechaFin = getdate()
         WHERE 
            preciocantidad.TiendaID = @a_TiendaID AND 
            preciocantidad.Codigo = @a_Codigo AND 
            preciocantidad.FechaFin IS NULL

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.preciocantidad(
         TiendaID, 
         Codigo, 
         FechaInicio, 
         FechaFin, 
         Precio, 
         Cantidad)
         VALUES (
            @a_TiendaID, 
            @a_Codigo, 
            isnull(getdate(), getdate()), 
            NULL, 
            @a_Precio, 
            @a_Cantidad)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPrecioCantidad',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPrecioCantidad$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarProducto$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarProducto$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarProducto$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_TipoDeCodigo char(7),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Codigo char(15),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Estatus char(9),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Fabricante varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Modelo varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Categoria int,
   @a_DebutEnElMercado date,
   @a_Largo float(24),
   @a_Ancho float(24),
   @a_Alto float(24),
   @a_Peso float(24),
   @a_PaisDeOrigen int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int, 
         @v_Describible_P int, 
         @v_Buscable_P int, 
         @v_CalificableSeguible_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarDescribible$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Describible_P = @procedure_return_value$2

      DECLARE
         @procedure_return_value$3 int

      EXECUTE dbo.InsertarBuscable$IMPL @returnvalue = @procedure_return_value$3  OUTPUT

      SELECT @v_Buscable_P = @procedure_return_value$3

      DECLARE
         @procedure_return_value$4 int

      EXECUTE dbo.InsertarCalificableSeguible$IMPL @returnvalue = @procedure_return_value$4  OUTPUT

      SELECT @v_CalificableSeguible_P = @procedure_return_value$4

      INSERT dbo.producto(
         dbo.producto.Rastreable_P, 
         dbo.producto.Describible_P, 
         dbo.producto.Buscable_P, 
         dbo.producto.CalificableSeguible_P, 
         dbo.producto.TipoDeCodigo, 
         dbo.producto.Codigo, 
         dbo.producto.Estatus, 
         dbo.producto.Fabricante, 
         dbo.producto.Modelo, 
         dbo.producto.Nombre, 
         dbo.producto.Categoria, 
         dbo.producto.DebutEnElMercado, 
         dbo.producto.Largo, 
         dbo.producto.Ancho, 
         dbo.producto.Alto, 
         dbo.producto.Peso, 
         dbo.producto.PaisDeOrigen)
         VALUES (
            @v_Rastreable_P, 
            @v_Describible_P, 
            @v_Buscable_P, 
            @v_CalificableSeguible_P, 
            @a_TipoDeCodigo, 
            @a_Codigo, 
            @a_Estatus, 
            @a_Fabricante, 
            @a_Modelo, 
            @a_Nombre, 
            @a_Categoria, 
            @a_DebutEnElMercado, 
            @a_Largo, 
            @a_Ancho, 
            @a_Alto, 
            @a_Peso, 
            @a_PaisDeOrigen)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarProducto',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarProducto$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPublicidad$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPublicidad$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPublicidad$IMPL  
   @a_Creador int,
   @a_Patrocinante int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Buscable_P int, 
         @v_Describible_P int, 
         @v_Rastreable_P int, 
         @v_Etiquetable_P int, 
         @v_Cobrable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarBuscable$IMPL @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Buscable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarDescribible$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Describible_P = @procedure_return_value$2

      DECLARE
         @procedure_return_value$3 int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value$3  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value$3

      DECLARE
         @procedure_return_value$4 int

      EXECUTE dbo.InsertarEtiquetable$IMPL @returnvalue = @procedure_return_value$4  OUTPUT

      SELECT @v_Etiquetable_P = @procedure_return_value$4

      DECLARE
         @procedure_return_value$5 int

      EXECUTE dbo.InsertarCobrable$IMPL @returnvalue = @procedure_return_value$5  OUTPUT

      SELECT @v_Cobrable_P = @procedure_return_value$5

      INSERT dbo.publicidad(
         dbo.publicidad.Buscable_P, 
         dbo.publicidad.Describible_P, 
         dbo.publicidad.Rastreable_P, 
         dbo.publicidad.Etiquetable_P, 
         dbo.publicidad.Cobrable_P, 
         dbo.publicidad.Patrocinante, 
         dbo.publicidad.TamanoDePoblacionObjetivo)
         VALUES (
            @v_Buscable_P, 
            @v_Describible_P, 
            @v_Rastreable_P, 
            @v_Etiquetable_P, 
            @v_Cobrable_P, 
            @a_Patrocinante, 
            NULL)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPublicidad',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPublicidad$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPunto$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPunto$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPunto$IMPL  
   @a_Latitud decimal(9, 6),
   @a_Longitud decimal(9, 6),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.punto(dbo.punto.Latitud, dbo.punto.Longitud)
         VALUES (@a_Latitud, @a_Longitud)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPunto',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPunto$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarPuntoDeCroquis$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarPuntoDeCroquis$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarPuntoDeCroquis$IMPL  
   @a_CroquisID int,
   @a_PuntoID int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.puntodecroquis(CroquisID, PuntoID)
         VALUES (@a_CroquisID, @a_PuntoID)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarPuntoDeCroquis',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarPuntoDeCroquis$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarRastreable$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarRastreable$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarRastreable$IMPL  
   @a_Creador int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.rastreable(
         dbo.rastreable.FechaDeCreacion, 
         dbo.rastreable.CreadoPor, 
         dbo.rastreable.FechaDeModificacion, 
         dbo.rastreable.ModificadoPor, 
         dbo.rastreable.FechaDeEliminacion, 
         dbo.rastreable.EliminadoPor, 
         dbo.rastreable.FechaDeAcceso, 
         dbo.rastreable.AccesadoPor)
         VALUES (
            isnull(getdate(), getdate()), 
            @a_Creador, 
            isnull(getdate(), getdate()), 
            @a_Creador, 
            NULL, 
            NULL, 
            isnull(getdate(), getdate()), 
            @a_Creador)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarRastreable',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarRastreable$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarRegionGeografica$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarRegionGeografica$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarRegionGeografica$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_RegionGeografica_P int, 
         @v_Dibujable_P int, 
         @v_Rastreable_P int, 
         @Resultado int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarDibujable$IMPL @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Dibujable_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value$2

      INSERT dbo.regiongeografica(
         dbo.regiongeografica.Rastreable_P, 
         dbo.regiongeografica.Dibujable_P, 
         dbo.regiongeografica.Nombre, 
         dbo.regiongeografica.Poblacion, 
         dbo.regiongeografica.Consumidores_Poblacion, 
         dbo.regiongeografica.Tiendas_Poblacion, 
         dbo.regiongeografica.Tiendas_Consumidores)
         VALUES (
            @v_Rastreable_P, 
            @v_Dibujable_P, 
            @a_Nombre, 
            @a_Poblacion, 
            0, 
            0, 
            NULL)

      /*
      *   SSMA warning messages:
      *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
      */

      SELECT @v_RegionGeografica_P = scope_identity()

      DECLARE
         @procedure_return_value$3 int

      EXECUTE dbo.InsertarTiendasConsumidores$IMPL @v_RegionGeografica_P, 0, 0, @returnvalue = @procedure_return_value$3  OUTPUT

      SELECT @Resultado = @procedure_return_value$3

      SET @returnvalue = @v_RegionGeografica_P

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarRegionGeografica',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarRegionGeografica$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarRegionGeograficaObjetivo$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarRegionGeograficaObjetivo$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarRegionGeograficaObjetivo$IMPL  
   @a_PublicidadID int,
   @a_RegionGeograficaID int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.regiongeograficaobjetivo(PublicidadID, RegionGeograficaID)
         VALUES (@a_PublicidadID, @a_RegionGeograficaID)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarRegionGeograficaObjetivo',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarRegionGeograficaObjetivo$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarRegistro$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarRegistro$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarRegistro$IMPL  
   @a_ActorActivo int,
   @a_ActorPasivo int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Accion char(13),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Parametros varchar(max),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_CodigoDeError char(10),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.registro(
         dbo.registro.FechaHora, 
         dbo.registro.ActorActivo, 
         dbo.registro.ActorPasivo, 
         dbo.registro.Accion, 
         dbo.registro.Parametros, 
         dbo.registro.CodigoDeError)
         VALUES (
            getdate(), 
            @a_ActorActivo, 
            @a_ActorPasivo, 
            @a_Accion, 
            @a_Parametros, 
            @a_CodigoDeError)

      SET @returnvalue = scope_identity()

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarRegistro',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarRegistro$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarRelacionDePalabras$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarRelacionDePalabras$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarRelacionDePalabras$IMPL  
   @a_Palabra1ID int,
   @a_Palabra2ID int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.relaciondepalabras(Palabra1ID, Palabra2ID)
         VALUES (@a_Palabra1ID, @a_Palabra2ID)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarRelacionDePalabras',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarRelacionDePalabras$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarResultadoDeBusqueda$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarResultadoDeBusqueda$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarResultadoDeBusqueda$IMPL  
   @a_BusquedaID int,
   @a_BuscableID int,
   @a_Relevancia float(24),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      /*
      *   SSMA informational messages:
      *   M2SS0052: BOOLEAN literal was converted to SMALLINT literal
      */

      INSERT dbo.resultadodebusqueda(BusquedaID, BuscableID, Visitado, Relevancia)
         VALUES (@a_BusquedaID, @a_BuscableID, 0, @a_Relevancia)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarResultadoDeBusqueda',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarResultadoDeBusqueda$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarSeguidor$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarSeguidor$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarSeguidor$IMPL  
   @a_Creador int,
   @a_CalificableSeguibleID int,
   @a_ConsumidorID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_AvisarSi char(40),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Rastreable_P int

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRastreable$IMPL @a_Creador, @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Rastreable_P = @procedure_return_value

      INSERT dbo.seguidor(Rastreable_P, ConsumidorID, CalificableSeguibleID, AvisarSi)
         VALUES (@v_Rastreable_P, @a_ConsumidorID, @a_CalificableSeguibleID, @a_AvisarSi)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarSeguidor',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarSeguidor$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarServicioVendido$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarServicioVendido$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarServicioVendido$IMPL  
   @a_FacturaID int,
   @a_CobrableID int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.serviciovendido(FacturaID, CobrableID, Acumulado)
         VALUES (@a_FacturaID, @a_CobrableID, 0)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarServicioVendido',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarServicioVendido$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarSexoObjetivo$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarSexoObjetivo$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarSexoObjetivo$IMPL  
   @a_PublicidadID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Sexo char(6),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.sexoobjetivo(PublicidadID, Sexo)
         VALUES (@a_PublicidadID, @a_Sexo)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarSexoObjetivo',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarSexoObjetivo$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarSubcontinente$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarSubcontinente$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarSubcontinente$IMPL  
   @a_Creador int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Nombre varchar(45),
   @a_Poblacion bigint,
   @a_Continente int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @v_RegionGeografica_P int

      SELECT @C = count_big(*)
      FROM dbo.subcontinente, dbo.regiongeografica
      WHERE regiongeografica.Nombre = @a_Nombre AND subcontinente.Continente = @a_Continente

      IF @C = 0
         BEGIN

            DECLARE
               @procedure_return_value int

            EXECUTE dbo.InsertarRegionGeografica$IMPL @a_Creador, @a_Nombre, @a_Poblacion, @returnvalue = @procedure_return_value  OUTPUT

            SELECT @v_RegionGeografica_P = @procedure_return_value

            INSERT dbo.subcontinente(dbo.subcontinente.RegionGeografica_P, dbo.subcontinente.Continente)
               VALUES (@v_RegionGeografica_P, @a_Continente)

            SET @returnvalue = scope_identity()

            /*
            *   SSMA warning messages:
            *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
            */

            RETURN 

         END
      ELSE 
         BEGIN

            SET @returnvalue = 0

            /*
            *   SSMA informational messages:
            *   M2SS0052: BOOLEAN literal was converted to INT literal
            */

            RETURN 

         END

      SET @returnvalue = NULL

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarSubcontinente',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarSubcontinente$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarTamano$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarTamano$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarTamano$IMPL  
   @a_TiendaID int,
   @a_NumeroTotalDeProductos int,
   @a_CantidadTotalDeProductos int,
   @a_Valor int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int

      SELECT @C = count_big(*)
      FROM dbo.tamano
      WHERE tamano.TiendaID = @a_TiendaID

      IF @C > 0
         UPDATE dbo.tamano
            SET 
               FechaFin = getdate()
         WHERE tamano.TiendaID = @a_TiendaID AND tamano.FechaFin IS NULL

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.tamano(
         TiendaID, 
         FechaInicio, 
         FechaFin, 
         NumeroTotalDeProductos, 
         CantidadTotalDeProductos, 
         Valor)
         VALUES (
            @a_TiendaID, 
            isnull(getdate(), getdate()), 
            NULL, 
            @a_NumeroTotalDeProductos, 
            @a_CantidadTotalDeProductos, 
            @a_Valor)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarTamano',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarTamano$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarTienda$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarTienda$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarTienda$IMPL  
   @a_Creador int,
   @a_Parroquia int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_CorreoElectronico varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Contrasena varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_RIF char(10),
   @a_Categoria int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Estatus char(9),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_NombreLegal varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_NombreComun varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Telefono char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Edificio_CC char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Piso char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Apartamento char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Local char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Casa char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Calle char(12),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Sector_Urb_Barrio char(20),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_PaginaWeb char(40),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Facebook char(80),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Twitter char(80),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @v_Buscable_P int, 
         @v_CalificableSeguible_P int, 
         @v_Interlocutor_P int, 
         @v_Dibujable_P int, 
         @Resultado int, 
         @T int

      DECLARE
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @v_Cliente_P char(10)

      DECLARE
         @procedure_return_value nvarchar(4000)

      EXECUTE dbo.InsertarCliente$IMPL 
         @a_Creador, 
         @a_Parroquia, 
         @a_CorreoElectronico, 
         @a_Contrasena, 
         @a_RIF, 
         @a_Categoria, 
         @a_Estatus, 
         @a_NombreLegal, 
         @a_NombreComun, 
         @a_Telefono, 
         @a_Edificio_CC, 
         @a_Piso, 
         @a_Apartamento, 
         @a_Local, 
         @a_Casa, 
         @a_Calle, 
         @a_Sector_Urb_Barrio, 
         @a_PaginaWeb, 
         @a_Facebook, 
         @a_Twitter, 
         @returnvalue = @procedure_return_value  OUTPUT

      SELECT @v_Cliente_P = @procedure_return_value

      DECLARE
         @procedure_return_value$2 int

      EXECUTE dbo.InsertarBuscable$IMPL @returnvalue = @procedure_return_value$2  OUTPUT

      SELECT @v_Buscable_P = @procedure_return_value$2

      DECLARE
         @procedure_return_value$3 int

      EXECUTE dbo.InsertarCalificableSeguible$IMPL @returnvalue = @procedure_return_value$3  OUTPUT

      SELECT @v_CalificableSeguible_P = @procedure_return_value$3

      DECLARE
         @procedure_return_value$4 int

      EXECUTE dbo.InsertarInterlocutor$IMPL @returnvalue = @procedure_return_value$4  OUTPUT

      SELECT @v_Interlocutor_P = @procedure_return_value$4

      DECLARE
         @procedure_return_value$5 int

      EXECUTE dbo.InsertarDibujable$IMPL @returnvalue = @procedure_return_value$5  OUTPUT

      SELECT @v_Dibujable_P = @procedure_return_value$5

      /*
      *   SSMA informational messages:
      *   M2SS0052: BOOLEAN literal was converted to SMALLINT literal
      */

      INSERT dbo.tienda(
         dbo.tienda.Buscable_P, 
         dbo.tienda.Cliente_P, 
         dbo.tienda.CalificableSeguible_P, 
         dbo.tienda.Interlocutor_P, 
         dbo.tienda.Dibujable_P, 
         dbo.tienda.Abierto)
         VALUES (
            @v_Buscable_P, 
            @v_Cliente_P, 
            @v_CalificableSeguible_P, 
            @v_Interlocutor_P, 
            @v_Dibujable_P, 
            0)

      /*
      *   SSMA warning messages:
      *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
      */

      SELECT @T = scope_identity()

      DECLARE
         @procedure_return_value$6 int

      EXECUTE dbo.InsertarTamano$IMPL 
         @T, 
         0, 
         0, 
         0, 
         @returnvalue = @procedure_return_value$6  OUTPUT

      SELECT @Resultado = @procedure_return_value$6

      SET @returnvalue = @T

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarTienda',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarTienda$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarTiendasConsumidores$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarTiendasConsumidores$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarTiendasConsumidores$IMPL  
   @a_RegionGeograficaID int,
   @a_NumeroDeConsumidores int,
   @a_NumeroDeTiendas int,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @C int, 
         @Pob int

      SELECT @C = count_big(*)
      FROM dbo.tiendasconsumidores
      WHERE tiendasconsumidores.RegionGeograficaID = @a_RegionGeograficaID

      IF @C > 0
         UPDATE dbo.tiendasconsumidores
            SET 
               FechaFin = getdate()
         WHERE tiendasconsumidores.RegionGeograficaID = @a_RegionGeograficaID AND tiendasconsumidores.FechaFin IS NULL

      /*
      *   SSMA informational messages:
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.tiendasconsumidores(
         RegionGeograficaID, 
         FechaInicio, 
         FechaFin, 
         NumeroDeConsumidores, 
         NumeroDeTiendas)
         VALUES (
            @a_RegionGeograficaID, 
            isnull(getdate(), getdate()), 
            NULL, 
            @a_NumeroDeConsumidores, 
            @a_NumeroDeTiendas)

      SELECT @Pob = regiongeografica.Poblacion
      FROM dbo.regiongeografica
      WHERE regiongeografica.RegionGeograficaID = @a_RegionGeograficaID

      UPDATE dbo.regiongeografica
         SET 
            Consumidores_Poblacion = 
               CASE 
                  WHEN (@Pob > 0) THEN @a_NumeroDeConsumidores * 1.0 / @Pob
                  ELSE 0
               END, 
            Tiendas_Poblacion = 
               CASE 
                  WHEN (@Pob > 0) THEN @a_NumeroDeTiendas * 1.0 / @Pob
                  ELSE 0
               END
      WHERE regiongeografica.RegionGeograficaID = @a_RegionGeograficaID

      UPDATE dbo.regiongeografica
         SET 
            Tiendas_Consumidores = 
               CASE 
                  WHEN (@a_NumeroDeConsumidores > 0) THEN @a_NumeroDeTiendas * 1.0 / @a_NumeroDeConsumidores
                  ELSE NULL
               END
      WHERE regiongeografica.RegionGeograficaID = @a_RegionGeograficaID

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarTiendasConsumidores',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarTiendasConsumidores$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarTurno$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarTurno$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarTurno$IMPL  
   @a_TiendaID int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
   */

   @a_Dia char(9),
   @a_HoraDeApertura time,
   @a_HoraDeCierre time,
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      INSERT dbo.turno(TiendaID, Dia, HoraDeApertura, HoraDeCierre)
         VALUES (@a_TiendaID, @a_Dia, @a_HoraDeApertura, @a_HoraDeCierre)

      SET @returnvalue = 1

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarTurno',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarTurno$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'InsertarUsuario$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[InsertarUsuario$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.InsertarUsuario$IMPL  
   @a_Parroquia int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_CorreoElectronico varchar(45),
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   @a_Contrasena varchar(45),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @AccesoID int

      INSERT dbo.usuario(dbo.usuario.Parroquia)
         VALUES (@a_Parroquia)

      /*
      *   SSMA warning messages:
      *   M2SS0240: The behaviour of Standard Function SCOPE_IDENTITY may not be same as in MySql
      */

      SELECT @AccesoID = scope_identity()

      /*
      *   SSMA informational messages:
      *   M2SS0052: BOOLEAN literal was converted to SMALLINT literal
      *   M2SS0231: Zero-date, zero-in-date and invalid dates to not null columns has been replaced with GetDate()/Constant date
      */

      INSERT dbo.acceso(
         AccesoID, 
         Conectado, 
         CorreoElectronico, 
         Contrasena, 
         FechaDeRegistro, 
         FechaDeUltimoAcceso, 
         DuracionDeUltimoAcceso, 
         NumeroTotalDeAccesos, 
         TiempoTotalDeAccesos, 
         TiempoPromedioPorAcceso)
         VALUES (
            @AccesoID, 
            0, 
            @a_CorreoElectronico, 
            @a_Contrasena, 
            isnull(getdate(), getdate()), 
            NULL, 
            m2ss.maketime(0, 0, 0), 
            0, 
            m2ss.maketime(0, 0, 0), 
            m2ss.maketime(0, 0, 0))

      SET @returnvalue = @AccesoID

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.InsertarUsuario',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'InsertarUsuario$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'RegistrarCreacion$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[RegistrarCreacion$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.RegistrarCreacion$IMPL  
   @a_Rastreable int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Parametros varchar(max),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @ActorActivo int, 
         @Resultado int

      DECLARE
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @Accion char(40), 
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @Error char(40)

      SELECT @ActorActivo = rastreable.CreadoPor
      FROM dbo.rastreable
      WHERE rastreable.RastreableID = @a_Rastreable

      SELECT @Accion = N'Crear'

      SELECT @Error = N'OK'

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRegistro$IMPL 
         @ActorActivo, 
         @a_Rastreable, 
         @Accion, 
         @a_Parametros, 
         @Error, 
         @returnvalue = @procedure_return_value  OUTPUT

      SELECT @Resultado = @procedure_return_value

      SET @returnvalue = @Resultado

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.RegistrarCreacion',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'RegistrarCreacion$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'RegistrarEliminacion$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[RegistrarEliminacion$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.RegistrarEliminacion$IMPL  
   @a_Rastreable int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Parametros varchar(max),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @ActorActivo int, 
         @Resultado int

      DECLARE
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @Accion char(40), 
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @Error char(40)

      SELECT @ActorActivo = rastreable.EliminadoPor
      FROM dbo.rastreable
      WHERE rastreable.RastreableID = @a_Rastreable

      SELECT @Accion = N'Eliminar'

      SELECT @Error = N'OK'

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRegistro$IMPL 
         @ActorActivo, 
         @a_Rastreable, 
         @Accion, 
         @a_Parametros, 
         @Error, 
         @returnvalue = @procedure_return_value  OUTPUT

      SELECT @Resultado = @procedure_return_value

      SET @returnvalue = @Resultado

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.RegistrarEliminacion',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'RegistrarEliminacion$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE spuria
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'RegistrarModificacion$IMPL'  AND sc.name=N'dbo'  AND type in (N'P'))
 DROP PROCEDURE [dbo].[RegistrarModificacion$IMPL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*/

CREATE PROCEDURE dbo.RegistrarModificacion$IMPL  
   @a_Rastreable int,
   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   @a_Parametros varchar(max),
   @returnvalue int  OUTPUT
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      SET @returnvalue = NULL

      DECLARE
         @ActorActivo int, 
         @Resultado int

      DECLARE
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @Accion char(40), 
         /*
         *   SSMA informational messages:
         *   M2SS0055: Data type was converted to CHAR according to character set mapping for latin1 character set
         */

         @Error char(40)

      SELECT @ActorActivo = rastreable.ModificadoPor
      FROM dbo.rastreable
      WHERE rastreable.RastreableID = @a_Rastreable

      SELECT @Accion = N'Actualizar'

      SELECT @Error = N'OK'

      DECLARE
         @procedure_return_value int

      EXECUTE dbo.InsertarRegistro$IMPL 
         @ActorActivo, 
         @a_Rastreable, 
         @Accion, 
         @a_Parametros, 
         @Error, 
         @returnvalue = @procedure_return_value  OUTPUT

      SELECT @Resultado = @procedure_return_value

      SET @returnvalue = @Resultado

   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.RegistrarModificacion',
        N'SCHEMA', N'dbo',
        N'PROCEDURE', N'RegistrarModificacion$IMPL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
