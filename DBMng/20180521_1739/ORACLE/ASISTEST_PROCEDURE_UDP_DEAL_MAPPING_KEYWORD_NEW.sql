/* *************************************************************************
 * NAME : ASISTEST.UDP_DEAL_MAPPING_KEYWORD_NEW
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:18
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEAL_MAPPING_KEYWORD_NEW" (v_keyword IN VARCHAR)
IS
  v_cate_keyword           VARCHAR2(100) :='';
  v_cnt                    NUMBER := 0;
BEGIN

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_DEAL_MAPPING_KEYWORD_NEW','START');
    COMMIT;
    
    --DELETE DEAL_MAPPING_KEYWORD WHERE DEAL_KEYWORD = v_keyword;
    --COMMIT;
    --UPDATE DEAL_GOODS SET DEAL_KEYWORD = '',USE_DEAL_KEYWORD = '' WHERE DEAL_KEYWORD = v_keyword ;
    --COMMIT;
    For tmp_loop in (SELECT A.DEAL_KEYWORD, B.CATEGORY_KEYWORD FROM TBL_DEAL_KEYWORD A,TBL_DEAL_CATEGORY B WHERE A.IS_USE = 'Y' AND A.DEAL_KEYWORD = v_keyword AND  A.KEYWORD_IDX = B.KEYWORD_IDX  ) LOOP
        v_cate_keyword := tmp_loop.CATEGORY_KEYWORD;
        FOR tmp_loop2 in (SELECT CP_ID FROM DEAL.D4_COUPON WHERE NVL(CP_USE_DEAL_KEYWORD,'N') <> 'Y'  AND to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between cp_startdate and cp_limitdate AND (INSTR(CP_NAME,v_keyword) > 0 OR INSTR(CP_DESCRIPT,v_keyword) > 0 OR INSTR(CP_DIVISION,v_keyword) > 0 OR INSTR(NVL(CP_SECTION1,''),v_keyword) > 0 OR INSTR(NVL(CP_SECTION2,''),v_keyword) > 0 OR INSTR(NVL(CP_SECTION3,''),v_keyword) > 0) AND (INSTR(NVL(CP_DIVISION,''),v_cate_keyword) > 0  OR INSTR(NVL(CP_SECTION1,''),v_cate_keyword) > 0 OR INSTR(NVL(CP_SECTION2,''),v_cate_keyword) > 0 OR INSTR(NVL(CP_SECTION3,''),v_cate_keyword) > 0 ) ) LOOP
            BEGIN
                v_cnt := 1;
                UPDATE DEAL.D4_COUPON SET CP_ETAG = v_keyword WHERE CP_ID = tmp_loop2.CP_ID;
                COMMIT;
                INSERT INTO DEAL_MAPPING_KEYWORD (MAPPING_IDX,DEAL_KEYWORD,DEAL_IDX) VALUES (SEQ_DEAL_KEYWORD.NEXTVAL,v_keyword,tmp_loop2.CP_ID);
                COMMIT;
            END;
        END LOOP;
    END LOOP;
    IF v_cnt = 0 THEN
        FOR tmp_loop2 in (SELECT CP_ID FROM DEAL.D4_COUPON WHERE NVL(CP_USE_DEAL_KEYWORD,'N') <> 'Y' AND to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between cp_startdate and cp_limitdate AND (INSTR(CP_NAME,v_keyword) > 0 OR INSTR(CP_DESCRIPT,v_keyword) > 0 OR INSTR(CP_DIVISION,v_keyword) > 0 OR INSTR(NVL(CP_SECTION1,''),v_keyword) > 0 OR INSTR(NVL(CP_SECTION2,''),v_keyword) > 0 OR INSTR(NVL(CP_SECTION3,''),v_keyword) > 0)  ) LOOP
            BEGIN
                UPDATE DEAL.D4_COUPON SET CP_ETAG = v_keyword WHERE CP_ID = tmp_loop2.CP_ID;
                COMMIT;
                INSERT INTO DEAL_MAPPING_KEYWORD (MAPPING_IDX,DEAL_KEYWORD,DEAL_IDX) VALUES ( SEQ_DEAL_KEYWORD.NEXTVAL,v_keyword,tmp_loop2.CP_ID);
                COMMIT;
            END;
        END LOOP;
   END IF;
   
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_DEAL_MAPPING_KEYWORD_NEW','END');
    COMMIT;
    
END UDP_DEAL_MAPPING_KEYWORD_NEW;