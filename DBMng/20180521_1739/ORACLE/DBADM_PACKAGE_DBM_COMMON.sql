/* *************************************************************************
 * NAME : DBADM.DBM_COMMON
 * TYPE : PACKAGE
 * TIME : Create: 2018-03-27 20:22:56
 *        Modify: 2018-03-27 20:23:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "DBADM"."DBM_COMMON" 
as
    /* ************************************************************************
     * 구분자가 포함된 리스트에서 각각의 항목을 테이블 형태로 반환
     * 예) select * from table(dbm_perf.fn_split('a,b,c,d'));
    ************************************************************************ */    
    function  fn_split(p_list varchar2, p_delim varchar2 default ',') return array_varchar pipelined;
    function  fn_get_longval(p_owner varchar2, p_table varchar2, p_column varchar2, p_len number, p_rowid rowid) return varchar2;
end;
CREATE OR REPLACE PACKAGE BODY "DBADM"."DBM_COMMON" 
is
    /* ************************************************************************
     * 구분자가 포함된 리스트에서 각각의 항목을 테이블 형태로 반환
     * 예) select * from table(dbm_common.fn_split('a,b,c,d'));
    ************************************************************************ */    
    function  fn_split(p_list varchar2, p_delim varchar2 default ',') return array_varchar pipelined
    is 
         v_idx  number; 
         v_list varchar2(32767) := p_list; 
         v_value varchar2(32767);
     begin 
        loop v_idx := instr(v_list, p_delim); 
          if v_idx > 0 then 
            v_value := trim(substr(v_list,1,v_idx-1));
            pipe row(v_value); 
            v_list := substr(v_list,v_idx+length(p_delim));
          else 
            v_value := trim(v_list);
            pipe row(v_value); 
            exit; 
          end if; 
        end loop; 
        return ;
    end ;
 
    /* ************************************************************************
     * long type column의 값을 가져옵니다.
     * 예) select dbadm_common.fn_get_longval('dbadm','tb_table', 'textbody', 10000, rowid) from dbadm.tb_table;
    ************************************************************************ */   
    function fn_get_longval(p_owner varchar2, p_table varchar2, p_column varchar2, p_len number, p_rowid rowid) return varchar2
    is
      v_col_value varchar2(32767);
      v_sql       varchar2(1000);
    begin
      v_sql := 'select '||p_column||' from '||p_owner||'.'||p_table||' where rowid = :1';
      execute immediate v_sql into v_col_value using p_rowid;
      
      v_col_value := substr(v_col_value, 1, p_len);
      return v_col_value;  
    end;    
    
end;