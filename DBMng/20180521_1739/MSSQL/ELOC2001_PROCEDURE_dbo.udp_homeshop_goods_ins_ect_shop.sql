/* *************************************************************************
 * NAME : dbo.udp_homeshop_goods_ins_ect_shop
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-11-13 15:09:48.68
 *        Modify: 2015-11-04 14:40:08.95
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_homeshop_goods_ins_ect_shop
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013.03.01
	-- ��  �� : ���θ� Ȩ���� ��ǰ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2014.11.12		wookki25		���ظ� ����
									47, 49, 55, 90, 536, 4027, 5910, 6361  - > 57, 75, 663, 806, 974, 6588
									Ȩ���� ���� ����.. and pl_goodsnm like '%Ȩ����%' and pl_goodsnm not like '%�츮Ȩ����%'
									���ܺз� �߰� .. 93

	2015.11.04		wookki25		�����ϴ� ���� �ҽ� ����. �⺻���� priceilst -> Ȩ���ξ� ������(����Ŭ)
	*/
	/*
	insert into pricelist_special_goods(pl_vcode, pl_goodscode, pl_no, mcate, group_flag)
	select pl_vcode, pl_goodscode, pl_no, left(pl_category, 4), '1'
	from pricelist with (readuncommitted)
	where pl_srvflag = '0'
	and pl_modelno = 0
	and pl_homeflag = 'Y'
	and pl_authdate >= cast(convert(varchar(10), getdate(), 120) as datetime)
	and pl_authdate <  dateadd(hh, 8, cast(convert(varchar(10), getdate(), 120) as datetime))
	and pl_vcode in (
		57, 75, 663, 806, 974, 6588
	)
	and pl_category not like '14%'
	and pl_category not like '15%'
	and pl_category not like '93%'	
	*/

	delete from pricelist_special_goods 
	where regdate >= cast(getdate() - 1 as date) and  regdate < cast(getdate()  as date) 
	and group_flag = '1'

	select market_code, product_no, market_name
	into #homeshop_goods
	from openquery(oradb_homeshop, 'select a.market_code, a.product_no, b.market_name from hs_broadcast a inner join  hs_market b on a.market_code = b.market_code where start_date > sysdate-2 and start_date <  sysdate+5 ')

	alter table #homeshop_goods add shop_vcode int null

	update #homeshop_goods 
	set shop_vcode = case market_code 
							when '0000' then 806	-- cjmall
							when '0001' then 75		-- gsshop
							when '0002' then 663	-- �Ե�i��
							when '0003' then 6588	-- Ȩ�ؼ��� 
							when '0004' then 57		-- hmall
							when '0005' then 974	-- nsmall
					end

	insert into pricelist_special_goods(pl_vcode, pl_goodscode, pl_no, mcate, group_flag)
	select pl_vcode, pl_goodscode, pl_no, left(pl_category, 4), '1' group_flag  
	from #homeshop_goods a inner join pricelist b 
		on a.shop_vcode = pl_vcode and pl_goodscode = product_no and pl_goodscode_cs = checksum(product_no)
	where shop_vcode is not null
	and pl_modelno = 0
