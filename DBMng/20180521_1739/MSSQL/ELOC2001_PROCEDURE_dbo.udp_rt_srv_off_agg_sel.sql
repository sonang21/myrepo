/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_agg_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-09 16:46:44.47
 *        Modify: 2018-05-03 17:23:36.14
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_rt_srv_off_agg_sel
	@category varchar(4)
,	@sdate date
,	@edate date
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.11.09
	-- ��  �� : ����3 ó�� ��Ȳ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	select yyyymmdd, category, 
	t_cnt
	, i_cnt_bat-- ����.��ġó��
	, i_cnt--����
	, d_cnt--����
	, u_cnt--����
	, case when (i_cnt + u_cnt + d_cnt + i_cnt_bat) > 0 then (d_cnt+u_cnt)*100.0 / (i_cnt + u_cnt + d_cnt + i_cnt_bat) * 1.0 else 0 end
	from 
	(
		-- ��з���
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

		-- �ߺз���
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

		-- �հ�
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
