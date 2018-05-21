/* *************************************************************************
 * NAME : DBADM.DBM_SCHEMA
 * TYPE : PACKAGE
 * TIME : Create: 2018-03-27 20:23:00
 *        Modify: 2018-03-27 20:23:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "DBADM"."DBM_SCHEMA" authid current_user
as
    /* ************************************************************************
     * desc : index - backup, drop, recreate
     *        fk    - backup, drop, recreate, enable, disable
     *        proc/func - backup and versioning
     *        privilage - backup and re-grant
     * ver  : 2013.10.11
     * 
    ************************************************************************ */
    -- create type array_varchar table of varchar;
    g_schema_list       array_varchar;
    
    --function  fn_split(p_list varchar2, p_delim varchar2) return array_varchar pipelined;
    -- 백업 대상으로 설정된 스키마 리스트를 출력함
    -- 예) select * from table(dbm_schema.fn_get_schema);
    function  fn_get_schema return array_varchar;
    -- 함수기반 인덱스 등의 함수정의를 반환함
    -- 예) select dbm_schema.fn_get_index_column_expression('dba','ix_table', 2) from dual;
    function  fn_get_index_column_expression(p_owner varchar2, p_ixname varchar2, p_position number) return varchar2; 
    
    -- 관리대상 스키마를 설정함
    -- 예) exec dbm_schema.set_schema('user1,user2,user3);
    procedure set_schema(p_schema_list in varchar2);
    
    -- 중요 오브젝트의 생성 스크립트를 백업함
    -- 예) exec dbm_schema.ddl_script_backup('SCOTT');
    procedure ddl_script_backup(p_obj_owner in varchar2);
    
    /*==============================================================================*
      SP NAME : index_backup
      SP DESC.: 
             - DB에 생성된 INDEX 정보를 TB_SCHEMA_INDEX 테이블에 저장한다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_ixname: 인덱스 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
    *==============================================================================*/
    procedure index_backup 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_ixname in varchar2 default '%' 
        );
    
    -- INDEX 구성 백업으로 부터 현재 없는 인덱스를 생성함
    -- 예) exec dbm_schema.index_recreate('SCOTT');
    procedure index_recreate(p_owner in varchar2);
    
    /*==============================================================================*
      SP NAME : fk_backup
      SP DESC.: 
             - DB에 생성된 FK의 정보를 TB_SCHEMA_FK 테이블에 저장한다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
    *==============================================================================*/
    procedure fk_backup 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
        );
    
    
     /*==============================================================================*
      SP NAME : fk_drop
      SP DESC.: 
             - FK 정보를 테이블에 저장한 후 DROP한다.
               테이블에 저장된 정보를 사용하여 SP_DBM_FK_RECOVER로 다시 복구할 수 있다.
             - set serverout on이 설정되어야 실행 결과 또는 스크립트 출력을 확인할 수 있다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
             p_exec  : 0 : FK를 drop하는 스크립트를 출력한다.
                       1 : FK를 drop한다.
                       
    *==============================================================================*/ 
    procedure fk_drop 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
         , p_exec in number default 0);
    
    
    /*==============================================================================*
      SP NAME : fk_recover
      SP DESC.: 
             - 테이블에 저장된 정보를 사용하여 FK를 생성한다.
             - set serverout on이 설정되어야 실행 결과 또는 스크립트 출력을 확인할 수 있다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
             p_status: 생성시 FK 옵션을 입력한다. ENABLE/DISABLE/ENABLE NOVALIDATE
             p_exec  : 1 : FK를 생성한다.
                       0 : FK를 생성하는 스크립트를 출력한다.
    *==============================================================================*/
    procedure fk_recover 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
         , p_status in varchar2 default null 
         , p_exec in number default 0);
    
    /*==============================================================================*
      SP NAME : fk_change_status
      SP DESC.: 
             - 현재의 FK에 대해 활성화 또는 비활성화 한다.
             - 제시된 테이블의 FK뿐만 아니라 해당 테이블을 참조하는 FK에 대해서도 적용된다.
             - set serverout on이 설정되어야 실행 결과 또는 스크립트 출력을 확인할 수 있다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_status: 변경할 FK 상태를 입력한다. ENABLE/DISABLE/ENABLE NOVALIDATE
             p_exec  : 0 : FK 상태를 변경한는 스크립트를 출력한다.
                       1 : FK 상태를 변경한다.
             p_option: A : 제시된 테이블의 FK 및 해당 테이블을 참조하는 모든 FK에 적용
                       I : 제시된 테이블의 FK에 한해 적용
                       R : 제시된 테이블의 자기참조 FK에 대해서만 적용
    *==============================================================================*/
    procedure fk_change_status
        (  p_owner in varchar2 default null        -- 테이블 소유자
         , p_tname in varchar2 default '%'         -- 처리할 테이블 명
         , p_status in varchar2 default 'ENABLE'   -- enable(novalidate), disable
         , p_exec in number default 0              -- 1: 실행, 0: 스크립트 출력
         , p_option in varchar2 default 'A'        -- a:all 테이블 자신 및 자신을 참조하는 키, i:테이블 자신의 FK만
        );
        
    /*==============================================================================*
      SP NAME : fk_chk 
      SP DESC.: 
             - FK 정보를 저장하는 테이블에서 실제 DB에 존재하지 않는 
               FK를 delete하거나 delete 하는 스크립트를 생성한다.
             - 스크립트를 생성하거나 결과를 확인하기 위해서는 실행전에 
               sqlplus에서 set serverout on을 설정하여야 한다.           
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
             p_exec  : 0 : 실행할 수 있는 스크립트를 출력한다.
                       1 : 바로 실행한다.          
    *==============================================================================*/
    procedure fk_chk 
        (  p_owner in varchar2 default ''
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
         , p_exec in number default 0 
        );

