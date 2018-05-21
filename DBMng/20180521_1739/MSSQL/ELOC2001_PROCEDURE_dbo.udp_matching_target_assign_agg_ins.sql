/* *************************************************************************
 * NAME : dbo.udp_matching_target_assign_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-06-03 15:40:24.543
 *        Modify: 2018-05-03 17:23:35.757
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE  proc udp_matching_target_assign_agg_ins
	@category	varchar(12)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.06.03
	-- ��  �� : ��Ī �Ҵ� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	delete tbl_matching_target_assign_agg where category = @category and regdate = convert(varchar(10), getdate(), 120)
	
	insert into tbl_matching_target_assign_agg(mm_id, category, goods_cnt, price_cnt, regdate)
	select ASSIGN_MM_ID, @category, count(*), sum(webcnt) webcnt, convert(varchar(10), getdate(), 120)
	from tbl_matching_target
	where category = @category 
	group by assign_mm_id

	-- �ֱ� �Ѵް� �����͸� �����Ѵ�.
	delete tbl_matching_target_assign_agg where category = @category and regdate < dateadd(m, -1 , getdate())
