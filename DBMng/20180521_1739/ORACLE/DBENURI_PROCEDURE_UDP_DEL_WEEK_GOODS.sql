/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_WEEK_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_WEEK_GOODS" is
/******************************************************************************
**  Name: UDP_DEL_WEEK_GOODS
**  Desc: Weekly JOB 수행을 위한 procedure
**        TBL_WEEK_GOODS.wg_date_id 의 마지막 두자리는 주수임. 2018년 2월 2째주 => 20180202
**
**  Called by: SCH_W6_DEL_WEEK_GOODS
**
**  Parameters:
**     Input                        Output
**     ----------                   -----------
**                 
**
**  Example : 실행 예시 (exec UDP_DEL_WEEK_GOODS;)
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018-02-23    김 영원         CRONTAB에 있던내용을 ORACLE JOB 으로 바꿈.
******************************************************************************
*/
begin

  -- to_char(sysdate, 'w') => 현재날짜 월주차 
  delete TBL_WEEK_GOODS
   where wg_date_id < (select to_char(add_months(sysdate, -13),'yyyymm') || '0'|| to_char(sysdate, 'w') from dual);
  commit;  

exception
  when others then
    rollback;

end UDP_DEL_WEEK_GOODS;
