/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_ALLNEW2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:23
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_ALLNEW2" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
     CURSOR cur_goods_info IS
        SELECT modelno, minprice, avgprice, maxprice, mallcnt, popular, sale_cnt, escnt, ca_lcode,
            NVL(p_pl_no,0) p_pl_no,NVL(p_imgurl,' ') p_imgurl,NVL(p_imgurl2,' ') p_imgurl2,NVL(p_imgurlflag,' ') p_imgurlflag
            ,NVL(imgchk,'0') imgchk
          FROM TBL_GOODS g
         WHERE cateflag = '0'
         AND JOBCODE > '0'
         AND MODELNO IN (select distinct modelno from tbl_pricelist where srvflag='9' and status='0' and modelno>0);
         --AND mallcnt>0
         --AND CONSTRAIN = '1';
         --AND MODELNO = 1335304;
         --and ca_code like '0304%';

     v_modelno_tmp tbl_goods.modelno%TYPE := 0;
     v_minprice_tmp tbl_goods.minprice%TYPE := 0;
     v_avgprice_tmp tbl_goods.avgprice%TYPE := 0;
     v_maxprice_tmp tbl_goods.maxprice%TYPE := 0;
     v_mallcnt_tmp tbl_goods.mallcnt%TYPE := 0;
     v_popular_tmp tbl_goods.popular%TYPE := 0;
     v_sale_cnt_tmp tbl_goods.sale_cnt%TYPE := 0;
     v_escnt_tmp  tbl_goods.escnt%TYPE := 0;
     v_ca_lcode_tmp tbl_goods.ca_lcode%TYPE := '';
     v_p_pl_no_tmp  tbl_goods.p_pl_no%TYPE := 0;
     v_p_imgurl_tmp tbl_goods.p_imgurl%TYPE := '';
     v_p_imgurl2_tmp tbl_goods.p_imgurl2%TYPE := '';
     v_p_imgurlflag_tmp tbl_goods.p_imgurlflag%TYPE := '';
     v_imgchk_tmp tbl_goods.imgchk%TYPE := '';

     v_minprice    tbl_goods.minprice%TYPE := 0;
     v_avgprice    tbl_goods.avgprice%TYPE := 0;
     v_maxprice    tbl_goods.maxprice%TYPE := 0;
     v_mallcnt     tbl_goods.mallcnt%TYPE := 0;
     v_popular   tbl_goods.popular%TYPE := 0;
     v_sale_cnt   tbl_goods.sale_cnt%TYPE := 0;
     v_escnt    tbl_goods.escnt%TYPE := 0;
     v_escnt2    tbl_goods.escnt%TYPE := 0;
     v_p_pl_no    tbl_goods.p_pl_no%TYPE := 0;
   	 v_p_imgurl   tbl_goods.p_imgurl%TYPE := '';
     v_p_imgurl2   tbl_goods.p_imgurl2%TYPE := '';
  	 v_p_imgurlflag tbl_goods.p_imgurlflag%TYPE := '';
     v_count    NUMBER := 0;
     i_count    NUMBER := 0;
     v_totcnt   NUMBER := 0;
     v_uptotcnt NUMBER := 0;
     v_upcheckcnt NUMBER := 0;
     v_logcnt NUMBER := 0;
     v_upimage_modelno NUMBER :=0;

     tmp_start     VARCHAR2(20) := '';
     tmp_end    VARCHAR2(20) := '';

