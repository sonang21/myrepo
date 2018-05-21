/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_1_0_mcate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 17:07:07.363
 *        Modify: 2018-05-07 16:54:27.03
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_make_lotte_data_1_0_mcate
as 
begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-06-21
	-- 설  명 : 롯데닷컴 제공 데이터 만들기
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	-- ------------------------------
	--1. 중분류별 500위 최저가 및 종합몰 수 데이터
	-- 중분류별 인기도를 구하라.
	-- ------------------------------
	-- 1번 결과 저장 -- 00:10:00
	-- 중분류별 인기점수 순 top 500개
	if object_id('tmp_shop_agg_result_1') is not null
		drop table tmp_shop_agg_result_1

	create table tmp_shop_agg_result_1
	(
		mcate char(4) not null
	,	modelno  int not null
	,	modelnm nvarchar(70) not null
	,	factory nvarchar(50) not null
	,	p_rank int not null
	,	popular int not null
	,	g_minprice money not null
	)

	set nocount on
	declare @mcate char(4)
	declare cur_mcate cursor fast_forward for
	(
		select distinct mcate from tmp_shop_agg_base
	)

	open cur_mcate
	fetch next from cur_mcate into @mcate
	while @@fetch_status =0
	begin
		insert into tmp_shop_agg_result_1
		select @mcate, g_modelno, replace(g_modelnm, char(9), ' '), replace(g_factory, char(9),' '), p_rank, g_popular, g_minprice
		  from ( select a.g_modelno
                      , a.g_modelnm
                      , b.g_popular
                      , a.g_factory
                      , b.g_minprice
                      , row_number() over(order by g_popular desc) as p_rank
                   from goods a
                        inner join goods_sum b on a.g_modelno = b.g_modelno
                  where a.g_jobcode > '0' 
                    and a.g_constrain = '1' 
                    and b.g_mallcnt > 0 
                    and b.g_minprice > 0
 			        and a.g_category like @mcate+'%'
 			        and a.g_factory not in ('불명','호환','','[불명]','[호환]','(호환업체)') ) a
		 where p_rank <= 500
		option (maxdop 1)

		fetch next from cur_mcate into @mcate
	end
	close cur_mcate
	deallocate cur_mcate
end