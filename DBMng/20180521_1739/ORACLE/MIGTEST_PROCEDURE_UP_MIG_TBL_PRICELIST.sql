/* *************************************************************************
 * NAME : MIGTEST.UP_MIG_TBL_PRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-17 13:33:38
 *        Modify: 2018-04-19 18:43:49
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "MIGTEST"."UP_MIG_TBL_PRICELIST" (P_VALUE VARCHAR2 DEFAULT NULL)
-- =============================================================================
-- ������̺� : TBL_PRICELIST (MIG_PRICELIST)
-- �ҽ����̺� : TBL_PRICELIST (OLD)
-- ��  �� : 
--------------------------------------------------------------------------------
-- �ۼ��� : ������
-- �ۼ��� : 2018.03.21
-- ----------------------------------------------------------------------------
-- [����] : 2018.04.19 : ��Ű�� ����� �ݵ�� ��ҹ��� �����Ͽ� �ϰ� ����
-- [Ȯ��] : source_schema=>DBENURI, target_schema => migtest
-- COUNT:
-- =============================================================================
IS
    -- ����� ���� ����
    V_TARGET_TABLE  VARCHAR2(100) := 'MIG_PRICELIST';  -- NEED CONNECT NAME FOR DDL
    V_SOURCE_TABLE  VARCHAR2(100) := 'TBL_PRICELIST(OLD)';
    -----------------------------------------------
    -- ���� ��� 
    V_SOURCE_COUNT  NUMBER ;
    V_TARGET_COUNT  NUMBER ;
    V_RESULT_COUNT  NUMBER := 0;
    -- V_WORK_COUNT    NUMBER := 0;       -- �۾� ���� �Ǽ� 
    -- V_WORK_UNIT     NUMBER := 1000000; -- �۾� ����(�̻��)
    V_JOB_NAME VARCHAR2(50);
    
BEGIN
    -----------------------------------------------------------------------------
    -- 01. [����] SP_LOG_CREATE('jobname', 'target_table','source_table');
    -----------------------------------------------------------------------------
    V_JOB_NAME := $$PLSQL_UNIT || CASE WHEN P_VALUE IS NOT NULL THEN '('||P_VALUE||')' END;
    DBADM.PG_MIG.SP_LOG_CREATE (V_JOB_NAME, V_TARGET_TABLE, V_SOURCE_TABLE);
    -------------------------------------------------------------------------------
    -- 02. SOURCE_COUNT & TARGET_COUNT -- SKIP FOR PERF
    -------------------------------------------------------------------------------   
    -- ���� [��������] ��ȯ �Ǽ� ���� 
    SELECT /*+ PARALLEL(4) */ 
           COUNT(*)                                             
      INTO V_SOURCE_COUNT
      FROM DBENURI.ASIS_TBL_PRICELIST;
   
    IF V_TARGET_COUNT IS NULL THEN
        V_TARGET_COUNT := V_SOURCE_COUNT;
    END IF;
    
    -------------------------------------------------------------------------------
    --03. [����] SP_LOG_START
    -------------------------------------------------------------------------------    
    -- DBADM.PG_MIG.SP_LOG_SOURCE_COUNT(V_SOURCE_COUNT, V_TARGET_COUNT);
    DBADM.PG_MIG.SP_LOG_START(P_SOURCE_CNT=>V_SOURCE_COUNT, P_TARGET_CNT=> V_TARGET_COUNT);
    /* *******************************************************************************
    -- 04. [����] MIG SQL
    ---------------------------------------------------------------------------------
    WHILE V_WORK_COUNT <= V_TARGET_COUNT
    LOOP
        -- DO SOMETHING
        V_WORK_COUNT := V_WORK_COUNT + V_WORK_UNIT;
    END;    
    ******************************************************************************* */  
    EXECUTE IMMEDIATE 'ALTER    TABLE migtest.'||V_TARGET_TABLE||'    NOLOGGING';
    -------------------------------------------------------------------------------
    -- ���� [��������] ��ȯ SQL �ۼ� ���� 
    
    INSERT /*+ APPEND */ INTO migtest.MIG_PRICELIST
         ( MODELNO                      
         , SHOP_CODE              
         , GOODSNM                
         , CA_CODE                
         , PRICE                  
         --------------------------- 5
         , URL                    
         , NOTE                   
         , SRVFLAG                
         , STATUS                 
         , AUTHFLAG               
         --------------------------- 10
         , AUTHDATE               
         , SOLDFLAG               
         , SOLDDATE               
         , U_DATE                 
         , RIGHTNLEFT             
         --------------------------- 15
         , ESSTOCKFLAG            
         , PL_NO                  
         , IMGURL                 
         , COUPON                 
         , AUTHVCODE              
         --------------------------- 20
         , JOBTYPE                
         , AIRCONFEETYPE          
         , DELPRICE               
         , ACCOUNT_YN             
         , IMGURLFLAG             
         --------------------------- 25
         , INSTANCE_PRICE         
         , GOODSFACTORY           
         , GOODSCODE              
         , DELIVERYINFO           
         , CASHBACK               
         --------------------------- 30
         , FREEINTEREST           
         , AGREE_MONTH            
         , POPULAR                
         , HOMEFLAG               
         , DELIVERYINFO2          
         --------------------------- 35
         , DELIVERYTYPE2          
         , PRICE_CARD             
         , OPTION_FLAG            
         , OPTION_FLAG2           
         , CATALOG_FLAG           
         --------------------------- 40
         , POWER_FLAG             
         , BID_FLAG               
         , ENURI_USER_ID          
         , PRICE_FLAG             
         , DELIVERY_LEV           
         --------------------------- 45
         , SET_YN                 
         , STORE_FLAG             
         , CA_CODE_DEPT           
         , MOBILE_FLAG            
         , POPULAR2               
         --------------------------- 50
         , MOBILE_URL)             
    SELECT /*+ PARALLEL(4) */ 
           MODELNO
         , SHOP_CODE
         , GOODSNM
         , CA_CODE
         , PRICE
         --------------------------- 5
         , URL
         , NOTE
         , SRVFLAG
         , STATUS
         , AUTHFLAG
         --------------------------- 10
         , AUTHDATE
         , SOLDFLAG
         , SOLDDATE
         , U_DATE
         , RIGHTNLEFT
         --------------------------- 15
         , ESSTOCKFLAG
         , PL_NO
         , IMGURL
         , COUPON
         , AUTHVCODE
         --------------------------- 20
         , JOBTYPE
         , AIRCONFEETYPE
         , DELPRICE
         , ACCOUNT_YN
         , IMGURLFLAG
         --------------------------- 25
         , INSTANCE_PRICE
         , GOODSFACTORY
         , GOODSCODE
         , DELIVERYINFO
         , CASHBACK
         --------------------------- 30
         , FREEINTEREST
         , AGREE_MONTH
         , POPULAR
         , HOMEFLAG
         , DELIVERYINFO2
         --------------------------- 35
         , DELIVERYTYPE2
         , PRICE_CARD
         , OPTION_FLAG
         , OPTION_FLAG2
         , CATALOG_FLAG
         --------------------------- 40
         , POWER_FLAG
         , BID_FLAG
         , ENURI_USER_ID
         , PRICE_FLAG
         , DELIVERY_LEV
         --------------------------- 45
         , SET_YN
         , STORE_FLAG
         , CA_CODE_DEPT
         , MOBILE_FLAG
         , POPULAR2
         --------------------------- 50
         , MOBILE_URL
      FROM DBENURI.ASIS_TBL_PRICELIST;

    -------------------------------------------------------------------------------
    -- 05. [����] COUNT EFFECTED ROWS AND COMMIT
    -------------------------------------------------------------------------------
    V_RESULT_COUNT := V_RESULT_COUNT + SQL%ROWCOUNT;
    
    COMMIT;
    EXECUTE IMMEDIATE 'ALTER    TABLE migtest.'||V_TARGET_TABLE||'    LOGGING';
    -------------------------------------------------------------------------------
    -- 06. [����] SP_LOG_END 
    -------------------------------------------------------------------------------
    DBADM.PG_MIG.SP_LOG_END(V_RESULT_COUNT);
EXCEPTION WHEN OTHERS THEN
    -- 07. [����] SP_LOG_END : ERROR
    DBADM.PG_MIG.SP_LOG_END(V_RESULT_COUNT, 'ERROR', SQLCODE, SQLERRM);
    RAISE;
END;