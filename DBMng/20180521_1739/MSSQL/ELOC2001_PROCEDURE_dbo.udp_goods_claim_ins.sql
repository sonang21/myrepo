/* *************************************************************************
 * NAME : dbo.udp_goods_claim_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-19 17:20:04.88
 *        Modify: 2018-05-03 17:23:34.103
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_goods_claim_ins
	@modelno int
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015-06-19
	-- ��  �� : Ŭ���� �߻��� �� �Է�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	merge goods_claim as t
	using (select g_modelno, g_category from goods where g_modelno = @modelno) as s
	on (t.g_modelno = s.g_modelno) 
	when matched then
		update set t.regdate = getdate()
	when not matched then 
		insert (g_modelno, g_category) values (g_modelno, g_category);


	-- �ֱ� 3������ ����.
	-- ������Ʈ���� 3���� ���� ������ ����.
