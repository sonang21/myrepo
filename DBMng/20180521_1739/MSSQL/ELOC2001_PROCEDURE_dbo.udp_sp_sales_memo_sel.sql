/* *************************************************************************
 * NAME : dbo.udp_sp_sales_memo_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-15 16:19:44.087
 *        Modify: 2018-05-03 17:23:35.203
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_sp_sales_memo_sel
	@memo_sdate smalldatetime
,	@memo_edate smalldatetime
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-06-15
	-- ��  �� : ���ⵥ���� Ư�̻��� �޸�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	
	select convert(varchar(10), memo_date, 120)	memo_date, memo 
	from tbl_ap_sales_memo 
	where memo_date >= @memo_sdate and memo_date < @memo_edate
