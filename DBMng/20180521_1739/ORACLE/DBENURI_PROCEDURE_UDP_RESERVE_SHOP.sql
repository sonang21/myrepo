/* *************************************************************************
 * NAME : DBENURI.UDP_RESERVE_SHOP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 13:07:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_RESERVE_SHOP" AS
/*
 NGIT 수정 반영 - 김영원 20180508
*/ 
BEGIN

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_RESERVE_SHOP','START');
    COMMIT;
    
  declare
   v_cate varchar2(12);
   v_modelno number(8);
   v_result char(1) := '0';
   v_exists char(1) := '0';
   i_count  NUMBER := 0;
       
    cursor cur01 is
      select ca_code from tbl_category where c_level = 1 and c_seqno > 0 order by ca_code;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
                    
          i_count := 0;
          FOR tmp_loop in
                (select  modelno from tbl_cate_goods where ca_code like v_cate||'%') 
            LOOP
            v_modelno := tmp_loop.modelno;
            BEGIN
              SELECT '1'  INTO v_result FROM TBL_PRICELIST
              WHERE modelno = v_modelno
              AND status IN ('0','8','9')
              AND srvflag in ('0','L','R')
              AND NVL(option_flag2,'0') = '0'
              AND esstockflag = '0'
              AND shop_code IN (4027,536,5910,55,806,75,6641,47,374,6665)
              AND ROWNUM = 1;            
            EXCEPTION WHEN OTHERS THEN
              v_result := '0';
            END;
            if v_result = '1' then
              begin
                select '1' into v_exists from TBL_GOODS_CHANGE where modelno = v_modelno;
              EXCEPTION WHEN OTHERS THEN
                v_exists := '0';
              END;              
              if v_exists = '1' then
                update TBL_GOODS_CHANGE set is_reserve = '1' where modelno = v_modelno;
              else 
                insert into TBL_GOODS_CHANGE (modelno,is_reserve) values (v_modelno,'1');
              end if;
            else
              begin
                select '1' into v_exists from TBL_GOODS_CHANGE where modelno = v_modelno;
              EXCEPTION WHEN OTHERS THEN
                v_exists := '0';
              END;              
              if v_exists = '1' then
                update TBL_GOODS_CHANGE set is_reserve = '0' where modelno = v_modelno;
              else 
                insert into TBL_GOODS_CHANGE (modelno,is_reserve) values (v_modelno,'0');
              end if;          
            end if;
            
            i_count := i_count + 1;
            
            IF i_count = 100 THEN
              COMMIT;
              i_count := 0;
            END IF;

          end loop;
          COMMIT;
          
        end loop;
      close cur01;
    end;    
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_RESERVE_SHOP','END');
    COMMIT;
    
END UDP_RESERVE_SHOP;
