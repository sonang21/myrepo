/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_BBS_MODEL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:24
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_BBS_MODEL" 
IS 
 
v_cur_time      NUMBER(2) :=0; 
v_str           VARCHAR2(4000) := '';

 
BEGIN 
    --SET SERVEROUTPUT ON  
    --DBMS_OUTPUT.ENABLE; 
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......1'); 
    SELECT to_number(to_char(sysdate,'HH24')) INTO v_cur_time FROM dual;
    
    --IF v_cur_time >= 6 AND v_cur_time <= 23 THEN
    
        --v_str := 'truncate table TBL_GOODS_BBS_MODEL';
        --EXECUTE IMMEDIATE v_str;
        
        DELETE /*+APPEND NOLOGGING TBL_GOODS_BBS_MODEL */ TBL_GOODS_BBS_MODEL;
        
        INSERT INTO TBL_GOODS_BBS_MODEL 
        
        SELECT B.CA_MCODE,B.MODELNO,B.REGDATE
        FROM TBL_GOODS A,
        (SELECT CA_MCODE,MODELNO,REGDATE
        FROM (
        SELECT CA_MCODE,NVL(MODELNO_GROUP,MODELNO) MODELNO, MAX(REGDATE) REGDATE
        FROM TBL_GOODS_BBS
        WHERE DELFLAG='N'   
        GROUP BY CA_MCODE,NVL(MODELNO_GROUP,MODELNO)
        )
        ) B
        WHERE A.MODELNO=B.MODELNO
        AND A.CATEFLAG='0'
        AND A.CONSTRAIN='1'
        AND A.JOBCODE>'0';
        /*
        SELECT CA_MCODE,NVL(MODELNO_GROUP,MODELNO) MODELNO, MAX(REGDATE) REGDATE
        FROM TBL_GOODS_BBS
        WHERE DELFLAG='N'
        GROUP BY CA_MCODE,NVL(MODELNO_GROUP,MODELNO)
        ORDER BY REGDATE DESC,MODELNO DESC,CA_MCODE DESC;
        */
        COMMIT; 
        
   --END IF;
     
END UDP_GOODS_BBS_MODEL;