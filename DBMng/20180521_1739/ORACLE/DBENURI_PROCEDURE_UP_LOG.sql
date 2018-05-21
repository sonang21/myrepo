/* *************************************************************************
 * NAME : DBENURI.UP_LOG
 * TYPE : PROCEDURE
 * TIME : Create: 2018-04-20 13:56:55
 *        Modify: 2018-04-20 17:08:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UP_LOG" ( p_type in varchar2, p_stat in varchar2 )
is

begin

  INSERT INTO TMP_ES_JOB_HIST (JOB_NM, JOB_STAT) VALUES (p_type,p_stat);
  COMMIT;

exception
  when others then
  null;
end;
