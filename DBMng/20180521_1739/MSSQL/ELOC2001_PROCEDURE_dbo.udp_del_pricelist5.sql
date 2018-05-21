/* *************************************************************************
 * NAME : dbo.udp_del_pricelist5
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-08 14:33:47.577
 *        Modify: 2017-07-10 14:19:24.31
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_del_pricelist5  
as  
begin  
	-- --------------------------------------------------
	-- 작 성 자 : wookki25
	-- 작 성 일 : 2017.02.08
	-- 설    명 : 2개월된 삭제자료 db에서 삭제처리
	-- --------------------------------------------------
	-- 수    정
	-- --------------------------------------------------
	set nocount on  
	set transaction isolation level read uncommitted  
	-- 2개월된 삭제자료 db에서 삭제처리
	--delete from pricelist where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5'  
return
	declare @top_cnt int = 10000
	select top 1  pl_no from	pricelist with (readuncommitted) where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5'
	while @@ROWCOUNT = 1 begin 

				;with cte_plno (pl_no)  
				as 
				(
					select	top (@top_cnt) pl_no from	pricelist where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5'
				)
				delete pricelist 
						output	 deleted.pl_no, deleted.pl_modelno, deleted.pl_vcode, deleted.pl_category, deleted.pl_goodsnm, deleted.pl_price, deleted.pl_url, deleted.pl_note
								, deleted.pl_srvflag, deleted.pl_status, deleted.pl_etc, deleted.pl_authflag, deleted.pl_authdate, deleted.pl_soldoutflag, deleted.pl_soldoutdate
								, deleted.pl_date, deleted.pl_rightnleft, deleted.pl_multiflag, deleted.pl_multicomment, deleted.pl_flag
								, deleted.pl_imgurl, deleted.pl_coupon, deleted.pl_jobtype, deleted.pl_stockcount, deleted.pl_regterm, deleted.pl_specflag
								, deleted.pl_origin, deleted.pl_delfeetype, deleted.pl_delareatype, deleted.pl_delprice, deleted.pl_delfeedesc
								, deleted.pl_delareadesc, deleted.pl_basisfrom, deleted.pl_basisto, deleted.pl_deliveryflag, deleted.pl_airconfeetype
								, deleted.pl_aircondesc, deleted.pl_account_yn, deleted.pl_esstockflag, deleted.pl_instance_price, deleted.pl_copyplno
								, deleted.pl_finalusedflag, deleted.pl_goodsfactory, deleted.pl_goodscode, deleted.pl_jobcode, deleted.pl_esoptflag
								, deleted.pl_searchflag, deleted.pl_imgurlflag, deleted.pl_deliveryinfo, deleted.pl_subside_level, deleted.pl_subside
								, deleted.pl_freeinterest, deleted.pl_nochange, deleted.pl_agree_month, deleted.pl_homeflag, deleted.pl_open_seller
								, deleted.pl_price_card, deleted.option_flag2, deleted.catalog_flag, deleted.pl_cashback, deleted.pl_tag_price
								, deleted.pl_call_plan, deleted.pl_in_fee_yn, deleted.pl_ship_fee_yn, deleted.pl_bond_fee, deleted.pl_penality_fee
								, deleted.pl_delivery_lev, deleted.pl_set_yn, deleted.pl_store_flag, deleted.pl_ca_code_dept
								, deleted.pl_mobile_flag, deleted.pl_deliveryinfo2, deleted.pl_deliverytype2
						into analsdw.dbo.pricelist_del_data(
								 pl_no, pl_modelno, pl_vcode, pl_category, pl_goodsnm, pl_price, pl_url, pl_note
								, pl_srvflag, pl_status, pl_etc, pl_authflag, pl_authdate, pl_soldoutflag, pl_soldoutdate
								, pl_date, pl_rightnleft, pl_multiflag, pl_multicomment, pl_flag
								, pl_imgurl, pl_coupon, pl_jobtype, pl_stockcount, pl_regterm, pl_specflag
								, pl_origin, pl_delfeetype, pl_delareatype, pl_delprice, pl_delfeedesc
								, pl_delareadesc, pl_basisfrom, pl_basisto, pl_deliveryflag, pl_airconfeetype
								, pl_aircondesc, pl_account_yn, pl_esstockflag, pl_instance_price, pl_copyplno
								, pl_finalusedflag, pl_goodsfactory, pl_goodscode, pl_jobcode, pl_esoptflag
								, pl_searchflag, pl_imgurlflag, pl_deliveryinfo, pl_subside_level, pl_subside
								, pl_freeinterest, pl_nochange, pl_agree_month, pl_homeflag, pl_open_seller
								, pl_price_card, option_flag2, catalog_flag, pl_cashback, pl_tag_price
								, pl_call_plan, pl_in_fee_yn, pl_ship_fee_yn, pl_bond_fee, pl_penality_fee
								, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_ca_code_dept
								, pl_mobile_flag, pl_deliveryinfo2, pl_deliverytype2				
				
						)
				where pl_no in (select pl_no from cte_plno)

				select top 1  pl_no from	pricelist with (readuncommitted) where pl_date < dateadd(mm,-2,getdate()) and pl_status = '5'

	end
	select getdate() e_date

end




