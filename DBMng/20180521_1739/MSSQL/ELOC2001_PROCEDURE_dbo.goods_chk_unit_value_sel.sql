/* *************************************************************************
 * NAME : dbo.goods_chk_unit_value_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-06-02 17:13:19.523
 *        Modify: 2018-05-03 17:23:35.197
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc goods_chk_unit_value_sel
	@category varchar(4)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-06-02
	-- ��  �� : goods ȯ�갡 ���� Ȯ��
	--			agent���� �ſ� 15�� ������ ���� ������ ��� ����� ���� �Է�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	select g_category, g_u_nit, regdate
	from goods_chk_unit_value
	where g_category like @category + '%'
	order by g_category asc
