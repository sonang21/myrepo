/* *************************************************************************
 * NAME : MIGTEST.MV_TEST
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-04-27 12:55:20
 *        Modify: 2018-04-27 12:55:20
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "MIGTEST"."MV_TEST" ("CA_CODE", "MODELNO", "MODELNO_GROUP", "CONSTRAIN", "JOBCODE", "CA_LCODE", "POPULAR", "SUM_POPULAR", "SALE_CNT", "SUM_SALE_CNT", "OPENEXPECTFLAG", "RECOMMEND", "MINPRICE", "MAXPRICE", "MINPRICE2", "MINPRICE3", "MINPRICE4", "MALLCNT", "MALLCNT3", "GROUP_YN")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS NOLOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TS_MIGTEST_D1" 
  PARALLEL 8 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH COMPLETE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS ENABLE QUERY REWRITE
  AS SELECT /*+ PARALLEL(8) */
    B.CA_CODE, 
    A.MODELNO, 
    CAST(NVL(A.MODELNO_GROUP, A.MODELNO)   AS NUMBER(8))   AS MODELNO_GROUP,
    A.CONSTRAIN, 
    A.JOBCODE, 
    B.CA_LCODE,
    C.POPULAR, 
    C.SUM_POPULAR, 
    C.SALE_CNT,
    C.SUM_SALE_CNT,
--    A.INFO_POINT1,
--    A.INFO_POINT2,
--    A.INFO_POINT3,
--    C.INFO_SUM_POINT,
    A.OPENEXPECTFLAG,
    A.RECOMMEND,
    C.MINPRICE, 
    C.MAXPRICE, 
    C.MINPRICE2,
    C.MINPRICE3,
    C.MINPRICE4,
    C.MALLCNT, 
    C.MALLCNT3, 
    CAST(NVL2(A.MODELNO_GROUP, 'Y','N') AS VARCHAR(1))   AS GROUP_YN
FROM MIGTEST.TBL_GOODS A 
    JOIN MIGTEST.TBL_CATE_GOODS B ON B.MODELNO=A.MODELNO
    JOIN MIGTEST.TBL_GOODS_SUM C ON C.MODELNO = A.MODELNO