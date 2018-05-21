/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_CA_COUNT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:24
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_CA_COUNT" 
IS

ca_count     NUMBER(6) := 0;
ca_count_tmp NUMBER(6) := 0;
BEGIN
    --SET SERVEROUTPUT ON 
    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......1');

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_CA_COUNT','START');
    COMMIT;
    
    
    --WHILE i < 3 LOOP
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......' || ca_mlists(i) ||'%');
    
    DELETE TBL_GOODS_CA_COUNT WHERE YYYYMMDD=to_char(sysdate,'yyyymmdd');
    COMMIT;
    --===============================================================================================================================================================
    FOR tmp_loop in (SELECT to_char(sysdate,'yyyymmdd') yyyymm,substr(ca_code,0,4) ca_mcode,NVL(count(distinct modelno),0) cnt 
        FROM TBL_GOODS WHERE mallcnt>0  AND constrain = '1' AND jobcode>0 AND minprice > 0 GROUP BY substr(ca_code,0,4)) LOOP
    
        --DELETE tbl_goods_group  WHERE ca_code like tmp_loop.ca_sub_code || '%';
        --INSERT INTO tbl_goods_group
        ca_count := tmp_loop.cnt;
        
        FOR tmp_loop2 in (SELECT ca_sub_code FROM TBL_GOODS_COPYCATE WHERE ca_code = tmp_loop.ca_mcode) LOOP
        
            SELECT NVL(count(distinct modelno),0) into ca_count_tmp
            FROM TBL_GOODS WHERE ca_code LIKE tmp_loop2.ca_sub_code || '%'
            AND mallcnt > 0  AND constrain = '1' AND jobcode > 0 AND minprice > 0;
            
            ca_count := ca_count + ca_count_tmp;
           
        END LOOP;
        
        INSERT INTO TBL_GOODS_CA_COUNT(YYYYMMDD,CA_CODE,CA_COUNT) VALUES(tmp_loop.yyyymm,tmp_loop.ca_mcode,ca_count);
        
        COMMIT;
        
    END LOOP;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_CA_COUNT','END');
    COMMIT;
    
END UDP_GOODS_CA_COUNT;