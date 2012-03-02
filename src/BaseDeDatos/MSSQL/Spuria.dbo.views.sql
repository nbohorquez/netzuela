
USE spuria
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'dbo')      
     EXEC (N'CREATE SCHEMA dbo')                                   
 GO                                                               

USE spuria
GO
IF  EXISTS (select * from sys.objects so join sys.schemas sc on so.schema_id = sc.schema_id where so.name = N'inventariotienda' and sc.name=N'dbo' AND type in (N'V'))
 DROP VIEW [dbo].[inventariotienda]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   ALGORITHM =  UNDEFINED.
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `chivo`@`localhost`.
*   M2SS0003: The following SQL clause was ignored during conversion:
*   SQL SECURITY DEFINER.
*/

CREATE VIEW dbo.inventariotienda (
   [TiendaID], 
   [Codigo], 
   [Descripcion], 
   [Precio], 
   [Cantidad])
AS 
   SELECT 
      inventario.TiendaID AS TiendaID, 
      inventario.Codigo AS Codigo, 
      inventario.Descripcion AS Descripcion, 
      preciocantidad.Precio AS Precio, 
      preciocantidad.Cantidad AS Cantidad
   FROM (dbo.inventario 
      LEFT JOIN dbo.preciocantidad 
      ON (((inventario.TiendaID = preciocantidad.TiendaID) AND (inventario.Codigo = preciocantidad.Codigo))))
   WHERE 
      CASE 
         WHEN CONVERT(varchar(20), preciocantidad.FechaFin, 120) IS NULL THEN 1
         ELSE 0
      END <> 0
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'spuria.inventariotienda',
        N'SCHEMA', N'dbo',
        N'VIEW', N'inventariotienda'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
