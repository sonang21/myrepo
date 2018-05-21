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
        , case when sysname = 'HBASE' and CF_L <> '기본' then CF_L ||'.'
          else ''
          end ||                   -- HBASE의 컬럼 논리명에 대하여 컬럼패밀리 기본이 아닌 것에 대한 컬럼패밀리명 포함
          case when substr(a.term_name, -1,1) in ('1','2','3','4','5','6','7','8','9') then
                    substr(a.term_name, 1, length(a.term_name) -1) 
               else a.term_name
          end                       TERMNAME      -- 용어의 마지막이 숫자인 것은 숫자 제거한 것을 표준으로(Addin에서 번호 처리함)
        --, a.term_name               term_name   -- 중복제거를 위해서 컬럼 제외
        , case when sysname = 'HBASE' and CF_L <> '기본' then CF_P ||'.'||CF_P||'_'
          else ''
          end ||                   -- HBASE의 컬럼 물리명에 대하여 컬럼패밀리 기본이 아닌 것에 대한 컬럼패밀리명 포함
          case when substr(a.term_name, -1,1) in ('1','2','3','4','5','6','7','8','9') then
                    substr(a.term_eng_name, 1, length(a.term_eng_name) -1) 
               else a.term_eng_name 
          end                       TERMENGNAME   -- 영문에서도 끝에 숫자는 제거
        -- , a.term_eng_name           term_eng_name -- 중복제거 위해 컬럼 제외
        , a.domain_name             DOMAINNAME 
        , case upper(c.sysname) 
               when 'HBASE'     then b.hbase_type
               when 'ORACLE'    then b.oracle_type
               when 'MSSQL'     then b.mssql_type
          end  LDATATYPE
        , case upper(c.sysname) 
               when 'HBASE'     then b.hbase_type
               when 'ORACLE'    then replace(b.oracle_type, 'varchar(','varchar2(')   -- 오라클의 varchar 물리타입을 varchar2로 변경
               when 'MSSQL'     then b.mssql_type
          end  PDATATYPE
        , null as comments
        , c.sysname
     from tb_std_term a
          left outer join tb_std_domain b on b.domain_name = a.domain_name   
          cross join (          select 'HBASE' sysname, '기본' as CF_L, '0' as CF_P from dual  -- HBASE는 컬럼패밀리에 대한 처리 필요          
                      union all select 'HBASE' sysname, '전체' as CF_L, 'A' as CF_P from dual
                      union all select 'HBASE' sysname, '기타' as CF_L, 'E' as CF_P from dual
                      
                      union all
                      select 'ORACLE' sysname, NULL, NULL from dual
                      union all
                      select 'MSSQL'  sysname, NULL, NULL from dual
                     ) c
     where 1 = 1
       and a.domain_name <> '테이블명'
       -- and substr(a.term_name,-1,1) not in ('1','2','3','4','5','6','7','8','9','0');
     order by sysname, bas_termname, termname