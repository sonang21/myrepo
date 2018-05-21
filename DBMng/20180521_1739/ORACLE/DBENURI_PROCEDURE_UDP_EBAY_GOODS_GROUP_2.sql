/* *************************************************************************
 * NAME : DBENURI.UDP_EBAY_GOODS_GROUP_2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 15:57:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_EBAY_GOODS_GROUP_2" 
/*
 NGIT 수정 반영 - 김영원 20180425
*/ 
IS
    v_check_count   NUMBER(6) := 0;
    v_group_count   NUMBER(6) := 0;
    
BEGIN

    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_EBAY_GOODS_GROUP_2','START');
    COMMIT;

    --==============================================================================================
   
    v_check_count :=0;
    
    FOR tmp_loop2 in  
    (            
        
        SELECT a.modelno, a.ca_code, MAX(b.popular) popular
        FROM TBL_GOODS a,
             TBL_GOODS_SUM b,
             tbl_pricelist d
        WHERE a.modelno = b.modelno
        AND a.modelno=d.modelno
        AND a.modelno NOT IN (SELECT modelno FROM TBL_EBAY_IMAGE_JOB WHERE shop_code=0)
        AND a.modelno NOT IN (SELECT modelno FROM TBL_EBAY_IMAGE_JOB_ENURI)
        AND b.mallcnt > 0
        AND a.jobcode > '0'
        AND a.constrain = '1'
        AND (a.ca_code LIKE '0201%%' OR a.ca_code LIKE '0203%' OR a.ca_code LIKE '0208' OR a.ca_code LIKE '0211%' OR a.ca_code LIKE '0215%' OR a.ca_code LIKE '0220%' OR a.ca_code LIKE '0224%' OR a.ca_code LIKE '0304%' OR a.ca_code LIKE '0305%' OR a.ca_code LIKE '0318%' OR a.ca_code LIKE '0352%' OR a.ca_code LIKE '0353%' OR a.ca_code LIKE '0354%' OR a.ca_code LIKE '0355%' OR a.ca_code LIKE '0356%' OR a.ca_code LIKE '0357%' OR a.ca_code LIKE '0359%' OR a.ca_code LIKE '0360%' OR a.ca_code LIKE '0361%' OR a.ca_code LIKE '0501%' OR a.ca_code LIKE '0502%' OR a.ca_code LIKE '0503%' OR a.ca_code LIKE '0504%' OR a.ca_code LIKE '0505%' OR a.ca_code LIKE '0506%' OR a.ca_code LIKE '0507%' OR a.ca_code LIKE '0508'
            OR a.ca_code LIKE '0510%' OR a.ca_code LIKE '0511%' OR a.ca_code LIKE '0513%' OR a.ca_code LIKE '0514%' OR a.ca_code LIKE '0515%' OR a.ca_code LIKE '0516%' OR a.ca_code LIKE '0519%' OR a.ca_code LIKE '0521%' OR a.ca_code LIKE '0526%' OR a.ca_code LIKE '0527%' OR a.ca_code LIKE '0530%' OR a.ca_code LIKE '0601%' OR a.ca_code LIKE '0602%' OR a.ca_code LIKE '0603%' OR a.ca_code LIKE '0605%' OR a.ca_code LIKE '0606%' OR a.ca_code LIKE '0607%' OR a.ca_code LIKE '0608%' OR a.ca_code LIKE '0609%' OR a.ca_code LIKE '0610%' OR a.ca_code LIKE '0611%' OR a.ca_code LIKE '0621%' OR a.ca_code LIKE '0801%' OR a.ca_code LIKE '0802%' OR a.ca_code LIKE '0803%' OR a.ca_code LIKE '0804%' OR a.ca_code LIKE '0805%' OR a.ca_code LIKE '0806%' OR a.ca_code LIKE '0807%' OR a.ca_code LIKE '0808'
            OR a.ca_code LIKE '0809%' OR a.ca_code LIKE '0810%' OR a.ca_code LIKE '0812%' OR a.ca_code LIKE '0814%' OR a.ca_code LIKE '0901%' OR a.ca_code LIKE '0903%' OR a.ca_code LIKE '0904%' OR a.ca_code LIKE '0905%' OR a.ca_code LIKE '0906%' OR a.ca_code LIKE '0908%' OR a.ca_code LIKE '0909%' OR a.ca_code LIKE '0911%' OR a.ca_code LIKE '0912%' OR a.ca_code LIKE '0913%' OR a.ca_code LIKE '0919%' OR a.ca_code LIKE '0920%' OR a.ca_code LIKE '0923%' OR a.ca_code LIKE '0925%' OR a.ca_code LIKE '0930%' OR a.ca_code LIKE '0931%' OR a.ca_code LIKE '0932%' OR a.ca_code LIKE '1001%' OR a.ca_code LIKE '1003%' OR a.ca_code LIKE '1004%' OR a.ca_code LIKE '1005%' OR a.ca_code LIKE '1007%' OR a.ca_code LIKE '1009%' OR a.ca_code LIKE '1010%' OR a.ca_code LIKE '1012%' OR a.ca_code LIKE '1013'
            OR a.ca_code LIKE '1020%' OR a.ca_code LIKE '1022%' OR a.ca_code LIKE '1024%' OR a.ca_code LIKE '1030%' OR a.ca_code LIKE '1201%' OR a.ca_code LIKE '1202%' OR a.ca_code LIKE '1203%' OR a.ca_code LIKE '1204%' OR a.ca_code LIKE '1205%' OR a.ca_code LIKE '1207%' OR a.ca_code LIKE '1219%' OR a.ca_code LIKE '1225%' OR a.ca_code LIKE '1501%' OR a.ca_code LIKE '1502%' OR a.ca_code LIKE '1503%' OR a.ca_code LIKE '1504%' OR a.ca_code LIKE '1505%' OR a.ca_code LIKE '1506%' OR a.ca_code LIKE '1507%' OR a.ca_code LIKE '1508%' OR a.ca_code LIKE '1510%' OR a.ca_code LIKE '1511%' OR a.ca_code LIKE '1513%' OR a.ca_code LIKE '1602%' OR a.ca_code LIKE '1603%' OR a.ca_code LIKE '1605%' OR a.ca_code LIKE '1609%' OR a.ca_code LIKE '1611%' OR a.ca_code LIKE '1614%' OR a.ca_code LIKE '1620'
            OR a.ca_code LIKE '1621%' OR a.ca_code LIKE '1625%' OR a.ca_code LIKE '1626%' OR a.ca_code LIKE '1629%' OR a.ca_code LIKE '1632%' OR a.ca_code LIKE '1634%' OR a.ca_code LIKE '1635%' OR a.ca_code LIKE '1642%' OR a.ca_code LIKE '1643%' OR a.ca_code LIKE '1647%' OR a.ca_code LIKE '1648%' OR a.ca_code LIKE '1803%' OR a.ca_code LIKE '1807%' OR a.ca_code LIKE '1808%' OR a.ca_code LIKE '1822%' OR a.ca_code LIKE '2101%' OR a.ca_code LIKE '2104%' OR a.ca_code LIKE '2106%' OR a.ca_code LIKE '2108%' OR a.ca_code LIKE '2109%' OR a.ca_code LIKE '2113%' OR a.ca_code LIKE '2115%' OR a.ca_code LIKE '2117%' OR a.ca_code LIKE '2122%' OR a.ca_code LIKE '2131%' OR a.ca_code LIKE '2201%' OR a.ca_code LIKE '2205%' OR a.ca_code LIKE '2206%' OR a.ca_code LIKE '2207%' OR a.ca_code LIKE '2208%' OR a.ca_code LIKE '2211'
            OR a.ca_code LIKE '2212%' OR a.ca_code LIKE '2213%' OR a.ca_code LIKE '2222%' OR a.ca_code LIKE '2223%' OR a.ca_code LIKE '2226%' OR a.ca_code LIKE '2227%' OR a.ca_code LIKE '2241%' OR a.ca_code LIKE '2242%' OR a.ca_code LIKE '2243%' OR a.ca_code LIKE '2244')
        AND NVL(a.imgchk,'0') NOT IN ('1','6','7','5','S')
        AND d.status='0'         
        AND d.srvflag='0'
        AND d.shop_code IN (4027,536)
        GROUP BY a.modelno, a.ca_code
        ORDER BY modelno DESC
    
    ) LOOP  
         
        IF v_check_count = 0 THEN
            
            SELECT NVL(MAX(GROUP_NO),0) + 1 INTO v_group_count FROM TBL_EBAY_IMAGE_JOB_ENURI_GROUP WHERE group_no < 100000;
            
            INSERT INTO TBL_EBAY_IMAGE_JOB_ENURI_GROUP(GROUP_NO) VALUES (v_group_count);
            COMMIT;
            
        END IF;
    
        v_check_count := v_check_count + 1;        
        IF v_check_count = 30 THEN
            v_check_count := 0;           
        END IF;

        INSERT INTO TBL_EBAY_IMAGE_JOB_ENURI(MODELNO,GROUP_NO,CA_CODE,SHOP_CODE) VALUES (tmp_loop2.modelno,v_group_count,tmp_loop2.ca_code,0);            
        COMMIT;           
        
    END LOOP;
    COMMIT;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_EBAY_GOODS_GROUP_2','END');
    COMMIT;

END UDP_EBAY_GOODS_GROUP_2;
