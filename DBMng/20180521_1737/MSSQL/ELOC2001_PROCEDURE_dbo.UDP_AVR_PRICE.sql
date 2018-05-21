/* *************************************************************************
 * NAME : dbo.UDP_AVR_PRICE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:53.357
 *        Modify: 2018-05-04 17:13:18.77
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE procedure udp_avr_price
    @modelno int 
as
begin
	set nocount on
	set transaction isolation level read uncommitted

    return

    /*
	update goods 
        set g_avgprice = ( select 
                                  avg(pl_price)
			                 from pricelist
			                where pl_modelno = @modelno
			                  and pl_status <= '2' and pl_srvflag = '0' )
		where g_modelno = @modelno
    */
end