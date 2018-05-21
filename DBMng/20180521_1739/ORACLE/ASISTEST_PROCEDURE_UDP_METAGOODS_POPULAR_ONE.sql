/* *************************************************************************
 * NAME : ASISTEST.UDP_METAGOODS_POPULAR_ONE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:28
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_METAGOODS_POPULAR_ONE" (v_modelno IN NUMBER)
IS

BEGIN
    --UPDATE TBL_META_GOODS_NEW SET POPULAR = (NVL(SALE_COUNT,0)  + nvl((SELECT NVL(HIT_CNT,0)+NVL(MOVE_CNT,0)  FROM TBL_META_GOODS_NEW_LOG  WHERE MODELNO = v_modelno and LOG_DATE = TO_CHAR(sysdate,'YYYYMMDD')),0))  where MODELNO = v_modelno;
    UPDATE TBL_META_GOODS_NEW SET POPULAR = 
        (
            (NVL(SALE_COUNT,0)  + nvl((SELECT NVL(HIT_CNT,0)+NVL(MOVE_CNT,0)  FROM TBL_META_GOODS_LOG_NEW  WHERE MODELNO = v_modelno and LOG_DATE = TO_CHAR(sysdate,'YYYYMMDD')),0))
            *
            (select case when  REG_DATE    >= TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD')) then 1.5 else 1 end from TBL_META_GOODS_NEW where modelno = v_modelno)  
         )
    where MODELNO = v_modelno;
    UPDATE TBL_META_GOODS_NEW SET POPULAR = 0 where MODELNO = v_modelno  and SALE_COUNT >= MAX_COUNT; 
    commit;
END UDP_METAGOODS_POPULAR_ONE;