/* *************************************************************************
 * NAME : dbo.udp_goods_all_new_3_back
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-04-08 17:54:34.293
 *        Modify: 2018-05-03 17:23:35.923
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE procedure [dbo].[udp_goods_all_new_3_back] 
as
	--핸드폰 카테고리의 경우 
	--+nvl(subside,0)*10000)추가
	--set nocount on
	set transaction isolation level read uncommitted

	declare @batch_size bigint
	declare @app_rowcnt bigint
	declare @batch_cnt bigint
	set @batch_size = 1000
	set @batch_cnt = 0
	set @app_rowcnt = @batch_size

	-- 대상 모델 입력
	select identity(bigint, 1,1) as seq, g_modelno 
	into #goods
	from goods with (readuncommitted) option (maxdop 1)
	alter table #goods add constraint pk_temp_goods primary key (seq)

	-- 데이터 업데이트
	while @app_rowcnt = @batch_size begin
		with tmp_acc(g_modelno, g_maxprice, g_avgprice, g_mallcnt, g_minprice_0304, g_minprice)
		as
		(
			select	g.g_modelno
			,		isnull(max(isnull(pl_price,0)),0) as g_maxprice
			,		isnull(avg(isnull(pl_price,0)),0) as g_avgprice
			,		count(*) as g_mallcnt
			,		isnull(min( pl_price + isnull(pl_subside,0)*10000 ),0) as g_minprice_0304
			,		isnull(min( pl_price),0) as g_minprice
			from	#goods g left outer join pricelist p
			on		g_modelno = pl_modelno
			and		pl_status in ('0','1','2', '8','9') and pl_esstockflag='0'  and isnull(option_flag2,'0')='0'  and pl_srvflag in ('0', 'r','l')
			where g.seq between (@batch_cnt*@batch_size)+1 and ((@batch_cnt+1)*@batch_size)
			group by g_modelno
		)
		update goods
		set g_avgprice = b.g_avgprice
		,	g_maxprice = b.g_maxprice
		,	g_mallcnt = b.g_mallcnt
		,	g_minprice =  case left(g_category,4) 
						when '0304' then 
							b.g_minprice_0304
						else
							b.g_minprice
						end
		,	g_work = case 
						when a.g_work='0' and b.g_mallcnt>0 and a.g_jobcode='0' then 
							'9'
						when a.g_work='9' and (a.g_jobcode='1' or b.g_mallcnt=0) then 
							'0'
						else	
							g_work 
						end 
		from goods a inner join tmp_acc b on a.g_modelno = b.g_modelno
		option (maxdop 1)


		set @app_rowcnt = @@rowcount
		set @batch_cnt = @batch_cnt + 1
	end


