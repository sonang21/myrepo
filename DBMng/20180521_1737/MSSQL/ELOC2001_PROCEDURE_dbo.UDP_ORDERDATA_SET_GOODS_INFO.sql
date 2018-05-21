/* *************************************************************************
 * NAME : dbo.UDP_ORDERDATA_SET_GOODS_INFO
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-12-24 15:32:47.5
 *        Modify: 2018-05-03 17:23:34.24
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [DBO].[UDP_ORDERDATA_SET_GOODS_INFO]
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.04.25
	-- ��  �� : �ֹ� Raw �����Ϳ� ��ǰ���� �Է�	
	-- ----------------------------------------------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2013.08.20		wookki25		�����ǰ ���� üũ.. is_auto_modelno
									�̳��� ��û. 8�� 20�� �����ͺ��� ����� ����
	*/
	
	declare @shop_vcode int
	select top 1 @shop_vcode = shop_vcode from tbl_orderdata_worker 

	create table #tmp_search_target_shop(
		shop_vcode int 
	)

--print @shop_vcode

	-- ������ ����
	--delete tbl_orderdata_worker 
	--from tbl_orderdata_worker 
	--where od_cnt <= 0 or od_price <= 0 or od_id is null 
	--or od_comment like '%���%' or od_comment like '%��ǰ%' 
	--or od_comment like '%Ŭ����%' or od_comment like '%����%'
	--or od_comment like '%cancel%' or od_comment like '%����%'


	--if @shop_vcode = 4027
	--begin
	--	delete tbl_orderdata_worker from tbl_orderdata_worker where od_goodscode like 'bn%'
	--end



	-- ��ü������� : �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
	-- �ֹ� ������°� �޶� 1�� ��ǰ���� ó��
	--select od_id, od_goodscode, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
	--into #tmp_worker
	--from tbl_orderdata_worker 
	--group by od_id, od_goodscode, convert(varchar(10), od_regdate, 112) having count(*) > 1

	--update	tbl_orderdata_worker
	--set		od_cnt = b.sum_cnt
	--,		od_price = b.sum_price
	--from	tbl_orderdata_worker a inner join #tmp_worker b 
	--on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	--and		a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd

	--delete	tbl_orderdata_worker 
	--from	tbl_orderdata_worker a inner join #tmp_worker b 
	--on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	--and		a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd

	-- �ܰ����
	--update tbl_orderdata_worker
	--set od_unit_price = od_price/od_cnt


	-- ��ǰ�� ����
	declare @is_goodsnm bit
	set @is_goodsnm = 0
	if @shop_vcode in (49, 1506, 6547, 90, 6665, 6252) begin
		--(1506:�ƽ���, 49:�Ե�����, 6547:���Ե�, 90:akmall,6252:���̸�Ʈ)
		set @is_goodsnm = 1
	end	else if @shop_vcode in (6361) and not exists(select 1 from tbl_orderdata_worker where od_goodscode is not null) begin
		-- Ȩ�÷��� ���ǰ:��ǰ�� ����
		set @is_goodsnm = 1
	end
	
	
	
	-- pricelist ������ �Է�
	if @is_goodsnm = 1
	begin
		-- ��ǰ�� ���� 
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- �ʴ��� ����/ 23:59�ʰ� �������� �νĵǱ⶧����..
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodsnm) = b.pl_goodsnm_cs
					and pl_goodsnm = od_goodsnm
					and pl_vcode = a.SHOP_VCODE
		option (maxdop 1)



		-- ���һ�ǰ�� ���� �߰�ó��
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- �ʴ��� ����/ 23:59�ʰ� �������� �νĵǱ⶧����..
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodsnm) = b.pl_goodsnm_cs
					and pl_goodsnm = od_goodsnm
					and pl_vcode = a.SHOP_VCODE
		where	a.g_modelno<=0 and b.pl_modelno>0
		option (maxdop 1)


		update tbl_orderdata_worker
		set od_id_no = isnull(od_id_no, '')
		,	od_goodscode = isnull(od_goodscode, '')

	end
	else if @shop_vcode in (5993)
	begin
		-- ��ǰ�� ���� (�����Ǿ�)
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- �ʴ��� ����/ 23:59�ʰ� �������� �νĵǱ⶧����..
		,		od_unit_price =od_unit_price
		,		od_cnt = od_cnt
		,		od_goodscode = od_goodscode
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on pl_url = 'http://popcornpc.co.kr/shopuser/goods/productview.html?code='+od_goodscode
					and pl_vcode = a.shop_vcode
		option (maxdop 1)

		-- ���һ�ǰ�� ���� �߰�ó��
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- �ʴ��� ����/ 23:59�ʰ� �������� �νĵǱ⶧����..
		,		od_unit_price =od_unit_price
		,		od_cnt = od_cnt
		,		od_goodscode = od_goodscode
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on pl_url = 'http://popcornpc.co.kr/shopuser/goods/productview.html?code='+od_goodscode
					and pl_vcode = a.shop_vcode
		where	a.g_modelno<=0 and b.pl_modelno>0
		option (maxdop 1)


	end	 	else 	begin


		if @shop_vcode in ( 6508, 6641, 5910) begin -- ������/Ƽ��/11����.�ҼȻ�ǰ������ ����ó��

			-- ����ȣ�� pl_no ã��
			update a 
			set pl_no = isnull((
					select top 1 pl_no 
					from pricelist_make_goodscode  with (readuncommitted) 
					where pl_url_goodscode  = a.od_goodscode and pl_url_goodscode_cs = checksum(a.od_goodscode) 
					and pl_vcode = a.shop_vcode
					order by pl_no desc
			), 0)
			from tbl_orderdata_worker a

			update	tbl_orderdata_worker
			set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
			,		g_modelno = isnull(b.pl_modelno,0)
			,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
			,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- �ʴ��� ����/ 23:59�ʰ� �������� �νĵǱ⶧����..
			,		pl_price = b.pl_price
			from	tbl_orderdata_worker a
						inner join
					pricelist b
						on a.pl_no= b.pl_no
			option (maxdop 1)


		end


		-- �迭�� �˻�
		if @shop_vcode in ( 7938 ) begin -- ���� ��ų�� ����(4027)���� �˻�

			insert into #tmp_search_target_shop (shop_vcode)
			values (7938),(4027)

		end else if @shop_vcode in ( 47, 374, 6665 ) begin -- (47)�ż���� vs (374)�̸�Ʈ vs (6665)SSG.COM


			insert into #tmp_search_target_shop (shop_vcode)
			values (47),(374),(6665)

		end else if @shop_vcode in ( 55, 6780 ) begin -- (55)������ũ vs (6780)������ũ ����������

			insert into #tmp_search_target_shop (shop_vcode)
			values (55),(6780)

		end else if @shop_vcode in ( 57, 7851 ) begin --(57)H�� vs (7851)���������

			insert into #tmp_search_target_shop (shop_vcode)
			values (57),(7851)

		end else if @shop_vcode in ( 536, 7692 ) begin --(536)G���� vs (7692)G9

			insert into #tmp_search_target_shop (shop_vcode)
			values (536),(7692)

		end else if @shop_vcode in ( 7455, 7695 ) begin -- (7455)�Ե���Ʈ vs (7695)���������� �¶���

			insert into #tmp_search_target_shop (shop_vcode)
			values (7455),(7695)

		end else begin

			insert into #tmp_search_target_shop (shop_vcode)
			select @shop_vcode

		end

		-- ��ǰ�ڵ� ����
		update	a
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- �ʴ��� ����/ 23:59�ʰ� �������� �νĵǱ⶧����..
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodscode) = b.pl_goodscode_cs
					and pl_goodscode = od_goodscode
