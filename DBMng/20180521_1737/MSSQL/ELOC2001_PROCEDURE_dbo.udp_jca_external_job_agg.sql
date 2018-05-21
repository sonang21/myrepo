/* *************************************************************************
 * NAME : dbo.udp_jca_external_job_agg
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-04-14 11:30:24.297
 *        Modify: 2017-05-15 13:24:30.2
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_external_job_agg	
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� :  wookki25 / 2017.04.14
	-- ��   �� :  gs �۾���
	-- http://58.234.199.100/redmine/issues/21859
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	-- ��ȣ�۾�
	select  * 
	into #pricelist_log
	from openquery(oltplog_196,  '
	select jp_id, jp_modelno, jp_plistno, jp_date
	from
	(
		select jp_id, jp_plistno, jp_modelno, jp_date, RANK() over (partition by jp_plistno order by jp_date desc) rnk
		from JOB_PRICELIST with (readuncommitted)	
		where jp_vcode = 7871
		and jp_modelno >0 
		and jp_flag in (''0'',''5'',''6'',''M'',''N'',''P'',''S'')
		and jp_id <> ''nuribot_sync''
		and jp_id <> ''dbagent_sync''
		and jp_id <> ''mp_auto''
		and jp_date >= cast(GETDATE()-1 as date)
		and jp_date <  cast(GETDATE() as date)
	) a where rnk = 1
	')


	-- �����ǰ�� �Ϲݸ𵨷� ��ȯ(����5��1 ����)
	-- drop table #swith_log
	--select  * 
	--into #swith_log
	--from openquery(oltplog_196,  '
	--select jg_id, jg_modelno, jg_date
	--from
	--(
	--	select jg_id, jg_modelno, jg_date, rank() over (partition by jg_modelno order by jg_date desc) rnk
	--	from job_goods with (readuncommitted)
	--	where jg_flag = ''9''
	--	and jg_date>=  cast(getdate()-1 as date)
	--	and jg_date < cast(getdate() as date)
	--) a where rnk = 1
	--')

	-- ��Ī ���� ����.GS�Ӽ� ���� üũ
	select distinct jp_id,  jp_plistno
	into #pricelist_log_distinct
	from #pricelist_log a
		inner join goods b on b.g_modelno = jp_modelno
		inner join tbl_external_attribute c on c.shop_code = 7871 and c.category = left(g_category, len(c.category)) and c.attribute_id > 0
		inner join goods_category_attribute d on d.attribute_id = c.attribute_id 
			and d.category in (select top 1 category from goods_category_attribute with (readuncommitted) where category = left(g_category, 4) or category = left(g_category, 6) or category = left(g_category, 8) order by len(category) desc)
		inner join goods_catalog_attribute e on e.g_modelno = b.g_modelno and e.attribute_id = c.attribute_id and del_yn = 'N'
	option (maxdop 1)

	-- ��Ī ���� ����
	insert into TBL_EXTERNAL_JOB_AGG(mm_id, job_date, p_cnt, job_flag)
	select jp_id, getdate()-1, COUNT(*) cnt, 'm'
	from #pricelist_log_distinct
	group by jp_id
	option (maxdop 1)

	-- ����->�Ϲ� ��ȯ.GS�Ӽ�����üũ + ��Ī���� ����
	insert into TBL_EXTERNAL_JOB_AGG(mm_id, job_date, p_cnt, job_flag)
	select mm_id, getdate()-1, count(distinct pl_no) cnt, 's'
	from tbl_external_work_model -- #swith_log
--		inner join goods b on b.g_modelno = jg_modelno
--		inner join tbl_external_attribute c on c.shop_code = 7871 and c.category = left(g_category, len(c.category)) and c.attribute_id > 0
--		inner join goods_category_attribute d on d.attribute_id = c.attribute_id and d.category in (select top 1 category from goods_category_attribute with (readuncommitted) where category = left(g_category, 4) or category = left(g_category, 6) or category = left(g_category, 8) order by len(category) desc)
--		inner join goods_catalog_attribute e on e.g_modelno = b.g_modelno and e.attribute_id = c.attribute_id and del_yn = 'N'
		inner join pricelist on pl_vcode = 7871 and pl_modelno = modelno and pl_srvflag = '4' and pl_status = '4'
	where pl_no not in (select jp_plistno from #pricelist_log_distinct) -- �ߺ����� // #pricelist_log�� �ִ�  pl_no����(�۾���)�� pl_no �۾��ڰ� ��������.
	and regdate >= cast(getdate()-1 as date) and regdate < cast(getdate()-0 as date)
	group by mm_id 
	option(maxdop 1)

end


