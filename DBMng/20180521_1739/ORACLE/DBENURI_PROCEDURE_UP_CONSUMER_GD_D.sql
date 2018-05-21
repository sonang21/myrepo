/* *************************************************************************
 * NAME : DBENURI.UP_CONSUMER_GD_D
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-17 15:41:10
 *        Modify: 2018-05-17 15:45:53
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UP_CONSUMER_GD_D" ( in_goods IN goods_type )
is

/******************************************************************************
**  Name: up_consumer_gd_d
**  Desc: Consumer���� �ű� �� ���� �ݿ� �� ���� ���̺� ������ ���� ���μ���
**
**  Called by: ȣ�� ���α׷� �Ǵ� ���
**
**  Parameters:
**     Input                         Output
**     ----------                    -----------
**     in_goods: �� �����ͼ�      ��º���: ��������
**
**  Example : ���� ���� (exec up_consumer_gd_d(v1))
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018.05.14   SSH              ���ν��� �ű� ����
*******************************************************************************/

begin

  DELETE
    FROM dbenuri.tbl_goods
   WHERE MODELNO = in_goods.model_no;
  

  DELETE
    FROM dbenuri.tbl_goods_sum
   WHERE MODELNO = in_goods.model_no;

 
  DELETE
    FROM dbenuri.tbl_cate_goods
   WHERE MODELNO = in_goods.model_no;


exception
  when others then
  null;
end;