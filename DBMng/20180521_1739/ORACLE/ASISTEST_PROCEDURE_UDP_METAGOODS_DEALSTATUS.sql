/* *************************************************************************
 * NAME : ASISTEST.UDP_METAGOODS_DEALSTATUS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:28
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_METAGOODS_DEALSTATUS" 
IS
v_cur_time           NUMBER(2) :=0; 
BEGIN
    SELECT to_number(to_char(sysdate,'HH24')) INTO v_cur_time FROM dual;
    IF v_cur_time >= 7 AND v_cur_time <= 21 THEN
        UPDATE TBL_META_GOODS_NEW SET DEAL_STATUS = '2' WHERE PRODUCT_SDATE > SYSDATE;
        UPDATE TBL_META_GOODS_NEW SET DEAL_STATUS = '1' WHERE PRODUCT_SDATE <= SYSDATE AND PRODUCT_EDATE >= SYSDATE;  
        UPDATE TBL_META_GOODS_NEW SET DEAL_STATUS = '3' WHERE PRODUCT_EDATE < SYSDATE;
        UPDATE TBL_META_GOODS_NEW SET DEAL_STATUS = '4' WHERE FORCED_SOLDOUT = 'Y';    
        commit;
    END IF;
END UDP_METAGOODS_DEALSTATUS;