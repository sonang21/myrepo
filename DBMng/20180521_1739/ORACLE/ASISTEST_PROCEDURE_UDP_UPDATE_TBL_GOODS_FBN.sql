/* *************************************************************************
 * NAME : ASISTEST.UDP_UPDATE_TBL_GOODS_FBN
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_UPDATE_TBL_GOODS_FBN" AS
BEGIN
  declare
   v_modelno tbl_goods.modelno%TYPE;
   v_factory tbl_goods.factory%TYPE;
   v_brand tbl_goods.brand%TYPE;
   v_modelnm TBL_GOODS.MODELNM%TYPE;
    cursor cur01 is
      select modelno,new_factory,new_brand,new_modelnm from TBL_GOODS_RE_FACTORY_DIFF ;
    begin
      open cur01;
        loop
          fetch cur01   
          into v_modelno,v_factory,v_brand,v_modelnm;
          if cur01%notfound
            then
            exit;
          end if;     
          update tbl_goods a set factory = v_factory,brand = v_brand,modelnm = v_modelnm  where modelno = v_modelno ;
          insert into TBL_GOODS_RE_FACTORY_COUNT values (v_modelno);
          COMMIT;
        end loop;
      close cur01;
    end; 
END UDP_UPDATE_TBL_GOODS_FBN;