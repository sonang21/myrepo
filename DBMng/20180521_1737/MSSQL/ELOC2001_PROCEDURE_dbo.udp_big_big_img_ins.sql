/* *************************************************************************
 * NAME : dbo.udp_big_big_img_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-09-17 13:07:50.94
 *        Modify: 2018-05-03 17:23:34.283
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_big_big_img_ins
	@g_modelno int
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-09-17
	-- ��  �� : �� ū�̹��� �̹����� �ۼ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	if not exists(select top 1 g_modelno from tbl_big_big_img where g_modelno=@g_modelno)	
		insert into tbl_big_big_img(g_modelno) values(@g_modelno)


