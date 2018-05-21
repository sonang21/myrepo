/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_3_scate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-24 09:57:11.17
 *        Modify: 2018-05-03 17:23:34.013
 *        Backup: 20180521_1739
 ************************************************************************* */


create proc udp_make_lotte_data_3_scate
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
		scate,
		(select cm_name from c_mcate where cm_lcode+cm_mcode = left(scate,4)) as [�ߺз���],
		factory as [������],
	--(select cm_name from c_scate where cm_lcode+cm_mcode = scate) as [�ߺз���],
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
	(select cl_name from c_lcate where cl_lcode = left(scate,2)) as [��з���],
	(select cs_name from c_scate where cs_lcode+cs_mcode+cs_scode = left(scate,6)) as [�Һз���]

	from
	(
		select factory, scate,
			case when pl_vcode = 49 then count(modelno) end as sh_49,
			case when pl_vcode = 47 then count(modelno) end as sh_47,
			case when pl_vcode = 57 then count(modelno) end as sh_57,
			case when pl_vcode = 75 then count(modelno) end as sh_75,
			case when pl_vcode = 663 then count(modelno) end as sh_663,
			case when pl_vcode = 806 then count(modelno) end as sh_806,
			count(modelno) as all_cnt
		from tmp_shop_agg_base
		group by pl_vcode, factory, scate
	) tmp
	group by scate, factory
	order by scate,[������]
