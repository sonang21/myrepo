/* *************************************************************************
 * NAME : DBADM.FN_SEC_TO_TIME
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-27 20:22:55
 *        Modify: 2018-04-03 13:27:49
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBADM"."FN_SEC_TO_TIME" (P_SEC NUMBER) RETURN VARCHAR2
AS
    V_TIME VARCHAR2(10);
BEGIN
    IF P_SEC IS NULL THEN
        V_TIME := NULL;
    ELSE
        V_TIME := TO_CHAR(TRUNC(P_SEC/3600), 'FM00')
                  ||':'||TO_CHAR(TRUNC(MOD(P_SEC, 3600) / 60), 'FM00')
                  ||':'||TO_CHAR(TRUNC(MOD(P_SEC, 60  )     ), 'FM00');
    END IF;
    
    RETURN V_TIME;
END;