/* *************************************************************************
 * NAME : dbo.UDP_GOODS_ALL_NEW_3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-04-07 11:11:44.407
 *        Modify: 2017-07-10 08:45:46.193
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE procedure [dbo].[udp_goods_all_new_3] 
as
	--핸드폰 카테고리의 경우 
	--+nvl(subside,0)*10000)추가
	Set nocount on
	set transaction isolation level read uncommitted

	declare @batch_size bigint
	declare @batch_cnt_limit bigint
	declare @batch_cnt bigint
	declare @today smalldatetime
	set @batch_size = 100000
	set @batch_cnt = 0
	set @batch_cnt_limit= 0
	set @today = cast(convert(varchar(10), getdate(), 120) as smalldatetime)

	
	if  exists(select create_date from sys.tables where name='tbl_worker_goods_sync'  and create_date < cast(GETDATE() as date)) begin
		-- 오늘 이전에 생성된 테이블은 삭제한다.
		drop table tbl_worker_goods_sync
	end

	-- 대상 모델 입력
	if  object_id('tbl_worker_goods_sync') is null begin

		insert into tbl_dba_goodsync_monitor 
		select 1, GETDATE(), 0, GETDATE()

		-- 테이블 생성
		create table tbl_worker_goods_sync (seq int identity(1,1) primary key, g_modelno int, g_minprice money, g_maxprice money, g_avgprice money, g_mallcnt int, g_minprice3 numeric(15,0), regdate datetime default(getdate()))

		insert tbl_worker_goods_sync(g_modelno, g_minprice, g_maxprice, g_avgprice, g_mallcnt, g_minprice3)
		select modelno, isnull(minprice,0), isnull(maxprice,0), isnull(avgprice,0), isnull(mallcnt,0), isnull(minprice3,0)
		from openquery(oradb, 'select to_char(modelno) modelno, nvl(minprice,0) minprice, nvl(maxprice,0) maxprice, nvl(avgprice,0) avgprice, nvl(mallcnt,0) mallcnt, nvl(minprice3,0),  minprice3, popular from tbl_goods where cateflag=''0''  ')
		--from openquery(oradb, 'select to_char(modelno) modelno, nvl(minprice,0) minprice, nvl(maxprice,0) maxprice, nvl(avgprice,0) avgprice, nvl(mallcnt,0) mallcnt, nvl(minprice3,0),  minprice3, popular from tbl_goods where cateflag=''0''  and rownum< 10  ')




		order by popular desc

		insert into tbl_dba_goodsync_monitor 
		select 2, GETDATE(), @@ROWCOUNT, GETDATE()

	end
	
	select @batch_cnt_limit = loopcnt	from tbl_dba_goodsync_monitor  where step=2 and regdate = cast(getdate() as date)
	select @batch_cnt = isnull(MAX(loopcnt),0)+1 	from tbl_dba_goodsync_monitor  where step=3 and regdate = cast(getdate() as date)

	-- 데이터 업데이트
	while @batch_cnt < @batch_cnt_limit begin

		--select @batch_size = case when datepart(hh, GETDATE())  between 8 and 18 then 1 else @batch_size end

		-- 9시가 되면 종료처리
		if DATEPART(hh, GETDATE()) = 8 begin
			return
		end


		;with cte_goods_sync(g_modelno, g_minprice, g_maxprice, g_avgprice, g_mallcnt, g_minprice3)
		as
		(
			select  g_modelno, g_minprice, g_maxprice, g_avgprice, g_mallcnt, g_minprice3
			from	tbl_worker_goods_sync g
			where 	g.seq >= @batch_cnt and g.seq < @batch_cnt+@batch_size
		)

		update goods
		set g_avgprice = b.g_avgprice
		,	g_maxprice = b.g_maxprice
		,	g_mallcnt = b.g_mallcnt
		,	g_minprice =  b.g_minprice
		,	g_minprice3 = b.g_minprice3
		,	g_work = case 
						--when a.g_work='0' and b.g_mallcnt>0 and a.g_jobcode='0' then 
						when a.g_work='0' and a.g_jobcode='0' and exists(select top 1 1 from pricelist where pl_modelno = b.g_modelno and pl_srvflag in('0','r','l') and pl_status not in ('3','4','5')) then
							'9'
						when a.g_work='9' and (a.g_jobcode='1' or b.g_mallcnt=0) then 
							'0'
						else	
							g_work 
						end 
		from goods a inner join cte_goods_sync b on a.g_modelno = b.g_modelno
		option (maxdop 1)

		insert into tbl_dba_goodsync_monitor select 3, GETDATE(), @batch_cnt, GETDATE()


		set @batch_cnt = @batch_cnt+@batch_size

		--select @batch_cnt 
	end

	drop table tbl_worker_goods_sync




