/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_EBAY_MB
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-21 17:55:39.043
 *        Modify: 2018-05-03 17:23:35.683
 *        Backup: 20180521_1737
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_EBAY_MB]

@StrChk char(1)

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
		DECLARE @NowCnt int
		DECLARE @DelCnt int
		DECLARE @ModCnt int
		DECLARE @AddCnt int
		DECLARE @SDate smalldatetime
		set @NowCnt = -1
 		set @DelCnt = -1
		set @ModCnt = -1
		set @AddCnt = -1
		set @SDate = getdate()	

		If 	@StrChk = 'M' 
			begin	
			--	--삭제
			--	update tbl_ebay_maker set del_yn = 'Y', upd_oprt = '', upd_date = getdate()
			--	--select count(maker_nm) 
			--	from tbl_ebay_maker as a with(readuncommitted) left outer join NB02.dbo.tbl_ebay_maker as b with(readuncommitted)
			--	on maker_id = id
			--	where id is null option(maxdop 1)

			--	exec(@SzQry)
			--	set @DelCnt = @@rowcount


				--추가
				insert into tbl_ebay_maker (maker_id, maker_nm, del_yn, ins_oprt)
				select id, name, yn, 'SYSTEM'
				from tbl_ebay_maker as a with(readuncommitted) right outer join NB02.dbo.tbl_ebay_maker as b with(readuncommitted)
				on maker_id = id
				where maker_id is null and Name <> '' option(maxdop 1)
				
				set @AddCnt = @@rowcount
					
				--수정							
				update tbl_ebay_maker set maker_nm = name, del_yn = yn, ins_oprt = 'SYSTEM', upd_date = getdate()
				from tbl_ebay_maker as a with(readuncommitted) inner join NB02.dbo.tbl_ebay_maker as b with(readuncommitted)
				on maker_id = id
				where maker_nm COLLATE Korean_Wansung_CS_AS_WS <> name or del_yn <> yn option(maxdop 1)
				set @ModCnt = @@rowcount

				delete dbo.tbl_ebay_matching_maker 
				where ebay_maker_id in (
				select maker_id from tbl_ebay_maker with(readuncommitted) where ins_oprt = 'SYSTEM' and ins_date < @SDate and upd_date > @SDate and del_yn = 'Y'
				)
  				
			End
		Else
			Begin
				--	--삭제
			--	update tbl_ebay_brand set del_yn = 'Y', upd_oprt = '', upd_date = getdate()
			--	--select count(brand_nm) 
			--	from tbl_ebay_brand as a with(readuncommitted) left outer join NB02.dbo.tbl_ebay_brand as b with(readuncommitted)
			--	on brand_id = id
			--	where id is null option(maxdop 1)

			--	exec(@SzQry)
			--	set @DelCnt = @@rowcount


				--추가
				insert into tbl_ebay_brand (brand_id, brand_nm, del_yn, ins_oprt)
				select id, name, yn, 'SYSTEM'
				from tbl_ebay_brand as a with(readuncommitted) right outer join NB02.dbo.tbl_ebay_brand as b with(readuncommitted)
				on brand_id = id
				where brand_id is null and Name <> '' option(maxdop 1)
				
				set @AddCnt = @@rowcount

					
				--수정							
				update tbl_ebay_brand set brand_nm = name, del_yn = yn, ins_oprt = 'SYSTEM', upd_date = getdate()
				from tbl_ebay_brand as a with(readuncommitted) inner join NB02.dbo.tbl_ebay_brand as b with(readuncommitted)
				on brand_id = id
				where brand_nm COLLATE Korean_Wansung_CS_AS_WS <> name or del_yn <> yn option(maxdop 1)
				
				set @ModCnt = @@rowcount

				delete dbo.tbl_ebay_matching_brand
				where ebay_brand_id in (
				select brand_id from tbl_ebay_brand with(readuncommitted) where ins_oprt = 'SYSTEM' and ins_date < @SDate and upd_date > @SDate and del_yn = 'Y'
				)	
			End
END


























































