/* *************************************************************************
 * NAME : DBENURI.UDP_AUTO_COMPARE_LOG
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_AUTO_COMPARE_LOG" 
IS

i_count     NUMBER := 0;

BEGIN

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_AUTO_COMPARE_LOG','START');
    COMMIT;

FOR tmp_basic in (select count(user_ip) real_cnt from tbl_auto_compare_log where reg_date = to_char(sysdate-1,'YYYYMMDD')) LOOP

    BEGIN
     
        IF tmp_basic.real_cnt > 0 THEN

            FOR tmp_loop in 
                (select (select count(modelno1) from (select distinct modelno1, user_ip from tbl_auto_compare_log where reg_date = to_char(sysdate-1,'YYYYMMDD')))
                        / (select count(user_ip) from (select distinct user_ip from tbl_auto_compare_log where reg_date = to_char(sysdate-1,'YYYYMMDD'))) v_cnt, 
                        (select count(modelno1) from (select distinct modelno1, user_ip 
                        from tbl_auto_compare_log 
                        where reg_date = to_char(sysdate-1,'YYYYMMDD'))) v_compare  
                 from tbl_auto_compare_log where rownum = 1) 
            LOOP

                BEGIN
                
                    IF tmp_loop.v_cnt <= 2 THEN
                        i_count  := 2;
                    ELSIF tmp_loop.v_cnt > 2 AND tmp_loop.v_cnt <= 6 THEN
                        i_count  := 3;
                    ELSIF tmp_loop.v_cnt > 6 AND tmp_loop.v_cnt <= 12 THEN
                        i_count  := 4;
                    ELSIF tmp_loop.v_cnt > 12 AND tmp_loop.v_cnt <= 20 THEN
                        i_count  := 5;
                    ELSIF tmp_loop.v_cnt > 20 AND tmp_loop.v_cnt <= 30 THEN
                        i_count  := 6;
                    ELSIF tmp_loop.v_cnt > 30 AND tmp_loop.v_cnt <= 42 THEN
                        i_count  := 7;
                    ELSIF tmp_loop.v_cnt > 42 AND tmp_loop.v_cnt <= 56 THEN
                        i_count  := 8;
                    ELSIF tmp_loop.v_cnt > 56 AND tmp_loop.v_cnt <= 72 THEN
                        i_count  := 9;
                    ELSIF tmp_loop.v_cnt > 72 THEN
                        i_count  := 10;
                    END IF;

                    DELETE TBL_AUTO_COMPARE_LOG_DATE WHERE REG_DATE = to_char(sysdate-1,'YYYYMMDD');
                    COMMIT;
                    INSERT INTO TBL_AUTO_COMPARE_LOG_DATE(REG_DATE, CNT, MODEL_CNT) VALUES(to_char(sysdate-1,'YYYYMMDD'),tmp_loop.v_compare,i_count);
                    COMMIT;
               --// 1-1 data inert end
              --EXCEPTION WHEN OTHERS THEN

                END;
            END LOOP;
         
            DELETE TBL_AUTO_COMPARE_LOG_BASIC WHERE REG_DATE = to_char(sysdate-1,'YYYYMMDD');
            COMMIT;
            DELETE TBL_AUTO_COMPARE_LOG_SUB WHERE REG_DATE = to_char(sysdate-1,'YYYYMMDD');
            COMMIT;
         
            FOR tmp_loop1 in (select count(modelno1) v_cnt, modelno1 from (select distinct modelno1, user_ip from tbl_auto_compare_log where reg_date = to_char(sysdate-1,'YYYYMMDD') order by modelno1)
                group by modelno1 order by count(modelno1) desc) LOOP

                BEGIN

                    INSERT INTO TBL_AUTO_COMPARE_LOG_BASIC VALUES(to_char(sysdate-1,'YYYYMMDD'),tmp_loop1.modelno1, tmp_loop1.v_cnt);
                    COMMIT;
                     --// 2-1 data inert

                    FOR tmp_loop2 in (select modelno1, modelno2, count(modelno2) v_cnt2 from (select modelno1, modelno2 from tbl_auto_compare_log 
                        where modelno1 = tmp_loop1.modelno1 and  reg_date = to_char(sysdate-1,'YYYYMMDD'))
                        group by modelno1, modelno2 order by v_cnt2 desc) LOOP

                        BEGIN

                             --DBMS_OUTPUT.ENABLE;
                             --DBMS_OUTPUT.PUT_LINE('tmp_loop1.modelno1--' || tmp_loop1.modelno1 || '==' || tmp_loop2.modelno2);
                             INSERT INTO TBL_AUTO_COMPARE_LOG_SUB(reg_date,modelno1,modelno2,sub_cnt) VALUES(to_char(sysdate-1,'YYYYMMDD'),tmp_loop1.modelno1, tmp_loop2.modelno2, tmp_loop2.v_cnt2);
                             --DBMS_OUTPUT.PUT_LINE('-----------------');

                             --// 2-1 data inert
                             COMMIT;
                 
                        END;
                    END LOOP;

                END;
            END LOOP;
        END IF;
    END;
END LOOP;

--sysdate-30
DELETE TBL_AUTO_COMPARE_LOG WHERE REG_DATE = to_char(sysdate-30,'YYYYMMDD');
COMMIT;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_AUTO_COMPARE_LOG','END');
    COMMIT;
    
END UDP_AUTO_COMPARE_LOG;