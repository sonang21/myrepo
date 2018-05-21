/* *************************************************************************
 * NAME : dbo.udp_group_cate_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-26 16:35:38.437
 *        Modify: 2018-05-03 17:23:34.933
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_group_cate_mod
	@gc_seq			int			
,	@category		varchar(12)
,	@unit_price		varchar(20)		
,	@group_spec		varchar(10)		
,	@add_cate		char(1)		
,	@exclude_cate		varchar(1000)
,	@unit_price_cmt	varchar(100)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : �׷� ���� �з� mod / 2010-04-26
	-- ��  �� : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2010.09.08		wookki25		unit_price_cmt �߰�
									�÷�����
									list_title, help_img_file, combo_title, small_img
	*/
	update tbl_group_cate			
	set	category		= @category		
	,	unit_price		= @unit_price		
	,	unit_price_cmt		= @unit_price_cmt
	,	group_spec		= @group_spec		
	,	add_cate		= @add_cate	
	,	exclude_cate		= @exclude_cate		
	where gc_seq = @gc_seq
