/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_attribute_enuri_cate_tmp_excel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-03 16:07:29.28
 *        Modify: 2018-05-03 17:23:35.207
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_external_report_detail_attribute_enuri_cate_tmp_excel
	@sdate char(8)
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
	select isnull(cl_name,'') cl_name
	,	isnull(cm_name,'') cm_name
	, 	isnull(cs_name,'') cs_name
	,	[�ֿ� �Ӽ���]	= set_cnt
	,	[��ǰ�ڵ��]		= plno_cnt
	,	[�Է� �Ӽ���]	= attribute_matching_cnt
	,	[��ü �Ӽ���]	= attribute_total_cnt
	,	[�Ӽ��Է·�]		= matching_rate
	from 
	(
		select category 
		,	isnull(sum(set_cnt), 0) set_cnt
		,	isnull(sum(plno_cnt), 0) plno_cnt
		,	isnull(sum(attribute_cnt), 0) attribute_matching_cnt
		,	isnull(sum(plno_cnt * set_cnt), 0) attribute_total_cnt
		,	isnull(case when (sum(plno_cnt * set_cnt)) = 0 then 0 else sum(attribute_cnt) *1.0 / (sum(plno_cnt * set_cnt)) end, 0) matching_rate
		from tbl_external_stats_enuri  a 
		where shop_code = 7871 and yyyymmdd =@sdate
		group by category 
	)  a
		left outer join c_lcate b on substring(a.category,1,2) = b.cl_lcode and  len(a.category) >= 2
		left outer join c_mcate c on substring(a.category,1,2) = c.cm_lcode and substring(a.category,3,2) = c.cm_mcode and len(a.category) >= 4 
		left outer join c_scate d on substring(a.category,1,2) = d.cs_lcode and substring(a.category,3,2) = d.cs_mcode  and substring(a.category,5,2) = d.cs_scode and len(a.category) >= 6 
	order by category

	--union all

	---- �հ�
	--select '�հ�', '', '', ''
	--,	isnull(sum(set_cnt), 0) set_cnt
	--,	isnull(sum(plno_cnt), 0) plno_cnt
	--,	isnull(sum(attribute_cnt), 0) attribute_matching_cnt
	--,	isnull(sum(plno_cnt * set_cnt), 0) attribute_total_cnt
	--,	isnull(case when (sum(plno_cnt * set_cnt)) = 0 then 0 else sum(attribute_cnt) * 100.0 / (sum(plno_cnt * set_cnt)) end, 0) matching_rate
	--,	1 ord
	--from tbl_external_stats_enuri a
	--where model_cnt > 0 and shop_code = 7871and yyyymmdd = @sdate
	--order by ord, category

end



