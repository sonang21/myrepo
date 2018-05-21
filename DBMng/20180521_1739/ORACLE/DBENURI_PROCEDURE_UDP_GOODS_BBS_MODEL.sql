/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_BBS_MODEL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 16:57:25
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_BBS_MODEL" 
IS 
/*
 NGIT 수정 반영 - 김영원 20180426
*/
v_cur_time      NUMBER(2) :=0; 

BEGIN 

    SELECT to_number(to_char(sysdate,'HH24')) INTO v_cur_time FROM dual;
        
        DELETE /*+APPEND NOLOGGING TBL_GOODS_BBS_MODEL */ TBL_GOODS_BBS_MODEL;
        
        INSERT INTO TBL_GOODS_BBS_MODEL 
        
        SELECT B.CA_MCODE,B.MODELNO,B.REGDATE
          FROM TBL_GOODS A,
               (SELECT CA_MCODE,MODELNO,REGDATE
                  FROM (SELECT CA_MCODE,
                               NVL(MODELNO_GROUP,MODELNO) MODELNO, 
                               MAX(REGDATE) REGDATE
                          FROM TBL_GOODS_BBS
                         WHERE DELFLAG='N'   
                         GROUP BY CA_MCODE,NVL(MODELNO_GROUP,MODELNO)
                       )
               ) B
         WHERE A.MODELNO=B.MODELNO
           AND A.CONSTRAIN='1'
           AND A.JOBCODE>'0';

        COMMIT; 
     
END UDP_GOODS_BBS_MODEL;
