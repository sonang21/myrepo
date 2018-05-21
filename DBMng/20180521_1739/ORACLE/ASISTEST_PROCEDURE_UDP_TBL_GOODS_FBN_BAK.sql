/* *************************************************************************
 * NAME : ASISTEST.UDP_TBL_GOODS_FBN_BAK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_TBL_GOODS_FBN_BAK" AS
BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 1 and c_seqno > 0 ;
    begin
      open cur01;
        loop
          fetch cur01     
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;       
          execute immediate 'delete TBL_GOODS_RE_FACTORY_' || v_cate;
          execute immediate 'insert into TBL_GOODS_RE_FACTORY_' || v_cate || ' (select modelno,factory,brand,modelnm from tbl_goods where ca_lcode = ' || v_cate || ')';
          COMMIT;
        end loop;
      close cur01;
    end;   
END UDP_TBL_GOODS_FBN_BAK;