/* *************************************************************************
 * NAME : dbo.UDP_MALL_CNT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.2
 *        Modify: 2018-05-07 17:07:39.177
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE procedure udp_mall_cnt
    @modelno int 
as
begin
	set nocount on
	set transaction isolation level read uncommitted

    return;

    /*
	update goods set g_mallcnt  =(
		select	count(distinct pl_vcode)
		from pricelist (nolock)
		where	pl_modelno = @modelno
		and pl_status <= '2' and pl_srvflag = '0'
		)
	where g_modelno = @modelno
    */
end