end;
CREATE OR REPLACE PACKAGE BODY "DBADM"."DBM_SCHEMA" 
as
    /* ************************************************************************
     * desc : index - backup, drop, recreate
     *        fk    - backup, drop, recreate, enable, disable
     *        proc/func - backup and versioning
     *        privilage - backup and re-grant
     * ver  : 2013.10.11
     * 
    ************************************************************************ */

    /* ************************************************************************
     * 백업 대상 스키마 리스트를 출력함
     * 예) select * from table(dbm_schema.fn_get_schema);
    ************************************************************************ */     
    function fn_get_schema return array_varchar
    is
    begin
        return g_schema_list;
    end;
    
    /* ************************************************************************
     * 함수기반 인덱스 등의 함수정의를 반환함
     * 예) select dbm_schema.fn_get_index_column_expression('dba','ix_table', 2) from dual;
    ************************************************************************ */     
    function fn_get_index_column_expression(p_owner varchar2, p_ixname varchar2, p_position number) return varchar2
    is
        v_col_expression varchar2(32767);
    begin
        select column_expression into v_col_expression from all_ind_expressions
        where index_owner = p_owner and index_name=p_ixname and column_position=p_position;
        v_col_expression := substr(v_col_expression, 1, 2000);
        return v_col_expression;  
    end;
    
    
     /* ************************************************************************
     * 관리대상 스키마를 설정함
     * 예) exec dbm_schema.set_schema('user1,user2,user3);
    ************************************************************************ */     
    procedure set_schema(p_schema_list in varchar2)
    is
    begin
        select * bulk collect into g_schema_list from table(dbm_common.fn_split(p_schema_list, ','));
    end;

    /* ************************************************************************
     * 인덱스 구성을 백업함
     * 예) exec dbm_schema.index_backup('SCOTT');
    ************************************************************************ */     
    
    
    /*==============================================================================*
      SP NAME : index_backup
      SP DESC.: 
             - DB에 생성된 INDEX 정보를 TB_SCHEMA_INDEX 테이블에 저장한다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_ixname: 인덱스 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
    *==============================================================================*/
    procedure index_backup 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_ixname in varchar2 default '%' 
        ) 
    is 
       v_owner      varchar2(50); 
       v_tname      varchar2(100); 
       v_ixname     varchar2(100); 
       v_colist     varchar2(2000); 
       v_rowcount   number(5); 
    begin
       v_owner  := upper(p_owner); 
       v_tname  := upper(p_tname); 
       v_ixname := upper(p_ixname); 
     
        -- insert into tb_schema_index
        merge into tb_schema_index m
        using
            (select /*+ rule */ a.index_owner
                 , a.index_name
                 , a.table_name
                 , a.column_count
                 , replace(substr(sys_connect_by_path(a.column_name,'#$'),3),'#$',',') columns
                 , c.index_type
                 , c.uniqueness
                 , c.tablespace_name
                 , c.partitioned
            from 
               (
                select a.index_owner, a.index_name, a.table_name, a.column_position
                     , nvl(e.column_expression, a.column_name) || decode(a.descend, 'DESC', ' DESC','') column_name 
                     , count(*) over (partition by a.index_owner, a.index_name) column_count
                from dba_ind_columns a 
                   , ( select index_owner, index_name, column_position
                            , fn_get_index_column_expression(index_owner, index_name, column_position) column_expression --, to_lob(column_expression) column_expression
                       from dba_ind_expressions
                       where index_owner = p_owner
                     ) e
                where a.index_owner=p_owner
                  and a.index_owner=e.index_owner(+) and a.index_name=e.index_name(+) and a.column_position = e.column_position(+)
               ) a
              , dba_indexes c
            where a.column_position=a.column_count
              and a.index_owner=c.owner and a.index_name=c.index_name
            start with a.column_position=1
            connect by prior a.index_owner=a.index_owner and prior a.index_name=a.index_name
                             and prior(a.column_position+1) = a.column_position
            order by 1,2
            ) s
        on (m.index_owner = s.index_owner and m.index_name = s.index_name)
        when matched then update set m.table_name = s.table_name , m.column_count = s.column_count
                                   , m.columns = s.columns       , m.index_type = s.index_type
                                   , m.uniqueness = s.uniqueness , m.tablespace_name = s.tablespace_name
                                   , m.partitioned = s.partitioned
        when not matched then insert (index_owner, index_name, table_name, column_count, columns, index_type, uniqueness, tablespace_name, partitioned)
                         values(s.index_owner, s.index_name, s.table_name, s.column_count, s.columns, s.index_type
                              , s.uniqueness, s.tablespace_name, s.partitioned)
        ;
    end;
 
    /* ************************************************************************
     * INDEX 구성 백업으로 부터 현재 없는 인덱스를 생성함
     * 예) exec dbm_schema.index_recreate('SCOTT');
    ************************************************************************ */     
    procedure index_recreate(p_owner in varchar2) --, p_table in varchar2, p_index in varchar2)
    is
    begin
       return;
    end;
