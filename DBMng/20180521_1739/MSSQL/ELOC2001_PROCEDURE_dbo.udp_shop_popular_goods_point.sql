/* *************************************************************************
 * NAME : dbo.udp_shop_popular_goods_point
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-09-26 14:25:20.857
 *        Modify: 2018-05-03 17:23:35.88
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_shop_popular_goods_point
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-09-26
	-- ��  �� : ���θ� �α��ǰ �α⵵�� �ݿ��� �� & ����
	--			196 �����۾����� �����Ѵ�.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	

	if object_id('tmp_worktbl_shop_popular_point') is not null
		drop table tmp_worktbl_shop_popular_point


	
	-- ���..�׽�Ʈ��
	if object_id('tbl_price_shop_popular_v2_bak') is not null begin
		insert into tbl_price_shop_popular_v2_bak(
			shop_code,goodscode,regdate,cate1_rank,cate2_rank,cate3_rank,cate4_rank,pl_modelno,pl_category,all_rank,popular_point
		)
		select 
			shop_code,goodscode,regdate,cate1_rank,cate2_rank,cate3_rank,cate4_rank,pl_modelno,pl_category,all_rank,popular_point
		from tbl_price_shop_popular_v2

		delete from tbl_price_shop_popular_v2_bak where bak_date < getdate()-7
	end

	select b.pl_vcode, b.pl_modelno, max(popular_point) popular_point
	into tmp_worktbl_shop_popular_point
	from tbl_price_shop_popular_v2 a inner join pricelist b
			on  a.goodscode = b.pl_goodscode and checksum(a.goodscode) = b.pl_goodscode_cs
			and a.shop_code = b.pl_vcode
			and b.pl_modelno > 0
	and a.regdate >= cast(convert(varchar(10), getdate()-1, 120) as datetime) and a.regdate < cast(convert(varchar(10), getdate(), 120) as datetime)
	group by b.pl_vcode, b.pl_modelno
	option (maxdop 1)

