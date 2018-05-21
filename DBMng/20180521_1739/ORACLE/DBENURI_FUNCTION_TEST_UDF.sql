/* *************************************************************************
 * NAME : DBENURI.TEST_UDF
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-04-19 18:32:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."TEST_UDF" (modelno in varchar2) return varchar2 is
  rtn_val varchar2(200);
begin
  select 'test' into rtn_val from dual;
  return rtn_val;
end TEST_UDF;
