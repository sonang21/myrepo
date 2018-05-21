/* *************************************************************************
 * NAME : ASISTEST.EXECUTE_IMMEDIATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:14
 *        Modify: 2018-05-07 13:11:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."EXECUTE_IMMEDIATE" ( p_sql_text VARCHAR2 ) IS

   COMPILATION_ERROR EXCEPTION;
   PRAGMA EXCEPTION_INIT(COMPILATION_ERROR,-24344);

   l_cursor INTEGER DEFAULT 0;
   rc       INTEGER DEFAULT 0;
   stmt     VARCHAR2(1000);

BEGIN

   l_cursor := DBMS_SQL.OPEN_CURSOR;
   DBMS_SQL.PARSE(l_cursor, p_sql_text, DBMS_SQL.NATIVE);
   rc := DBMS_SQL.EXECUTE(l_cursor);
   DBMS_SQL.CLOSE_CURSOR(l_cursor);
--
-- Ignore compilation errors because these sometimes happen due to
-- dependencies between views AND procedures
--
   EXCEPTION WHEN COMPILATION_ERROR THEN DBMS_SQL.CLOSE_CURSOR(l_cursor);
       WHEN OTHERS THEN
          BEGIN
              DBMS_SQL.CLOSE_CURSOR(l_cursor);
              raise_application_error(-20101,sqlerrm || '  when executing ''' || p_sql_text || '''   ');
          END;
END;