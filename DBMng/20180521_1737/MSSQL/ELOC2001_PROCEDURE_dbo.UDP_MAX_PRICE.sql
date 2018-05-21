/* *************************************************************************
 * NAME : dbo.UDP_MAX_PRICE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.28
 *        Modify: 2018-05-07 16:53:16.35
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE procedure udp_max_price 
    @modelno int 
as
begin
	set nocount on
	set transaction isolation level read uncommitted

    return;
    /*
	update goods set g_maxprice =(
		select	max(pl_price)
		from pricelist (nolock)
		where	pl_modelno = @modelno
		and pl_status <= '2' and pl_srvflag = '0'
		)
	where g_modelno = @modelno
    */
end




