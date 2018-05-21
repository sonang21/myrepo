/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_BBS_GROUP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 16:55:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_BBS_GROUP" 
IS
/*
 NGIT 수정 반영 - 김영원 20180426
*/
 v_modelno tbl_goods.modelno%TYPE := 0;
 i_count      NUMBER := 0;

BEGIN

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_BBS_GROUP','START');
    COMMIT;

  --=======================================================================
  --일별 집계 테이블 생성
  --=======================================================================
  i_count := 0;
  FOR tmp_loop in (SELECT distinct a.modelno,
                          nvl(b.modelno_group,0) modelno_group
                     FROM TBL_GOODS_BBS a, TBL_GOODS b 
                    WHERE a.modelno = b.modelno
                      AND a.delflag='N'
                      AND b.jobcode>'0'
                      AND b.constrain='1'
                      AND NVL(a.modelno_group,0) <> NVL(b.modelno_group,0))
  LOOP

    BEGIN
      IF tmp_loop.modelno_group=0 THEN
          UPDATE TBL_GOODS_BBS SET MODELNO_GROUP = NULL WHERE modelno = tmp_loop.modelno AND MODELNO_GROUP IS NOT NULL;
      ELSE
          UPDATE TBL_GOODS_BBS SET MODELNO_GROUP = tmp_loop.modelno_group WHERE modelno = tmp_loop.modelno;
      END IF;

     EXCEPTION WHEN OTHERS THEN
     COMMIT;
     
      i_count := i_count + 1;
    END;
    
    IF i_count = 100 THEN
      COMMIT;
      i_count := 0;
    END IF;
  
  END LOOP;
  
  COMMIT;
  --================================
  --중복/공백 데이타 삭제
  -- Lock 현상으로 인한 주석 처리 하기로 함(이성만, 김병욱)
  -- 하루 전 데이터만 검사하여 삭제 처리 하도록 수정 함.
  --================================
   delete tbl_goods_bbs a
    where a.regdate >= to_char((sysdate - 1), 'YYYY-MM-DD') 
      and rowid < (select max(rowid)
                     from tbl_goods_bbs b
                    where b.regdate >= to_char((sysdate - 1), 'YYYY-MM-DD') 
                      and a.contents=b.contents
                      and a.modelno=b.modelno 
                      and nvl(b.shop_code,0) > 0)
      and nvl(a.shop_code,0) > 0;
   COMMIT;
  
   delete tbl_goods_bbs
    where contents is null;
   COMMIT;
  --================================
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_BBS_GROUP','END');
    COMMIT;
    
END UDP_GOODS_BBS_GROUP;
