/* *************************************************************************
 * NAME : dbo.udp_orderdata_cleansing_mobile
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-07-12 17:44:42.72
 *        Modify: 2018-05-03 17:23:35.31
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_orderdata_cleansing_mobile]
	@flag	varchar(5)
as
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2009.12.14
	-- ��  �� : �ֹ� raw �����Ϳ� �ߺ�����
	-- ----------------------------------------------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted
	
	-- ��ü����
	declare @shop_vcode int
	select top 1 @shop_vcode = shop_vcode from tbl_orderdata_worker_mobile

	-- �ֹ���ȣ ���� ���� : �ֹ���+####(������ �Ϸù�ȣ
	update tbl_orderdata_worker_mobile set od_id = convert(varchar(8), od_regdate, 112) +'_'+ right('0000'+cast(seq as varchar(10)), 4) where od_id is null


	-- ���� ���,��ǰ,Ŭ����, ��� ��ǰ ����
	IF @SHOP_VCODE = 55 	begin
		delete tbl_orderdata_worker_mobile 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker_mobile a inner join tbl_orderdata_worker_mobile b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode
					and a.od_price = b.od_price -- ������ ��� �κ� ��Ұ����ϹǷ� ���ݱ��� ���� ��츸 ����
			where	a.od_comment <> b.od_comment
			and		(b.od_comment like '%���%' 
							or b.od_comment like '%��ǰ%' 
							or b.od_comment like '%Ŭ����%' 
							or b.od_comment like '%����%' 
							or b.od_comment like '%ȸ��%' 
							or b.od_comment like '%cancel%'
							or b.od_comment like '%ȯ��%'
							or b.od_comment like '%����%'
							or b.od_comment like '%ǰ��%'
							)
		)
	end else begin
		delete tbl_orderdata_worker_mobile 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker_mobile a inner join tbl_orderdata_worker_mobile b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode
			where	a.od_comment <> b.od_comment
			and		(b.od_comment like '%���%' 
							or b.od_comment like '%��ǰ%' 
							or b.od_comment like '%Ŭ����%' 
							or b.od_comment like '%����%' 
							or b.od_comment like '%ȸ��%' 
							or b.od_comment like '%cancel%'
							or b.od_comment like '%ȯ��%'
							or b.od_comment like '%����%'
							or b.od_comment like '%ǰ��%'
							)
		)

	end

	delete tbl_orderdata_worker_mobile where (od_comment like '%���%' 
												or od_comment like '%��ǰ%' 
												or od_comment like '%Ŭ����%' 
												or od_comment like '%����%' 
												or od_comment like '%ȸ��%'
												or od_comment like '%cancel%'
												or od_comment like '%ȯ��%'
												or od_comment like '%����%'
												or od_comment like '%ǰ��%'
												)
											and od_comment not like '%öȸ%'


	-- �ż���� , �̸�Ʈ
	if @shop_vcode in ( 47, 374 ) begin
		delete b from tbl_orderdata_worker_mobile b where	b.od_comment = '�Աݴ��'
	end

	delete tbl_orderdata_worker_mobile where  od_price <=0  
	

	-- �߸��� ���� ����
	delete tbl_orderdata_worker_mobile where od_id is null

	-- ��ü�� �ֹ������� ���� ó��
	-- gsshop
	if @shop_vcode = 75 begin
		-- ��ۺ� ����
		delete	tbl_orderdata_worker_mobile where	od_goodsnm  like '��ۺ�'
	end else if @shop_vcode = 4027 begin
		delete tbl_orderdata_worker_mobile from tbl_orderdata_worker_mobile where od_goodscode like 'bn%'
	end else if @shop_vcode = 7857 begin -- Qoo10
		-- $�� ��ȭ�� ȯ�� // http://58.234.199.100/redmine/issues/18007
		update tbl_orderdata_worker_mobile set od_price = od_price * 1100
	end

	-- ���������� ��ȯ��Ű�� �𵨸� ó��
	update tbl_orderdata_worker_mobile
	set od_goodsnm =replace(replace(replace(replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(replace(
replace(replace(od_goodsnm,'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��
','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'<b>','-'),'��','-')


	-- ��ü������� : �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
	-- �ֹ� ������°� �޶� 1�� ��ǰ���� ó��
	select od_id, od_goodscode, shop_vcode, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
	into #tmp_worker
	from tbl_orderdata_worker_mobile 
	group by od_id, od_goodscode, convert(varchar(10), od_regdate, 112), shop_vcode
	having count(*) > 1

	update	tbl_orderdata_worker_mobile
	set		od_cnt = b.sum_cnt
	,		od_price = b.sum_price
	from	tbl_orderdata_worker_mobile a inner join #tmp_worker b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.shop_vcode = b.shop_vcode

	delete	tbl_orderdata_worker_mobile 
	from	tbl_orderdata_worker_mobile a inner join #tmp_worker b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.shop_vcode = b.shop_vcode


	-- �ܰ����
	update tbl_orderdata_worker_mobile	set od_unit_price = od_price/od_cnt











 