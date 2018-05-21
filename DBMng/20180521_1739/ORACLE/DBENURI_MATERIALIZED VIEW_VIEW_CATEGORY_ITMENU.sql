/* *************************************************************************
 * NAME : DBENURI.VIEW_CATEGORY_ITMENU
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-03-28 18:53:31
 *        Modify: 2018-03-28 18:53:31
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "DBENURI"."VIEW_CATEGORY_ITMENU" ("CA_CODE2", "CA_CODE3", "C_NAME2", "C_NAME3", "C_SEQNO2", "C_SEQNO3", "C_KNOWBOX2", "C_ITSORT", "C_LOCATION")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DBENURI3" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH COMPLETE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS ENABLE QUERY REWRITE
  AS SELECT a.ca_code ca_code2,b.ca_code ca_code3, a.c_name c_name2,b.c_name c_name3, a.c_seqno c_seqno2,
     b.c_seqno c_seqno3, a.c_knowbox c_knowbox2, a.c_itsort c_itsort,a.c_location c_location
     FROM tbl_category a INNER JOIN  tbl_category b ON a.ca_code = SUBSTR(b.ca_code,0,4) AND b.c_level=3
     AND a.c_level=2 and a.c_seqno>0 and a.c_itsort>0
     AND a.ca_code>'00' AND a.ca_code<>'00' AND a.ca_code<>'XX'
     AND b.ca_code>'00' AND b.ca_code<>'00' AND b.ca_code<>'XX'
     AND b.c_seqno>0
     --and b.ca_code3 NOT IN ('020906','030409','030410','020607','020111','040401','040808')
     UNION ALL
     SELECT ca_code ca_code2,NULL ca_code3,c_name c_name3,NULL c_name2,c_seqno c_seqno2,NULL c_seqno3,
     c_knowbox c_knowbox2, c_itsort  c_itsort, c_location c_location FROM TBL_CATEGORY a
     WHERE ca_code IN ('9702','0702') AND c_seqno >0
     