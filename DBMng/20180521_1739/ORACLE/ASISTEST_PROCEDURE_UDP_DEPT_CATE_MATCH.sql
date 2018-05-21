/* *************************************************************************
 * NAME : ASISTEST.UDP_DEPT_CATE_MATCH
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEPT_CATE_MATCH" AS 
BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 2 and c_seqno > 0 and ca_code1 <> '86' order by ca_code;
    begin
      delete tbl_departcate_from_lp;
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          insert into tbl_departcate_from_lp (ca_code, depart_ca_code)
          (select  v_cate ,ca_code  from tbl_goods where modelno in ( select modelno from tbl_goods where ca_code like v_cate || '%'  and constrain IN ('1','5') AND jobcode>'0' AND (mallcnt>0 OR mallcnt3>0) AND openexpectflag='0' ) and ca_code like '86%' group by ca_code);
        end loop;
      close cur01;
    end;    
   commit;
END UDP_DEPT_CATE_MATCH;