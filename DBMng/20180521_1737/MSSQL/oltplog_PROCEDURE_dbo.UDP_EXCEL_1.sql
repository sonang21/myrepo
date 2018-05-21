/* *************************************************************************
 * NAME : dbo.UDP_EXCEL_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:31:40.96
 *        Modify: 2018-05-13 19:31:40.96
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_EXCEL_1
	@sdate smalldatetime
,	@edate smalldatetime
AS begin
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 20161122
	-- ��  �� : �����ǰ.gmv
	-- ��  �� : 
	-- ----------------------------------------------------------------------------------

	-- ------------------
	-- �����ǰ ���� �з��ڵ�
	-- ------------------
	-- drop table #tmp_cate
	select * 
	into #tmp_cate
	from openquery(oradb_144, 'select ca_code from TBL_GRMATCHING_AUTO_MODEL_CATE ')

	-- ------------------
	-- ��Ʈ�� ��
	-- ------------------
	begin
		-- drop table #auto_b_modelno
		select jg_modelno, left(jg_category,4) jg_category
		into #auto_b_modelno
		from JOB_goods where jg_id = 'ENURI_AUTO_B' and jg_flag ='n'
		and jg_date>= '2016-11-01'-- and jg_date < '2017-02-03'

		-- �����ǰ ���� �з��� ���� ���� ����
		delete from a
		--select	* 
		from	#auto_b_modelno a 
					left outer join 
				#tmp_cate b on a.jg_category = b.ca_code
		where b.ca_code is null
	end

	

	-- ------------------
	-- �ֹ����� ����
	-- ------------------	
	-- pc.ü��1
	-- drop table #tmp_gmv
	select	pl_modelno, left(a.OD_CATEGORY, 8) as mcate, convert(varchar(10), a.od_date, 120) as yyyymmdd, count(*) od_cnt, sum(a.od_cnt*a.od_price) as total_price
	, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)) as auto_model_total_price
	--, sum(a.od_cnt*a.od_price*sign(isnull(b.jg_modelno,0))) as built_on_total_price
	--, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)*sign(isnull(b.jg_modelno,0))) as auto_model_built_on_total_price	
	into	#tmp_gmv 
	from	tbl_orderdata a-- left outer join #auto_b_modelno b on a.pl_modelno = b.jg_modelno
	where	od_date >=@sdate and od_date<@edate+1
	and		left(od_category,4) in (
		select left(ca_code, 4) from #tmp_cate
	)
	and		shop_vcode not in (55, 536, 5910, 4027)
	group by pl_modelno, left(OD_CATEGORY, 8), convert(varchar(10), od_date, 120)

	-- pc.ü��3
	insert into	#tmp_gmv
	select	pl_modelno, left(a.OD_CATEGORY, 8) as mcate, convert(varchar(10), a.od_date, 120) as yyyymmdd, count(*) od_cnt
	, sum(a.od_cnt*a.od_price) as total_price
	, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)) as auto_model_total_price
	from	tbl_orderdata_gmarket_auction a
	where	od_date >=@sdate and od_date<@edate+1
	and		left(od_category,4) in (
		select left(ca_code, 4) from #tmp_cate
	)
	and		shop_vcode in (55, 536, 5910, 4027)
	group by pl_modelno, left(OD_CATEGORY, 8), convert(varchar(10), od_date, 120)

	-- �����.ü��1
	insert into	#tmp_gmv
	select	pl_modelno, left(a.OD_CATEGORY, 8) as mcate, convert(varchar(10), a.od_date, 120) as yyyymmdd, count(*) od_cnt
	, sum(a.od_cnt*a.od_price) as total_price
	, sum(a.od_cnt*a.od_price*isnull(a.is_auto_modelno,0)) as auto_model_total_price
	from	tbl_orderdata_ord_mobile a
	where	od_date >=@sdate and od_date<@edate+1
	and		left(od_category,4) in (
		select left(ca_code, 4) from #tmp_cate
	)
	group by pl_modelno, left(OD_CATEGORY, 8), convert(varchar(10), od_date, 120)


	-- ------------------
	--	�������
	-- ------------------
	-- ����.�𵨺�
	select yyyymmdd, mcate, PL_MODELNO, g_modelnm, od_cnt, auto_model_total_price
	, convert(varchar(10), getdate(), 120) as '���ϻ�����'
	from 
	(
		select yyyymmdd, mcate, pl_modelno, sum(od_cnt) od_cnt
		, sum(auto_model_total_price) auto_model_total_price		
		from #tmp_gmv
		where auto_model_total_price>0
		group by mcate, yyyymmdd, pl_modelno
	) a  inner join analstore.dbo.goods on pl_modelno = g_modelno
	
	

	-- ����.�ߺз���
	select mcate
	, sum(total_price)								-- ����з�.��ü�ֹ���		
	, sum(auto_model_total_price)					-- ����з�.�����ǰ.��ü�ֹ���
	, sum(total_price*sign(isnull(b.jg_modelno,0)))	-- ����з�.��Ʈ����ü
	, cast(getdate() as date) as '���ϻ�����'
	from 
	(
		select left(mcate,4) mcate
			, sum(total_price) as total_price							
			, sum(auto_model_total_price)	auto_model_total_price					
			, pl_modelno
		from #tmp_gmv
		group by left(mcate,4), pl_modelno
	) a left outer join #auto_b_modelno b on a.pl_modelno = b.jg_modelno
	group by mcate
	order by mcate
end



