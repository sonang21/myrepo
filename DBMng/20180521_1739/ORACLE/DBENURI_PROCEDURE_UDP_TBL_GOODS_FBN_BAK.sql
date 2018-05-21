/* *************************************************************************
 * NAME : DBENURI.UDP_TBL_GOODS_FBN_BAK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-08 19:06:11
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_TBL_GOODS_FBN_BAK" AS
/*
 NGIT 수정 반영 - 김영원 20180508
*/ 
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
