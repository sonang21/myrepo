/* *************************************************************************
 * NAME : DBADM.DBM_LOG
 * TYPE : PACKAGE
 * TIME : Create: 2018-03-27 20:22:56
 *        Modify: 2018-03-27 20:22:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "DBADM"."DBM_LOG" 
as
    g_log_id        dbadm.tb_dbm_logs.log_id%type               default 0;
    g_inst_id       number                                      default null;
    g_group_name    dbadm.tb_dbm_logs.group_name%type           default null;
    g_job_name      dbadm.tb_dbm_logs.job_name%type             default null;
    
    g_msg_sn        dbadm.tb_dbm_log_msgs.msg_sn%type           default 1;
    g_step_name     dbadm.tb_dbm_log_msgs.step_name%type        default null;
    g_sub_step_name dbadm.tb_dbm_log_msgs.sub_step_name%type    default null;

    ERROR_PREPARE    exception;
    ERROR_START      exception;
    ERROR_END        exception;

    function fn_get_log_id      return number;
    function fn_get_group_name  return varchar2;

    procedure sp_set_log_id(p_log_id number);
    procedure sp_set_group_name(p_group_name varchar2);

    procedure sp_log_create(p_job_name varchar2, p_job_type varchar2 default null, p_job_desc varchar2 default null, p_rel_object varchar2 default null);
    procedure sp_log_start(p_job_name varchar2 default null, p_job_type varchar2 default null, p_job_desc varchar2 default null, p_rel_object varchar2 default null);
    procedure sp_log_update(p_res_cnt number default null, p_error_code varchar2 default null, p_error_msg varchar2 default null);
    procedure sp_log_end(p_res_code varchar2, p_res_cnt number default null, p_error_code varchar2 default null, p_error_msg varchar2 default null);

    procedure sp_log_msg(p_code varchar2, p_msg varchar2, p_step_name varchar2 default null, p_sub_step_name varchar2 default null, p_msg_type varchar2 default null);

end;
CREATE OR REPLACE PACKAGE BODY "DBADM"."DBM_LOG" 
as
    function fn_get_log_id      return number is begin return(g_log_id); end;
    function fn_get_group_name  return varchar2 is begin return(g_group_name); end;

    procedure sp_set_log_id(p_log_id number)  is begin g_log_id := p_log_id; end;
    procedure sp_set_group_name(p_group_name varchar2) is begin g_group_name := p_group_name; end;

    procedure sp_log_create(p_job_name varchar2, p_job_type varchar2 default null, p_job_desc varchar2 default null, p_rel_object varchar2 default null)
    is
    begin
        g_log_id    := dbadm.sq_dbm_logs.nextval;
        g_job_name  := p_job_name;
        g_inst_id   := userenv('instance');

        if ( g_job_name is null ) then raise ERROR_PREPARE; end if;

        insert into dbadm.tb_dbm_logs(log_id, inst_id, group_name, job_name, job_type, job_desc, rel_object, status)
                    values(g_log_id, g_inst_id, g_group_name, p_job_name, p_job_type, p_job_desc, p_rel_object, 'READY');
        commit;

        g_msg_sn := 1;

    exception
        when ERROR_PREPARE then
            raise_application_error(-20001, 'Failed to prepare logging : Job name is not defined', false);
            sp_log_msg('-20001', 'Failed to prepare logging : Job name is not defined.', 'LOG_INIT',NULL,'WARNING');
        when others then
            raise;
    end;

    procedure sp_log_start(p_job_name varchar2 default null, p_job_type varchar2 default null, p_job_desc varchar2 default null, p_rel_object varchar2 default null)
    is
        pragma autonomous_transaction;
    begin
        if (p_job_name) is not null then
            sp_log_create(p_job_name, p_job_type, p_job_desc, p_rel_object);
        end if;
        update dbadm.tb_dbm_logs
           set status = 'START'
             , start_time = sysdate
         where log_id = g_log_id
           and status = 'READY';

        if (SQL%ROWCOUNT = 0) then raise ERROR_START; end if;

        commit;
    exception
        when ERROR_START then
            raise_application_error(-20002, 'Failed to start logging : Logging is not prepared. (please execute sp_log_create)', false);
            sp_log_msg('-20002', 'Failed to start logging : Logging is not prepared. (please execute sp_log_create)', 'LOG_START',NULL,'WARNING');
        when others then
            raise;
    end;
    
    procedure sp_log_update(p_res_cnt number default null, p_error_code varchar2 default null, p_error_msg varchar2 default null)
    is
        pragma autonomous_transaction;
    begin
        update dbadm.tb_dbm_logs
           set status       = 'RUNNING' -- p_status
             --, res_code     = p_res_code
             , res_cnt      = p_res_cnt
             , error_code   = p_error_code
             , error_msg    = p_error_msg
             --, end_time     = sysdate
         where log_id = g_log_id
           and status in ('START', 'RUNNING');

        if (SQL%ROWCOUNT = 0) then  raise ERROR_END; end if;
        commit;

        commit;
        exception
            when ERROR_END then
                raise_application_error(-20003, 'Failed to update logging', false);
                sp_log_msg('-20003', 'Failed to update logging', 'LOG_END',NULL,'WARNING');
            when others then
                raise;
    end;

    procedure sp_log_end(p_res_code varchar2, p_res_cnt number default null, p_error_code varchar2 default null, p_error_msg varchar2 default null)
    is
        pragma autonomous_transaction;
    begin
        update dbadm.tb_dbm_logs
           set status       = 'END' --p_status
             , res_code     = p_res_code
             , res_cnt      = p_res_cnt
             , error_code   = p_error_code
             , error_msg    = p_error_msg
             , end_time     = sysdate
         where log_id = g_log_id
           and status in ('START', 'RUNNING');

        if (SQL%ROWCOUNT = 0) then  raise ERROR_END; end if;
        commit;

        commit;
        exception
            when ERROR_END then
                raise_application_error(-20003, 'Failed to complete logging : Logging is not started. (please execute sp_log_start)', false);
                sp_log_msg('-20003', 'Failed to complete logging : Logging is not started. (please execute sp_log_start)', 'LOG_END',NULL,'WARNING');
            when others then
                raise;
    end;

    procedure sp_log_msg(p_code varchar2, p_msg varchar2, p_step_name varchar2 default null, p_sub_step_name varchar2 default null, p_msg_type varchar2 default null)
    is
        pragma autonomous_transaction;
    begin
        insert into dbadm.tb_dbm_log_msgs(log_id, msg_sn, inst_id, job_name, step_name, sub_step_name, msg_type, msg_time, code, msg)
        values (g_log_id, g_msg_sn, g_inst_id, g_job_name, p_step_name, p_sub_step_name, p_msg_type, sysdate, p_code, p_msg);
        commit;

        g_msg_sn := g_msg_sn + 1;
    end;
end;