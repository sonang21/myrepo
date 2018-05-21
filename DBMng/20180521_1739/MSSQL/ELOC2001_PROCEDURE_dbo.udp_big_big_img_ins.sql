/* *************************************************************************
 * NAME : dbo.udp_big_big_img_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-09-17 13:07:50.94
 *        Modify: 2018-05-03 17:23:34.283
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_big_big_img_ins
	@g_modelno int
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-09-17
	-- 설  명 : 더 큰이미지 이미지맵 작성대상
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	if not exists(select top 1 g_modelno from tbl_big_big_img where g_modelno=@g_modelno)	
		insert into tbl_big_big_img(g_modelno) values(@g_modelno)


