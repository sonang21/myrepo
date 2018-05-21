/* *************************************************************************
 * NAME : DBENURI.UDP_SUM_POPULAR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 13:15:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_SUM_POPULAR" (
  	v_modelno   IN  NUMBER,
  	v_part      IN  varchar2,
    result_code IN OUT VARCHAR2,
    result_desc IN OUT VARCHAR2,
    startTime   IN OUT VARCHAR2,
    endTime     IN OUT VARCHAR2)
IS
/*
 NGIT 수정 반영 - 김영원 20180510
*/ 
    tmp_modelno     number := 0;
    i_count         NUMBER := 0;
    tmp_start       VARCHAR2(100) := '';
    tmp_end         VARCHAR2(100) := '';
    v_totcnt        NUMBER := 0;
    v_uptotcnt      NUMBER := 0;
    v_upcheckcnt    NUMBER := 0;
    v_logcnt        NUMBER := 0;

BEGIN
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SUM_POPULAR','START');
    COMMIT;
    
    SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
       INTO tmp_start
       FROM DUAL;

    startTime := startTime || '|4 : ' || tmp_start;

    i_count := 0;

        FOR tmp_loop in (SELECT distinct modelno
                           FROM TBL_GOODS g
                          WHERE modelno_group = modelno
                            AND modelno_group > 0 
        ) LOOP

          tmp_modelno := tmp_loop.modelno;
          v_totcnt := v_totcnt + 1;

            BEGIN

               UPDATE TBL_GOODS_SUM
                  SET sum_popular = (SELECT SUM(popular) 
                                       FROM (SELECT NVL(b.popular,0) as popular
                                               FROM TBL_GOODS a,
                                                    TBL_GOODS_SUM b
                                              WHERE a.modelno = b.modelno
                                                AND a.modelno_group  = tmp_loop.modelno
                                                AND a.jobcode > 0 
                                                AND b.mallcnt > 0 
                                                AND a.constrain = '1'
                                           ORDER BY popular DESC)
                                      WHERE ROWNUM <= 3)
                     , sum_sale_cnt = (SELECT SUM(NVL(b.sale_cnt,0)) 
                                         FROM TBL_GOODS a,
                                              TBL_GOODS_SUM b
                                        WHERE a.modelno = b.modelno
                                          AND a.modelno_group  = tmp_loop.modelno
                                          AND a.jobcode > 0 
                                          AND b.mallcnt > 0 
                                          AND a.constrain = '1')          
                 --  , height=tmp_loop.imgchk_rolling   
                 WHERE modelno in (select a.modelno
                                     from TBL_GOODS a
                                    where a.modelno_group = tmp_loop.modelno)
               ;
               
               COMMIT;

               v_uptotcnt := v_uptotcnt + 1;
               i_count := i_count + 1;
               v_upcheckcnt := v_upcheckcnt + 1;

            EXCEPTION WHEN OTHERS THEN

             COMMIT;

            END;

       	END LOOP;

       	COMMIT;
        
        --================================================================================================================
        FOR tmp_loop in (SELECT distinct a.modelno
                           FROM TBL_GOODS a,
                                TBL_GOODS_SUM b,
                                TBL_CATE_GOODS c
                          WHERE a.modelno = b.modelno
                            AND a.modelno = c.modelno
                            AND a.modelno_group IS NULL
                            AND c.ca_code LIKE '15%'
                            AND NVL(b.sum_popular,0) <> NVL(b.popular,0)
        ) LOOP

          tmp_modelno := tmp_loop.modelno;
          v_totcnt := v_totcnt + 1;

          BEGIN

            UPDATE TBL_GOODS_SUM
               SET sum_popular = popular 
             WHERE modelno=tmp_loop.modelno
               AND sum_popular <> popular;               

             COMMIT;

             v_uptotcnt := v_uptotcnt + 1;
             i_count := i_count + 1;
             v_upcheckcnt := v_upcheckcnt + 1;

          EXCEPTION WHEN OTHERS THEN

          	 COMMIT;

          END;
        
       	END LOOP;
        
        --================================================================================================================
        FOR tmp_loop in (SELECT distinct a.modelno
                           FROM TBL_GOODS a,
                                TBL_GOODS_SUM b
                          WHERE a.modelno = b.modelno
                            and NVL(a.modelno_group,0)=0 
                            and a.ca_code not like '15%'
                            and NVL(b.sum_popular,0) > 0
        ) LOOP

          tmp_modelno := tmp_loop.modelno;
          v_totcnt := v_totcnt + 1;

          BEGIN

             UPDATE TBL_GOODS_SUM
                SET sum_popular = 0
              WHERE modelno=tmp_loop.modelno;
             
              COMMIT;

              v_uptotcnt := v_uptotcnt + 1;
              i_count := i_count + 1;
              v_upcheckcnt := v_upcheckcnt + 1;

          EXCEPTION WHEN OTHERS THEN

          	COMMIT;

          END;

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

    
END UDP_SUM_POPULAR;
