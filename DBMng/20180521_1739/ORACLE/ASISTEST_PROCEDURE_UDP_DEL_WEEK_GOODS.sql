/* *************************************************************************
 * NAME : ASISTEST.UDP_DEL_WEEK_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:19
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEL_WEEK_GOODS" is
/******************************************************************************
**  Name: UDP_DEL_WEEK_GOODS
**  Desc: Weekly JOB ������ ���� procedure
**        TBL_WEEK_GOODS.wg_date_id �� ������ ���ڸ��� �ּ���. 2018�� 2�� 2°�� => 20180202
**
**  Called by: SCH_W6_DEL_WEEK_GOODS
**
**  Parameters:
**     Input                        Output
**     ----------                   -----------
**                 
**
**  Example : ���� ���� (exec UDP_DEL_WEEK_GOODS;)
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018-02-23    �� ����         CRONTAB�� �ִ������� ORACLE JOB ���� �ٲ�.
******************************************************************************
*/
begin

  -- to_char(sysdate, 'w') => ���糯¥ ������ 
  delete TBL_WEEK_GOODS
   where wg_date_id < (select to_char(add_months(sysdate, -13),'yyyymm') || '0'|| to_char(sysdate, 'w') from dual);
  commit;  

exception
  when others then
    rollback;

end UDP_DEL_WEEK_GOODS;