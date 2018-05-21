/* *************************************************************************
 * NAME : DBADM.V_STD_TERM
 * TYPE : VIEW
 * TIME : Create: 2018-04-10 18:30:19
 *        Modify: 2018-04-23 14:43:08
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DBADM"."V_STD_TERM" ("BAS_TERMNAME", "TERMNAME", "TERMENGNAME", "DOMAINNAME", "LDATATYPE", "PDATATYPE", "COMMENTS", "SYSNAME") AS 
  select distinct  
          case when substr(a.term_name, -1,1) in ('1','2','3','4','5','6','7','8','9') then
                    substr(a.term_name, 1, length(a.term_name) -1) 
               else a.term_name
          end                       BAS_TERMNAME
        , case when sysname = 'HBASE' and CF_L <> '�⺻' then CF_L ||'.'
          else ''
          end ||                   -- HBASE�� �÷� ���� ���Ͽ� �÷��йи� �⺻�� �ƴ� �Ϳ� ���� �÷��йи��� ����
          case when substr(a.term_name, -1,1) in ('1','2','3','4','5','6','7','8','9') then
                    substr(a.term_name, 1, length(a.term_name) -1) 
               else a.term_name
          end                       TERMNAME      -- ����� �������� ������ ���� ���� ������ ���� ǥ������(Addin���� ��ȣ ó����)
        --, a.term_name               term_name   -- �ߺ����Ÿ� ���ؼ� �÷� ����
        , case when sysname = 'HBASE' and CF_L <> '�⺻' then CF_P ||'.'||CF_P||'_'
          else ''
          end ||                   -- HBASE�� �÷� ������ ���Ͽ� �÷��йи� �⺻�� �ƴ� �Ϳ� ���� �÷��йи��� ����
          case when substr(a.term_name, -1,1) in ('1','2','3','4','5','6','7','8','9') then
                    substr(a.term_eng_name, 1, length(a.term_eng_name) -1) 
               else a.term_eng_name 
          end                       TERMENGNAME   -- ���������� ���� ���ڴ� ����
        -- , a.term_eng_name           term_eng_name -- �ߺ����� ���� �÷� ����
        , a.domain_name             DOMAINNAME 
        , case upper(c.sysname) 
               when 'HBASE'     then b.hbase_type
               when 'ORACLE'    then b.oracle_type
               when 'MSSQL'     then b.mssql_type
          end  LDATATYPE
        , case upper(c.sysname) 
               when 'HBASE'     then b.hbase_type
               when 'ORACLE'    then replace(b.oracle_type, 'varchar(','varchar2(')   -- ����Ŭ�� varchar ����Ÿ���� varchar2�� ����
               when 'MSSQL'     then b.mssql_type
          end  PDATATYPE
        , null as comments
        , c.sysname
     from tb_std_term a
          left outer join tb_std_domain b on b.domain_name = a.domain_name   
          cross join (          select 'HBASE' sysname, '�⺻' as CF_L, '0' as CF_P from dual  -- HBASE�� �÷��йи��� ���� ó�� �ʿ�          
                      union all select 'HBASE' sysname, '��ü' as CF_L, 'A' as CF_P from dual
                      union all select 'HBASE' sysname, '��Ÿ' as CF_L, 'E' as CF_P from dual
                      
                      union all
                      select 'ORACLE' sysname, NULL, NULL from dual
                      union all
                      select 'MSSQL'  sysname, NULL, NULL from dual
                     ) c
     where 1 = 1
       and a.domain_name <> '���̺��'
       -- and substr(a.term_name,-1,1) not in ('1','2','3','4','5','6','7','8','9','0');
     order by sysname, bas_termname, termname