BEGIN
     --DBMS_OUTPUT.ENABLE;
     --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_ALLNEW start ......');

     --검색관련 pricelist_popular 추가 시작
     --SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     --   INTO tmp_start
     --   FROM DUAL;

     --startTime := 	'|UDP_PRICELIST_POPULAR_PROC : ' || tmp_start;

     --BEGIN
     --  UDP_PRICELIST_POPULAR_PROC;
     --EXCEPTION WHEN OTHERS THEN
     --  result_code := result_code || '|' || SQLCODE;
     --  result_desc := result_desc || '|' || 'UDP_PRICELIST_POPULAR_PROC => ERROR';
     --END;

     --SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     --   INTO tmp_end
     --   FROM DUAL;

     --endTime   := 	'|UDP_PRICELIST_POPULAR_PROC : ' || tmp_end;

     --IF result_code = '' THEN
     -- result_code := '0';
     --ELSE
     -- result_code := result_code || '|' || '0';
     --END IF;
     --검색관련 pricelist_popular 추가 끝

     SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
       INTO tmp_start
       FROM DUAL;

     startTime := startTime || '|3 : ' || tmp_start;

     i_count := 0;
     v_uptotcnt := 0;

     OPEN cur_goods_info;
     LOOP

       FETCH cur_goods_info INTO v_modelno_tmp, v_minprice_tmp, v_avgprice_tmp, v_maxprice_tmp, v_mallcnt_tmp,
             v_popular_tmp, v_sale_cnt_tmp,v_escnt_tmp,v_ca_lcode_tmp,v_p_pl_no_tmp,v_p_imgurl_tmp,v_p_imgurl2_tmp,
             v_p_imgurlflag_tmp,v_imgchk_tmp;
       EXIT WHEN cur_goods_info%NOTFOUND;

          v_p_pl_no :=0;
          v_p_imgurl :='';
          v_p_imgurl2 :='';
          v_p_imgurlflag :='';

          BEGIN

            SELECT NVL(AVG(p.price), 0)
              , NVL(MIN(p.price),0)
              , NVL(MAX(p.price), 0)
              , count(p.shop_code)
              INTO v_avgprice, v_minprice, v_maxprice, v_mallcnt
            FROM TBL_PRICELIST p
             WHERE p.modelno = v_modelno_tmp
               AND p.status IN ('0','8','9')
               AND p.srvflag = '0'
               AND p.esstockflag = '0';
        	EXCEPTION WHEN OTHERS THEN
            v_avgprice := 0;
            v_minprice := 0;
            v_maxprice := 0;
            v_mallcnt := 0;
        	END;

        	BEGIN
                SELECT NVL(sum_point, 0),NVL(sail_cnt, 0)
                INTo v_popular,v_sale_cnt
                FROM TBL_GOODS_POPULAR
                WHERE modelno = v_modelno_tmp;
          EXCEPTION WHEN OTHERS THEN
             v_popular := v_popular_tmp;
             v_sale_cnt := v_sale_cnt_tmp;
          END;

          --======================================================================================
          BEGIN
            v_upimage_modelno := 0;
            IF v_ca_lcode_tmp='16' OR v_ca_lcode_tmp='11' OR v_ca_lcode_tmp='14' OR v_ca_lcode_tmp='15' THEN                                
                --DBMS_OUTPUT.ENABLE;  
                IF v_p_pl_no_tmp=0 THEN
                    SELECT pl_no, imgurl, imgurlflag
                    INTO v_p_pl_no, v_p_imgurl, v_p_imgurlflag
                    FROM (SELECT rownum num, pl_no, imgurl, imgurlflag
                        FROM (SELECT p.pl_no pl_no, p.imgurl imgurl, NVL(p.imgurlflag,'0') imgurlflag,
                             --(case when (NVL(s.es_use,'0') = '9' or p.jobtype = '2') and NVL(p.instance_price, 0) > 0 then p.instance_price when s.shop_code = 55 then trunc(p.price, -1) else p.price end) tmp_price
                                price tmp_price                             
                             FROM TBL_PRICELIST p, TBL_SHOPLIST s
                             WHERE p.modelno = v_modelno_tmp
                             AND p.status IN ('0','8','9')
                             AND p.srvflag = '0'
                             AND p.esstockflag = '0'
                             AND p.imgurlflag='1'
                             AND p.shop_code = s.shop_code
                             ORDER BY tmp_price ASC))
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
                             AND p.srvflag = '0'
                             AND p.esstockflag = '0'
                             AND p.imgurlflag='1' --미정주임
                             AND p.shop_code = s.shop_code
                             ORDER BY price ASC))
                     WHERE num = 1;                         
                     v_p_imgurl2 := v_p_imgurl2;  
                    
                
                    v_p_pl_no := v_p_pl_no_tmp;
                    v_p_imgurl := v_p_imgurl_tmp;                    
                    v_p_imgurlflag := v_p_imgurlflag_tmp;
                END IF;
            END IF;        
        	 
      	 	EXCEPTION WHEN OTHERS THEN
          	 --v_p_pl_no :=0;
          	 --v_p_imgurl :='';
          	 --v_p_imgurlflag :='';
             v_p_pl_no := v_p_pl_no_tmp;
             v_p_imgurl := v_p_imgurl_tmp;
             v_p_imgurlflag := v_p_imgurlflag_tmp;
             v_p_imgurl2 :='';
          END;

          --==================================================================================================================================
