/* *************************************************************************
 * NAME : DBENURI.VIEW_CATEGORY_MENU
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-03-28 18:53:31
 *        Modify: 2018-03-28 18:53:31
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "DBENURI"."VIEW_CATEGORY_MENU" ("CA_CODE2", "CA_CODE3", "C_NAME2", "C_NAME3", "C_SEQNO2", "C_SEQNO3", "C_KNOWBOX2", "C_LOCATION")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DBENURI3" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH COMPLETE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS ENABLE QUERY REWRITE
  AS SELECT a.ca_code ca_code2,
b.ca_code ca_code3,
a.c_name c_name2,
b.c_name c_name3,
a.c_seqno c_seqno2,
b.c_seqno c_seqno3,
a.c_knowbox c_knowbox2,
a.c_location c_location
FROM tbl_category a LEFT JOIN tbl_category b ON a.ca_code = SUBSTR (b.ca_code, 0, 4) AND b.c_level = 3 	AND (b.c_seqno IS NULL OR b.c_seqno > 0)
WHERE a.c_level = 2 AND
(
	a.ca_code > '00' AND a.ca_code < > '00' AND a.ca_code < > 'XX' AND a.c_seqno > 0
)