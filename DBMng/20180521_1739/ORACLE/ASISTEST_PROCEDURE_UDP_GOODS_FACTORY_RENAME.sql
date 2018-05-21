/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_FACTORY_RENAME
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_FACTORY_RENAME" as
BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 1 and c_seqno > 0 and ca_code not in ('90','91','92','95') order by ca_code;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
/*          
          insert into TBL_GOODS_RE_FACTORY (
select * from (
select modelno,nvl(new_factory_name1,factory),nvl(new_brand_name1,brand) from tbl_goods left outer join tbl_rename_factory on factory = factory_name and brand = brand_name and tbl_rename_factory.ca_code = v_cate
where ca_lcode = v_cate and  mallcnt > 0 and cateflag = '0'  and jobcode > '0' and constrain = '1'
) a where modelno not in (select modelno from  TBL_GOODS_RE_FACTORY )          
          );
*/
          update TBL_GOODS_RE_FACTORY a set new_modelnm = (select modelnm from tbl_goods b where ca_lcode = v_cate and instr(modelnm,',') > 0 and a.modelno = b.modelno and b.cateflag = '0')
          where exists (select 1 from tbl_goods c where c.ca_lcode = v_cate and c.modelno = a.modelno);
        
        end loop;
      close cur01;
    end;    
    commit;
END UDP_GOODS_FACTORY_RENAME;