/* *************************************************************************
 * NAME : DBENURI.MV_CATEGORY_LEVEL3
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-03-28 18:53:31
 *        Modify: 2018-03-28 18:53:31
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "DBENURI"."MV_CATEGORY_LEVEL3" ("C_POPULAR", "C_SEQNO", "CA_CODE", "C_NAME", "M_SEQNO", "M_CA_CODE", "M_C_NAME", "M_GROUP_FLAG", "M_GROUP_CACODE")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DBENURI7" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON COMMIT
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS SELECT ca.c_popular,
ca.c_seqno,
ca.ca_code,
ca.c_name,
mca.m_seqno,
mca.m_ca_code,
Replace
(
	mca.m_c_name,
	'<br>',
	''
)
m_c_name,
mca.m_group_flag,
mca.m_group_cacode
FROM tbl_category ca,
tbl_mobile_category mca
WHERE ca.ca_code = mca.ca_code
(
	+
)
AND ca.c_level = 3 AND ca.c_seqno > 0 AND ca.c_name < > 'temp' AND
(
	mca.m_c_name IS NULL OR mca.m_c_name < > 'temp'
)