/* *************************************************************************
 * NAME : dbo.udp_price_shop_popular_v2_agg_sel_mcate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-07-03 17:39:01.147
 *        Modify: 2018-05-03 17:23:35.217
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_price_shop_popular_v2_agg_sel_mcate
	@cate varchar(4)
,	@shop_vcode int
,	@sdate smalldatetime
,	@edate smalldatetime
,	@hour smallint
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-09-30
	-- ��  �� : ���θ� �α��ǰ �Ϻ� �ѷ�/�۾��� ���
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	select isnull(max(cm_name), max(cl_name)) as cate_name, left(cate,4) as cate, sum(sum_cnt) as sum_cnt, sum(match) as match
	,	case when isnull(sum(sum_cnt),0) =0 then 0 else (isnull(sum(match),0)*1.0/isnull(sum(sum_cnt),0)*1.0)*100.0 end as match_ratio
	from tbl_price_shop_popular_v2_agg
	where cate like @cate+'%' and shop_vcode = isnull(@shop_vcode, shop_vcode) and agg_date >= @sdate and agg_date < @edate+1
	and agg_hour = @hour
	group by left(cate,4)
	order by cate asc



	select case when isnull(sum(sum_cnt),0) =0 then 0 else (isnull(sum(match),0)*1.0/isnull(sum(sum_cnt),0)*1.0)*100.0 end as match_ratio, isnull(sum(sum_cnt),0), isnull(sum(match),0)
	from tbl_price_shop_popular_v2_agg
	where cate like @cate+'%' and shop_vcode = isnull(@shop_vcode, shop_vcode) and agg_date >= @sdate and agg_date < @edate+1
	and agg_hour = @hour


