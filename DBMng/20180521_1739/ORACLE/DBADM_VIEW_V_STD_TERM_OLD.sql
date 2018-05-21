/* *************************************************************************
 * NAME : DBADM.V_STD_TERM_OLD
 * TYPE : VIEW
 * TIME : Create: 2018-04-23 14:19:55
 *        Modify: 2018-04-23 14:19:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DBADM"."V_STD_TERM_OLD" ("TERMNAME", "TERM_NAME", "TERMENGNAME", "TERM_ENG_NAME", "DOMAINNAME", "LDATATYPE", "PDATATYPE", "COMMENTS", "SYSNAME") AS 
  select distinct    
          case when substr(a.term_name, -1,1) in ('1','2','3','4','5','6','7','8','9') then
                    substr(a.term_name, 1, length(a.term_name) -1) 
               else a.term_name
          end                       TERMNAME
        , a.term_name               term_name
        , case when substr(a.term_name, -1,1) in ('1','2','3','4','5','6','7','8','9') then
                    substr(a.term_eng_name, 1, length(a.term_eng_name) -1) 
               else a.term_eng_name
          end                       TERMENGNAME
        , a.term_eng_name           term_eng_name
        , a.domain_name             DOMAINNAME 
        , case upper(c.sysname) 
               when 'HBASE'     then b.hbase_type
               when 'ORACLE'    then b.oracle_type
               when 'MSSQL'     then b.mssql_type
          end  LDATATYPE
        , case upper(c.sysname) 
               when 'HBASE'     then b.hbase_type
               when 'ORACLE'    then replace(b.oracle_type, 'varchar(','varchar2(')
               when 'MSSQL'     then b.mssql_type
          end  PDATATYPE
        , null as comments
        , c.sysname
     from tb_std_term a
          left outer join tb_std_domain b on b.domain_name = a.domain_name
          cross join (select 'HBASE' sysname from dual
                      union all
                      select 'ORACLE' sysname from dual
                      union all
                      select 'MSSQL' sysname from dual
                     ) c
     -- where substr(a.term_name,-1,1) not in ('1','2','3','4','5','6','7','8','9','0');