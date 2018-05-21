/* *************************************************************************
 * NAME : DEAL.SF_CODENAME
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DEAL"."SF_CODENAME" 
(
  in_code in varchar2 
) return varchar2 is

v_codename d4_commoncode.codename%type;

begin

    select a.codename 
      into v_codename
      from d4_commoncode a
     where a.code = in_code; 

  return v_codename;
end;