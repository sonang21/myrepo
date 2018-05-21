/* *************************************************************************
 * NAME : DBADM.VW_INDEXES
 * TYPE : VIEW
 * TIME : Create: 2018-03-27 20:23:19
 *        Modify: 2018-03-27 20:23:19
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DBADM"."VW_INDEXES" ("DB_NAME", "INDEX_OWNER", "TABLE_NAME", "INDEX_NAME", "COLUMN_CNT", "INDEX_COLUMNS", "INDEX_TYPE", "UNIQUENESS", "TABLESPACE_NAME", "PARTITIONED") AS 
  select /*+ first_rows xrule */ 
       sys_context('userenv','db_name') as db_name
     , a.index_owner                    as index_owner
     , a.table_name                     as table_name 
     , a.index_name                     as index_name
     , a.column_cnt                     as column_cnt
     , replace(substr(sys_connect_by_path(a.column_name,'~'),2),'~',',') index_columns
     , c.index_type, c.uniqueness, c.tablespace_name
     , decode(c.partitioned, 'YES', 'Y', 'NO', 'N', c.partitioned)  as partitioned
from 
     (
      select a.index_owner, a.index_name, a.table_name, a.column_position
           , nvl(fn_get_ixcol_exp(a.index_owner, a.index_name, a.column_position),a.column_name) column_name
           , count(*) over (partition by a.index_owner, a.index_name) column_cnt
      from all_ind_columns a 
      -- where a.index_owner = 'SCADM'
     ) a
    , all_indexes c
where a.column_position=a.column_cnt  -- get last row 
  and a.index_owner=c.owner and a.index_name=c.index_name
  and a.index_owner in (select username from dba_users where user_id > 80 and username <> 'SCOTT')
start with a.column_position=1
connect by prior a.index_owner=a.index_owner and prior a.index_name=a.index_name
                 and prior(a.column_position+1) = a.column_position
order by a.index_owner, a.table_name, a.index_name