/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_PRINT_FACTORY
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_PRINT_FACTORY" 
IS

    v_cur_time           NUMBER(2) :=0; 

BEGIN
    --SET SERVEROUTPUT ON 
    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......1');

    
    --WHILE i < 3 LOOP
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......' || ca_mlists(i) ||'%');
    
    SELECT to_number(to_char(sysdate,'HH24')) INTO v_cur_time FROM dual;
    
    IF v_cur_time >= 8 AND v_cur_time <= 21 THEN
    
        DELETE TBL_GOODS_PRINT_FACTORY;
        
        INSERT INTO TBL_GOODS_PRINT_FACTORY
        
        
        SELECT MAX(factory) factory, MAX(ca_code) ca_code, modelnm, MAX(modelno) modelno, MAX(popular) popular, MAX(c_seqno) c_seqno FROM (
        SELECT factory, substr(ca_code, 0,6) ca_code, replace(modelnm,'[' || condiname || ']','') modelnm, modelno,popular,
            (SELECT c_seqno FROM TBL_CATEGORY WHERE ca_code =  SUBSTR(TBL_GOODS.ca_code, 0,6)) c_seqno
                FROM TBL_GOODS
                WHERE modelno in
                    ( SELECT su_modelno FROM TBL_GOODS_SUPPLY
                        WHERE modelno in
                            ( SELECT distinct modelno FROM TBL_GOODS
                                WHERE TBL_GOODS.ca_code like '040207%'
                                AND jobcode > 0
                                AND constrain = '1'
                                and mallcnt > 0
                                and ca_lcode='04'
                                AND minprice > 0
                            )
                    )
                --AND (condiname like '%잉크포함%' or condiname like '%토너포함%' or condiname is null)
           )
        WHERE ca_code in ('040209','040210','040206','040203','040201','040202','040220')
        GROUP BY modelnm
        ORDER BY factory,c_seqno,modelnm;
        COMMIT;
        
   END IF;
    
END UDP_GOODS_PRINT_FACTORY;