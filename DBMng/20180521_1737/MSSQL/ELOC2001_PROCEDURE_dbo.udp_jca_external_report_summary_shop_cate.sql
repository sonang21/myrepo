/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_summary_shop_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-23 13:02:33.933
 *        Modify: 2018-05-03 17:23:34.313
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_external_report_summary_shop_cate
	@shop_code int
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.02.21
	-- ��  �� :  ��ฮ��Ʈ.������ ī�װ� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/

	select [��з�]			= case when (grouping(category) = 1) then '�հ�' else category end
		 , [db ���ۼ�]		= sum(send_cnt)
		 , [��Ī��]			= sum(matching_cnt)
		 , [��Ī �Ұ���]		= sum(denied_cnt)
		 , [�̸�Ī��]			= sum(send_cnt) - sum(matching_cnt) - sum(denied_cnt)
		 , [�۾���]			= sum(matching_cnt) + sum(denied_cnt) * 0.5
		 , [��Ī��]			= round(sum(matching_cnt) * 100.0 / sum(send_cnt), 2)
		 , [�����]			= round((sum(matching_cnt) + sum(denied_cnt) * 0.5) * 100.0 / 3000000, 2)
		 , [���� �𵨼�]		= sum(model_cnt)
		 , [�Ӽ��Է·�]		= isnull(round(case when (sum(attribute_plno_cnt )) = 0 then 0 else sum(attribute_plno_cnt) * 100.0 / (sum(plno_cnt )) end, 2),0)
	from tbl_external_stats_gs
	where shop_code = @shop_code and yyyymmdd = convert(char(8), getdate()-1 , 112)
	group by category
	with rollup
	order by (case when (grouping(category) = 1) then  1 else 0 end), category
end

