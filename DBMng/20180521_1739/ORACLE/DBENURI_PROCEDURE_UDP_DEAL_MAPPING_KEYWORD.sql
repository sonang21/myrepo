/* *************************************************************************
 * NAME : DBENURI.UDP_DEAL_MAPPING_KEYWORD
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEAL_MAPPING_KEYWORD" 
IS
  v_deal_keyword             VARCHAR2(100) :='';
  v_deal_division            VARCHAR2(100) :='';
  v_deal_division2            VARCHAR2(100) :='';
  v_deal_division3            VARCHAR2(100) :='';    
  v_deal_division4            VARCHAR2(100) :='';  
BEGIN
    DELETE DEAL_MAPPING_KEYWORD;
    
    For tmp_loop in (select DEAL_KEYWORD,DEAL_DIVISION,NVL(DEAL_DIVISION2,'결과없음!!!') DEAL_DIVISION2 ,NVL(DEAL_DIVISION3,'결과없음!!!') DEAL_DIVISION3,NVL(DEAL_DIVISION4,'결과없음!!!') DEAL_DIVISION4 from DEAL_KEYWORD) LOOP
        v_deal_keyword := tmp_loop.DEAL_KEYWORD;
        v_deal_division := tmp_loop.DEAL_DIVISION;
        v_deal_division2 := tmp_loop.DEAL_DIVISION2;
        v_deal_division3 := tmp_loop.DEAL_DIVISION3;
        v_deal_division4 := tmp_loop.DEAL_DIVISION4;                        
        FOR tmp_loop2 in (SELECT DEAL_IDX FROM DEAL_GOODS WHERE (INSTR(TITLE,v_deal_keyword) > 0 OR INSTR(DESCRIPTION,v_deal_keyword) > 0 OR INSTR(DIVISION,v_deal_keyword) > 0 OR INSTR(NVL(SECTION3,''),v_deal_keyword) > 0) AND (INSTR(NVL(DIVISION,''),v_deal_division) > 0  OR INSTR(NVL(DIVISION,''),v_deal_division2) > 0 OR INSTR(NVL(DIVISION,''),v_deal_division3) > 0 OR INSTR(NVL(DIVISION,''),v_deal_division4) > 0 ) ) LOOP
            BEGIN
                UPDATE DEAL_GOODS SET DEAL_KEYWORD = v_deal_keyword WHERE DEAL_IDX = tmp_loop2.DEAL_IDX;
                INSERT INTO DEAL_MAPPING_KEYWORD (MAPPING_IDX,DEAL_KEYWORD,DEAL_IDX) VALUES ((SELECT NVL(MAX(MAPPING_IDX),0)+1 FROM DEAL_MAPPING_KEYWORD),v_deal_keyword,tmp_loop2.DEAL_IDX);
            END;
        END LOOP;
    END LOOP;
    COMMIT;

END UDP_DEAL_MAPPING_KEYWORD;