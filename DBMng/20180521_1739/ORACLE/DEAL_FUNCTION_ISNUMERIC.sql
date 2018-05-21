/* *************************************************************************
 * NAME : DEAL.ISNUMERIC
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DEAL"."ISNUMERIC" (i_str VARCHAR2) RETURN NUMBER
IS
 v_ret NUMBER;
BEGIN
  IF i_str IS NULL OR LENGTH(TRIM(i_str)) = 0 THEN
    RETURN 0;
  END IF;
 
  V_RET := TO_NUMBER(I_STR);
  RETURN 1;
 
EXCEPTION WHEN OTHERS THEN
  RETURN 0;
END ;