/* *************************************************************************
 * NAME : DBENURI.UDP_PRICELIST_DANAWA_BATCH_INS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 12:56:21
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_PRICELIST_DANAWA_BATCH_INS" 
IS
/*
 NGIT 수정 반영 - 김영원 20180502
*/ 
    v_exist char(1) := '';
    i_count      NUMBER := 0;

BEGIN
  --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICELIST_DANAWA_BATCH_INS','START');
  COMMIT;
    
	-- 미니봇, CTU로그 중 10번 이상 가격변경된 상품코드 일괄입력 데이터는 2일 보관.
	delete from tbl_pricelist_danawa where flag in ('1','2') ;
    --and regdate < trunc(sysdate-1);
  COMMIT;
  
	-- pricelist에서 삭제된 데이터는 삭제.
	delete from tbl_pricelist_danawa a where exists (select 1 from tbl_pricelist b where a.shop_code=b.shop_code and a.goodscode = b.goodscode group by b.shop_code having max(status) = '5');
  COMMIT;
  
  i_count := 0;
  FOR tmp_loop in (select shop_code, goodscode, 'i' as i_or_u
                    from tbl_mini_nuribot_log
                    WHERE REGDATE >= trunc(sysdate-1) AND REGDATE < trunc(sysdate)
                    AND logo_type IN ('1','5')
                    AND error_code IN ('0', '9')
                    and goodscode is not null
                    group by shop_code, goodscode
                    having count(*) >=15)
    LOOP
    
    BEGIN
            
            v_exist :='';
            
                insert into tbl_pricelist_danawa (shop_code, goodscode, regdate, flag)
                values (tmp_loop.shop_code,tmp_loop.goodscode,sysdate,'1'); 
                   
                
    END;
 
  END LOOP;
  
  COMMIT;    
    
  --====================================================================================
  --품절 데이타
  --====================================================================================
  
  FOR tmp_loop in (
    
        select substr(a.ca_code,0,4) ca_mcode
        from tbl_mini_nuribot_log a, tbl_goods b
        WHERE a.modelno=b.modelno
      --  AND b.cateflag='0'
        and a.logo_type IN('1','3') and error_code IN ('9')
        and a.goodscode is not null
        and a.shop_code IN (47,49,55,57,75,90,536,663,806,4027,5910,6508,6547,6588,6620,6641)
        AND a.modelno > 0
        AND a.ca_code IS NOT NULL
        group by substr(a.ca_code,0,4)
        order by ca_mcode

        )
    LOOP
    
    BEGIN
        
        v_exist :='';            
        
        FOR tmp_loop2 in (
                
            select shop_code, goodscode FROM tbl_mini_nuribot_log
            WHERE modelno IN 
            (
                SELECT modelno FROM (
                SELECT modelno,rownum rnum
                  FROM (SELECT a.modelno
                          FROM TBL_GOODS a, TBL_GOODS_SUM b
                         WHERE a.modelno = b.modelno
                           AND a.ca_code LIKE tmp_loop.ca_mcode || '%'
                           AND b.mallcnt > 0
                           AND a.constrain='1'
                           AND a.jobcode > '0'
                         ORDER BY b.popular DESC
                ))
                WHERE rnum <= 300
            )
            and logo_type IN('1','3') and error_code IN ('9')
            and goodscode is not null
            and shop_code IN (47,49,55,57,75,90,536,663,806,4027,5910,6508,6547,6588,6620,6641)
            AND modelno > 0
            GROUP BY shop_code, goodscode
            
            )
        LOOP            
        
            insert into tbl_pricelist_danawa (shop_code, goodscode, regdate, flag)
            values (tmp_loop2.shop_code,tmp_loop2.goodscode,sysdate,'2'); 
           
        END LOOP;                
    END;
  END LOOP;
  
  COMMIT;    

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICELIST_DANAWA_BATCH_INS','END');
    COMMIT;
    
END UDP_PRICELIST_DANAWA_BATCH_INS;
