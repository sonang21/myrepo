/* *************************************************************************
 * NAME : dbo.udp_wibro_sold_out_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-07-22 10:13:12.927
 *        Modify: 2018-05-08 16:21:59.63
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_wibro_sold_out_sel
	@s_mallcnt  int = 0
,	@e_mallcnt	int = 1000000
,	@is_bak bit = 0
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2010-07-21
	-- ��  �� : ���̺�� �߰����� ��ǰ ǰ������ Ȯ��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
    select p_modelno, c_modelno, g_mallcnt, seqno, g_modelnm
      from goods a
           inner join goods_wibro_sold_out b on a.g_modelno = b.c_modelno
           inner join goods_sum c on a.g_modelno = c.g_modelno
	 where c.g_mallcnt between @s_mallcnt and @e_mallcnt
	   and is_bak = @is_bak
	 order by g_mallcnt asc

