/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_ALLNEW_PACK_1
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:23
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_ALLNEW_PACK_1" 
is
     result_code varchar2(1000);
     result_desc varchar2(1000);
     startTime   varchar2(1000);
     endTime     varchar2(1000);
begin

  begin
    UDP_GOODS_ALLNEW5(result_code, result_desc, startTime, endTime,'09');
  exception when others then
    result_code := result_code || '|' || sqlcode;
    result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => ERROR';

    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW5', '09', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    from dual;
    commit;
  end;

  begin
    UDP_GOODS_ALLNEW5(result_code, result_desc, startTime, endTime,'02');
  exception when others then
    result_code := result_code || '|' || sqlcode;
    result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => ERROR';

    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW5', '02', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    from dual;
    commit;
  end;

  begin
    UDP_GOODS_ALLNEW5(result_code, result_desc, startTime, endTime,'03');
  exception when others then
    result_code := result_code || '|' || sqlcode;
    result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW5 => ERROR';

    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW5', '03', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
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
      result_desc := 'UDP_GOODS_ALLNEW_PACK_1 => ERROR';
    else
      result_desc := result_desc || '|' || 'UDP_GOODS_ALLNEW_PACK_1 => ERROR';
    end if;
        
 -- SYS_LOG
    insert into TBL_SYS_PGM_LOG (pgm_nm, pgm_nm_para, pgm_srt_dt, pgm_fns_dt, starttime, endtime, result_code, result_desc, step_desc)
    select 'UDP_GOODS_ALLNEW_PACK_1', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    from dual;
    commit;

end UDP_GOODS_ALLNEW_PACK_1;