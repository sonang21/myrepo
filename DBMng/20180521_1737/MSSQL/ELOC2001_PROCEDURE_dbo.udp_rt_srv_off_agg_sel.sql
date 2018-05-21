/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_agg_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-09 16:46:44.47
 *        Modify: 2018-05-03 17:23:36.14
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_rt_srv_off_agg_sel
	@category varchar(4)
,	@sdate date
,	@edate date
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.11.09
	-- 설  명 : 단종3 처리 현황
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select yyyymmdd, category, 
	t_cnt
	, i_cnt_bat-- 정상.배치처리
	, i_cnt--정상
	, d_cnt--유지
	, u_cnt--변경
	, case when (i_cnt + u_cnt + d_cnt + i_cnt_bat) > 0 then (d_cnt+u_cnt)*100.0 / (i_cnt + u_cnt + d_cnt + i_cnt_bat) * 1.0 else 0 end
	from 
	(
		-- 대분류별
		select yyyymmdd
		     , left(category, 2) category
		     , isnull(sum(t_cnt),0) t_cnt
			 , isnull(sum(i_cnt),0) i_cnt
			 , isnull(sum(u_cnt),0) u_cnt
			 , isnull(sum(d_cnt),0) d_cnt
			 , isnull(sum(i_cnt_bat),0) i_cnt_bat			 
		from tbl_rt_srv_off_agg
		where category like @category +'%' and @category = ''
		and yyyymmdd between @sdate and @edate
		group by yyyymmdd, left(category, 2)
		
		union all

		-- 중분류별
		select yyyymmdd
		     , left(category, 4) category
		     , isnull(sum(t_cnt),0) t_cnt
			 , isnull(sum(i_cnt),0) i_cnt
			 , isnull(sum(u_cnt),0) u_cnt
			 , isnull(sum(d_cnt),0) d_cnt
			 , isnull(sum(i_cnt_bat),0) i_cnt_bat		
		from tbl_rt_srv_off_agg
		where category like @category +'%' and @category <> ''
		and yyyymmdd between @sdate and @edate
		group by yyyymmdd, left(category, 4)


		union all

		-- 합계
		select '9999-12-31'
		     , 'zz' category
		     , isnull(sum(t_cnt),0) t_cnt
			 , isnull(sum(i_cnt),0) i_cnt
			 , isnull(sum(u_cnt),0) u_cnt
			 , isnull(sum(d_cnt),0) d_cnt
			 , isnull(sum(i_cnt_bat),0) i_cnt_bat		
		from tbl_rt_srv_off_agg
		where category like @category +'%'
		and yyyymmdd between @sdate and @edate

	) a
	order by category
