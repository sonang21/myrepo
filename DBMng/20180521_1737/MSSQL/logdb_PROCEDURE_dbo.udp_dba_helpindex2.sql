/* *************************************************************************
 * NAME : dbo.udp_dba_helpindex2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-28 14:36:29.843
 *        Modify: 2012-09-28 14:37:21.463
 *        Backup: 20180521_1737
 ************************************************************************* */

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE dbo.udp_dba_helpindex2
    @object_name AS SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
      tTBL.name                                             table_name
    , ROW_NUMBER() OVER (PARTITION BY tTBL.name 
                         ORDER BY tIDX.index_id ASC )       seq
    , tIDX.name             index_name
    , CASE WHEN ( tIDX.is_primary_key = 1 ) THEN 'PRIMARY KEY '
           WHEN ( tIDX.is_unique      = 1 ) THEN 'UNIQUE '
           ELSE ''                          END             index_attribute
    , tIDX.type_desc                                        index_type
    , SUBSTRING 
        ( /*INDEX KEY COLUMN SUBQUERY*/
          ( SELECT 
                ( SELECT ', ' + name + ' ' + CASE tIXC.is_descending_key WHEN 1 THEN 'DESC' ELSE '' END 
                  FROM sys.columns tCOL 
                  WHERE tCOL.object_id = tTBL.object_id 
                    AND tCOL.column_id = tIXC.column_id
                )
            FROM sys.index_columns  tIXC 
            WHERE tIXC.object_id = tTBL.object_id 
              AND tIXC.index_id  = tIDX.index_id        
              AND tIXC.is_included_column = 0 
            ORDER BY tIXC.key_ordinal ASC
            FOR XML PATH ('')
          )
        , 3, 4000 )                                         index_key_order
    , CASE WHEN ( tIDX.type_desc = 'HEAP' ) THEN NULL
           ELSE   COALESCE 
                    ( SUBSTRING
                        ( /*INDEX INCLUDE COLUMN SUBQUERY*/
                          ( SELECT 
                                ( SELECT ', ' + name + ' '
                                  FROM sys.columns tCOL 
                                  WHERE tCOL.object_id = tTBL.object_id 
                                    AND tCOL.column_id = tIXC.column_id
                                )
                            FROM sys.index_columns  tIXC 
                            WHERE tIXC.object_id = tTBL.object_id 
                              AND tIXC.index_id  = tIDX.index_id        
                              AND tIXC.is_included_column = 1
                            ORDER BY tIXC.key_ordinal ASC
                            FOR XML PATH ('')
                          )
                        , 3, 4000 )
                    , '' )              
      END                                                   index_included_column
    FROM sys.tables         tTBL
    JOIN sys.indexes        tIDX ON tIDX.object_id = tTBL.object_id
    WHERE
        ( @object_name IS NOT NULL AND tTBL.object_id = OBJECT_ID ( @object_name ) )
     OR ( @object_name IS NULL )
    ORDER BY 
      tTBL.name
    , tIDX.index_id
END

