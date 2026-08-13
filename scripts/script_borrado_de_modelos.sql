USE GD2C2022
GO

-----------------------------------------------------------
---------- BORRADO DE FOREIGN KEYS DEL MODELO BI ----------
-----------------------------------------------------------

IF Object_id('LOS_SELECTOS.BI_BORRAR_FOREIGN_KEYS') IS NOT NULL
  DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_FOREIGN_KEYS
GO 

CREATE PROCEDURE LOS_SELECTOS.BI_BORRAR_FOREIGN_KEYS
AS
	DECLARE @query nvarchar(255)
	DECLARE query_cursor CURSOR FOR
		SELECT 'ALTER TABLE '
		+ object_schema_name(fk.parent_object_id)
		+ '.[' + Object_name(fk.parent_object_id)
		+ '] DROP CONSTRAINT ' + fk.name query
		FROM sys.foreign_keys fk
		WHERE  fk.name LIKE 'FK_BI%' 
	OPEN query_cursor
	FETCH NEXT FROM query_cursor INTO @query
	WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_executesql
			@query
			FETCH NEXT FROM query_cursor INTO @query
		END
	CLOSE query_cursor
	DEALLOCATE query_cursor
GO

-----------------------------------------------------------
------------- BORRADO DE TABLAS DEL MODELO BI -------------
-----------------------------------------------------------

IF Object_id('LOS_SELECTOS.BI_BORRAR_TABLAS') IS NOT NULL
	DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_TABLAS
GO

CREATE PROCEDURE LOS_SELECTOS.BI_BORRAR_TABLAS
AS
	DECLARE @query nvarchar(255)
	DECLARE query_cursor CURSOR FOR
	SELECT 'DROP TABLE LOS_SELECTOS.' + name
			FROM  sys.tables
			WHERE schema_id = (SELECT schema_id FROM sys.schemas WHERE name = 'LOS_SELECTOS') AND name like 'BI_%'
	OPEN query_cursor
    FETCH NEXT FROM query_cursor INTO @query
    WHILE @@FETCH_STATUS = 0
      BEGIN
          EXEC sp_executesql
            @query
          FETCH NEXT FROM query_cursor INTO @query
      END
    CLOSE query_cursor
    DEALLOCATE query_cursor
GO

-----------------------------------------------------------
----------- BORRADO DE PROCEDURES DEL MODELO BI -----------
-----------------------------------------------------------

IF Object_id('LOS_SELECTOS.BI_BORRAR_PROCEDURES') IS NOT NULL
  DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_PROCEDURES
GO

CREATE PROCEDURE LOS_SELECTOS.BI_BORRAR_PROCEDURES
AS
    DECLARE @query nvarchar(255)
    DECLARE query_cursor CURSOR FOR
    SELECT 'DROP PROCEDURE LOS_SELECTOS.' + name
               FROM  sys.procedures
               WHERE schema_id = (SELECT schema_id FROM sys.schemas WHERE name = 'LOS_SELECTOS') AND name LIKE 'MIGRAR_TABLA_BI%'
      OPEN query_cursor
    FETCH NEXT FROM query_cursor INTO @query
    WHILE @@FETCH_STATUS = 0
      BEGIN
          EXEC sp_executesql
            @query
          FETCH NEXT FROM query_cursor INTO @query
      END
    CLOSE query_cursor
    DEALLOCATE query_cursor
GO

--------------------------------------------------------
---------- BORRADO DE FUNCIONES DEL MODELO BI ----------
--------------------------------------------------------

IF Object_id('LOS_SELECTOS.BI_BORRAR_FUNCIONES') IS NOT NULL 
  DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_FUNCIONES
GO 

CREATE PROCEDURE LOS_SELECTOS.BI_BORRAR_FUNCIONES
AS
	DECLARE @query nvarchar(255) 
	DECLARE query_cursor CURSOR FOR  
	SELECT 'DROP FUNCTION LOS_SELECTOS.' + name
		FROM sys.sql_modules m
		INNER JOIN sys.objects o 
		ON m.object_id = o.object_id
		WHERE name like 'BI_FUNCION%'
	OPEN query_cursor 
	FETCH NEXT FROM query_cursor INTO @query
	WHILE @@FETCH_STATUS = 0 
		BEGIN
			EXEC sp_executesql
			@query
			FETCH NEXT FROM query_cursor INTO @query
		END
	CLOSE query_cursor
	DEALLOCATE query_cursor
GO 

-----------------------------------------------------
---------- BORRADO DE VISTAS DEL MODELO BI ----------
-----------------------------------------------------

IF Object_id('LOS_SELECTOS.BI_BORRAR_VISTAS') IS NOT NULL 
  DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_VISTAS

GO 

CREATE PROCEDURE LOS_SELECTOS.BI_BORRAR_VISTAS
AS
	DECLARE @query nvarchar(255)
	DECLARE query_cursor CURSOR FOR
		SELECT 'DROP VIEW LOS_SELECTOS.' + name
		FROM sys.views
	OPEN query_cursor
	FETCH NEXT FROM query_cursor INTO @query
	WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_executesql
			@query
			FETCH NEXT FROM query_cursor INTO @query
		END
		CLOSE query_cursor
		DEALLOCATE query_cursor
