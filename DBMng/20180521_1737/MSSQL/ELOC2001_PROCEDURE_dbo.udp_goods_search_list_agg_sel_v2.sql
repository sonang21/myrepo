/* *************************************************************************
 * NAME : dbo.udp_goods_search_list_agg_sel_v2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-02-28 15:50:17.64
 *        Modify: 2018-05-03 17:23:34.783
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_goods_search_list_agg_sel_v2
	@sdate smalldatetime
,	@edate smalldatetime
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-02-28
	-- ��  �� : pricelist ��ǰ��Ī �Ϻ� ��� ����
	-- ��  �� : udp_goods_search_list_agg_sel_v2
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	select  
	  [����] = datepart(ww, agg_date)
	, [������] = agg_date
	, [�з�] = category
	, [�з���] = (select cm_name from c_mcate where cm_lcode = substring(category, 1,2) and cm_mcode = substring(category, 3,2))
	, [�ѱ׷�] =  g_raw_t_cnt
	,	[�ѱ׷�_�߰�] = g_raw_nm_cnt 
	,	[�ѱ׷�_��Ī] = g_raw_vm_cnt 
	,	[�ѱ׷�_��Ī_����] = g_raw_vm_min_cnt 
	,	[�ѱ׷�_���߸�Ī] = g_raw_multi_cnt 

	, [ó���׷�] = g_work_t_cnt 
	,	[�����ǰ]	 = g_work_auto_cnt
	,	[�ڵ��׷��Ī]	 =  g_work_auto_m_cnt
	,	[�հ�]			 = g_work_wm_cnt +g_work_mm_cnt +g_work_multi_cnt + g_work_etc_cnt
	,		[ó���׷�_�߰�]  = g_work_wm_cnt 
	,		[ó���׷�_��Ī]  = g_work_mm_cnt 
	,		[ó���׷�_��Ī_����]  = g_work_mm_min_cnt 
	,		[ó���׷�_���߸�Ī]  = g_work_multi_cnt 
	,		[ó���׷�_��Ÿ]  = g_work_etc_cnt

	, [�Ѱ���] = p_raw_t_cnt 
	,	[�Ѱ���_�߰�]  = p_raw_nm_cnt 
	,	[�Ѱ���_��Ī]  = p_raw_vm_cnt
	,	[�Ѱ���_��Ī_����]  = p_raw_vm_min_cnt
	,	[�Ѱ���_���߸�Ī] = p_raw_multi_cnt

	, [ó��] = p_work_t_cnt 
	,	[�����ǰ]	= p_work_auto_cnt
	,	[�ڵ��׷��Ī]	 =  p_work_auto_m_cnt
	,	[�հ�] = p_work_wm_cnt +p_work_mm_cnt +p_work_multi_cnt +p_work_etc_cnt
	,		[ó��_�߰�] = p_work_wm_cnt 
	,		[ó��_��Ī] = p_work_mm_cnt 
	,		[ó��_��Ī_����] = p_work_mm_min_cnt 
	,		[ó��_���߸�Ī] = p_work_multi_cnt 
	,		[ó��_��Ÿ] = p_work_etc_cnt

--	, [��ó���׷�] = g_nwork_t_cnt 
--	,	[��ó���׷�_�߰�] = g_nwork_nm_cnt 
--	,	[��ó���׷�_��Ī] = g_nwork_vm_cnt
--	,	[��ó���׷�_���߸�Ī] = g_nwork_multi_cnt

--	, [��ó��] = g_nwork_vm_cnt
--	,	[��ó��_�߰�] = p_nwork_nm_cnt 
--	,	[��ó��_��Ī] = p_nwork_vm_cnt 
--	,	[��ó��_���߸�Ī] = p_nwork_multi_cnt 

	-- ��ȭ��
	, [�Ѱ���] = p_raw_s_t_cnt 
	,	[�Ѱ���_�߰�]  = p_raw_s_nm_cnt 
	,	[�Ѱ���_��Ī]  = p_raw_s_vm_cnt
	,	[�Ѱ���_��Ī_����]  = p_raw_s_vm_min_cnt
	,	[�Ѱ���_���߸�Ī] = p_raw_s_multi_cnt

	, [ó��] = p_work_s_t_cnt 
	,	[�����ǰ]	= p_work_s_auto_cnt
	,	[�ڵ��׷��Ī]	 =  p_work_s_auto_m_cnt
	,	[�հ�] = p_work_s_wm_cnt +p_work_s_mm_cnt +p_work_s_multi_cnt +p_work_s_etc_cnt
	,		[ó��_�߰�] = p_work_s_wm_cnt 
	,		[ó��_��Ī] = p_work_s_mm_cnt 
	,		[ó��_��Ī_����] = p_work_s_mm_min_cnt 
	,		[ó��_���߸�Ī] = p_work_s_multi_cnt 
	,		[ó��_��Ÿ] = p_work_s_etc_cnt

	from tbl_goods_search_list_agg_v2
	where agg_date >= @sdate and agg_date < @edate +1
	order by agg_date, category




