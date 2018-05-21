/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_0_mcate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 17:06:51.76
 *        Modify: 2018-05-07 16:54:49.997
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_make_lotte_data_0_mcate
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
	-- 기본 데이터 구하기 -- 2:24
	-- 필요한 업체의 상품정보 copy
	-- ------------------------------
		if object_id('tmp_shop_agg_base') is not null
			drop table tmp_shop_agg_base


		create table tmp_shop_agg_base
		(
			pl_vcode int not null
		,	min_price money not null
		,	modelno int not null
		,	mcate char(4) not null
		,	scate char(6) not null
		,	factory nvarchar(50) not null
		,	pl_goodscode varchar(50) null
		)


		declare @vcode int
		declare cur_vcode cursor fast_forward for
		(
			select 49 as vcode union all
			select 663 union all
			select 57 union all
			select 47 union all
			select 75 union all
			select 806
		)

		open cur_vcode
		fetch next from cur_vcode into @vcode
		while @@fetch_status =0
		begin

			insert 
              into tmp_shop_agg_base
			select pl_vcode
                 , min_price
                 , pl_modelno
                 , left(g_category, 4) as mcate
                 , left(g_category, 6) as scate
                 , replace(g.g_factory, char(9), ' ')
			     , case when pl_vcode=49 then pl_goodscode else null end
			  from ( select 
                          pl_vcode
                          , min(pl_price) as min_price
                          , pl_modelno
                          , max(pl_goodscode) pl_goodscode
			         from pricelist
			        where pl_vcode = @vcode
			          and pl_modelno  > 0
				      and pl_status in ('0','1','2', '8', '9')
				      and pl_esstockflag='0'
				      and isnull(option_flag2,'0')='0'  -- 옵션필수 상품 제외
				      and pl_srvflag = '0' -- 리퍼브(r)도 제외
				    group by pl_vcode
                           , pl_modelno ) p 
                    inner join goods g on g.g_modelno = pl_modelno
                    inner join goods_sum s on g.g_modelno = s.g_modelno
			--select top 1 g_modelno from goods with (readuncommitted)
			  where g.g_jobcode > '0' 
                and g.g_constrain = '1' 
                and s.g_mallcnt > 0 
                and s.g_minprice > 0
  			    and g.g_category not like '1471%' 
                and g.g_category not like '1472%' 
                and g.g_category not like '1473%' 
                and g.g_category not like '90%'

			fetch next from cur_vcode into @vcode
		end
		close cur_vcode
		deallocate cur_vcode

		-- 예외처리
		/*
		과장님~
		롯데닷컴 관련해서 요청 드립니다.,

		자세한 부분 조금있다 직접 찾아 뵙겠습니다.

		*중분류 14분류, 90분류 빼기
		*3번 데이터에서 제조사 중 "불명, 호환" 제조사 빼기
		*그 외의 빈칸으로 나오는 데이터 빼기
		*/
		delete 
          from tmp_shop_agg_base 
         where FACTORY in ('불명','호환','','[불명]','[호환]','(호환업체)') 
            or factory is null
end