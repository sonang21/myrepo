/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_PRINT_FACTORY
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-10 16:26:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_PRINT_FACTORY" 
IS
/*
 NGIT 수정 반영 - 김영원 20180502
*/ 
    v_cur_time           NUMBER(2) :=0; 

BEGIN
    
    SELECT to_number(to_char(sysdate,'HH24')) INTO v_cur_time FROM dual;
    
    IF v_cur_time >= 8 AND v_cur_time <= 21 THEN
    
        DELETE TBL_GOODS_PRINT_FACTORY;
        
        INSERT INTO TBL_GOODS_PRINT_FACTORY
        
        SELECT MAX(factory) factory, MAX(ca_code) ca_code, modelnm, MAX(modelno) modelno, MAX(popular) popular, MAX(c_seqno) c_seqno FROM (
        SELECT a.factory, substr(c.ca_code, 0,6) ca_code, replace(modelnm,'[' || condiname || ']','') modelnm, a.modelno, b.popular,
            (SELECT c_seqno FROM TBL_CATEGORY WHERE ca_code =  SUBSTR(c.ca_code, 0,6)) c_seqno
                FROM TBL_GOODS a, TBL_GOODS_SUM b, TBL_CATE_GOODS c
               WHERE a.modelno = b.modelno
                 AND a.modelno = c.modelno
                 AND a.modelno in
                    ( SELECT su_modelno FROM TBL_GOODS_SUPPLY
                        WHERE modelno in
                            ( SELECT distinct aa.modelno
                                FROM TBL_GOODS aa, TBL_GOODS_SUM bb, TBL_CATE_GOODS cc
                               WHERE aa.modelno = bb.modelno
                                 AND aa.modelno = cc.modelno
                                 AND cc.ca_code like '040207%'
                                 AND aa.jobcode > 0
                                 AND aa.constrain = '1'
                                 and bb.mallcnt > 0
                                 and cc.ca_lcode='04'
                                 AND bb.minprice > 0
                            )
                    )
           )
        WHERE ca_code in ('040209','040210','040206','040203','040201','040202','040220')
        GROUP BY modelnm
        ORDER BY factory,c_seqno,modelnm;
        COMMIT;
        
   END IF;
    
END UDP_GOODS_PRINT_FACTORY;
