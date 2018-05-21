/* *************************************************************************
 * NAME : dbo.udp_del_pricelist6
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-17 09:57:47.217
 *        Modify: 2018-05-04 17:19:04.023
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_del_pricelist6
	@loop_group bigint
as  
begin  
	-- --------------------------------------------------
	-- �� �� �� : wookki25
	-- �� �� �� : 2017.02.08
	-- ��    �� : 2������ �����ڷ� db���� ����ó��
	-- --------------------------------------------------
	-- ��    ��
	-- --------------------------------------------------
	set nocount on  
	set transaction isolation level read uncommitted  
	-- 2������ �����ڷ� db���� ����ó��
	--delete from pricelist where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5'  

	declare @top_cnt int = 50

	set @loop_group = case when @loop_group > 2 then 0 else @loop_group end

	select 1
	while @@ROWCOUNT = 1 begin 

				-- 00:00 ~ 00:10 ���̿� ����
				-- 00�� 10�п� ����� - �����층 ó��
				--if datepart(hh, GETDATE()) = 0 and DATEPART(mi, getdate()) between 0 and 9  begin
				if datepart(hh, GETDATE()) = 2 and DATEPART(mi, getdate()) between 0 and 9  begin
					return 
				end

				;with cte_del_plno (pl_no)  
				as 
				(
					--select	top (@top_cnt) pl_no from	pricelist where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5' and (pl_no % 3)  = @loop_group
					select  pl_no from (select top (@top_cnt)  pl_no from	pricelist with (readuncommitted) where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5') a where  (pl_no % 3)  = @loop_group
				)
				delete pricelist 
						output	 deleted.pl_no, deleted.pl_modelno, deleted.pl_vcode, deleted.pl_category, deleted.pl_goodsnm
                                , deleted.pl_price, deleted.pl_url, deleted.pl_note
								, deleted.pl_srvflag, deleted.pl_status, deleted.pl_authdate, deleted.pl_soldoutflag, deleted.pl_soldoutdate
								, deleted.pl_date, deleted.pl_rightnleft, deleted.pl_multicomment
								, deleted.pl_imgurl, deleted.pl_coupon,deleted.pl_airconfeetype
								, deleted.pl_account_yn, deleted.pl_esstockflag, deleted.pl_instance_price, deleted.pl_copyplno
								, deleted.pl_finalusedflag, deleted.pl_goodsfactory, deleted.pl_goodscode, deleted.pl_imgurlflag, deleted.pl_deliveryinfo
								, deleted.pl_freeinterest, deleted.pl_nochange, deleted.pl_agree_month, deleted.pl_homeflag
								, deleted.pl_price_card, deleted.option_flag2, deleted.catalog_flag, deleted.pl_cashback, deleted.pl_tag_price
								, deleted.pl_call_plan, deleted.pl_in_fee_yn, deleted.pl_ship_fee_yn, deleted.pl_bond_fee, deleted.pl_penality_fee
								, deleted.pl_delivery_lev, deleted.pl_set_yn, deleted.pl_store_flag, deleted.pl_ca_code_dept
								, deleted.pl_mobile_flag, deleted.pl_deliveryinfo2, deleted.pl_deliverytype2
						into analsdw.dbo.pricelist_del_data(
								 pl_no, pl_modelno, pl_vcode, pl_category, pl_goodsnm
                                , pl_price, pl_url, pl_note
								, pl_srvflag, pl_status, pl_authdate, pl_soldoutflag, pl_soldoutdate
								, pl_date, pl_rightnleft, pl_multicomment
								, pl_imgurl, pl_coupon,pl_airconfeetype
								, pl_account_yn, pl_esstockflag, pl_instance_price, pl_copyplno
								, pl_finalusedflag, pl_goodsfactory, pl_goodscode, pl_imgurlflag, pl_deliveryinfo
								, pl_freeinterest, pl_nochange, pl_agree_month, pl_homeflag
								, pl_price_card, option_flag2, catalog_flag, pl_cashback, pl_tag_price
								, pl_call_plan, pl_in_fee_yn, pl_ship_fee_yn, pl_bond_fee, pl_penality_fee
								, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_ca_code_dept
								, pl_mobile_flag, pl_deliveryinfo2, pl_deliverytype2
				
						)
				where pl_no in (select pl_no from cte_del_plno)

				select top 1  pl_no from	pricelist with (readuncommitted) where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5'

	end
	--select getdate() e_date

end




