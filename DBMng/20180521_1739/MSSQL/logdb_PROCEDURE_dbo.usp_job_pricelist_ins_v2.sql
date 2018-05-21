/* *************************************************************************
 * NAME : dbo.usp_job_pricelist_ins_v2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-01-10 09:23:17.753
 *        Modify: 2015-10-20 17:51:12.56
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[usp_job_pricelist_ins_v2]
	@jp_plistno  bigint,
	@jp_modelno int,
	@jp_vcode int,
	@jp_id varchar(12),
	@jp_goodsnm varchar(400),
	@jp_price money
as
begin
	set nocount on
	set transaction isolation level read uncommitted

	insert into job_pricelist 
	(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_goodsnm, jp_price)
	values
	(@jp_plistno,@jp_modelno,@jp_vcode,@jp_id,'0', @jp_goodsnm, @jp_price)	

end

