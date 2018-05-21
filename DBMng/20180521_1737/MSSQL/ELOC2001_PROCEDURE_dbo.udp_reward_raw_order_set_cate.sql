/* *************************************************************************
 * NAME : dbo.udp_reward_raw_order_set_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-05-17 16:48:57.96
 *        Modify: 2018-05-03 17:23:34.523
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_reward_raw_order_set_cate
	@shop_vcode int
as
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2017.05.17
	-- ��  �� :  �з����� �Է�
	-- ----------------------------------------------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted


	create table #tmp_search_target_shop(
		shop_vcode int 
	)



	-- ������ ����ó��
	if @shop_vcode in ( 6508, 6641, 5910) begin -- ������/Ƽ��/11����.�ҼȻ�ǰ������ ����ó��

		-- ����ȣ�� pl_no ã��
		update a 
		set pl_no = isnull((
				select top 1 pl_no 
				from PRICELIST_MAKE_GOODSCODE  with (readuncommitted) 
				where pl_url_goodscode  = a.goodscode and pl_url_goodscode_cs = checksum(a.goodscode) 
				and pl_vcode = a.shop_code
				order by pl_no desc
		), 0)
		from tbl_reward_raw_order_worker a

		-- �з��ڵ� ������
		update a set ca_code = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		from tbl_reward_raw_order_worker a inner join pricelist b on a.pl_no= b.pl_no	

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


	update a 
	set ca_code =  isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
	, pl_no = b.pl_no
	from tbl_reward_raw_order_worker a inner join pricelist b 
	on checksum(a.goodscode) = pl_goodscode_cs
	and a.goodscode = pl_goodscode 
	--and a.shop_code = b.pl_vcode 
	--where b.pl_vcode = @shop_vcode
	--and	a.shop_code = @shop_vcode
	where (isnull(a.pl_no,0) = 0 or a.ca_code like '00%')
	and b.pl_vcode in (
		select SHOP_VCODE from #tmp_search_target_shop
	)
	option (maxdop 1)