--						and pl_vcode =  a.shop_vcode
		where (a.pl_no = 0 or a.g_category like '00%')
		and b.pl_vcode in (
			select SHOP_VCODE from #tmp_search_target_shop
		)
		option (maxdop 1)


		-- ���һ�ǰ�� ���� �߰�ó��
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(rtrim(ltrim(pl_category))),0)>=2 then rtrim(ltrim(pl_category)) else '00' end, '00')
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodscode) = b.pl_goodscode_cs
					and pl_goodscode = od_goodscode
--					and pl_vcode = a.shop_vcode
		where	 a.g_modelno<=0 and b.pl_modelno>0
		and b.pl_vcode in (
			select SHOP_VCODE from #tmp_search_target_shop
		)
		option (maxdop 1)



	end

	-- goods ������ �Է� 
	update	tbl_orderdata_worker
	set		g_modelno = b.g_modelno
	,		g_category =  b.g_category
	--		���� �Է�(374:�̸�Ʈ, 47:�ż���, 58:���ڷ�����θ�,6641:Ƽ��)
	/* 2015.12.02 ����. pricelist.pl_price ����ϵ��� ����
	,		od_cnt = case when shop_vcode in (374,47,58,6641) and isnull(g_minprice,0) > 1001  and od_price > 1000 then 
						case when round((od_price*1.0)/(g_minprice*1.0),0) > 0 then
							round((od_price*1.0)/(g_minprice*1.0),0) 
						else
							isnull(od_cnt,1)
						end 
					else isnull(od_cnt,1) end
	*/
	,		od_cnt = case when shop_vcode in (58,6641, 6665) and isnull(pl_price,0) > 1001  and od_price > 1000 then 
						case when round((od_price*1.0)/(pl_price*1.0),0) > 0 then
							round((od_price*1.0)/(pl_price*1.0),0) 
						else
							isnull(od_cnt,1)
						end 
					else isnull(od_cnt,1) end
	--		�ܰ� ���(374:�̸�Ʈ, 47:�ż���, 58:���ڷ�����θ�,6641:Ƽ��)
	/* 2015.12.02 ����. pricelist.pl_price ����ϵ��� ����
	,		od_unit_price = 
					case when shop_vcode in (374,47,58,6641) and isnull(g_minprice,0) > 1001 and od_price > 1000 then 
						case when round((od_price*1.0)/(g_minprice*1.0),0) > 0 then
							od_price/(round((od_price*1.0)/(g_minprice*1.0),0))
						else
							od_unit_price 
						end
					else 
						od_unit_price 
					end					
	*/
	,		od_unit_price = 
					case when shop_vcode in (58,6641, 6665) and isnull(pl_price,0) > 1001 and od_price > 1000 then 
						case when round((od_price*1.0)/(pl_price*1.0),0) > 0 then
							od_price/(round((od_price*1.0)/(pl_price*1.0),0))
						else
							od_unit_price 
						end
					else 
						od_unit_price 
					end	
	,		g_factory = b.g_factory
	,		is_auto_modelno = case when g_constrain = '5' then 1  end
	from	tbl_orderdata_worker a
				inner join
			eloc2001.dbo.goods b
				on a.g_modelno = b.g_modelno
	where b.g_modelno > 0
			
	-- 196 proc ȣ�� - ssis package���� �����ϵ��� ó��
	-- exec oltplog_196.oltplog.dbo.udp_orderdata_ins_dlv
	-- exec oltplog_196.oltplog.dbo.udp_orderdata_ins_ord
	-- 

	if @shop_vcode in (5910) begin
		-- 11���� �ɼǻ�ǰ�� ���� ��ǰ�� �з��ڵ� �Է�
		update a
		set	a.g_category = b.g_category
		--select a.g_category , b.g_category
		from tbl_orderdata_worker a inner join (
			select od_id, max(g_category) as g_category 
			from tbl_orderdata_worker 
			group by od_id
			having count(*) > 1
		) b on a.od_id = b.od_id
		where a.g_category = '00'
	end

