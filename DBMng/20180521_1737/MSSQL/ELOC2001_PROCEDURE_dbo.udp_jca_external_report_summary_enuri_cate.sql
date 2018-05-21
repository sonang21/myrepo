/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_summary_enuri_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-22 17:33:12.017
 *        Modify: 2018-05-03 17:23:34.577
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_external_report_summary_enuri_cate
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

	select [��з�]		= case when (grouping(left(category, 2)) = 1) then '�հ�' else (select top 1 cl_name  from c_lcate where cl_lcode = left(category, 2)) end
		 , [db ���ۼ�]		= sum(send_cnt)
		 , [��Ī��]			= sum(matching_cnt)
		 , [��Ī �Ұ���]		= sum(denied_cnt)
		 , [�̸�Ī��]			= sum(send_cnt) - sum(matching_cnt) - sum(denied_cnt)
		 , [�۾���]			= sum(matching_cnt) + sum(denied_cnt) * 0.5
		 , [��Ī��]			= round(sum(matching_cnt) * 100.0 / sum(send_cnt), 2)
		 , [�����]			= round((sum(matching_cnt) + sum(denied_cnt) * 0.5) * 100.0 / 3000000, 2)
		 , [���� �𵨼�]		= sum(model_cnt)

		 -- attribute �����Ѵ�.
		 , [�Ӽ��Է·�]		= round(isnull(case when isnull(sum(attribute_plno_cnt),0) = 0 then 0 else (sum(attribute_plno_cnt)*100.0 / sum(b.plno_cnt)) end, 0), 2)
	from tbl_external_stats_enuri a left outer join (
		select left(category, 6) scate
		,	sum(attribute_plno_cnt) attribute_plno_cnt
		,	sum(plno_cnt) plno_cnt
		from tbl_external_stats_attribute  a 
		where shop_code = @shop_code and yyyymmdd =convert(char(8), getdate()-1, 112)
		group by left(category, 6)	
	
	) b on a.category = b.scate
	where shop_code = @shop_code and yyyymmdd = convert(char(8), getdate()-1, 112)
	group by left(category, 2)
	with rollup
	order by case when (grouping(left(category, 2)) = 1) then '99' else left(category, 2) end
end


