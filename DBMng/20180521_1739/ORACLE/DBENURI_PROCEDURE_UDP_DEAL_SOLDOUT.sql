/* *************************************************************************
 * NAME : DBENURI.UDP_DEAL_SOLDOUT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEAL_SOLDOUT" (v_shop_code number,v_meta_id varchar2)
IS
cnt NUMBER;

BEGIN
    SELECT COUNT(*) INTO cnt FROM DEAL_GOODS WHERE DEAL_SHOP_CODE = v_shop_code AND META_ID = v_meta_id;
    IF  cnt > 0  THEN
        update deal_goods set FORCE_SALE_OUT = 'Y', END_AT = SYSDATE-1/24 where deal_shop_code = v_shop_code and meta_id = v_meta_id;
        commit;
    ELSE
        insert into deal_goods (select * from deal_goods_history where deal_shop_code = v_shop_code and meta_id = v_meta_id);
        delete from deal_goods_history where deal_shop_code = v_shop_code and meta_id = v_meta_id;
        update deal_goods set FORCE_SALE_OUT = 'Y', END_AT = SYSDATE-1/24 where deal_shop_code = v_shop_code and meta_id = v_meta_id;
        COMMIT;    
    END IF;
END;