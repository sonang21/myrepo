/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_ALLNEW_PACK_LAST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 16:50:24
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_ALLNEW_PACK_LAST" 
is
     result_code varchar2(1000);
     result_desc varchar2(1000);
     startTime   varchar2(1000);
     endTime     varchar2(1000);
begin
    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_SUM_POPULAR2', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'START'
    FROM DUAL;
    COMMIT;

   --네번째 프로시저(1시간 30분)
   UDP_SUM_POPULAR2(0, 'handphone', result_code, result_desc, startTime, endTime);

    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_SUM_POPULAR2', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END'
    FROM DUAL;
    COMMIT;

exception when others then
   result_code := result_code || '' || SQLCODE;
   result_desc := result_desc || 'UDP_SUM_POPULAR => ERROR';

    -- SYS_LOG
    INSERT INTO TBL_SYS_PGM_LOG (PGM_NM, PGM_NM_PARA, PGM_SRT_DT, PGM_FNS_DT, startTime, endTime, result_code, result_desc, step_desc)
    SELECT 'UDP_SUM_POPULAR2', 'X', sysdate, sysdate, startTime, endTime, result_code, result_desc, 'END-ERROR'
    FROM DUAL;
    COMMIT;


end UDP_GOODS_ALLNEW_PACK_LAST;
