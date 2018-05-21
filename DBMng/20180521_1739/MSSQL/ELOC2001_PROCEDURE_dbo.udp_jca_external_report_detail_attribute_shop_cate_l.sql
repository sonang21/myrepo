/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_attribute_shop_cate_l
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-08 16:42:58.097
 *        Modify: 2018-05-03 17:23:35.923
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_external_report_detail_attribute_shop_cate_l
	@shop_code int
,	@sdate char(8)
,	@category varchar(12)
as  begin 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.02.21
	-- ��  �� :  �󼼸���Ʈ : �Ӽ��Է»���
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/
	-- ����Ʈ
	select [�з�]			= a.category
		 , [��ǰ��]		= isnull(attribute_plno_cnt,0)
		 , [��ǰ��]		= isnull(plno_cnt, 0)
		 , [�Ӽ��Է·�]	= isnull(case when (attribute_plno_cnt ) = 0 then 0 else attribute_plno_cnt * 100.0 / (plno_cnt ) end, 0)
		 , 0 ord
	from tbl_external_stats_gs  a 
	where model_cnt > 0 and shop_code = @shop_code and yyyymmdd = @sdate and a.category like @category+'%'

	union all
	-- �հ�
	select '�հ�'
	,	isnull(sum(attribute_plno_cnt), 0)
	,	isnull(sum(plno_cnt), 0)
	,	isnull(case when (sum(attribute_plno_cnt )) = 0 then 0 else sum(attribute_plno_cnt) * 100.0 / (sum(plno_cnt )) end, 0)
	,	1 ord
	from tbl_external_stats_gs a
	where model_cnt > 0 and shop_code = @shop_code and yyyymmdd = @sdate and a.category like @category+'%'
	order by ord, category

end

