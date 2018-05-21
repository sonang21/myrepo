/* *************************************************************************
 * NAME : dbo.udp_week_goods_sel_errorlist
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-08 21:05:24.61
 *        Modify: 2018-05-08 21:05:24.61
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc [dbo].[udp_week_goods_sel_errorlist]
	@error_percent int
,	@category varchar(12)
,	@sweek varchar(12)
,	@eweek varchar(12)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-08-16
	-- 설  명 : 그래프 데이터 확인
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select a.g_modelno
         , a.g_modelnm
         , b.g_minprice 
      from eloc2001.dbo.goods a 
           inner join eloc2001.dbo.goods_sum b on a.g_modelno = b.g_modelno
	 where a.g_category like @category + '%'
	   and b.g_minprice > 0
	   and exists ( select 1 
		              from tbl_week_goods 	
		             where wg_date_id between @sweek and @eweek
		               and wg_minprice < (b.g_minprice-(b.g_minprice * @error_percent/100))
		               and wg_modelno = a.g_modelno)
	order by g_modelno
	option (maxdop 1)