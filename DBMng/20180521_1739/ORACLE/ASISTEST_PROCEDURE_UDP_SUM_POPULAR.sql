/* *************************************************************************
 * NAME : ASISTEST.UDP_SUM_POPULAR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SUM_POPULAR" (
  	v_modelno   IN  NUMBER,
  	v_part      IN  varchar2,
    result_code IN OUT VARCHAR2,
    result_desc IN OUT VARCHAR2,
    startTime   IN OUT VARCHAR2,
    endTime     IN OUT VARCHAR2)
IS
    tmp_modelno     number := 0;
    i_count         NUMBER := 0;
    tmp_start       VARCHAR2(100) := '';
    tmp_end         VARCHAR2(100) := '';
    v_totcnt        NUMBER := 0;
    v_uptotcnt      NUMBER := 0;
    v_upcheckcnt    NUMBER := 0;
    v_logcnt        NUMBER := 0;

BEGIN
    --set serveroutput on;
    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('UDP_SUM_POPULAR start ......');

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SUM_POPULAR','START');
    COMMIT;
    
    SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
       INTO tmp_start
       FROM DUAL;

    startTime := startTime || '|4 : ' || tmp_start;

    i_count := 0;

        FOR tmp_loop in (SELECT distinct modelno,imgchk_rolling FROM TBL_GOODS g WHERE modelno_group = modelno AND modelno_group > 0 
        --AND ca_code LIKE '1803%'
        ) LOOP

          tmp_modelno := tmp_loop.modelno;
          v_totcnt := v_totcnt + 1;

          BEGIN

             UPDATE TBL_GOODS SET sum_popular =                
               (SELECT SUM(popular) FROM (
                SELECT NVL(popular,0) as popular FROM TBL_GOODS
                WHERE modelno_group  = tmp_loop.modelno
                AND jobcode > 0 AND mallcnt > 0 AND constrain = '1'
                AND cateflag='0' order by popular desc)
               WHERE ROWNUM <= 3),
               
               /*
               sum_sale_cnt = 
               (SELECT SUM(sale_cnt) FROM (
               SELECT NVL(sale_cnt,0) as sale_cnt FROM TBL_GOODS
               WHERE modelno_group  = tmp_loop.modelno
               AND jobcode > 0 AND mallcnt > 0 AND constrain = '1'
               AND cateflag='0' order by popular desc)
               WHERE ROWNUM <= 3),
               */
               
               sum_sale_cnt = 
               (SELECT SUM(NVL(sale_cnt,0)) FROM TBL_GOODS
               WHERE modelno_group  = tmp_loop.modelno
               AND jobcode > 0 AND mallcnt > 0 AND constrain = '1'
               AND cateflag='0'),               
               height=tmp_loop.imgchk_rolling
               
             WHERE modelno_group = tmp_loop.modelno;
             
              COMMIT;

              v_uptotcnt := v_uptotcnt + 1;
              i_count := i_count + 1;
              v_upcheckcnt := v_upcheckcnt + 1;

      		EXCEPTION WHEN OTHERS THEN

          	COMMIT;

          END;
          /*
          IF v_upcheckcnt > 5 THEN
            v_upcheckcnt := 0;
            LOOP
                select count(*) into v_logcnt from mlog$_tbl_goods;
                IF v_logcnt < 10000 THEN
                    EXIT;
                ELSE
                    FOR i_temp IN 1 .. 100000 LOOP
                        endTime := ' ';
                    END LOOP;
                END IF;
                --EXIT WHEN v_logcnt < 10000;
            END LOOP;
          END IF;
          */
          --IF i_count = 5 THEN
          --	COMMIT;
          -- 	i_count := 0;
       	  --END IF;

       	END LOOP;

       	COMMIT;
        
        --================================================================================================================
        FOR tmp_loop in (SELECT distinct modelno FROM TBL_GOODS g 
            WHERE modelno_group IS NULL AND ca_lcode ='15' AND ca_code LIKE '15%'  AND NVL(sum_popular,0) <> NVL(popular,0)) LOOP

          tmp_modelno := tmp_loop.modelno;
          v_totcnt := v_totcnt + 1;

          BEGIN

             UPDATE TBL_GOODS SET sum_popular = popular 
             WHERE modelno=tmp_loop.modelno
             AND sum_popular <> popular;               

              COMMIT;

              v_uptotcnt := v_uptotcnt + 1;
              i_count := i_count + 1;
              v_upcheckcnt := v_upcheckcnt + 1;

      		EXCEPTION WHEN OTHERS THEN

          	COMMIT;

          END;
          /*
          IF v_upcheckcnt > 5 THEN
            v_upcheckcnt := 0;
            LOOP
                select count(*) into v_logcnt from mlog$_tbl_goods;
                IF v_logcnt < 10000 THEN
                    EXIT;
                ELSE
                    FOR i_temp IN 1 .. 100000 LOOP
                        endTime := ' ';
                    END LOOP;
                END IF;
                --EXIT WHEN v_logcnt < 10000;
            END LOOP;
          END IF;
          */
          --IF i_count = 5 THEN
          --	COMMIT;
          -- 	i_count := 0;
       	  --END IF;
    
       	END LOOP;
        
        --================================================================================================================
        FOR tmp_loop in (SELECT distinct modelno FROM TBL_GOODS g 
            WHERE NVL(modelno_group,0)=0 and cateflag='0' and ca_lcode <> '15' and NVL(sum_popular,0) > 0) LOOP

          tmp_modelno := tmp_loop.modelno;
          v_totcnt := v_totcnt + 1;

          BEGIN

             UPDATE TBL_GOODS SET sum_popular = 0
             WHERE modelno=tmp_loop.modelno;
             
              COMMIT;

              v_uptotcnt := v_uptotcnt + 1;
              i_count := i_count + 1;
              v_upcheckcnt := v_upcheckcnt + 1;

      		EXCEPTION WHEN OTHERS THEN

          	COMMIT;

          END;
          /*
          IF v_upcheckcnt > 5 THEN
            v_upcheckcnt := 0;
            LOOP
                select count(*) into v_logcnt from mlog$_tbl_goods;
                IF v_logcnt < 10000 THEN
                    EXIT;
                ELSE
                    FOR i_temp IN 1 .. 100000 LOOP
                        endTime := ' ';
                    END LOOP;
                END IF;
                --EXIT WHEN v_logcnt < 10000;
            END LOOP;
          END IF;
          */
          --IF i_count = 5 THEN
          --	COMMIT;
          -- 	i_count := 0;
       	  --END IF;
    
       	END LOOP;
        --===========================================================================================================
        
   SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      INTO tmp_end
      FROM DUAL;

     endTime   := endTime || '|4 : ' || tmp_end;

     IF result_code = '' THEN
  		result_code := '0';
     ELSE
        result_code := result_code || '|' || '0';
     END IF;

     IF result_desc = '' THEN
        result_desc := 'UDP_SUM_POPULAR => SUCCESS total: ' || v_totcnt || ', uptotcnt : ' || v_uptotcnt;
     ELSE
        result_desc := result_desc || '|' || 'UDP_SUM_POPULAR => SUCCESS total: ' || v_totcnt || ', uptotcnt : ' || v_uptotcnt;
     END IF;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SUM_POPULAR','END');
    COMMIT;
    
EXCEPTION
	WHEN OTHERS THEN
  	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      INTO tmp_end
      FROM DUAL;

		IF result_code = '' THEN
        result_code := '' || SQLCODE;
    ELSE
     result_code := result_code || '|' || SQLCODE;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_SUM_POPULAR => ERROR';
    ELSE
         result_desc := result_desc || '|' || 'UDP_SUM_POPULAR => ERROR';
    END IF;

	endTime   := endTime || '|4 error: ' || tmp_end;

 --EXCEPTION
--	WHEN OTHERS THEN
--    		DBMS_OUTPUT.PUT_LINE('error code : ' || SQLCODE || ', message : ' || SQLERRM);
  --SQL PLUS ¿¡¼­ set serveroutput on
    
END UDP_SUM_POPULAR;