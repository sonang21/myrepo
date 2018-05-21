/* *************************************************************************
 * NAME : dbo.udp_cpg_shot_goods
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-20 15:39:57.097
 *        Modify: 2018-05-20 15:39:57.097
 *        Backup: 20180521_1737
 ************************************************************************* */


create proc udp_cpg_shot_goods	
as  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 
	-- ��  �� : cpg �����.goods  ������
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/

    --if  datepart(dw, getdate())  = 1 begin -- �Ͽ��� 

    select left(g_category,4)  g_category
         , a.g_modelno
         , is_g_service = (case when g_constrain in ('1','5') and g_jobcode>'0' and g_mallcnt > 0 and g_minprice > 0 then 1 else 0 end) 
         , g_constrain
         , getdate() as regdate
           into tmp_shot_20161227_goods
      from goods a with (readuncommitted)
           inner join goods_sum b with (readuncommitted) on a.g_modelno = b.g_modelno
     where g_category <> '00000000' and g_modelnm <> '�𵨻���'
    option (maxdop 1)
    --(7906688�� ���� ������ ����) / 4��

    --end
end