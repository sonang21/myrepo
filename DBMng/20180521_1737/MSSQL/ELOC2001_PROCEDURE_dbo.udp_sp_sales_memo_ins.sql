/* *************************************************************************
 * NAME : dbo.udp_sp_sales_memo_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-15 16:19:43.96
 *        Modify: 2018-05-03 17:23:35.18
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_sp_sales_memo_ins
	@memo_date smalldatetime
,	@memo varchar(500)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-06-15
	-- ��  �� : ���ⵥ���� Ư�̻��� �޸�
	--sp_help_udp 'udp_sp_sales_memo_ins', 'wookki25', '���ⵥ���� Ư�̻��� �޸�'
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	if exists(select 1 from tbl_ap_sales_memo where memo_date = @memo_date)
		update tbl_ap_sales_memo set memo=@memo where memo_date = @memo_date
	else
		insert into tbl_ap_sales_memo(memo_date, memo) values(@memo_date, @memo)


