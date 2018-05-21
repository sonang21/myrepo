/* *************************************************************************
 * NAME : dbo.udp_gfk_target_modelno
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:38:10.47
 *        Modify: 2018-05-13 19:38:10.47
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc dbo.udp_gfk_target_modelno
as
	set nocount on
	set transaction isolation level read uncommitted
	-- -------------------------------------------
	-- �ۼ��� : wookki25
	-- �ۼ��� : 2015.04.06
	-- ��  �� : GFK_�з��� ��� ��
	-- -------------------------------------------
	-- 2016.02.11 wookki25 22 �з� �߰� // �����Ǿ��־���.
	-- -------------------------------------------

	truncate table tbl_gfk_target_modelno

	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '02%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '03%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '04%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '05%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '06%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '07%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '08%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '09%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '10%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '12%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '16%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '21%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '22%'
	insert into tbl_gfk_target_modelno(g_modelno, g_modelnm, g_factory, g_category) select g_modelno, g_modelnm, g_factory, g_category from analstore.dbo.goods with (nolock) where g_category like '24%'
	

	-- �ǻ���
	update tbl_gfk_target_modelno
	set g_modelnm = replace(g_modelnm, char(9), '') 
	,	g_factory = replace(g_factory, char(9), '')
	,	g_category = replace(g_category, char(9), '')




