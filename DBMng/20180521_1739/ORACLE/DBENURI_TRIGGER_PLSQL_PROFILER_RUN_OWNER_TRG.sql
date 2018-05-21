/* *************************************************************************
 * NAME : DBENURI.PLSQL_PROFILER_RUN_OWNER_TRG
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 18:50:09
 *        Modify: 2018-03-28 18:50:09
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."PLSQL_PROFILER_RUN_OWNER_TRG" BEFORE INSERT OR UPDATE OF run_owner ON plsql_profiler_runs FOR EACH ROW      WHEN (new.run_owner IS NULL) BEGIN :new.run_owner := user; END;




ALTER TRIGGER "DBENURI"."PLSQL_PROFILER_RUN_OWNER_TRG" ENABLE