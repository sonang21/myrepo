/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_attribute_enuri_cate_m
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-08 16:28:41.073
 *        Modify: 2018-05-03 17:23:35.377
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_external_report_detail_attribute_enuri_cate_m
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
	select [�Һз�]			= a.category
	,	isnull(cl_name,'') cl_name
	,	isnull(cm_name,'') cm_name
	, 	isnull(cs_name,'') cs_name
	,	[�Ӽ�ID]			= attribute_id
	,	[���ÿ�Ӽ���]	= gallery_attribute_nm
	,	[��ǰ��_ID��]	= isnull(attribute_plno_cnt, 0)
	,	[��ǰ��_�з���]= isnull(plno_cnt, 0)
	,	[�Ӽ��Է·�]		= isnull(matching_rate, 0)
	,	[��ǥ�Է·�]		= isnull(target_aim, 0)
	,	0 ord
	from 
	(
		select category, attribute_id, gallery_attribute_nm, attribute_plno_cnt, plno_cnt,  isnull(case when isnull(attribute_plno_cnt,0) = 0 then 0 else (attribute_plno_cnt*100.0 / plno_cnt) end, 0) matching_rate, target_aim
		from tbl_external_stats_attribute  a 
		where shop_code = @shop_code and yyyymmdd =@sdate and category like @category+'%'
	)  a
		left outer join c_lcate b on substring(a.category,1,2) = b.cl_lcode and  len(a.category) >= 2
		left outer join c_mcate c on substring(a.category,1,2) = c.cm_lcode and substring(a.category,3,2) = c.cm_mcode and len(a.category) >= 4 
		left outer join c_scate d on substring(a.category,1,2) = d.cs_lcode and substring(a.category,3,2) = d.cs_mcode  and substring(a.category,5,2) = d.cs_scode and len(a.category) >= 6

	union all
	
	
	select '�հ�', '�հ�','','',0,'', sum(attribute_plno_cnt), sum(plno_cnt),  isnull(case when isnull(sum(attribute_plno_cnt),0) = 0 then 0 else (sum(attribute_plno_cnt)*100.0 / sum(plno_cnt)) end, 0) matching_rate, 0
	, 1 ord
	from tbl_external_stats_attribute  a 
	where shop_code = @shop_code and yyyymmdd =@sdate and category like @category+'%'

	order by ord, category

end



