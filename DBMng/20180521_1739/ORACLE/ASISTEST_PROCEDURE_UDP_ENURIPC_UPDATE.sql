/* *************************************************************************
 * NAME : ASISTEST.UDP_ENURIPC_UPDATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:21
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ENURIPC_UPDATE" (p_type in varchar2)
is
/******************************************************************************
**  Name: UDP_ENURIPC_DEL
**  Desc: ����PC ��ǰ ��ü Update�� ���� procedure
**        ������ ����Ʈ�� "������PC" ���񽺿��� ����ϴ� ��õ�����͸� ���� ��ü�κ��� ������Ʈ �޴� �����۾����� �����
**  Called by: 100.100.100.232 winwinApi.java winwinMatch.java ������ ����PC ��ǰ ������Ʈ API
**
**  Parameters:
**     Input                        Output
**     ----------                   -----------
**      p_type ('P' = TBL_ENURIPC_PRODUCT_TMP -> TBL_ENURIPC_SUBGOODS_TMP -> TBL_ENURIPC_SUBGOODS_CHANGE_T  ������ update)
**             ('T' = TBL_ENURIPC_GOODS_TMP update)
**             ('S' = TBL_ENURIPC_SUBGOODS -> TBL_ENURIPC_SUBGOODS_CHANGE ������ update)
**
**  Example : ���� ���� (exec UDP_ENURIPC_DEL('P');)
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018-03-13    �� ����         �躴�� ������ ��û���� 
**                                ����PC ��ǰ UPDATE ���� API��Ŀ��� 
**                                MERGE ���� ���ν��� ȣ�������� �ٲٸ鼭 ������.
******************************************************************************
*/
begin

  if (p_type = 'P') then
    
    merge into TBL_ENURIPC_PRODUCT_TMP t
    using TBL_ENURIPC_PRODUCT s
       on (t.pd_no = s.pd_no)
     when matched then
       update set t.modelno = s.modelno
                , t.pd_regdate = s.pd_regdate
                , t.pd_viewcnt = s.pd_viewcnt
    ;

    merge into TBL_ENURIPC_SUBGOODS_TMP t
    using TBL_ENURIPC_PRODUCT_TMP s
       on (t.pd_no = s.pd_no)
     when matched then
       update set t.modelno = s.modelno
    ;

    merge into TBL_ENURIPC_SUBGOODS_CHANGE_T t
    using TBL_ENURIPC_PRODUCT_TMP s
       on (t.c_pd_no = s.pd_no)
     when matched then
       update set c_modelno = s.modelno
    ;

  elsif (p_type = 'T') then

    merge into TBL_ENURIPC_GOODS_TMP t
    using TBL_ENURIPC_GOODS s
       on (t.sy_no = s.sy_no)
     when matched then
       update set t.modelno = s.modelno
                , t.sy_regdate = s.sy_regdate
                , t.sy_viewcnt = s.sy_viewcnt
    ;

  elsif (p_type = 'S') then

    merge into TBL_ENURIPC_SUBGOODS t
    using TBL_ENURIPC_PRODUCT s
       on (t.pd_no = s.pd_no)
     when matched then
        update set modelno = s.modelno
    ;

    merge into TBL_ENURIPC_SUBGOODS_CHANGE t
    using TBL_ENURIPC_PRODUCT s
       on (t.c_pd_no = s.pd_no)
     when matched then
       update set c_modelno = s.modelno
    ;

  end if;

  commit;

exception
  when others then
    rollback;
end UDP_ENURIPC_UPDATE;