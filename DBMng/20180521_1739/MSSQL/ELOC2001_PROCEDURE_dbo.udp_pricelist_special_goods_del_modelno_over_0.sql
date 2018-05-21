/* *************************************************************************
 * NAME : dbo.udp_pricelist_special_goods_del_modelno_over_0
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-11-21 17:11:59.363
 *        Modify: 2018-05-03 17:23:35.187
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_pricelist_special_goods_del_modelno_over_0
	@shop_code int
,	@regdate datetime
,	@group_flag char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-06-18
	-- ��  �� : ���θ� Ư�� ��ǰ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	delete a
	from pricelist_special_goods a inner join pricelist b on a.pl_vcode = b.pl_vcode and a.pl_no = b.pl_no
	where a.pl_vcode = @shop_code and regdate >= @regdate and regdate < @regdate+1 and b.pl_modelno > 0
	and group_flag = @group_flag


