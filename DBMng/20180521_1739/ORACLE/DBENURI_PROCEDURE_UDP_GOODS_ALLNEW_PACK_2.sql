/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_ALLNEW_PACK_2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 16:50:01
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_ALLNEW_PACK_2" 
is
     result_code varchar2(1000);
     result_desc varchar2(1000);
     startTime   varchar2(1000);
     endTime     varchar2(1000);
begin

  begin
    UDP_GOODS_ALLNEW5(result_code, result_desc, startTime, endTime,'10');
  exception when others then
    result_code := result_code || '|' || sqlcode;
    result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => ERROR';

    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW5', '10', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    from dual;
    commit;
  end;

  begin
    UDP_GOODS_ALLNEW5(result_code, result_desc, startTime, endTime,'04');
  exception when others then
    result_code := result_code || '|' || sqlcode;
    result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => ERROR';

    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW5', '04', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    from dual;
    commit;
  end;

  begin
    UDP_GOODS_ALLNEW5(result_code, result_desc, startTime, endTime,'05');
  exception when others then
    result_code := result_code || '|' || sqlcode;
    result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => ERROR';

    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW5', '05', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    from dual;
    commit;
  end;

exception
  when others then

    if result_code = '' then
      result_code := '' || sqlcode;
    else
      result_code := result_code || '|' || sqlcode;
    end if;

    if result_desc = '' then
      result_desc := 'UDP_GOODS_ALLNEW_PACK_2 => ERROR';
    else
      result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW_PACK_2 => ERROR';
    end if;
        
 -- SYS_LOG
    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW_PACK_2', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    from dual;
    commit;

end UDP_GOODS_ALLNEW_PACK_2;
