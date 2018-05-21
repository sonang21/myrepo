/* *************************************************************************
 * NAME : dbo.udp_delay
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-07-05 17:13:18.963
 *        Modify: 2018-05-03 17:23:34.483
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_delay
as begin

	waitfor delay '00:01:00'

	select replace(replace(replace(convert(char(16), GETDATE(), 120),'-',''),':',''),' ','_')

end



