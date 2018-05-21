/* *************************************************************************
 * NAME : DBENURI.UDP_ZUM_MINPRICELIST_SUM2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ZUM_MINPRICELIST_SUM2" AS 
BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 1 and c_seqno > 0 and ca_code not in ('90','91','92','86','95') order by ca_code;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          insert into TBL_ZUM_MINPRICELIST_SUM_PREV2 (select modelno,case when nvl(minprice4,0) = 0 then minprice else minprice4 end,ca_code from tbl_goods where jobcode > '0' and mallcnt > 0 and openexpectflag = '0' and constrain = '1' and ca_lcode = v_cate and cateflag = '0' and modelno not in (select modelno from TBL_ZUM_MINPRICELIST_SUM_PREV2) );
          commit;
          update TBL_ZUM_MINPRICELIST_SUM_PREV2 a set a.minprice  =  (select case when nvl(minprice4,0) = 0 then minprice else minprice4 end from tbl_goods where a.modelno = modelno and jobcode > '0' and mallcnt > 0 and openexpectflag = '0' and constrain = '1' and ca_lcode = v_cate and cateflag = '0' ) where exists (select 1 from tbl_goods where a.modelno = modelno);
          COMMIT;
        end loop;
      close cur01;
    end;    
END UDP_ZUM_MINPRICELIST_SUM2;