--    
    /* ************************************************************************
     * FK 설정을 백업함
     * 예) exec dbm_schema.fk_backup('SCOTT');
    ************************************************************************ */     
    -- procedure fk_backup(p_owner in varchar2)
    -- is
    -- begin
    --     insert into tb_schema_fk
    --     select a.owner, a.table_name, a.constraint_name, a.cnt, substr(sys_connect_by_path(a.column_name,','),2) columns
    --     from 
    --        (
    --         select c.owner, c.table_name, c.constraint_name, c.position, c.column_name
    --               ,count(*) over (partition by c.owner, c.table_name, c.constraint_name) cnt
    --         from dba_cons_columns c
    --            , dba_constraints s
    --         where c.owner=s.owner
    --           and c.constraint_name = s.constraint_name
    --           and s.constraint_type = 'R'
    --           and s.owner = p_owner
    --        ) a
    --     where a.position=a.cnt
    --     connect by prior owner = owner and  
    --                prior constraint_name = constraint_name  
    --                and prior (position + 1) = position
    --     start with position=1;
    -- end;
    
--    procedure fk_recreate;
--    procedure fk_enable;
--    procedure fk_disable;
--    procedure fk_check_sync;

    /* ************************************************************************
     * 중요 오브젝트의 생성 스크립트를 백업함
     * 예) exec dbm_schema.ddl_script_backup('SCOTT');
    ************************************************************************ */     
    procedure ddl_script_backup(p_obj_owner in varchar2)
    is
        v_obj_owner varchar2(50) := p_obj_owner;
        v_obj_cnt   number(10) := 0;
        v_obj_sum   number(10) := 0;
        v_err_cnt   number(1)  := 0;
    begin
      
        dbm_log.sp_log_start('dbm_schema.ddl_script_backup', 'dbm work', 'script backup');
        
        delete from dbadm.tb_schema_ddl;
        dbm_log.sp_log_msg('SUCCESS', to_char(SQL%ROWCOUNT) || ' deleted', '0.delete script backup');
        --execute immediate 'truncate table  dbadm.tb_schema_ddl_temp';
        begin 
            insert into dbadm.tb_schema_ddl(owner, obj_type, obj_nm, base_obj, gen_ddl, last_ddl_time)
            select a.owner, a.object_type, a.object_name, null as base_obj
                 , dbms_metadata.get_ddl(decode(a.object_type,'PACKAGE BODY','PACKAGE_BODY',a.object_type), a.object_name, a.owner) as gen_ddl 
                 , a.last_ddl_time
            from dba_objects a
            where a.owner=v_obj_owner
              and a.object_type in ('TABLE', 'VIEW', 'PROCEDURE','FUNCTION','SEQUENCE','PACKAGE','PACKAGE BODY','TRIGGER')
              and object_name not like 'BIN%'
            ;
            
            v_obj_cnt := SQL%ROWCOUNT;
            v_obj_sum := v_obj_sum + v_obj_cnt;
            
            dbm_log.sp_log_msg('SUCCESS', to_char(v_obj_cnt) || ' inserted', '1.OBJECTS', 'TABLE, VIEW, PROC, FUNC, SEQ, PKG, TRIGGER', 'info');
  
        exception when others then 
            dbm_log.sp_log_msg(SQLCODE, SQLERRM, '1.OBJECTS', 'TABLE, VIEW, PROC, FUNC, SEQ, PKG, TRIGGER', 'info');
            v_err_cnt := v_err_cnt + 1;
        end;
      
      
        begin 
            -- 인덱스 스크립트를 테이블로 저장한다.
            insert into dbadm.tb_schema_ddl(owner, obj_type, obj_nm, base_obj, uniqueness, partitioned, gen_ddl, last_ddl_time)
            select i.owner, 'INDEX', i.index_name, i.table_name as base_obj, i.uniqueness , i.partitioned
                 , dbms_metadata.get_ddl('INDEX', i.index_name, i.owner) as gen_ddl 
                 , o.last_ddl_time
            from dba_indexes i, dba_objects o
            where i.owner=v_obj_owner
              and i.index_name not like 'BIN%'
              and o.owner = i.owner
              and o.object_name = i.index_name
              and o.object_type = 'INDEX'
            ;
            
            v_obj_cnt := SQL%ROWCOUNT;
            v_obj_sum := v_obj_sum + v_obj_cnt;
            
            dbm_log.sp_log_msg('SUCCESS', to_char(v_obj_cnt) || ' inserted', '2.INDEX', 'Index Script backup', 'info');
  
        exception when others then 
            dbm_log.sp_log_msg(SQLCODE, SQLERRM, '2.INDEX', 'Index Script backup', 'info');
            v_err_cnt := v_err_cnt + 1;
        end;

        begin 
            -- PRIMARY KEY 스크립트를 저장한다.(USING절을 사용하고 있다)
            insert into dbadm.tb_schema_ddl(owner, obj_type, obj_nm, base_obj, gen_ddl, last_ddl_time)
            select c.owner, 'PRIMARY KEY', c.constraint_name, c.table_name as base_obj
                 , dbms_metadata.get_ddl('CONSTRAINT', c.constraint_name, c.owner) as gen_ddl 
                 , c.last_change
            from dba_constraints c
            where c.owner=v_obj_owner
              and c.constraint_type='P'
              and c.constraint_name not like 'BIN%'
            ;
            
            v_obj_cnt := SQL%ROWCOUNT;
            v_obj_sum := v_obj_sum + v_obj_cnt;
            
            dbm_log.sp_log_msg('SUCCESS', to_char(v_obj_cnt) || ' inserted', '3.PRIMARY KEY', 'PK Script backup', 'info');
  
        exception when others then 
            dbm_log.sp_log_msg(SQLCODE, SQLERRM, '3.PRIMARY KEY', 'PK Script backup', 'info');
            v_err_cnt := v_err_cnt + 1;
        end;
        
        begin 
            -- FOREIGN KEY 스크립트를 저장한다.
            insert into dbadm.tb_schema_ddl(owner, obj_type, obj_nm, base_obj, gen_ddl, last_ddl_time)
            select owner, 'FOREIGN KEY', constraint_name, table_name as base_obj
                 , dbms_metadata.get_ddl('REF_CONSTRAINT', constraint_name, owner) as gen_ddl 
                 , last_change
            from dba_constraints
            where owner=v_obj_owner
              and constraint_type='R'
            ;
            
            v_obj_cnt := SQL%ROWCOUNT;
            v_obj_sum := v_obj_sum + v_obj_cnt;
            
            dbm_log.sp_log_msg('SUCCESS', to_char(v_obj_cnt) || ' inserted', '4.FOREIGN KEY', 'FK Script backup', 'info');
  
        exception when others then 
            dbm_log.sp_log_msg(SQLCODE, SQLERRM, '4.FOREIGN KEY', 'FK Script backup', 'info');
            v_err_cnt := v_err_cnt + 1;
        end;
            
      /**********************************
      -- 중복 또는 삭제된 오브젝트 delete 
      delete from dbadm.tb_schema_ddl a 
      where exists (select 1 from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm and a.last_ddl_time <= b.last_ddl_time)
      
      delete from dbadm.tb_schema_ddl a
      where not exists (select 1 from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm and a.last_ddl_time)
      ------------------------------------------------------------------------------------------------------------------------
      update dbadm.tb_schema_ddl a 
         set base_obj      = (select base_obj      from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm)
           , uniqueness    = (select uniqueness    from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm)
           , partitioned   = (select partitioned   from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm)
           , gen_ddl       = (select gen_ddl       from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm)
           , last_ddl_time = (select last_ddl_time from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm)
       where exists (select 1 from dbadm.tb_schema_ddl_temp b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm)
      ;
      ------------------------------------------------------------------------------------------------------------------------
      insert into dbadm.tb_schema_ddl (owner, obj_type, obj_nm, base_obj, uniqueness, partitioned, gen_ddl, last_ddl_time)
      select owner, obj_type, obj_nm, base_obj, uniqueness, partitioned, gen_ddl, last_ddl_time
      from dbadm.tb_schema_ddl_temp a
      where not exists (select 1 from dbadm.tb_schema_ddl b where b.owner = a.owner and b.obj_type = a.obj_type and b.obj_nm = a.obj_nm)
      ;
      *****************************/
      
      commit;
      
      if v_err_cnt = 0 then 
        dbm_log.sp_log_end('SUCESS', v_obj_sum, 0, null);
      else
        dbm_log.sp_log_end('SUCESS', v_obj_sum, v_err_cnt, to_char(v_err_cnt)|| ' error ocurred, check tb_dbm_log_msgs');
      end if;
    end;
    
    
    /*==============================================================================*
      SP NAME : fk_backup
      SP DESC.: 
             - DB에 생성된 FK의 정보를 TB_SCHEMA_FK 테이블에 저장한다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
    *==============================================================================*/
    procedure fk_backup 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
        ) 
    is 
       v_owner      varchar2(50); 
       v_tname      varchar2(100); 
       v_fkname     varchar2(100); 
       v_colist     varchar2(2000); 
       v_rcolist    varchar2(2000); 
       v_rowcount   number(5); 
        
    begin 
       v_owner  := upper(p_owner); 
       v_tname  := upper(p_tname); 
       v_fkname := upper(p_fkname); 
     
        if v_owner is null then 
            dbms_output.enable(100); 
            dbms_output.put_line('usage: sp_tb_schema_fk_save(owner, tname[%], fkname[%])'); 
            return; 
        end if; 
         
       for icur in (select con.con# --, con.obj#, con.type#, con.robj#, con.rcon# 
                         , tnm.name tname, rnm.name rtname, cnm.name fkname 
                         , decode(con.refact, 1, 'ON DELETE CASCADE', 2, 'ON DELETE SET NULL', '') drule 
                         , decode(con.enabled,1,'ENABLE','DISABLE') 
                           ||decode(bitand(con.defer, 4), 4, ' VALIDATE', ' NOVALIDATE') status 
                         , twn.name towner, rwn.name rowner 
                    from sys.cdef$ con, sys.obj$ tnm, sys.con$ cnm, sys.obj$ rnm 
                        ,sys.user$ twn, sys.user$ rwn 
                    where (con.obj# in (select a.obj#  
                                     from sys.obj$ a, sys.user$ b 
                                     where a.owner# = b.user# 
                                       and a.name like v_tname  and a.type#=2 
                                       and b.name = v_owner)  
                           or  
                           con.robj# in (select a.obj#  
                                     from sys.obj$ a, sys.user$ b 
                                     where a.owner# = b.user# 
                                       and a.name like v_tname and a.type#=2 
                                       and b.name = v_owner) 
                          ) 
                      and con.type#=4 and con.obj#=tnm.obj# and con.robj#=rnm.obj# 
                      and con.con#=cnm.con# and tnm.owner#=twn.user# and rnm.owner#=rwn.user# 
                      and cnm.name like v_fkname 
                    ) 
        loop 
           v_colist := ''; 
           v_rcolist := ''; 
           for jcur in (select a.con#, a.obj#, b.col#, b.pos#, d.name colname, e.name rcolname 
                        from sys.cdef$ a, sys.ccol$ b, sys.ccol$ c, sys.col$ d, sys.col$ e 
                        where a.con#=icur.con# 
                          and a.con#=b.con# 
                          and a.rcon#=c.con# 
                          and b.pos#=c.pos# 
                          and b.obj#=d.obj# and b.col#=d.col# 
                          and c.obj#=e.obj# and c.col#=e.col# 
                        order by a.con#, b.pos#) 
           loop 
                if jcur.pos# = 1 then  
                    v_colist := jcur.colname;  
                    v_rcolist := jcur.rcolname; 
                else 
                    v_colist := v_colist ||','||jcur.colname; 
                    v_rcolist := v_rcolist ||','||jcur.rcolname; 
                end if; 
                v_rowcount := jcur.pos#; 
           end loop; 
            
           if v_rowcount > 0 then 
               delete from tb_schema_fk where owner=icur.towner and tname=icur.tname and fkname=icur.fkname; 
               insert into tb_schema_fk (owner, tname, fkname, cols, rowner, rtname, rcols, drule, status) --logdt=sysdate 
               values(icur.towner, icur.tname, icur.fkname, v_colist, icur.rowner, icur.rtname, v_rcolist, icur.drule, icur.status); 
           end if; 
           -- dbms_output.enable(20000); 
           -- dbms_output.put_line(v_colist||'...'||to_char(v_rowcount)); 
        end loop; 
        commit; 
    exception when others then 
        rollback; 
    end;

    /*==============================================================================*
      SP NAME : fk_recover
      SP DESC.: 
             - 테이블에 저장된 정보를 사용하여 FK를 생성한다.
             - set serverout on이 설정되어야 실행 결과 또는 스크립트 출력을 확인할 수 있다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
             p_status: 생성시 FK 옵션을 입력한다. ENABLE/DISABLE/ENABLE NOVALIDATE
             p_exec  : 1 : FK를 생성한다.
                       0 : FK를 생성하는 스크립트를 출력한다.
    *==============================================================================*/
    procedure fk_recover 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
         , p_status in varchar2 default null 
         , p_exec in number default 0) 
    is 
        v_sqltxt    varchar2(4000); 
        v_owner     varchar2(100); 
        v_tname     varchar2(100); 
        v_fkname    varchar2(100); 
        v_cols      varchar2(2000); 
        v_rcols     varchar2(2000); 
        v_status    varchar2(20); 
    begin 
        v_owner  := upper(p_owner); 
        v_tname  := upper(p_tname); 
        v_fkname := upper(p_fkname); 
        v_status := upper(p_status); 
     
        if v_owner is null then 
            dbms_output.enable(100); 
            dbms_output.put_line('usage: sp_tb_schema_fk_recover(p_owner=>, p_tname=>''%'', p_fkname=>''%'', p_status=>null, p_exec=>0)'); 
            dbms_output.put_line('       p_status=> enable, disable, enable novalidate'); 
            return; 
        end if; 
         
        for icur in (select a.owner, a.tname, a.fkname, a.cols, a.rowner, a.rtname, a.rcols 
                          , a.drule, nvl(v_status, a.status) status 
                     from dbadm.tb_schema_fk a 
                     where a.owner=v_owner and a.tname like v_tname and a.fkname like v_fkname 
                       and not exists(select 1 from dba_constraints b  -- all_constraints b  
                                      where a.owner=b.owner and b.table_name=a.tname and b.constraint_name=a.fkname) 
                     ) 
        loop 
            begin
                v_sqltxt := 'ALTER TABLE '||icur.owner||'.'||icur.tname||' ADD CONSTRAINT '||icur.fkname 
                            ||' FOREIGN KEY ('||icur.cols||') REFERENCES '||icur.rowner||'.'||icur.rtname 
                            ||'('||icur.rcols||') '||icur.drule||' '||icur.status; 
         
                dbms_output.enable(500); 
                if p_exec = 1 then 
                    execute immediate v_sqltxt; 
                    dbms_output.put_line(v_sqltxt||';  -- done'); 
                else 
                    dbms_output.put_line(v_sqltxt||';'); 
                end if; 
            exception when others then
                dbms_output.enable(500); 
                dbms_output.put_line('Error at: '||v_sqltxt);
                dbms_output.put_line('-->'||SQLERRM); 
            end;
        end loop; 
    end;
    
    /*==============================================================================*
      SP NAME : fk_change_status
      SP DESC.: 
             - 현재의 FK에 대해 활성화 또는 비활성화 한다.
             - 제시된 테이블의 FK뿐만 아니라 해당 테이블을 참조하는 FK에 대해서도 적용된다.
             - set serverout on이 설정되어야 실행 결과 또는 스크립트 출력을 확인할 수 있다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_status: 변경할 FK 상태를 입력한다. ENABLE/DISABLE/ENABLE NOVALIDATE
             p_exec  : 0 : FK 상태를 변경한는 스크립트를 출력한다.
                       1 : FK 상태를 변경한다.
             p_option: A : 제시된 테이블의 FK 및 해당 테이블을 참조하는 모든 FK에 적용
                       I : 제시된 테이블의 FK에 한해 적용
                       R : 제시된 테이블의 자기참조 FK에 대해서만 적용
    *==============================================================================*/
    procedure fk_change_status
        (  p_owner in varchar2 default null        -- 테이블 소유자
         , p_tname in varchar2 default '%'         -- 처리할 테이블 명
         , p_status in varchar2 default 'ENABLE'   -- enable(novalidate), disable
         , p_exec in number default 0              -- 1: 실행, 0: 스크립트 출력
         , p_option in varchar2 default 'A'        -- a:all 테이블 자신 및 자신을 참조하는 키, i:테이블 자신의 FK만
        )
    is
        v_sqltxt    varchar2(4000);
        v_owner     varchar2(100);
        v_tname     varchar2(100);
        v_fkname    varchar2(100);
        v_status    varchar2(20);
        v_option    varchar2(1);
    begin
        v_owner  := upper(p_owner);
        v_tname  := upper(p_tname);
        v_status := upper(p_status);
        v_option := upper(p_option);
        
        if v_owner is null then
            dbms_output.enable(100);
            dbms_output.put_line('usage: sp_tb_schema_fk_status(p_owner=>, p_tname=>''%'', p_status=>''enable/disable'', p_exec=>0,p_option=>''A''');
            dbms_output.put_line('      p_option=> a:All, i:itself, r: recursive only');
            return;
        end if;
        
        for icur in (select con.con# --, con.obj#, con.type#, con.robj#, con.rcon#
                          , twn.name owner, tnm.name tname, cnm.name fkname
                          , v_status targetstatus
                    from sys.cdef$ con, sys.obj$ tnm, sys.con$ cnm, sys.user$ twn
                    where ((con.obj# in (select a.obj# 
                                     from sys.obj$ a, sys.user$ b
                                     where a.owner# = b.user#
                                       and a.name like v_tname  and a.type#=2
                                       and b.name = v_owner) 
                            and (v_option<>'R' or con.obj#=con.robj#) -- recursive fk 
                           )
                           or 
                           (v_option='A' and -- 참조하고 있는 FK도 포함
                            con.robj# in (select a.obj# 
                                          from sys.obj$ a, sys.user$ b
                                          where a.owner# = b.user#
                                            and a.name like v_tname and a.type#=2
                                            and b.name = v_owner)
                           )
                          )
                      and con.type#=4 and con.obj#=tnm.obj# 
                      and con.con#=cnm.con# and tnm.owner#=twn.user#
                      --and cnm.name like v_fkname
                      and v_status not like decode(con.enabled, 1,'ENABLE','DISABLE') ||'%' -- 목적 상태와 다른 것만 추출
                    )
        loop
            v_sqltxt := 'ALTER TABLE '||icur.owner||'.'||icur.tname||' MODIFY CONSTRAINT '||icur.fkname 
                        ||' '|| icur.targetstatus;

            dbms_output.enable(1000);
            if p_exec = 1 then
                begin
                    execute immediate v_sqltxt;
                    dbms_output.put_line(v_sqltxt||'; -- done');
                exception when others then
                    dbms_output.put_line(sqlerrm);
                    dbms_output.put_line('Err at: '||v_sqltxt );
                end;
            else
                dbms_output.put_line(v_sqltxt||';');
            end if;
        end loop;
    end;
 
    /*==============================================================================*
      SP NAME : fk_drop
      SP DESC.: 
             - FK 정보를 테이블에 저장한 후 DROP한다.
               테이블에 저장된 정보를 사용하여 SP_DBM_FK_RECOVER로 다시 복구할 수 있다.
             - set serverout on이 설정되어야 실행 결과 또는 스크립트 출력을 확인할 수 있다.
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
             p_exec  : 0 : FK를 drop하는 스크립트를 출력한다.
                       1 : FK를 drop한다.
                       
    *==============================================================================*/ 
    procedure fk_drop 
        (  p_owner in varchar2 default null
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
         , p_exec in number default 0) 

    is 
        v_sqltxt    varchar2(4000); 
        v_owner     varchar2(100); 
        v_tname     varchar2(100); 
        v_fkname    varchar2(100); 
    begin 
        v_owner  := upper(p_owner); 
        v_tname  := upper(p_tname); 
        v_fkname := upper(p_fkname); 
     
        if v_owner is null then 
            dbms_output.enable(100); 
            dbms_output.put_line('usage: sp_dbm_fk_drop(p_owner=>null, p_tname=>''%'', p_fkname=>''%'', p_exec=>0)'); 
            return; 
        end if; 
     
        for icur in (select con.con# --, con.obj#, con.type#, con.robj#, con.rcon# 
                          , twn.name owner, tnm.name tname, cnm.name fkname 
                    from sys.cdef$ con, sys.obj$ tnm, sys.con$ cnm, sys.user$ twn 
                    where (con.obj# in (select a.obj#  
                                     from sys.obj$ a, sys.user$ b 
                                     where a.owner# = b.user# 
                                       and a.name like v_tname  and a.type#=2 
                                       and b.name = v_owner)  
                           or  
                           con.robj# in (select a.obj#  
                                     from sys.obj$ a, sys.user$ b 
                                     where a.owner# = b.user# 
                                       and a.name like v_tname and a.type#=2 
                                       and b.name = v_owner) 
                          ) 
                      and con.type#=4 and con.obj#=tnm.obj#  
                      and con.con#=cnm.con# and tnm.owner#=twn.user#  
                      and cnm.name like v_fkname 
                    ) 
        loop 
            fk_backup(icur.owner, icur.tname, icur.fkname); 
            v_sqltxt := 'ALTER TABLE '||icur.owner||'.'||icur.tname||' DROP CONSTRAINT '||icur.fkname; 
             
            dbms_output.enable(2000); 
            if p_exec = 1 then 
                execute immediate v_sqltxt; 
                dbms_output.put_line(v_sqltxt||';  -- done'); 
            else 
                dbms_output.put_line(v_sqltxt||';'); 
            end if; 
        end loop; 
    end;
    
    
    
    /*==============================================================================*
      SP NAME : fk_chk 
      SP DESC.: 
             - FK 정보를 저장하는 테이블에서 실제 DB에 존재하지 않는 
               FK를 delete하거나 delete 하는 스크립트를 생성한다.
             - 스크립트를 생성하거나 결과를 확인하기 위해서는 실행전에 
               sqlplus에서 set serverout on을 설정하여야 한다.           
        PARAM :
             p_owner : 테이블 소유자
             p_tname : 테이블 명칭. like 조건으로 검색되며 기본값은 %로 소유자의 모든 테이블이다.
             p_fkname: FK 명칭. like 조건으로 검색되며 기본값은 %로 해당 테이블의 모든 FK이다.
             p_exec  : 0 : 실행할 수 있는 스크립트를 출력한다.
                       1 : 바로 실행한다.          
    *==============================================================================*/
    procedure fk_chk 
        (  p_owner in varchar2 default ''
         , p_tname in varchar2 default '%' 
         , p_fkname in varchar2 default '%' 
         , p_exec in number default 0 
        ) 
    is 
        v_sqltxt    varchar2(4000); 
        v_sqlpar    varchar2(4000); 
        v_owner     varchar2(100); 
        v_tname     varchar2(100); 
        v_fkname    varchar2(100); 
    begin 
        v_owner  := upper(p_owner); 
        v_tname  := upper(p_tname); 
        v_fkname := upper(p_fkname); 
        v_sqltxt := 'delete from dbadm.tb_schema_fk where owner=:1 and tname=:2 and fkname=:3'; 
        if v_owner is null then 
            dbms_output.enable(100); 
            dbms_output.put_line('usage: sp_tb_schema_fk_chk(p_owner, p_tname=>''%'', p_fkname=>''%'', p_exec=>0)'); 
            return; 
        end if; 
     
        for icur in (select a.owner, a.tname, a.fkname 
                     from dbadm.tb_schema_fk a 
                     where a.owner=v_owner and a.tname like v_tname and a.fkname like v_fkname 
                       and not exists(select 1 from all_constraints b  
                                      where a.owner=b.owner and b.table_name=a.tname and b.constraint_name=a.fkname) 
                     ) 
        loop 
            v_sqlpar := ''''||icur.owner||''', '''||icur.tname||''','''||icur.fkname||''''; 
            --v_sqltxt := 'delete from dbadm.tb_schema_fk where owner='''||icur.owner||''' and tname='''||icur.tname||''' and fkname='''||icur.fkname||''''; 
     
            dbms_output.enable(1000); 
            if p_exec = 1 then 
                execute immediate v_sqltxt using icur.owner, icur.tname, icur.fkname; 
                dbms_output.put_line('delete -- '|| v_sqlpar||';  -- done'); 
            else 
                dbms_output.put_line('execute execute immediate '''||v_sqltxt||''' using '|| v_sqlpar||';');  
                --dbms_output.put_line(v_sqltxt||';'); 
            end if; 
        end loop; 
    end;

end;