--DBMS_OUTPUT.PUT_LINE('v_ca_lcode_tmp......' || v_ca_lcode_tmp);          
--DBMS_OUTPUT.PUT_LINE('v_p_pl_no......' || v_p_pl_no);
--DBMS_OUTPUT.PUT_LINE('v_p_pl_no_tmp......' || v_p_pl_no_tmp);
          IF v_minprice <> v_minprice_tmp OR v_avgprice <> v_avgprice_tmp OR v_maxprice <> v_maxprice_tmp
              OR v_mallcnt <> v_mallcnt_tmp OR v_popular <> v_popular_tmp OR v_sale_cnt <> v_sale_cnt_tmp
              OR ((v_ca_lcode_tmp='11' OR v_ca_lcode_tmp='14' OR v_ca_lcode_tmp='15' OR v_ca_lcode_tmp='16')
                  AND (v_p_pl_no <> v_p_pl_no_tmp OR v_p_imgurl <> v_p_imgurl_tmp OR v_p_imgurl2 <> v_p_imgurl2_tmp OR v_p_imgurlflag <> v_p_imgurlflag_tmp)) THEN
              
              IF v_imgchk_tmp='8' THEN
                  UPDATE TBL_GOODS set minprice = v_minprice, avgprice = v_avgprice, maxprice = v_maxprice,
                    mallcnt = NVL(v_mallcnt, 0), popular = NVL(v_popular, 0), sale_cnt = NVL(v_sale_cnt, 0)                    
                  WHERE modelno = v_modelno_tmp;
              ELSE
                  UPDATE TBL_GOODS set minprice = v_minprice, avgprice = v_avgprice, maxprice = v_maxprice,
                    mallcnt = NVL(v_mallcnt, 0), popular = NVL(v_popular, 0), sale_cnt = NVL(v_sale_cnt, 0),
                    p_pl_no = v_p_pl_no, p_imgurl = v_p_imgurl, p_imgurl2 = v_p_imgurl2, p_imgurlflag = v_p_imgurlflag
                  WHERE modelno = v_modelno_tmp;
              END IF;

              COMMIT;
              i_count := i_count + 1;
              v_upcheckcnt := v_upcheckcnt + 1;
              v_uptotcnt := v_uptotcnt + 1;

          END IF;

          v_totcnt := v_totcnt + 1;

          --IF i_count = 5 THEN
          --  COMMIT;
          --  i_count := 0;
          --END IF;

          --IF v_upcheckcnt > 5 THEN
          --  v_upcheckcnt := 0;
          --  LOOP
          --      select count(*) into v_logcnt from mlog$_tbl_goods;
          --      EXIT WHEN v_logcnt < 10000;
          --  END LOOP;
          --END IF;

     END LOOP;
     CLOSE cur_goods_info;

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
     	result_desc := 'UDP_GOODS_ALLNEW => SUCCESS total: ' || v_totcnt || ', uptotcnt : ' || v_uptotcnt;
    ELSE
     	result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => SUCCESS total: ' || v_totcnt || ', uptotcnt : ' || v_uptotcnt;
    END IF;

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
         result_desc := 'UDP_GOODS_ALLNEW => ERROR : ' || SQLERRM;
    ELSE
         result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW => ERROR : ' || SQLERRM;
    END IF;

		endTime   := endTime || '|3 error: ' || tmp_end;

END UDP_GOODS_ALLNEW2;