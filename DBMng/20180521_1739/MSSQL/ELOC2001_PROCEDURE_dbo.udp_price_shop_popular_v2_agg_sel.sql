/* *************************************************************************
 * NAME : dbo.udp_price_shop_popular_v2_agg_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-09-30 15:43:34.703
 *        Modify: 2018-05-03 17:23:34.023
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_price_shop_popular_v2_agg_sel
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

	select shop_vcode, isnull(cm_name, cl_name), cate, isnull(sum_cnt,0), isnull(match,0), isnull(not_match_zero,0), isnull(not_match_minus,0), isnull(not_match_srv_O,0), match_ratio
	from tbl_price_shop_popular_v2_agg
	where cate like @cate and shop_vcode = isnull(@shop_vcode, shop_vcode) and agg_date >= @sdate and agg_date < @edate+1
	and agg_hour = @hour
	order by cate, shop_vcode


	select isnull(sum(sum_cnt),0), isnull(sum(match),0), isnull(sum(not_match_zero),0), isnull(sum(not_match_minus),0), isnull(sum(not_match_srv_O),0)
	,		case when isnull(sum(sum_cnt),0) =0 then 0 else (isnull(sum(match),0)*1.0/isnull(sum(sum_cnt),0)*1.0)*100.0 end as match_ratio
	from tbl_price_shop_popular_v2_agg
	where cate like @cate and shop_vcode = isnull(@shop_vcode, shop_vcode) and agg_date >= @sdate and agg_date < @edate+1
	and agg_hour = @hour
