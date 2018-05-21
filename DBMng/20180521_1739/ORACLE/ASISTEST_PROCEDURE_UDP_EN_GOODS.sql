/* *************************************************************************
 * NAME : ASISTEST.UDP_EN_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:22
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_EN_GOODS" 
IS

 v_tmp_shop_incnt   NUMBER(8) := 0;
 v_tmp_cnt          NUMBER(8) := 0;
 v_md_hit           NUMBER(8) := 0;
  
 v_modelno          en_goods.modelno%TYPE := 0;
 
 v_mallcnt          en_goods.mallcnt%TYPE := 0;
 v_minprice         en_goods.minprice%TYPE := 0;
 v_maxprice         en_goods.maxprice%TYPE := 0;
 v_avgprice         en_goods.avgprice%TYPE := 0;
 v_minsale         enprodmain.lrprice%TYPE := 0;
 
 v_ca_code          EN_CATEGORY_MAP.ca_code%TYPE := '';
 v_custid           enprodmain.custid%TYPE := '';
 v_pnamep           enprodmain.pnamep%TYPE := '';
 v_brand            enprodmain.brand%TYPE := '';
 v_prodinc          enprodmain.prodinc%TYPE := 0;
 v_maker            enprodmain.maker%TYPE := '';
 
 v_ccode1_name      enprodmain.ccode1_name%TYPE := '';
 v_ccode2_name      enprodmain.ccode2_name%TYPE := '';
 v_ccode3_name      enprodmain.ccode3_name%TYPE := '';
 v_ccode4_name      enprodmain.ccode4_name%TYPE := '';
 
 loop_cnt NUMBER(8) :=0;
 lopp_cnt NUMBER(8) :=0;
 

BEGIN

    --SET SERVEROUTPUT ON
    --DBMS_OUTPUT.ENABLE;
 
    
    /*
    DELETE ENCOLORMAIN a 
    WHERE a.prodinc IN (SELECT prodinc FROM enProdMain b WHERE MODIFYDATE < SYSDATE - 14 AND a.custid=b.custid);
    COMMIT;


    DELETE ENSIZEMAIN a 
    WHERE a.prodinc IN (SELECT prodinc FROM enProdMain b WHERE MODIFYDATE < SYSDATE - 14 AND a.custid=b.custid);
    COMMIT;


    DELETE ENSTILLMAIN a 
    WHERE a.prodinc IN (SELECT prodinc FROM enProdMain b WHERE MODIFYDATE < SYSDATE - 14 AND a.custid=b.custid);
    COMMIT;

    DELETE ENSTILLMAIN a 
    WHERE a.prodinc IN (SELECT prodinc FROM enProdMain b WHERE MODIFYDATE < SYSDATE - 14 AND a.custid=b.custid);
    COMMIT;

    DELETE ENSTORYMAIN a 
    WHERE a.prodinc IN (SELECT prodinc FROM enProdMain b WHERE MODIFYDATE < SYSDATE - 14 AND a.custid=b.custid);
    COMMIT;
    */


 
 --=========================================================================================
 -- 기존 모델에서 매칭
 --=========================================================================================
 
 lopp_cnt := 0;
 FOR tmp_loop in (SELECT pimgp,modelno,mallcnt,minprice,maxprice,avgprice,ca_code,minsale FROM EN_GOODS) LOOP
     
    BEGIN

        lopp_cnt := lopp_cnt + 1;
        DBMS_OUTPUT.PUT_LINE(lopp_cnt || '==pimgp1..' || tmp_loop.pimgp);
        
        SELECT count(*) mallcnt,  NVL(min(lrprice),0) minsale, min(srprice) minprice ,max(srprice) maxprice, AVG(srprice) avgprice
        INTO v_mallcnt, v_minsale, v_minprice, v_maxprice, v_avgprice
        FROM enprodmain
        WHERE pimgp=tmp_loop.pimgp
        AND stock='1';
    
    EXCEPTION WHEN OTHERS THEN
        v_mallcnt   := 0;
        v_minsale   := 0;
        v_minprice   := 0;
        v_maxprice   := 0;
        v_avgprice   := 0;
    END;
    
    --DBMS_OUTPUT.PUT_LINE(lopp_cnt || '==pimgp2..' || tmp_loop.pimgp);
    
    UPDATE enprodmain SET modelno=tmp_loop.modelno, ca_code=tmp_loop.ca_code WHERE pimgp=tmp_loop.pimgp AND (modelno <> tmp_loop.modelno OR NVL(ca_code,' ' ) <> tmp_loop.ca_code);
    COMMIT;
    --DBMS_OUTPUT.PUT_LINE(lopp_cnt || '==pimgp3..' || tmp_loop.pimgp);
    
    IF tmp_loop.mallcnt <> v_mallcnt OR tmp_loop.minprice <> v_minprice OR tmp_loop.minsale <> v_minsale THEN
        UPDATE EN_GOODS SET mallcnt=v_mallcnt, minprice=v_minprice, maxprice=v_maxprice, avgprice=v_avgprice, minsale=v_minsale WHERE modelno=tmp_loop.modelno;   
        COMMIT;
    END IF;
    --DBMS_OUTPUT.PUT_LINE(lopp_cnt || '==pimgp4..' || tmp_loop.pimgp);
    COMMIT;
    
 END LOOP;
 
 --==========================================================================================
 --신규모델생성
 --==========================================================================================
 FOR tmp_loop in (
 
        SELECT pimgp, mallcnt, custid, minsale, minprice, maxprice, avgprice,maker, brand, pnamep FROM (
            SELECT ROWNUM num, pimgp, mallcnt, custid, minsale, minprice, maxprice, avgprice, maker, brand, pnamep FROM (
                SELECT pimgp , count(*) mallcnt,  MAX(custid) custid, min(lrprice) minsale, min(srprice) minprice ,max(srprice) maxprice,AVG(srprice) avgprice, 
                    MAX(maker) maker, MAX(brand) brand, MAX(pnamep) pnamep
                    FROM  enProdMain
                    WHERE Stock='1'
                    AND NVL(srprice,0) > 0
                    AND length(pimgp) >= 10
                    AND pnamep IS NOT NULL
                    AND pimgp NOT IN (SELECT DISTINCT pimgp FROM EN_GOODS)
                    group by pimgp
                    having count(*) > 1
        ))   
        --WHERE num <= 100
) LOOP
    
    loop_cnt := loop_cnt + 1;
        
    SELECT NVL(MAX(modelno),0)+1 INTO v_modelno FROM EN_GOODS;
            
    FOR tmp_loop2 in (
            SELECT custid, pnamep,brand,maker,prodinc,pimgp, ccode1_name, ccode2_name, ccode3_name, ccode4_name, ccode3, ccode4
            FROM enProdMain
            WHERE pimgp=tmp_loop.pimgp
            AND ccode1_name IS NOT NULL
            AND ccode2_name IS NOT NULL
            AND ccode3_name IS NOT NULL
            --AND ccode4_name IS NOT NULL
            ORDER BY CCODE4 desc, CCODE3 desc , CCODE2 desc , srprice DESC
    ) LOOP
        
        BEGIN
            
            IF tmp_loop2.ccode4 = '0' THEN
                SELECT SUBSTR(CA_CODE,0,6) INTO v_ca_code
                FROM EN_CATEGORY_MAP
                WHERE CUSTID= ltrim(rtrim(tmp_loop2.custid))
                AND CCODE1_NAME = ltrim(rtrim(tmp_loop2.ccode1_name))
                AND CCODE2_NAME = ltrim(rtrim(tmp_loop2.ccode2_name))
                AND CCODE3_NAME = ltrim(rtrim(tmp_loop2.ccode3_name))
                AND rownum=1;
            ELSE
                SELECT CA_CODE INTO v_ca_code
                FROM EN_CATEGORY_MAP
                WHERE CUSTID= ltrim(rtrim(tmp_loop2.custid))
                AND CCODE1_NAME = ltrim(rtrim(tmp_loop2.ccode1_name))
                AND CCODE2_NAME = ltrim(rtrim(tmp_loop2.ccode2_name))
                AND CCODE3_NAME = ltrim(rtrim(tmp_loop2.ccode3_name))
                AND CCODE4_NAME = ltrim(rtrim(tmp_loop2.ccode4_name))
                AND rownum=1;
            END IF;
            
            EXCEPTION WHEN OTHERS THEN
            v_ca_code := NULL;

        END;

        --DBMS_OUTPUT.PUT_LINE('CA_CODE..' || tmp_loop2.custid || '==' || tmp_loop2.ccode1_name || '==' || tmp_loop2.ccode2_name || '==' || tmp_loop2.ccode3_name || '==' || tmp_loop2.ccode4_name || '==v_ca_code==' || v_ca_code || '==' || length(v_ca_code));

        IF v_ca_code IS NOT NULL THEN            
            EXIT;            
        END IF;    
           
    END LOOP;    
    --===========================================================================================================================================
    INSERT INTO EN_GOODS (MODELNO, PIMGP, MODELNM, CA_CODE, FACTORY, BRAND, MINPRICE, AVGPRICE, MAXPRICE, POPULAR, MALLCNT, MINSALE)
    VALUES(v_modelno, tmp_loop.pimgp, tmp_loop.pnamep, v_ca_code, tmp_loop.maker, tmp_loop.brand, tmp_loop.minprice, tmp_loop.avgprice, tmp_loop.maxprice, 0, tmp_loop.mallcnt, tmp_loop.minsale);
    COMMIT;
    --DBMS_OUTPUT.PUT_LINE(loop_cnt || '==CA_CODE_1..' || tmp_loop2.custid || '==' || tmp_loop2.ccode1_name || '==' || tmp_loop2.ccode2_name || '==' || tmp_loop2.ccode3_name || '==' || tmp_loop2.ccode4_name || '==v_ca_code==' || v_ca_code);
    --DBMS_OUTPUT.PUT_LINE(loop_cnt || '==ca_code..' || v_ca_code);
    UPDATE enProdMain SET modelno=v_modelno, ca_code=v_ca_code WHERE PIMGP=tmp_loop.pimgp;
    COMMIT;
    
    IF v_ca_code IS NOT NULL THEN  
        INSERT INTO EN_GOODS_CATEGORY (CA_CODE, MODELNO) VALUES(v_ca_code, v_modelno);     
        COMMIT;
    END IF;
    
    COMMIT;
    --===========================================================================================================================================

 END LOOP;
 
 --==========================================================================================
 --카테고리 없는 모델/상품 처리
 --==========================================================================================
 --FOR tmp_loop in (SELECT modelno FROM EN_GOODS WHERE (ca_code IS NULL OR LENGTH(ca_code)=6)) LOOP
 FOR tmp_loop in (SELECT modelno FROM EN_GOODS) LOOP
    v_ca_code := NULL;
    FOR tmp_loop2 in (SELECT custid, ccode1_name, ccode2_name, ccode3_name, ccode4_name, ccode3, ccode4 FROM enProdMain WHERE modelno=tmp_loop.modelno ORDER BY CCODE4 desc, CCODE3 desc , CCODE2 desc , srprice DESC) LOOP
        
        BEGIN
                
            IF tmp_loop2.ccode4 = '0' THEN
                SELECT SUBSTR(CA_CODE,0,6) INTO v_ca_code
                FROM EN_CATEGORY_MAP
                WHERE CUSTID= ltrim(rtrim(tmp_loop2.custid))
                AND CCODE1_NAME = ltrim(rtrim(tmp_loop2.ccode1_name))
                AND CCODE2_NAME = ltrim(rtrim(tmp_loop2.ccode2_name))
                AND CCODE3_NAME = ltrim(rtrim(tmp_loop2.ccode3_name))
                AND rownum=1;
            ELSE
                SELECT CA_CODE INTO v_ca_code
                FROM EN_CATEGORY_MAP
                WHERE CUSTID= ltrim(rtrim(tmp_loop2.custid))
                AND CCODE1_NAME = ltrim(rtrim(tmp_loop2.ccode1_name))
                AND CCODE2_NAME = ltrim(rtrim(tmp_loop2.ccode2_name))
                AND CCODE3_NAME = ltrim(rtrim(tmp_loop2.ccode3_name))
                AND CCODE4_NAME = ltrim(rtrim(tmp_loop2.ccode4_name))
                AND rownum=1;
            END IF;
            
        EXCEPTION WHEN OTHERS THEN
            v_ca_code := NULL;
        END;
        
        IF v_ca_code IS NOT NULL THEN    
        
            --DBMS_OUTPUT.PUT_LINE('==custid..' || tmp_loop2.custid);
            --DBMS_OUTPUT.PUT_LINE('==ccode1_name..' || tmp_loop2.ccode1_name);
            --DBMS_OUTPUT.PUT_LINE('==ccode2_name..' || tmp_loop2.ccode2_name);
            --DBMS_OUTPUT.PUT_LINE('==ccode3_name..' || tmp_loop2.ccode3_name);
            
            DELETE EN_GOODS_CATEGORY WHERE modelno=v_modelno;
            COMMIT;
            INSERT INTO EN_GOODS_CATEGORY(CA_CODE, MODELNO) VALUES(v_ca_code, v_modelno);
            COMMIT;
            UPDATE enProdMain SET ca_code=v_ca_code WHERE modelno=tmp_loop.modelno;
            COMMIT;
            UPDATE en_goods SET ca_code=v_ca_code WHERE modelno=tmp_loop.modelno AND NVL(ca_code,' ') <> v_ca_code;
            COMMIT;
            
            EXIT;
                        
        END IF;
            
    END LOOP;
    
    --DBMS_OUTPUT.PUT_LINE('==v_ca_code2..' || v_ca_code);    
    IF v_ca_code IS NULL THEN
        --DBMS_OUTPUT.PUT_LINE('==v_ca_code3..' || v_ca_code);
        DELETE EN_GOODS_CATEGORY WHERE modelno=v_modelno;
        COMMIT;
        UPDATE en_goods SET ca_code=NULL WHERE modelno=tmp_loop.modelno;
        COMMIT;
        UPDATE enProdMain SET ca_code=NULL WHERE modelno=tmp_loop.modelno;
        COMMIT;
    END IF;
 
 END LOOP;

END UDP_EN_GOODS;