GO 


---------------------------------------------------------------------------------------------------
---------- BORRADO DE FOREIGN KEYS, TABLAS, PROCEDURES, FUNCIONES Y VISTAS DEL MODELO BI ----------
---------------------------------------------------------------------------------------------------

EXEC LOS_SELECTOS.BI_BORRAR_FOREIGN_KEYS
EXEC LOS_SELECTOS.BI_BORRAR_TABLAS
EXEC LOS_SELECTOS.BI_BORRAR_PROCEDURES
EXEC LOS_SELECTOS.BI_BORRAR_FUNCIONES
EXEC LOS_SELECTOS.BI_BORRAR_VISTAS
GO

DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_FOREIGN_KEYS
DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_TABLAS
DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_FUNCIONES
DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_PROCEDURES
DROP PROCEDURE LOS_SELECTOS.BI_BORRAR_VISTAS
GO

-------------------------------------------------------------------
---------- BORRADO DE FOREIGN KEYS DEL MODELO RELACIONAL ----------
-------------------------------------------------------------------

IF Object_id('LOS_SELECTOS.BORRAR_FOREIGN_KEYS') IS NOT NULL
  DROP PROCEDURE BORRAR_FOREIGN_KEYS
GO 

CREATE PROCEDURE LOS_SELECTOS.BORRAR_FOREIGN_KEYS
AS
	DECLARE @query nvarchar(255)
	DECLARE query_cursor CURSOR FOR
		SELECT 'ALTER TABLE '
		+ object_schema_name(fk.parent_object_id)
		+ '.[' + Object_name(fk.parent_object_id)
		+ '] DROP CONSTRAINT ' + fk.name query
		FROM sys.foreign_keys fk
	OPEN query_cursor
	FETCH NEXT FROM query_cursor INTO @query
	WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_executesql
			@query
			FETCH NEXT FROM query_cursor INTO @query
		END
	CLOSE query_cursor
	DEALLOCATE query_cursor
GO

-------------------------------------------------------------------
------------- BORRADO DE TABLAS DEL MODELO RELACIONAL -------------
-------------------------------------------------------------------

IF Object_id('LOS_SELECTOS.BORRAR_TABLAS') IS NOT NULL
	DROP PROCEDURE LOS_SELECTOS.BORRAR_TABLAS
GO

CREATE PROCEDURE LOS_SELECTOS.BORRAR_TABLAS
AS
	DECLARE @query nvarchar(255)
	DECLARE query_cursor CURSOR FOR
	SELECT 'DROP TABLE LOS_SELECTOS.' + name
			FROM  sys.tables
			WHERE schema_id = (SELECT schema_id FROM sys.schemas WHERE name = 'LOS_SELECTOS')
	OPEN query_cursor
    FETCH NEXT FROM query_cursor INTO @query
    WHILE @@FETCH_STATUS = 0
      BEGIN
          EXEC sp_executesql
            @query
          FETCH NEXT FROM query_cursor INTO @query
      END
    CLOSE query_cursor
    DEALLOCATE query_cursor
GO

-------------------------------------------------------------------
----------- BORRADO DE PROCEDURES DEL MODELO RELACIONAL -----------
-------------------------------------------------------------------

IF Object_id('LOS_SELECTOS.BORRAR_PROCEDURES') IS NOT NULL
  DROP PROCEDURE LOS_SELECTOS.BORRAR_PROCEDURES
GO

CREATE PROCEDURE LOS_SELECTOS.BORRAR_PROCEDURES
AS
    DECLARE @query nvarchar(255)
    DECLARE query_cursor CURSOR FOR
    SELECT 'DROP PROCEDURE LOS_SELECTOS.' + name
               FROM  sys.procedures
               WHERE schema_id = (SELECT schema_id FROM sys.schemas WHERE name = 'LOS_SELECTOS') AND name LIKE 'MIGRAR_%'
      OPEN query_cursor
    FETCH NEXT FROM query_cursor INTO @query
    WHILE @@FETCH_STATUS = 0
      BEGIN
          EXEC sp_executesql
            @query
          FETCH NEXT FROM query_cursor INTO @query
      END
    CLOSE query_cursor
    DEALLOCATE query_cursor
GO

----------------------------------------------------------------------------------------
---------- BORRADO DE FOREIGN KEYS, TABLAS Y PROCEDURES DEL MODELO RELACIONAL ----------
----------------------------------------------------------------------------------------

EXEC LOS_SELECTOS.BORRAR_FOREIGN_KEYS
EXEC LOS_SELECTOS.BORRAR_TABLAS
EXEC LOS_SELECTOS.BORRAR_PROCEDURES
GO

DROP PROCEDURE LOS_SELECTOS.BORRAR_FOREIGN_KEYS
DROP PROCEDURE LOS_SELECTOS.BORRAR_TABLAS
DROP PROCEDURE LOS_SELECTOS.BORRAR_PROCEDURES

----------------------------------------
---------- BORRADO DE ESQUEMA ----------
----------------------------------------

IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'LOS_SELECTOS')
BEGIN
   DROP SCHEMA LOS_SELECTOS
   PRINT('Esquema LOS_SELECTOS borrado')
END
GO