/* *************************************************************************
 * NAME : ASISTEST.TEST_UDF
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:33
 *        Modify: 2018-05-07 13:11:11
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."TEST_UDF" (modelno in varchar2) return varchar2 is
  rtn_val varchar2(200);
begin
  select 'test' into rtn_val from dual;
  return rtn_val;
end TEST_UDF;