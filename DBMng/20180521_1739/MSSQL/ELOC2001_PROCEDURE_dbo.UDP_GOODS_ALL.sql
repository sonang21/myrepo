/* *************************************************************************
 * NAME : dbo.UDP_GOODS_ALL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.467
 *        Modify: 2018-05-03 17:23:35.173
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체: 저장 프로시저 dbo.spGoodsAll    스크립트 날짜: 2004-10-21 오후 3:21:06 ******/
CREATE  PROCEDURE UDP_GOODS_ALL
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	declare @i int
	set @i=0
	while @i < 30000
	begin
		exec UDP_GOODS  @i,minprice
		exec UDP_GOODS @i,aminprice
		exec UDP_GOODS @i,avgprice
		exec UDP_GOODS @i,maxprice
		exec UDP_GOODS @i,mallcnt
		set @i=@i+1
	end

END


