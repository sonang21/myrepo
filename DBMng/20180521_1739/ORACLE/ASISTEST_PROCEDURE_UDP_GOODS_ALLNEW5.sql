/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_ALLNEW5
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:23
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_ALLNEW5" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2,
     v_ca_lcode IN  CHAR
     )
IS
     CURSOR cur_goods_info IS
        SELECT  modelno, NVL(modelno_group,0) modelno_group, minprice, NVL(minprice2,0) minprice2 ,NVL(minprice3,0) minprice3 , NVL(minprice4,0) minprice4 ,avgprice, maxprice, mallcnt, NVL(mallcnt3,0) mallcnt3, popular, sale_cnt, escnt, ca_lcode,ca_code,
            NVL(p_pl_no,0) p_pl_no,NVL(p_imgurl,' ') p_imgurl,NVL(p_imgurl2,' ') p_imgurl2,NVL(p_imgurlflag,' ') p_imgurlflag
            ,NVL(imgchk,'0') imgchk, constrain, NVL(bbs_num,0) bbs_num, NVL(bbs_point,0) bbs_point, NVL(bbs_point_avg,0) bbs_point_avg
          FROM TBL_GOODS g
         WHERE cateflag = '0'
         AND ca_lcode = v_ca_lcode --20170822 lsm 대카테별로 수행
         
         AND (mallcnt > 0 OR (mallcnt=0 AND moddate > (sysdate-5)))
         AND modelno > 0
         AND JOBCODE > '0'
         ;

     v_modelno_tmp tbl_goods.modelno%TYPE := 0;
     v_modelno_group_tmp tbl_goods.modelno_group%TYPE := 0;
     v_minprice_tmp tbl_goods.minprice%TYPE := 0;
     v_minprice2_tmp tbl_goods.minprice2%TYPE := 0;
     v_minprice3_tmp tbl_goods.minprice3%TYPE := 0;
     v_minprice4_tmp tbl_goods.minprice4%TYPE := 0;

     v_avgprice_tmp tbl_goods.avgprice%TYPE := 0;
     v_maxprice_tmp tbl_goods.maxprice%TYPE := 0;

     v_mallcnt_tmp tbl_goods.mallcnt%TYPE := 0;
     v_mallcnt3_tmp tbl_goods.mallcnt3%TYPE := 0;

     v_popular_tmp tbl_goods.popular%TYPE := 0;
     v_sale_cnt_tmp tbl_goods.sale_cnt%TYPE := 0;
     v_escnt_tmp  tbl_goods.escnt%TYPE := 0;
     v_ca_code_tmp tbl_goods.ca_code%TYPE := '';
     v_ca_lcode_tmp tbl_goods.ca_lcode%TYPE := '';
     v_p_pl_no_tmp  tbl_goods.p_pl_no%TYPE := 0;

     v_bbs_num_tmp tbl_goods.bbs_num%TYPE := 0;
     v_bbs_point_tmp tbl_goods.bbs_point%TYPE := 0;
     v_bbs_point_avg_tmp tbl_goods.bbs_point_avg%TYPE := 0;

     v_p_imgurl_tmp tbl_goods.p_imgurl%TYPE := '';
     v_p_imgurl2_tmp tbl_goods.p_imgurl2%TYPE := '';
     v_p_imgurlflag_tmp tbl_goods.p_imgurlflag%TYPE := '';
     v_imgchk_tmp tbl_goods.imgchk%TYPE := '';
     v_constrain_tmp tbl_goods.constrain%TYPE := '';

     v_minprice     tbl_goods.minprice%TYPE := 0;
     v_minprice2    tbl_goods.minprice2%TYPE := 0;
     v_minprice3    tbl_goods.minprice3%TYPE := 0;
     v_minprice4    tbl_goods.minprice4%TYPE := 0;
     v_avgprice     tbl_goods.avgprice%TYPE := 0;
     v_maxprice     tbl_goods.maxprice%TYPE := 0;
     v_mallcnt      tbl_goods.mallcnt%TYPE := 0;
     v_mallcnt3     tbl_goods.mallcnt3%TYPE := 0;
     v_popular      tbl_goods.popular%TYPE := 0;
     v_sale_cnt     tbl_goods.sale_cnt%TYPE := 0;
     v_escnt        tbl_goods.escnt%TYPE := 0;
     v_escnt2       tbl_goods.escnt%TYPE := 0;
     v_p_pl_no      tbl_goods.p_pl_no%TYPE := 0;
     v_p_imgurl     tbl_goods.p_imgurl%TYPE := '';
     v_p_imgurl2    tbl_goods.p_imgurl2%TYPE := '';
    v_p_imgurlflag tbl_goods.p_imgurlflag%TYPE := '';     
     v_bbs_num      tbl_goods.bbs_num%TYPE := 0;
     v_bbs_point    tbl_goods.bbs_point%TYPE := 0;
     v_bbs_point_avg    tbl_goods.bbs_point_avg%TYPE := 0;

     v_count                NUMBER := 0;
     v_totcnt               NUMBER := 0;
     v_uptotcnt             NUMBER := 0;
     v_upcheckcnt           NUMBER := 0;
     v_logcnt               NUMBER := 0;
     v_upimage_modelno      NUMBER :=0;

     i_count                NUMBER := 0;
     i_popular_count        NUMBER := 0;

     tmp_start              VARCHAR2(20) := '';
     tmp_end                VARCHAR2(20) := '';

