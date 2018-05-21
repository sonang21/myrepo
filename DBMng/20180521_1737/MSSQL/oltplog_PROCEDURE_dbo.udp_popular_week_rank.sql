/* *************************************************************************
 * NAME : dbo.udp_popular_week_rank
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-09 20:28:42.507
 *        Modify: 2018-05-13 20:24:52.607
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_popular_week_rank]
	@date_in	smalldatetime
as
begin
	-- ------------------------------------------
	-- 작성자 : wookki25 2007.08
	-- 설  명 : 상품별 인기도 주간 랭킹
	--          tbl_goods_popular_acc 기준으로 산출
	--			주간기준 : 매주 일~토
	--			가상주문실적 : 매주 토요일 가상주문실적
	--			인기도 순 : 매주 일~토요일 인기점수 합계를 기준으로 순위 정한다.
	-- ------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted
	declare @loopdate smalldatetime			-- 입력할 주(week)에 포함되는 날짜
	declare @firstday smalldatetime			-- 입력할 주(week)의 월(month) 시작일
	declare @weekofmonth char(8)			-- 입력할 주간
	declare @sdateofweek smalldatetime		-- 입력할 주간의 시작일(일요일)
	declare @edateofweek smalldatetime		-- 입력할 주간의 종료일(토요일)+1

	-- 디폴트값 설정
	if @date_in = ''
		set @loopdate = dateadd(dd, -datepart(weekday,getdate()), getdate()) -- 전주(前週) 토요일
	else
		set @loopdate = @date_in
	set @loopdate = convert(varchar(8), @loopdate, 112)


	-- 주간계산
	set @firstday = dateadd(dd, -day(@loopdate)+1, @loopdate)
	set @firstday = case
						when datepart(weekday, @firstday) > 1 and datediff(ww, @firstday, @loopdate)= 0 then
							dateadd(mm,-1,@firstday)
						else
							@firstday
					end
	set @weekofmonth = left(convert(varchar(8), @firstday, 112),6)+'0'+cast(datediff(ww,@firstday,@loopdate)+(case when datepart(weekday, @firstday) > 1 then 0 else 1 end) as varchar(2))
	-- select getdate(), '주간계산 ok', @weekofmonth



	-- 주간범위(시작일, 종료일)
	set @sdateofweek = dateadd(dd, -datepart(weekday,@loopdate)+1, @loopdate)
	set @edateofweek = dateadd(dd, 7-datepart(weekday,@loopdate)+1, @loopdate)
	-- select getdate(), '주간범위 ok', @sdateofweek, @edateofweek


	-- tbl_goods_popular_week_rank_acc 입력
	truncate /* udp_popular_week_rank:01 */
       table tbl_goods_popular_week_rank_acc
    
    insert /* udp_popular_week_rank:02 */
      into tbl_goods_popular_week_rank_acc
           ( g_modelno
           , g_category
           , g_mcate
           , g_scate
           , g_factory
           , po_point
           , od_vcnt
           , week_of_month
           , od_vcnt_of_sat)
    select g.g_modelno
           , g.g_category
           , left(g.g_category, 4) as g_mcate
           , left(g.g_category, 6) as g_scate
           , g.g_factory
           , po_point
           , od_vcnt
           , @weekofmonth          as week_of_month
           , od_vcnt_of_sat
      from (select g_modelno
                   , Sum(gpa_po_point) as po_point
                   , Sum(gpa_od_vcnt)  as od_vcnt
                   , Sum(case
                           when gpa_date = ( @edateofweek - 1 ) then gpa_od_vcnt
                           else 0
                         end)          as od_vcnt_of_sat
              from tbl_goods_popular_acc
             where gpa_date >= @sdateofweek
               and gpa_date < @edateofweek
               and g_modelno > 0
             group by g_modelno) tbl_temp_mid
           left outer join simpledb.dbo.goods g on tbl_temp_mid.g_modelno = g.g_modelno
     where g_jobcode <> '0'
       and g_mallcnt > 0 


	--select getdate(), 'tbl_goods_popular_week_rank_acc 입력 ok'


	-- 제조사 가중치 적용
    update /* udp_popular_week_rank:03 */
           a
       set po_point = Ceiling(po_point * p_weight)
      from tbl_goods_popular_week_rank_acc a
           inner join goods_popular_weight_factory b on a.g_factory = b.g_factory
     where b.use_flag = 1
       and left(a.g_category, Len(b.g_category)) = b.g_category 



	--모델 가중치 적용
    update /* udp_popular_week_rank:04 */
           a
       set po_point = Ceiling(po_point * p_weight)
      from tbl_goods_popular_week_rank_acc a
           inner join goods_popular_weight_modelno b on a.g_modelno = b.g_modelno
     where b.use_flag = 1 



	-- 카테고리별 가중치
    update /* udp_popular_week_rank:05 */
           a
       set po_point = Ceiling(po_point * p_weight)
      from tbl_goods_popular_week_rank_acc a
           inner join goods_popular_weight_category b
                   on a.g_category like b.g_category + '%'
     where b.use_flag = 1 




	-- 순위 적용 : 개별상품
	--insert into mpdb02.log2004.dbo.tbl_goods_popular_week_rank 	
	if object_id('tmp_worker_1_at_udp_popular_week_rank') is not null begin
		drop /* udp_popular_week_rank:06 */
       table tmp_worker_1_at_udp_popular_week_rank
    end

    select /* udp_popular_week_rank:07 */
           g_modelno
         , g_category
         , po_point
         , od_vcnt
         , week_of_month
         , mcate_po_rank = (select Count(*) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_mcate = b.g_mcate
                               and a.po_point > b.po_point)
         , scate_po_rank = (select Count(*) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_scate = b.g_scate
                               and a.po_point > b.po_point)
         , mcate_od_rank = (select Count(*) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_mcate = b.g_mcate
                               and a.od_vcnt > b.od_vcnt)
         , scate_od_rank = (select Count(*) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_scate = b.g_scate
                               and a.od_vcnt > b.od_vcnt)
         , od_vcnt_of_sat
      into tmp_worker_1_at_udp_popular_week_rank
      from tbl_goods_popular_week_rank_acc b 


	--select getdate(), ''순위적용 ok''

	-- ----------------------------------------
	-- 그룹인기도 계산..
	-- ----------------------------------------
	update /* udp_popular_week_rank:08 */
           tbl_goods_popular_week_rank_acc
	   set group_point = po_point
	     , group_od_vcnt = od_vcnt
	     , g_modelno_group = g_modelno
	     , group_od_vcnt_of_sat = od_vcnt_of_sat

	-- eloc 기준. 그룹모델 정보 입력 : 2초
	select /* udp_popular_week_rank:09 */
           g_modelno
         , g_modelno_group
	     , cast(0 as int) popular
	     , cast(0 as int) od_vcnt
	     , cast(0 as int) od_vcnt_of_sat
	  into #eloc_goods_group
	  from openquery(eloc188, '
           select /* udp_popular_week_rank:10 */
                  a.g_modelno
                , a.g_modelno_group 
             from eloc2001.dbo.goods a with (readuncommitted)
                  inner join eloc2001.dbo.goods_sum b with (readuncommitted) on a.g_modelno = b.g_modelno
            where a.g_modelno_group is not null 
              and b.g_mallcnt>0 
              and a.g_constrain = ''1''
    ')

	
	-- 그룹정보 입력 : 4 초
	update /* udp_popular_week_rank:11 */
           x
	   set g_modelno_group = y.g_modelno_group
	  from tbl_goods_popular_week_rank_acc x 
           inner join #eloc_goods_group y on x.g_modelno = y.g_modelno

	-- 모델점수 입력 : 3초
	update /* udp_popular_week_rank:12 */
           y
	   set popular = x.po_point
	     , od_vcnt = x.od_vcnt	
	     , od_vcnt_of_sat = x.od_vcnt_of_sat
	  from tbl_goods_popular_week_rank_acc x inner join #eloc_goods_group y on x.g_modelno = y.g_modelno

	-- 그룹 인기도 계산 : 7초
	select /* udp_popular_week_rank:13 */
           c.g_modelno_group
	     , sum(case when d.g_modelno is not null then popular else 0 end) as group_point -- top 3개만 인기도에 참조
	     , sum(od_vcnt) as group_od_vcnt
	     , sum(od_vcnt_of_sat) as group_od_vcnt_of_sat
	  into #group_point
	  from #eloc_goods_group as c
	       left outer join ( select a.g_modelno
                                  , Count(*) as ranknum
                               from #eloc_goods_group as a
                                    inner join #eloc_goods_group as b on ( a.g_modelno_group = b.g_modelno_group )
                                                                     and ( a.popular + ( a.g_modelno / 100000000000 ) <= b.popular + ( b.g_modelno / 100000000000 ) )
                              group by a.g_modelno
                             having Count(*) <= 3 ) as d on (c.g_modelno = d.g_modelno)
	 group by c.g_modelno_group



	-- 그룹인기도 적용 : 3초
	update /* udp_popular_week_rank:14 */
           x
	   set group_point = y.group_point
	     , group_od_vcnt = y.group_od_vcnt
	     , group_od_vcnt_of_sat = y.group_od_vcnt_of_sat
	  from tbl_goods_popular_week_rank_acc x 
           inner join #group_point y on x.g_modelno_group = y.g_modelno_group

	-- 순위 적용 - 그룹
	--insert into mpdb02.log2004.dbo.tbl_goods_popular_week_rank_group
	if object_id('tmp_worker_2_at_udp_popular_week_rank') is not null begin
		drop /* udp_popular_week_rank:15 */
       table tmp_worker_2_at_udp_popular_week_rank
    end
	select /* udp_popular_week_rank:16 */
           g_modelno
         , g_category
         , group_point
         , group_od_vcnt
         , week_of_month
         , mcate_po_rank = (select Count(distinct group_point) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_mcate = b.g_mcate
                               and a.group_point > b.group_point)
         , scate_po_rank = (select Count(distinct group_point) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_scate = b.g_scate
                               and a.group_point > b.group_point)
         , mcate_od_rank = (select Count(distinct group_od_vcnt) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_mcate = b.g_mcate
                               and a.group_od_vcnt > b.group_od_vcnt)
         , scate_od_rank = (select Count(distinct group_od_vcnt) + 1
                              from tbl_goods_popular_week_rank_acc a
                             where a.g_scate = b.g_scate
                               and a.group_od_vcnt > b.group_od_vcnt)
         , group_od_vcnt_of_sat
      into tmp_worker_2_at_udp_popular_week_rank
      from tbl_goods_popular_week_rank_acc b
     where g_modelno_group is not null 


	--select getdate(), '순위적용 ok'
end


