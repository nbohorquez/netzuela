
USE spuria
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'm2ss')      
     EXEC (N'CREATE SCHEMA m2ss')                                   
 GO                                                               

USE spuria
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id 
             WHERE so.name = N'maketime'  AND sc.name=N'm2ss'  AND type in (N'FN',N'TF',N'IF'))
BEGIN

  DECLARE @drop_statement nvarchar(500)
  DECLARE drop_cursor CURSOR FOR
     SELECT
                 'ALTER TABLE ' +
                       quotename(schema_name(tbl.schema_id)) + '.' + 
                       quotename(object_name(tbl.object_id)) + 
                 ' DROP CONSTRAINT ' + quotename(object_name(constr.object_id))
     FROM sys.sql_expression_dependencies dep
           JOIN sys.objects constr 
                 ON constr.object_id = dep.referencing_id AND constr.type = N'C'
           JOIN sys.objects tbl
                 ON tbl.object_id = constr.parent_object_id
     WHERE 
           dep.referenced_id = 
           (
                 SELECT so.object_id 
                       FROM sys.objects so 
                             JOIN sys.schemas sc 
                                   ON so.schema_id = sc.schema_id 
                       WHERE 
                             so.name = N'maketime'  AND 
                             sc.name=N'm2ss'  AND 
                             type in (N'FN',N'TF',N'IF')
            )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement


  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)
     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP FUNCTION [m2ss].[maketime]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION m2ss.maketime(@hour INT, @minute INT, @second int) RETURNS TIME
AS
  BEGIN
        RETURN
                CASE
                      WHEN
                          @hour BETWEEN 0 AND 24 AND @minute BETWEEN 0 AND 59 AND @second BETWEEN 0 AND 59 THEN
                          CAST(
                                DATEADD(hour, @hour,
                                        DATEADD(minute, @minute,
                                                DATEADD(second, @second, 0)
                                                )
                              )
                          AS TIME)
                      ELSE NULL
                END
  END
      
GO
