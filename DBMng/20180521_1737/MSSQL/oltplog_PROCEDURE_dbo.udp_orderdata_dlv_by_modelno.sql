/* *************************************************************************
 * NAME : dbo.udp_orderdata_dlv_by_modelno
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-14 13:55:27.193
 *        Modify: 2018-05-14 13:55:27.193
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_orderdata_dlv_by_modelno
	@sdate smalldatetime
,	@edate smalldatetime
,	@category varchar(12)
,	@top_n int
,	@pl_modelno int
as
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-12-03
	-- 설  명 : 저장시점 쇼핑몰별 배송 데이터
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select cast(od_tid as bigint) od_tid,shop_vcode,od_id,od_id_no,od_date,od_goodscode,od_goodsnm,
	od_price,od_cnt,pl_no,pl_modelno,od_category,od_flag,od_jumin_yyyy,od_jumin_sex 
	into #result
	from dbo.tbl_orderdata with (readuncommitted) 
	where od_date>=@sdate and od_date <@edate+1
	and od_category like @category + '%'
	and pl_modelno = isnull(@pl_modelno, pl_modelno)

	select top (@top_n) a.pl_modelno, b.g_modelnm, cnt, od_cnt, sum_price, b.g_factory, 0
	from 
	(
		select pl_modelno,
			count(*) as cnt,
			sum(od_cnt) od_cnt,
			sum(od_price*od_cnt) sum_price
		from #result r
		group by pl_modelno
	) a left outer join analsdw.dbo.goods b with (readuncommitted) on a.pl_modelno = b.g_modelno
	order by sum_price desc

