/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step1_raw_g4
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-07-29 17:08:14.36
 *        Modify: 2018-05-07 17:32:11.71
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_step1_raw_g4
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-07-29
	-- 설  명 : 모니터링 데이터 수집-이상 최저가/최고가
	--			매일 1회 새벽 5시에 실행
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2016.08.17		wookki25		단종1만 모니터링 대상으로 처리
	2016.10.07		wookki25		데이터 수집중지
									이경국 요청 //http://58.234.199.100/redmine/issues/18444
	*/


	-- 기존 테이블명 변경
	if object_id('tbl_monitoring_target_raw_old_g4') is not null begin
		drop table tbl_monitoring_target_raw_old_g4		
	end
	if object_id('tbl_monitoring_target_raw_new_g4') is not null begin
		exec sp_rename tbl_monitoring_target_raw_new_g4, tbl_monitoring_target_raw_old_g4
	end

	-- 중분류별 n개 모델
	-- drop table #p_goods 


    select 
           a.modelno
         , s.g_minprice
         , s.g_maxprice
	     , case when s.g_minprice <= (s.g_avgprice * 0.3) then 1 else 0 end is_min
	     , case when s.g_maxprice >= (s.g_avgprice * 3.0) then 1 else 0 end is_max  
           into #p_goods 
      from tbl_mcate_popular_rank a 
           inner join goods b on a.modelno = b.g_modelno
           inner join goods_sum s on b.g_modelno = s.g_modelno
     where 1=0

    if getdate() < cast('2015-11-11' as datetime) begin

	    insert into #p_goods
	    select modelno
             , s.g_minprice
             , s.g_maxprice
		     , case when s.g_minprice <= (s.g_avgprice * 0.3) then 1 else 0 end is_min
		     , case when s.g_maxprice >= (s.g_avgprice * 3.0) then 1 else 0 end is_max  
	    --into #p_goods 
	      from tbl_mcate_popular_rank a 
               inner join goods b on a.modelno = b.g_modelno
               inner join goods_sum s on b.g_modelno = s.g_modelno
	     where mcate_group_rank between 1 and 300 -- 중분류 인기순위 1~300위 모델
	       and s.g_mallcnt >= 3
	       and s.g_minprice >= 11
	       and s.g_maxprice >= 11
	       and s.g_avgprice >= 11
	       and ( s.g_minprice <= (g_avgprice * 0.3)
		       or s.g_maxprice >= (g_avgprice * 3.0) )
	    option (maxdop 1)


    end else begin

	    insert into #p_goods
	    select 
              modelno
            , s.g_minprice
            , s.g_maxprice
		    , case when s.g_minprice <= (s.g_avgprice * 0.3) then 1 else 0 end is_min
		    , case when s.g_maxprice >= (s.g_avgprice * 3.0) then 1 else 0 end is_max  
	    --into #p_goods 
	     from tbl_mcate_popular_rank a 
              inner join goods b on a.modelno = b.g_modelno
              inner join goods_sum s on b.g_modelno = s.g_modelno
	    where mcate_group_rank between 1 and 60 -- 중분류 인기순위 1~60위 모델
	      and s.g_mallcnt >= 3
	      and s.g_minprice >= 11
	      and s.g_maxprice >= 11
	      and s.g_avgprice >= 11
	      and ( s.g_minprice <= (s.g_avgprice * 0.3)		   
              or s.g_maxprice >= (s.g_avgprice * 3.0))
	      and g_constrain <> '1' --단종1만 모니터링 대상으로 처리
	   option (maxdop 1)
    end


	-- 원본 데이터
	--drop table tbl_monitoring_target_raw_new_g4
	select 
            pl_no, pl_vcode, pl_modelno, pl_category, pl_price, pl_deliveryinfo, pl_status, pl_call_plan, pl_tag_price --pl_price_card, 
	      , pl_goodsnm
	      , cast('' as nvarchar(200)) pl_goodsnm_old
	      , cast(0 as smallint) comp_order	-- 변경사항 비교 우선순위
	      , cast(0 as smallint) chg_type		-- 변경사항 구분
	      , cast('' as nvarchar(70)) as g_modelnm
	      , cast('' as char(8)) as g_category
	      , getdate() as regdate
	      , pl_date
	      , case when pl_price <= g_minprice and is_min = 1 then pl_price end min_pl_price
	      , case when pl_price >= g_maxprice and is_max = 1 then pl_price end max_pl_price
	      , getdate() as today_first_date
	   into tbl_monitoring_target_raw_new_g4
	   from pricelist  with (readuncommitted) 
            inner join #p_goods on pl_modelno = modelno
	  where pl_modelno>0 
        and pl_status in ('0','1','2','8') 
        and pl_srvflag in ('0','r','l','b','s') 
        and option_flag2 ='0' 
	    and ((pl_price <= g_minprice and is_min = 1) or (pl_price >= g_maxprice  and is_max = 1))
	 option (maxdop 1)


	-- 모델별 최저가, 최고가
	-- drop table #tmp_result
	 select pl_modelno
          , min(min_pl_price) min_pl_price
          , max(max_pl_price) max_pl_price 
	   into #tmp_result
	   from tbl_monitoring_target_raw_new_g4 
      group by pl_modelno

	-- 해당하는 데이터 표시
	update 
           a
	   set chg_type = case 
						when a.pl_price = b.min_pl_price then 21 -- 이상 최저가
						when a.pl_price = b.max_pl_price then 22 -- 이상 최고가
						else 0
					end
	  from tbl_monitoring_target_raw_new_g4 a 
		   inner join #tmp_result b on a.pl_modelno = b.pl_modelno 
	                               and pl_price > 0

	-- 인덱스 생성
	create nonclustered index ncl_chg_type on tbl_monitoring_target_raw_new_g4(chg_type)


	-- 우선 순위 설정	
	update 
           a 
       set a.comp_order = b.comp_order 	
	  from tbl_monitoring_target_raw_new_g4 a 
		   inner join tbl_monitoring_team_agg_name b  on a.chg_type = b.monitor_no
	 where a.chg_type > 0


	-- 이전에 확인처리한 놈들의 변경일과 같으면 다시 입력하지 않는다.
	update 
           a -- tbl_monitoring_target_raw_new_g4
	  set chg_type = 0
	    , comp_order = 0
   output deleted.pl_no, deleted.pl_date 
	 into tbl_monitoring_target_raw_new_g4_exception(pl_no, pl_date) -- 해당 건수가 많은지 체크한다.
	 from tbl_monitoring_target_raw_new_g4 a 
          inner join tbl_monitoring_target b on a.pl_no = b.pl_no  
                                            and a.chg_type = b.chg_type 
                                            and a.pl_date = b.pl_date
	where b.p_status = 'd' 
      and a.chg_type > 0

	-- 당일 최초 입력시점 저장
	update 
           a -- tbl_monitoring_target_raw_new
	   set today_first_date = b.today_first_date
	  from tbl_monitoring_target_raw_new_g4 a 
           inner join tbl_monitoring_target b on a.pl_no = b.pl_no 
	 where b.today_first_date >= cast(cast(getdate() as date) as datetime)
	   and b.p_status = 'i'


	-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 낮으면 처리중인 데이터 삭제
	update 
           a -- tbl_monitoring_target_raw_new_g4
	   set chg_type = 0
	     , comp_order = 0
	  from tbl_monitoring_target_raw_new_g4 a 
           inner join tbl_monitoring_target b on a.pl_no = b.pl_no  
                                              and a.comp_order > b.comp_order
	 where b.p_status = 'i' 
       and a.chg_type > 0

	-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 높으면 저장된 데이터 삭제
	delete 
           b --tbl_monitoring_target
	  from tbl_monitoring_target_raw_new_g4 a 
           inner join tbl_monitoring_target b on a.pl_no = b.pl_no  
                                             and a.comp_order <= b.comp_order
	 where b.p_status = 'i' 
       and a.chg_type > 0


	-- 입력전에 pl_no distinct하게 처리 .. 2015.02.13
	delete 
           b --tbl_monitoring_target
	  from tbl_monitoring_target_raw_new_g4 a 
           inner join tbl_monitoring_target b on a.pl_no = b.pl_no
	 where b.p_status in ('u', 'd') and a.chg_type >0


	-- 데이터 입력
	insert 
      into tbl_monitoring_target
           ( pl_no
           , pl_vcode
           , pl_category
           , pl_goodsnm
           , comp_order
           , chg_type
           , pl_date
           , today_first_date )
	  select pl_no, pl_vcode
           , pl_category
           , pl_goodsnm
           , comp_order
           , chg_type
           , pl_date
           , today_first_date
	    from tbl_monitoring_target_raw_new_g4 
       where chg_type > 0


	-- -----------------------------
	-- 임시// 2016-05-16~2016-05-20
	-- -----------------------------
	--insert into tmp_20160516_20160520_wookki25(pl_no, chg_type)
	--select pl_no, chg_type	
	--from tbl_monitoring_target_raw_new_g4 where chg_type > 0







