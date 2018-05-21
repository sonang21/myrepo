/* *************************************************************************
 * NAME : DBENURI.UDP_SOCIAL_MINPRICE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-10 15:11:28
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_SOCIAL_MINPRICE" 
IS
/*
 NGIT ���� �ݿ� - �迵�� 20180510
*/ 
social_minprice    NUMBER(10) := 0;
BEGIN

    --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SOCIAL_MINPRICE','START');
  COMMIT;
    
  --=======================================================================
  --�Ϻ� ���� ���̺� ����
  --=======================================================================
  
  FOR tmp_loop in (select distinct modelno
                     from tbl_cate_goods c
                    where c.ca_code like '8701%'
  ) LOOP

        BEGIN
            SELECT NVL(MIN(price),0) 
              INTO social_minprice
              FROM tbl_pricelist 
             WHERE modelno=tmp_loop.modelno
               AND status in ('0','8','9')
               AND srvflag in ('0','L','S')
               AND NVL(option_flag2,'0') = '2'
               AND NVL(solddate,sysdate) >= sysdate; 

        EXCEPTION WHEN OTHERS THEN
                social_minprice := 0;
        END;

        UPDATE tbl_goods_sum
           SET socialprice = social_minprice
         WHERE modelno=tmp_loop.modelno
           AND NVL(socialprice,0) <> social_minprice;

        COMMIT;

  END LOOP;
  COMMIT;

    --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SOCIAL_MINPRICE','END');
  COMMIT;
    
END UDP_SOCIAL_MINPRICE;