BEGIN

     SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO tmp_start
     FROM DUAL;

     startTime := startTime || '|3 : ' || tmp_start;

    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_GOODS_ALLNEW5', v_ca_lcode, sysdate, sysdate, startTime, endTime, result_code, result_desc, 'START'
    FROM DUAL;
    COMMIT;

     SELECT COUNT(*)  
     INTo i_popular_count
     FROM TBL_GOODS_POPULAR;     

     i_count := 0;
     v_uptotcnt := 0;


     FOR c IN cur_goods_info
     LOOP
     
       v_modelno_tmp := c.modelno;
       v_modelno_group_tmp := c.modelno_group;
       v_minprice_tmp := c.minprice;
       v_minprice2_tmp := c.minprice2;
       v_minprice3_tmp := c.minprice3;
       v_minprice4_tmp := c.minprice4;
       v_avgprice_tmp := c.avgprice;
       v_maxprice_tmp := c.maxprice;
       v_mallcnt_tmp := c.mallcnt;
       v_mallcnt3_tmp := c.mallcnt3;
       v_popular_tmp := c.popular;
       v_sale_cnt_tmp := c.sale_cnt;
       v_escnt_tmp := c.escnt;
       v_ca_lcode_tmp := c.ca_lcode;
       v_ca_code_tmp := c.ca_code;
       v_p_pl_no_tmp := c.p_pl_no;
       v_p_imgurl_tmp := c.p_imgurl;
       v_p_imgurl2_tmp := c.p_imgurl2;
       v_p_imgurlflag_tmp := c.p_imgurlflag;
       v_imgchk_tmp := c.imgchk;
       v_constrain_tmp := c.constrain;
       v_bbs_num_tmp := c.bbs_num;
       v_bbs_point_tmp := c.bbs_point;
       v_bbs_point_avg_tmp := c.bbs_point_avg;

          v_p_pl_no :=0;
          v_p_imgurl :='';
          v_p_imgurl2 :='';
          v_p_imgurlflag :='';

        BEGIN
        
            SELECT NVL(AVG(CASE WHEN  p.esstockflag = '0' THEN p.price END), 0) v_avgprice
                 , NVL(MIN(CASE WHEN  p.esstockflag = '0' THEN p.price END), 0) v_minprice
                 , MIN(CASE WHEN  p.esstockflag = '0' THEN 
                         CASE WHEN p.deliverytype2=0 THEN (p.price + 2500) ELSE (p.price + DECODE(p.deliveryinfo, '무료배송', 0, NVL(p.deliveryinfo2, 2500))) END
                       END) v_minprice2
                 , NVL(MAX(p.price), 0) v_maxprice
                 , COUNT(CASE WHEN  p.esstockflag = '0' THEN p.shop_code END) v_mallcnt
                 , NVL(MIN(CASE WHEN NVL(p.instance_price,0) > 0 AND NVL(p.price,'0') > 0 AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4') THEN p.instance_price END),0) v_minprice3
                 , COUNT(CASE WHEN NVL(p.instance_price,0) > 0 AND NVL(p.price,'0') > 0 AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4') THEN p.shop_code END) v_mallcnt3
                 , NVL(MIN(CASE WHEN NVL(p.price,'0') > 0 AND NVL(p.store_flag,'0') = '1' AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4') THEN p.price END),0) v_minprice4
              INTO v_avgprice, v_minprice, v_minprice2, v_maxprice, v_mallcnt , v_minprice3, v_mallcnt3, v_minprice4
              FROM TBL_PRICELIST p
             WHERE p.modelno = v_modelno_tmp
               AND p.status IN ('0','8','9')
               AND p.srvflag in ('0','L','R')
               AND NVL(p.option_flag2,'0') = '0'
            ;

        EXCEPTION WHEN OTHERS THEN
            v_avgprice := 0;
            v_minprice := 0;
            v_maxprice := 0;
            v_mallcnt := 0;
            v_minprice3 := 0;
            v_mallcnt3 := 0;
            v_minprice4 := 0;

        END;


        BEGIN

            IF v_modelno_group_tmp > 0 THEN
                SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
                WHERE modelno_group = v_modelno_group_tmp
                AND delflag='N';
            ELSE
                SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
                WHERE modelno = v_modelno_tmp
                AND delflag='N';
            END IF;

        EXCEPTION WHEN OTHERS THEN
                v_bbs_num := 0;   
                v_bbs_point := 0; 
                v_bbs_point_avg := 0;
        END;

        BEGIN

            IF i_popular_count > 600000 THEN
                SELECT NVL(sum_point, 0),NVL(sail_cnt, 0)
                INTo v_popular,v_sale_cnt
                FROM TBL_GOODS_POPULAR
                WHERE modelno = v_modelno_tmp;                
            ELSE
                v_popular := v_popular_tmp;
                v_sale_cnt := v_sale_cnt_tmp;
            END IF;

        EXCEPTION WHEN OTHERS THEN
            --v_popular := v_popular_tmp;
            --v_sale_cnt := v_sale_cnt_tmp;
            v_popular := 0;
            v_sale_cnt := 0;
        END;

        IF v_popular < 0 THEN
            v_popular := 0;
        END IF;
        IF v_sale_cnt < 0 THEN
            v_sale_cnt := 0;
        END IF;
        
        --==================================================

        IF substr(v_ca_code_tmp,0,4)='0304' OR substr(v_ca_code_tmp,0,4)='0305' OR substr(v_ca_code_tmp,0,6)='020922' THEN

            BEGIN
                SELECT NVL(MIN(p.price),0),NVL(AVG(p.price), 0),NVL(MAX(p.price), 0) 
                  INTO v_minprice,v_avgprice,v_maxprice
                  FROM TBL_PRICELIST p
                 WHERE p.modelno = v_modelno_tmp                 
                   AND p.status in ('0','8','9')
                   AND p.srvflag in ('0','L','R')
                   AND NVL(p.option_flag2,'0') = '0'
                   AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4');

            EXCEPTION WHEN OTHERS THEN
                    v_minprice := 0;
                    v_avgprice := 0;
                    v_maxprice := 0;    
            END;

        END IF;

        IF (v_minprice3 > 0 AND v_minprice3 > v_minprice) OR v_minprice3 = 0 THEN
            v_minprice3 := v_minprice;
        END IF;

        --======================================================================================
          
        BEGIN
            v_upimage_modelno := 0;
                            
            IF v_constrain_tmp='5' THEN --유사상품

                IF v_p_pl_no_tmp=0 THEN
                    SELECT pl_no, imgurl, imgurlflag
                    INTO v_p_pl_no, v_p_imgurl, v_p_imgurlflag
                    FROM (SELECT rownum num, pl_no, imgurl, imgurlflag
                        FROM (SELECT p.pl_no pl_no, p.imgurl imgurl, NVL(p.imgurlflag,'0') imgurlflag,
                             (case when p.shop_code=47 OR p.shop_code=49 OR p.shop_code=57 OR p.shop_code=75 OR p.shop_code=90 OR p.shop_code=663 OR p.shop_code=806 OR p.shop_code=6547 then '0' else '1' end) tmp_order_by,
                             price tmp_price                             
                             FROM TBL_PRICELIST p, TBL_SHOPLIST s
                             WHERE p.modelno = v_modelno_tmp
                             AND p.status IN ('0','8','9')
                             AND p.srvflag in ('0','L','R')
                             AND NVL(p.option_flag2,'0') = '0'
                             AND p.esstockflag = '0'
                             AND p.imgurlflag='1'
                             AND p.shop_code NOT IN (4861,6368)
                             AND p.shop_code = s.shop_code
                             AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4')
                             ORDER BY tmp_order_by,tmp_price ASC))
                    WHERE num = 1;                  
                    v_p_imgurl2 := v_p_imgurl;

                ELSE

                    SELECT imgurl
                    INTO v_p_imgurl2
                    FROM (SELECT rownum num, imgurl
                        FROM (SELECT p.imgurl imgurl
                            FROM TBL_PRICELIST p, TBL_SHOPLIST s
                             WHERE p.modelno = v_modelno_tmp
                             AND p.status IN ('0','8','9')
                             AND p.srvflag in ('0','L','R')
                             AND NVL(p.option_flag2,'0') = '0'
                             AND p.esstockflag = '0'
                             --AND p.imgurlflag='1' --미정주임
                             AND p.shop_code = s.shop_code
                             AND (NVL(p.PRICE_FLAG,'0') = '0' OR NVL(p.AIRCONFEETYPE,'0') = '3' OR NVL(p.AIRCONFEETYPE,'0') = '4')
                             ORDER BY price,pl_no ASC))
                     WHERE num = 1;                         
                     v_p_imgurl2 := v_p_imgurl2;
                     v_p_pl_no := v_p_pl_no_tmp;
                     v_p_imgurl := v_p_imgurl_tmp;                    
                     v_p_imgurlflag := v_p_imgurlflag_tmp;

                END IF;

            ELSE      

                 v_p_pl_no := v_p_pl_no_tmp;
                 v_p_imgurl := v_p_imgurl_tmp;
                 v_p_imgurlflag := v_p_imgurlflag_tmp;
                 v_p_imgurl2 := v_p_imgurl2_tmp;

            END IF;        

        EXCEPTION WHEN OTHERS THEN    

                 v_p_pl_no := v_p_pl_no_tmp;
                 v_p_imgurl := v_p_imgurl_tmp;
                 v_p_imgurlflag := v_p_imgurlflag_tmp;
                 v_p_imgurl2 := v_p_imgurl2_tmp;

        END;

          --==================================================================================================================================

          IF v_minprice <> v_minprice_tmp OR nvl(v_minprice2,0) <> v_minprice2_tmp OR v_minprice3 <> v_minprice3_tmp 
              OR v_minprice4 <> v_minprice4_tmp 
              OR v_avgprice <> v_avgprice_tmp OR v_maxprice <> v_maxprice_tmp
              OR v_mallcnt <> v_mallcnt_tmp OR v_mallcnt3 <> v_mallcnt3_tmp OR v_popular <> v_popular_tmp OR v_sale_cnt <> v_sale_cnt_tmp
              OR v_bbs_num <> v_bbs_num_tmp OR v_bbs_point <> v_bbs_point_tmp OR v_bbs_point_avg <> v_bbs_point_avg_tmp
              OR v_constrain_tmp='5'
              OR ((v_ca_lcode_tmp='11' OR v_ca_lcode_tmp='14' OR v_ca_lcode_tmp='15' OR v_ca_lcode_tmp='16' OR v_ca_lcode_tmp='93')
                  AND (v_p_pl_no <> v_p_pl_no_tmp OR v_p_imgurl <> v_p_imgurl_tmp OR v_p_imgurl2 <> v_p_imgurl2_tmp OR v_p_imgurlflag <> v_p_imgurlflag_tmp)) THEN

              IF v_constrain_tmp='5' THEN --유사상품

                  UPDATE /*+ append NOLOGGING */ TBL_GOODS
                     set minprice = v_minprice,
                         minprice2 = v_minprice2, 
                         minprice3 = v_minprice3, 
                         minprice4 = v_minprice4, 
                         avgprice = v_avgprice, 
                         maxprice = v_maxprice,
                         mallcnt = NVL(v_mallcnt, 0),
                         mallcnt3 = NVL(v_mallcnt3, 0), 
                         popular = NVL(v_popular, 0), 
                         sale_cnt = NVL(v_sale_cnt, 0), 
                         bbs_num = v_bbs_num, 
                         bbs_point = v_bbs_point,
                         bbs_point_avg = v_bbs_point_avg,
                         moddate=sysdate,
                         
                         p_pl_no      = case when (v_p_imgurl <> ' ' AND v_p_imgurlflag <> ' ') then v_p_pl_no else p_pl_no end,
                         p_imgurl     = case when (v_p_imgurl <> ' ' AND v_p_imgurlflag <> ' ') then v_p_imgurl else p_imgurl end,
                         p_imgurl2    = case when (v_p_imgurl <> ' ' AND v_p_imgurlflag <> ' ') then v_p_imgurl2 else p_imgurl2 end,
                         p_imgurlflag = case when (v_p_imgurl <> ' ' AND v_p_imgurlflag <> ' ') then v_p_imgurlflag else p_imgurlflag end
                         
                  WHERE modelno = v_modelno_tmp;       

              ELSE

                  UPDATE /*+ append NOLOGGING */ TBL_GOODS set minprice = v_minprice, minprice2 = v_minprice2, minprice3 = v_minprice3, minprice4 = v_minprice4, avgprice = v_avgprice, maxprice = v_maxprice,
                    mallcnt = NVL(v_mallcnt, 0),mallcnt3 = NVL(v_mallcnt3, 0), popular = NVL(v_popular, 0), sale_cnt = NVL(v_sale_cnt, 0),
                    bbs_num = v_bbs_num, bbs_point = v_bbs_point, bbs_point_avg = v_bbs_point_avg, moddate=sysdate
                  WHERE modelno = v_modelno_tmp;
                      
              END IF;

              i_count := i_count + 1;
              v_upcheckcnt := v_upcheckcnt + 1;
              v_uptotcnt := v_uptotcnt + 1;

          END IF;

          v_totcnt := v_totcnt + 1;
/*
          IF i_count = 100 THEN
            COMMIT;
            i_count := 0;
          END IF;
*/
COMMIT;
     END LOOP;

   COMMIT;

    SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      INTO tmp_end
      FROM DUAL;

    endTime   := endTime || '|3 : ' || tmp_end;

    IF result_code = '' THEN
      result_code := '0';
    ELSE
      result_code := result_code || '|' || '0';
    END IF;

    IF result_desc = '' THEN
      result_desc := 'UDP_GOODS_ALLNEW5 => SUCCESS total: ' || v_totcnt || ', uptotcnt : ' || v_uptotcnt;
    ELSE
      result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => SUCCESS total: ' || v_totcnt || ', uptotcnt : ' || v_uptotcnt;
    END IF;

    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_GOODS_ALLNEW5', v_ca_lcode, sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END'
    FROM DUAL;
    COMMIT;


EXCEPTION
 WHEN OTHERS THEN
   COMMIT;
   SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      INTO tmp_end
      FROM DUAL;

    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE ;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_GOODS_ALLNEW5 => ERROR : ' || SQLERRM;
    ELSE
         result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => ERROR : ' || SQLERRM;
    END IF;

  endTime   := endTime || '|3 error: ' || tmp_end;

    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_GOODS_ALLNEW5', v_ca_lcode, sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    FROM DUAL;
    COMMIT;

END UDP_GOODS_ALLNEW5;