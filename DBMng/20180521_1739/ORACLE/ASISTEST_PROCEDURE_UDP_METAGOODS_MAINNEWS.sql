/* *************************************************************************
 * NAME : ASISTEST.UDP_METAGOODS_MAINNEWS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:28
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_METAGOODS_MAINNEWS" 
IS

BEGIN
    UPDATE TBL_META_GOODS_NEW SET MAIN_NEWS = 'Y' WHERE MODELNO IN
    (
        SELECT MODELNO FROM(
            SELECT ROWNUM NUM , MODELNO FROM (
                SELECT MODELNO FROM TBL_META_GOODS_NEW WHERE DEAL_STATUS = '1' ORDER BY POPULAR DESC
        ) ) WHERE NUM <= 10
    );
    commit;
END;