/* *************************************************************************
 * NAME : dbo.UDP_MIN_PRICE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.357
 *        Modify: 2018-05-07 16:53:24.79
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE procedure udp_min_price
    @modelno int 
as
begin
	set nocount on
	set transaction isolation level read uncommitted

    return
    /*
	update goods set g_minprice =(
		select	min(pl_price)
		from pricelist (nolock)
		where	pl_modelno = @modelno
		and pl_status <= '2' and pl_srvflag = '0'
		)
	where g_modelno = @modelno
    */
end