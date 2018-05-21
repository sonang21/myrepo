/* *************************************************************************
 * NAME : DBADM.FN_GET_IXCOL_EXP
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-27 20:22:49
 *        Modify: 2018-03-27 20:22:49
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBADM"."FN_GET_IXCOL_EXP" (iowner varchar2, ixname varchar2, icol_pos number) 
RETURN varchar2 
authid current_user
AS 
    v_col_expression varchar2(32767);
begin
  select column_expression into v_col_expression from all_ind_expressions
  where index_owner = iowner and index_name=ixname and column_position=icol_pos;
  
  v_col_expression := substr(v_col_expression, 1, 1000);
  RETURN v_col_expression;  
END;