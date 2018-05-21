/* *************************************************************************
 * NAME : dbo.udp_job_goods_set_mallcnt
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-09 20:17:55.117
 *        Modify: 2018-05-09 20:17:55.117
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_job_goods_set_mallcnt
	@set_date smalldatetime = null
as begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 
	-- 설  명 : 쇼핑몰 개수 입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	set @set_date = isnull(@set_date, cast(convert(varchar(10), getdate()-1, 120) as smalldatetime))

    update /* udp_job_goods_set_mallcnt:01 */
           a
       set jg_mallcnt = b.g_mallcnt 
      from job_goods a 
           inner join eloc188.eloc2001.dbo.goods_sum b on a.jg_modelno = b.g_modelno
     where jg_flag in ('0','8') 
       and jg_date >= @set_date
       and jg_date <  @set_date
end