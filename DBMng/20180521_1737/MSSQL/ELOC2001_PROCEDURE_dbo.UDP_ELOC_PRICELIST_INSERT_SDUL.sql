/* *************************************************************************
 * NAME : dbo.UDP_ELOC_PRICELIST_INSERT_SDUL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-05-18 10:19:08.197
 *        Modify: 2015-09-17 16:49:12.397
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_eloc_pricelist_insert_sdul]
	@modelno	int,
	@vcode		int,
	@price		money,
	@etc		nvarchar(100),
	@url		varchar(255),
	@rightnleft	char(1),
	@srvflag	char(1),
	@pl_goodsnm		nvarchar(400) = null,
	@pl_goodscode	varchar(50),
	@pl_airconfeetype	char(1),
	@pl_agree_month	tinyint,
	@option_flag2	char(1),
	@catalog_flag	char(1),

	@plno		bigint	output,
	@ireturn	int 	output
as
begin
	set nocount on
	set transaction isolation level read uncommitted
	begin tran
		declare @cate varchar(8)
		set @cate = isnull((select  top 1 g_category from goods where g_modelno=@modelno),'00000000')

		insert pricelist (pl_modelno, pl_category, pl_vcode, pl_goodsnm, pl_price, pl_etc, pl_url, pl_rightnleft, pl_srvflag, pl_status, pl_date,pl_goodscode,pl_airconfeetype,pl_agree_month,option_flag2,catalog_flag)
		values (@modelno, @cate, @vcode, @pl_goodsnm, @price, @etc, @url, @rightnleft, @srvflag, '0', getdate(),@pl_goodscode,@pl_airconfeetype,@pl_agree_month,@option_flag2,@catalog_flag)

		set @plno=scope_identity()

	if @@error<>0
	begin
		rollback tran
		set @ireturn = 99
	end
	else
	begin
		commit tran
		set @ireturn = 0
	end
end
