/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_1_scate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-24 09:57:11.093
 *        Modify: 2018-05-03 17:23:36.147
 *        Backup: 20180521_1737
 ************************************************************************* */



create proc udp_make_lotte_data_1_scate
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
	select
		scate,
		(select cm_name from c_mcate where cm_lcode+cm_mcode = left(scate,4)) as [�ߺз���],
		p_rank as [����],
		max(modelnm) as [��ǰ��],
		max(factory) as [������],
		--(select g_factory from goods where g_modelno = max(modelno)) as [������],
		isnull(sum(mall_cnt),0) as [��޼��θ���],
		--min(min_price) as [������],
		isnull(min(g_minprice),0) as [������],
		--case when min(min_price) = sum(sh_49) then 'y' else 'n' end [�Ե����� ������ ����],
		case when min(g_minprice) = sum(sh_49) then 'y' else 'n' end [�Ե����� ������ ����],
		case when sum(sh_49) is not null then 'y' else 'n' end [�Ե����� ��Ī ����],
		isnull(max(pl_goodscode),'') as [�Ե����� ��ǰ�ڵ�] ,
		isnull(sum(sh_49),0) as [�Ե����� �ǸŰ�],
		isnull(sum(sh_49_d_rank),0) as [�Ե����� ����],

		isnull(sum(sh_47),0) as [�ż���� �ǸŰ�],
		isnull(sum(sh_47_d_rank),0) as [�ż���� ����],

		isnull(sum(sh_57),0) as [HMall �ǸŰ�],
		isnull(sum(sh_57_d_rank),0) as [HMall ����],

		isnull(sum(sh_75),0) as [GSSho �ǸŰ�],
		isnull(sum(sh_75_d_rank),0) as [GSSho ����],

		isnull(sum(sh_663),0) as [�Ե�Ȩ���� �ǸŰ�],
		isnull(sum(sh_663_d_rank),0) as [�Ե�Ȩ���� ����],

		isnull(sum(sh_806),0) as [CJMall �ǸŰ�],
		isnull(sum(sh_806_d_rank),0) as [CJMall ����],
		(select cl_name from c_lcate where cl_lcode = left(scate,2)) as [��з���],
		(select cs_name from c_scate where cs_lcode+cs_mcode+cs_scode = left(scate,6)) as [�Һз���]
	from (
		select a.scate,
			p_rank,
			modelnm,
			a.modelno,
			a.factory,
			min_price,
			pl_vcode,
			case when pl_vcode is null then 0 else 1 end as mall_cnt,
			case when pl_vcode = 49 then min_price end as sh_49,
			case when pl_vcode = 49 then d_rank end as sh_49_d_rank,
			case when pl_vcode = 47 then min_price end as sh_47,
			case when pl_vcode = 47 then d_rank end as sh_47_d_rank,
			case when pl_vcode = 57 then min_price end as sh_57,
			case when pl_vcode = 57 then d_rank end as sh_57_d_rank,
			case when pl_vcode = 75 then min_price end as sh_75,
			case when pl_vcode = 75 then d_rank end as sh_75_d_rank,
			case when pl_vcode = 663 then min_price end as sh_663,
			case when pl_vcode = 663 then d_rank end as sh_663_d_rank,
			case when pl_vcode = 806 then min_price end as sh_806,
			case when pl_vcode = 806 then d_rank end as sh_806_d_rank,
			case when pl_vcode = 49 then pl_goodscode end as pl_goodscode,
			g_minprice
		from tmp_shop_agg_result_1  a
			left outer join
			(	select *,
				dense_rank() over(partition by modelno order by min_price) as d_rank
				from tmp_shop_agg_base
			) b
				on a.modelno = b.modelno
	) c
	group by scate, p_rank
	order by scate, p_rank
