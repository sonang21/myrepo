/* *************************************************************************
 * NAME : DBADM.PG_MIG
 * TYPE : PACKAGE
 * TIME : Create: 2018-03-27 20:23:01
 *        Modify: 2018-04-17 16:22:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "DBADM"."PG_MIG" 
as
    g_log_id        dbadm.tb_mig_log.log_id%type               default 0;
    g_inst_id       number                                     default null;
    g_log_group    dbadm.tb_mig_log.log_group%type           default null;
    g_job_id        dbadm.tb_mig_log.job_id%type               default null;
    g_job_name      dbadm.tb_mig_log.job_name%type             default null;
    
    
    g_msg_sn        dbadm.tb_mig_log_msg.msg_sn%type           default 1;
    g_step_name     dbadm.tb_mig_log_msg.step_name%type        default null;
    g_sub_step_name dbadm.tb_mig_log_msg.sub_step_name%type    default null;

    ERROR_PREPARE    exception;
    ERROR_START      exception;
    ERROR_END        exception;

    function get_log_id      return number;
    function get_log_group   return varchar2;

    procedure set_log_id(p_log_id number);
    procedure set_log_group(p_log_group varchar2);

    procedure sp_log_create(p_job_name     varchar2, p_job_id varchar2 default null
                          , p_target_table varchar2 default null, p_source_table varchar2 default null);
    procedure sp_log_start(p_job_name varchar2 default null, p_job_id varchar2 default null
                         , p_target_table varchar2 default null, p_source_table varchar2 default null
                         , p_source_cnt number default null, p_target_cnt number default null);
    procedure sp_log_source_count(p_source_cnt number, p_target_cnt number);
    procedure sp_log_update(p_source_cnt    number      default null
                          , p_target_cnt    number      default null
                          , p_result_cnt    number      default null 
                          , p_error_code    varchar2    default null
                          , p_error_msg     varchar2    default null);
    
    procedure sp_log_end(p_result_cnt number, p_res_code varchar2 default null
                       , p_error_code varchar2 default null, p_error_msg varchar2 default null);
    
    procedure sp_log_comment (p_comment varchar2, p_log_id number default null);
    
    procedure sp_log_msg(p_code         varchar2
                       , p_msg          varchar2
                       , p_step_name    varchar2    default null
                       , p_substep_name varchar2    default null
                       , p_row_cnt      number      default null
                       , p_msg_type     varchar2    default null);

end;
CREATE OR REPLACE PACKAGE BODY "DBADM"."PG_MIG" 
as
    function get_log_id     return number   is begin return(g_log_id); end;
    function get_log_group  return varchar2 is begin return(g_log_group); end;

    procedure set_log_id(p_log_id number)   is begin g_log_id := p_log_id; end;
    procedure set_log_group(p_log_group varchar2) is begin g_log_group := p_log_group; end;

    procedure sp_log_create(p_job_name     varchar2, p_job_id varchar2 default null
                          , p_target_table varchar2 default null, p_source_table varchar2 default null)
    is
    begin
        g_log_id    := dbadm.sq_mig_log.nextval;
        g_job_name  := p_job_name;
        g_job_id    := p_job_id;
        -- g_inst_id   := userenv('instance');

        if ( g_job_name is null ) then raise ERROR_PREPARE; end if;

        insert into dbadm.tb_mig_log(log_id, log_group, job_id, job_name, target_table, source_table, status)
                    values(g_log_id, g_log_group, p_job_id, p_job_name, p_target_table, p_source_table, 'READY');
        commit;

        g_msg_sn := 1;

    exception
        when ERROR_PREPARE then
            raise_application_error(-20001, 'Failed to prepare logging : Job name is not defined', false);
            sp_log_msg('-20001', 'Failed to prepare logging : Job name is not defined.', 'LOG_INIT', NULL, NULL, 'ERROR');
        when others then
            raise;
    end;

    procedure sp_log_start(p_job_name varchar2 default null, p_job_id varchar2 default null
                         , p_target_table varchar2 default null, p_source_table varchar2 default null
                         , p_source_cnt number default null, p_target_cnt number default null)
    is
        pragma autonomous_transaction;
    begin
        if (p_job_name) is not null then
            sp_log_create(p_job_name, p_job_id, p_target_table, p_source_table);
        end if;
        update dbadm.tb_mig_log
           set status       = 'RUNNING'
             , source_cnt   = nvl(p_source_cnt, source_cnt)
             , target_cnt   = nvl(p_target_cnt, target_cnt)
             , start_time   = sysdate
             , log_time     = sysdate 
         where log_id = g_log_id
           and status = 'READY';

        if (SQL%ROWCOUNT = 0) then raise ERROR_START; end if;

        commit;
    exception
        when ERROR_START then
            raise_application_error(-20002, 'Failed to start logging : Logging is not prepared. (please execute sp_log_create)', false);
            sp_log_msg('-20002', 'Failed to start logging : Logging is not prepared. (please execute sp_log_create)', 'LOG_START',NULL,NULL,'ERROR');
        when others then
            raise;
    end;
    
    procedure sp_log_source_count(p_source_cnt number, p_target_cnt number)
    is 
        pragma autonomous_transaction;
    begin
        update dbadm.tb_mig_log
           set source_cnt   = p_source_cnt
             , target_cnt   = p_target_cnt
             , log_time     = sysdate 
         where log_id = g_log_id
           and status in ('READY', 'RUNNING', 'RUNNING');

        if (SQL%ROWCOUNT = 0) then  raise ERROR_END; end if;
        commit;

        commit;
    exception
        when ERROR_END then
            raise_application_error(-20003, 'Failed to update logging', false);
            sp_log_msg('-20003', 'Failed to update logging', 'LOG_END',NULL, NULL,'WARNING');
        when others then
            raise;
    end;
    
    procedure sp_log_update(p_source_cnt    number      default null
                          , p_target_cnt    number      default null
                          , p_result_cnt    number      default null 
                          , p_error_code    varchar2    default null
                          , p_error_msg     varchar2    default null)
    is
        pragma autonomous_transaction;
    begin
        update dbadm.tb_mig_log
           set source_cnt   = nvl(p_source_cnt, source_cnt  )
             , target_cnt   = nvl(p_target_cnt, target_cnt  )
             , result_cnt   = nvl(p_result_cnt, result_cnt  )
             , error_code   = nvl(p_error_code, error_code  )
             , error_msg    = nvl(p_error_msg , error_msg   )
             , log_time     = sysdate             
         where log_id = g_log_id
           and status in ('READY', 'RUNNING');

        if (SQL%ROWCOUNT = 0) then  raise ERROR_END; end if;
        commit;

        commit;
    exception
        when ERROR_END then
            raise_application_error(-20003, 'Failed to update logging', false);
            sp_log_msg('-20003', 'Failed to update logging', 'LOG_END',NULL, NULL,'WARNING');
        when others then
            raise;
    end;

    procedure sp_log_end(p_result_cnt number, p_res_code varchar2 default null
                       , p_error_code varchar2 default null, p_error_msg varchar2 default null)
    is
        pragma autonomous_transaction;
    begin
        update dbadm.tb_mig_log
           set status       = 'END' --p_status
             , res_code     = case when p_res_code is null then 
                                        case when target_cnt = p_result_cnt then 'SUCCESS'
                                             else 'FAIL'
                                        end
                                   else p_res_code
                              end 
             , result_cnt   = p_result_cnt
             , error_code   = p_error_code
             , error_msg    = p_error_msg
             , end_time     = sysdate
             , log_time     = sysdate 
         where log_id = g_log_id
           and status in ('READY', 'RUNNING');

        if (SQL%ROWCOUNT = 0) then  raise ERROR_END; end if;
        commit;

        commit;
    exception
        when ERROR_END then
            raise_application_error(-20003, 'Failed to complete logging : Logging is not started. (please execute sp_log_start)', false);
            sp_log_msg('-20003', 'Failed to complete logging : Logging is not started. (please execute sp_log_start)', 'LOG_END', NULL, NULL, 'ERROR');
        when others then
            raise;
    end;
    
    procedure sp_log_comment (p_comment varchar2, p_log_id number default null)
    is 
        pragma autonomous_transaction;
    begin 
        update dbadm.tb_mig_log 
           set log_comment = p_comment
             , log_time = sysdate 
         where log_id = nvl(p_log_id, g_log_id)
        ;
        
        if (SQL%ROWCOUNT = 0) then  raise ERROR_END; end if;
        commit;
    exception
        when ERROR_END then
            raise_application_error(-20003, 'log_id'|| to_char(p_log_id)||' is not exists' , false);
        when others then
            raise;
    end;
    

    procedure sp_log_msg(p_code         varchar2
                       , p_msg          varchar2
                       , p_step_name    varchar2    default null
                       , p_substep_name varchar2    default null
                       , p_row_cnt      number      default null
                       , p_msg_type     varchar2    default null)
    is
        pragma autonomous_transaction;
    begin
        insert into dbadm.tb_mig_log_msg(log_id, msg_sn, inst_id, job_name, step_name, sub_step_name, msg_type, msg_time, row_cnt, code, msg)
        values (g_log_id, g_msg_sn, g_inst_id, g_job_name, p_step_name, p_substep_name, p_msg_type, sysdate, p_row_cnt, p_code, p_msg);
        commit;

        g_msg_sn := g_msg_sn + 1;
    end;
end;