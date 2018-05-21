/* *************************************************************************
 * NAME : DEAL.COUPON_CR_JCA
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 16:53:35
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_CR_JCA" AS 
BEGIN
declare
  v_meta_id varchar2(255);
  v_shop_code number(11);
  cursor cur01 is 
    select deal_shop_code,meta_id from dbenuri.deal_goods where end_at >= sysdate and (from_jca = 'Y' or from_jca = 'C') and deal_shop_code <> 7692; 
    begin
      open cur01;
      loop
        fetch cur01
          into v_shop_code
              ,v_meta_id;
          if cur01%notfound
            then
            exit;
          end if; 
          dbms_output.put_line('v_shop_code=' || v_shop_code || ' ' || 'v_meta_id=' || v_meta_id);
          COUPON_CR_ONE(v_shop_code,trim(v_meta_id));
      end loop;
      close cur01;
    end;    
    CATEGORY_SUM_ALL('YES');
END COUPON_CR_JCA;