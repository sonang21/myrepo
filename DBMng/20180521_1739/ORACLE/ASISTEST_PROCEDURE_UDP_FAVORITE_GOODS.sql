/* *************************************************************************
 * NAME : ASISTEST.UDP_FAVORITE_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:22
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_FAVORITE_GOODS" 
IS

v_modelno TBL_FAVORITE_GOODS.modelno%TYPE := 0;
v_ca_code TBL_FAVORITE_GOODS.ca_code%TYPE := ' ';
v_dis_list TBL_FAVORITE_GOODS.DIS_LIST%TYPE := '';
v_dis_main TBL_FAVORITE_GOODS.DIS_MAIN%TYPE := '';
v_dis_hana TBL_FAVORITE_GOODS.DIS_HANA%TYPE := '';
v_dis_order TBL_FAVORITE_GOODS.DIS_ORDER%TYPE := '';

i_count                 NUMBER := 0;
i_row                     NUMBER := 0;      

CURSOR favorite_model_cursor IS
    SELECT CA_CODE,MODELNO,DIS_MAIN,DIS_LIST,DIS_HANA,DIS_ORDER  FROM TBL_FAVORITE_GOODS WHERE FAV_TYPE = 'G';
    
CURSOR favorite_category_cursor IS
    SELECT CA_CODE,DIS_MAIN,DIS_LIST,DIS_HANA,DIS_ORDER   FROM TBL_FAVORITE_GOODS    WHERE FAV_TYPE = 'C';
    
BEGIN

DELETE FROM TBL_FAVORITE_GOODS_MODELNO;
    
OPEN favorite_model_cursor;
LOOP
    FETCH  favorite_model_cursor INTO v_ca_code,v_modelno,v_dis_main,v_dis_list,v_dis_hana,v_dis_order;
    EXIT WHEN favorite_model_cursor%NOTFOUND;    
    
     IF v_dis_main = 'Y' THEN
        FOR tmp IN (SELECT MODELNO,CA_CODE,MODELNM,MINPRICE,ORDER_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO  FROM ( SELECT ROWNUM NUM , MODELNO ,CA_CODE,MODELNM,MINPRICE,ORDER_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM ( SELECT MODELNO,CA_CODE,MODELNM,MINPRICE,(CASE WHEN SUM_SALE_CNT > SALE_CNT THEN SUM_SALE_CNT ELSE SALE_CNT END ) ORDER_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM TBL_GOODS WHERE  MINPRICE >  0  AND jobcode>'0' AND constrain='1' AND modelno = v_modelno AND cateflag = '0'  AND sale_cnt IS NOT NULL ORDER BY  ORDER_CNT DESC ) ) WHERE ROWNUM <=  1 ) LOOP
            INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO) VALUES (i_count,tmp.modelno,'M',tmp.ca_code,tmp.modelnm,tmp.minprice,tmp.order_cnt,tmp.imgchk,tmp.p_imgurl,tmp.p_imgurlflag,tmp.p_pl_no);
            i_count := i_count + 1;
        END LOOP;    
     END IF;
     
     IF v_dis_list = 'Y' THEN
         INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE) VALUES (i_count,v_modelno,'L',v_ca_code);
        i_count := i_count + 1;
     END IF; 
     
     IF v_dis_hana = 'Y' THEN
         INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE) VALUES (i_count,v_modelno,'H',v_ca_code);
        i_count := i_count + 1;
     END IF;            
    
     IF v_dis_order = 'Y' THEN
        FOR tmp IN (SELECT MODELNO,CA_CODE,MODELNM,MINPRICE,ORDER_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO  FROM ( SELECT ROWNUM NUM , MODELNO ,CA_CODE,MODELNM,MINPRICE,ORDER_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM ( SELECT MODELNO,CA_CODE,MODELNM,MINPRICE,(CASE WHEN SUM_SALE_CNT > SALE_CNT THEN SUM_SALE_CNT ELSE SALE_CNT END ) ORDER_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM TBL_GOODS WHERE  MINPRICE >  0  AND jobcode>'0' AND constrain='1' AND modelno = v_modelno AND cateflag = '0' AND sale_cnt IS NOT NULL  ORDER BY  ORDER_CNT DESC ) ) WHERE ROWNUM <=  1 ) LOOP
            INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO) VALUES (i_count,tmp.modelno,'O',tmp.ca_code,tmp.modelnm,tmp.minprice,tmp.order_cnt,tmp.imgchk,tmp.p_imgurl,tmp.p_imgurlflag,tmp.p_pl_no);
            i_count := i_count + 1;
        END LOOP;    
     END IF;            
         
END LOOP;
CLOSE favorite_model_cursor;

OPEN favorite_category_cursor;
LOOP

    FETCH favorite_category_cursor INTO v_ca_code,v_dis_main,v_dis_list,v_dis_hana,v_dis_order;
    EXIT WHEN favorite_category_cursor%NOTFOUND;

    IF v_dis_main = 'Y' THEN
       i_row := 20;
        FOR tmp IN (SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO  FROM ( SELECT ROWNUM NUM , MODELNO ,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM ( SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM TBL_GOODS WHERE  MINPRICE >  0  AND CATEFLAG='0' AND jobcode>'0' AND constrain='1' AND CA_CODE LIKE TRIM(v_ca_code) || '%' AND CA_LCODE = SUBSTR(v_ca_code,1,2) ORDER BY  popular DESC ) ) WHERE ROWNUM <=  i_row ) LOOP
            INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO) VALUES (i_count,tmp.modelno,'M',v_ca_code,tmp.modelnm,tmp.minprice,tmp.sale_cnt,tmp.imgchk,tmp.p_imgurl,tmp.p_imgurlflag,tmp.p_pl_no);
            i_count := i_count + 1;
        END LOOP;
    END IF;        
    
    IF v_dis_list = 'Y' THEN
       i_row := 30;
        FOR tmp IN (SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT  FROM ( SELECT ROWNUM NUM , MODELNO ,MODELNM,MINPRICE,SALE_CNT FROM ( SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT FROM TBL_GOODS WHERE  MINPRICE >  0  AND CATEFLAG='0' AND jobcode>'0' AND constrain='1' AND CA_CODE LIKE TRIM(v_ca_code) || '%' AND CA_LCODE = SUBSTR(v_ca_code,1,2) ORDER BY  popular DESC ) ) WHERE ROWNUM <=  i_row ) LOOP
            INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE) VALUES (i_count,tmp.modelno,'L',v_ca_code);
            i_count := i_count + 1;
        END LOOP;
    END IF;        
    
    IF v_dis_hana = 'Y' THEN
       i_row := 1;
        FOR tmp IN (SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT  FROM ( SELECT ROWNUM NUM , MODELNO ,MODELNM,MINPRICE,SALE_CNT FROM ( SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT FROM TBL_GOODS WHERE  MINPRICE >  0  AND CATEFLAG='0' AND jobcode>'0' AND constrain='1' AND CA_CODE LIKE TRIM(v_ca_code) || '%' AND CA_LCODE = SUBSTR(v_ca_code,1,2) ORDER BY  popular DESC ) ) WHERE ROWNUM <=  i_row ) LOOP
            INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE) VALUES (i_count,tmp.modelno,'H',v_ca_code);
            i_count := i_count + 1;
        END LOOP;        
    END IF;                                                                                            
    
    IF v_dis_order = 'Y' THEN
       i_row := 1;
        FOR tmp IN (SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO  FROM ( SELECT ROWNUM NUM , MODELNO ,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM ( SELECT MODELNO,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO FROM TBL_GOODS WHERE  MINPRICE >  0  AND jobcode>'0' AND constrain='1' AND cateflag = '0' AND CA_CODE LIKE TRIM(v_ca_code) || '%' AND CA_LCODE = SUBSTR(v_ca_code,1,2) AND sale_cnt IS NOT NULL  ORDER BY  sale_cnt DESC ) ) WHERE ROWNUM <=  i_row ) LOOP
            INSERT INTO TBL_FAVORITE_GOODS_MODELNO (cnt,modelno,DIS_POS,CA_CODE,MODELNM,MINPRICE,SALE_CNT,IMGCHK,P_IMGURL,P_IMGURLFLAG,P_PL_NO) VALUES (i_count,tmp.modelno,'O',v_ca_code,tmp.modelnm,tmp.minprice,tmp.sale_cnt,tmp.imgchk,tmp.p_imgurl,tmp.p_imgurlflag,tmp.p_pl_no );
            i_count := i_count + 1;
        END LOOP;    
    END IF;        
    
END LOOP;
CLOSE favorite_category_cursor;

COMMIT;

END Udp_Favorite_Goods;