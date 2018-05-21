/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-07-15 13:57:43.127
 *        Modify: 2018-05-03 17:23:35.3
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[udp_rt_srv_off_set_ins]
	@category varchar(4)
,	@limit_pct1 tinyint
,	@limit_pct2 tinyint
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.05.12
	-- ��  �� : �ǽð� ���� 3ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	DECLARE @Chk int
		
	update tbl_rt_srv_off_set set limit_pct1 = (case when @limit_pct1 = '' then null else @limit_pct1 end), limit_pct2 = (case when @limit_pct2 = '' then null else @limit_pct2 end) 
	where category = @category
	set @Chk = @@rowcount

	If ( @Chk = 0 )
		Begin
			insert into tbl_rt_srv_off_set(category, limit_pct1, limit_pct2) 
			values (@category, (case when @limit_pct1 = '' then null else @limit_pct1 end), (case when @limit_pct2 = '' then null else @limit_pct2 end))
		End