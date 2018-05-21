/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_3_mcate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 17:07:54.767
 *        Modify: 2018-05-03 17:23:35.943
 *        Backup: 20180521_1737
 ************************************************************************* */




CREATE proc udp_make_lotte_data_3_mcate
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-06-21
	-- ��  �� : �Ե����� ���� ������ �����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	-- ------------------------------
	-- 3. ��ü ��ǰ ���� ���ո� ��ǰ�� ��Ȳ
	-- ------------------------------
	select
		mcate,
		(select cm_name from c_mcate where cm_lcode+cm_mcode = mcate) as [�ߺз���],
		factory as [������],
	--(select cm_name from c_mcate where cm_lcode+cm_mcode = mcate) as [�ߺз���],
--	'�������' as [�׸�],
	isnull(sum(sh_49),0) as [�Ե�����],
	isnull(round((sum(sh_49)/(max(all_cnt)*1.0))*100,0),0) as [�����],
	isnull(sum(sh_47),0) as [�ż����],
	isnull(round((sum(sh_47)/(max(all_cnt)*1.0))*100,0),0) as [A_�����],
	isnull(sum(sh_57),0) as [HMall],
	isnull(round((sum(sh_57)/(max(all_cnt)*1.0))*100,0),0) as [B_�����],
	isnull(sum(sh_75),0) as [GSShop],
	isnull(round((sum(sh_75)/(max(all_cnt)*1.0))*100,0),0) as [C_�����],
	isnull(sum(sh_663),0) as [�Ե�Ȩ����],
	isnull(round((sum(sh_663)/(max(all_cnt)*1.0))*100,0),0) as [D_�����],
	isnull(sum(sh_806),0) as [CJMall],
	isnull(round((sum(sh_806)/(max(all_cnt)*1.0))*100,0),0) as [E_�����],
	(select cl_name from c_lcate where cl_lcode = left(mcate,2)) as [��з���]
	from
	(
		select factory, mcate,
			case when pl_vcode = 49 then count(modelno) end as sh_49,
			case when pl_vcode = 47 then count(modelno) end as sh_47,
			case when pl_vcode = 57 then count(modelno) end as sh_57,
			case when pl_vcode = 75 then count(modelno) end as sh_75,
			case when pl_vcode = 663 then count(modelno) end as sh_663,
			case when pl_vcode = 806 then count(modelno) end as sh_806,
			count(modelno) as all_cnt
		from tmp_shop_agg_base
		group by pl_vcode, factory, mcate
	) tmp
	group by mcate, factory
	order by mcate,[������]
