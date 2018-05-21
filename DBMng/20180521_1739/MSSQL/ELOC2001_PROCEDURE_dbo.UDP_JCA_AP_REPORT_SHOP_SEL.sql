/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_SHOP_SEL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-03-10 13:41:30.63
 *        Modify: 2018-05-03 17:23:34.013
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [DBO].[UDP_JCA_AP_REPORT_SHOP_SEL]
	@SHOP_GROUP CHAR(1) = NULL-- TBL_AP_SHOP_MINOR.SHOP_GROUP
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2010.03.09
	-- 설  명 : AP 업체목록
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	2009.03.20		WOOKKI25		
	*/

	if (@shop_group = 't') -- 여행
		select	shop_vcode, shop_name 
		from	shoplist
		where	shop_vcode in (6010,6011,5942,5989,6514,6655,6024) -- 출발일 기준 : ,5947,5981,5985,6001,6000,6005 
		union all
		select	shop_vcode, shop_name 
		from	shoplist
		where	shop_vcode in (6225,6228,6233,6499,6515,6654,6656) -- 예약일 기준	:6405,6232,6231,6230,6229,6227,6226
		order by shop_name
	else if (@shop_group = 'b') -- 책
		select	shop_vcode, shop_name , shop_service
		from	shoplist inner join (
			select 1 ord, 4856 book_shop union all
			select 2 , 3367 union all
			select 3 , 4861 union all
			--select 4 , 724 union all
			select 5 , 4858 union all
			--select 6 , 6238 union all
			--select 7 , 4859 union all
			select 8 , 6367 union all
			select 9 , 6368 union all			
			--select 10 , 536	 union all		
			select 11 , 4027
		) shoplist_book
		on book_shop=shop_vcode
		order by ord
	else if (@shop_group = 'o') -- 전문몰
		select	shop_vcode, shop_name , shop_service
		from	shoplist inner join (
			select 1 ord,58	book_shop union all
			select 2, 5438	  union all
			select 3, 5962	  union all
			select 4, 5978    union all
			select 5, 6174	 union all
			select 6, 6193	 union all
			select 7, 6252	 union all
			select 8, 6389	 union all
			select 9, 6603	 union all
			select 10, 6634	 union all
			select 11, 6644	 union all
			select 12, 6695	 union all
			select 13, 6729	 union all
			select 14, 7867	 union all
			select 15, 7885	 union all
			select 16, 7910	 union all
			select 17, 7939	 


		) shoplist_book
		on book_shop=shop_vcode
		order by ord
	else
		select	shop_vcode, shop_name
		from	(
				select	shop_vcode, shop_name 
				from	shoplist
				where	shop_apflag = 1 and shop_service = '0' and shop_grade = 'cc'
				union all
				select	1733,'G마켓(순)'
				union all
				select	5893,'옥션(순)'
				union all
				select	1719,'인터파크(순)'				
				union all
				select	6052,'11번가(순)'				
				) a
		order by shop_name



