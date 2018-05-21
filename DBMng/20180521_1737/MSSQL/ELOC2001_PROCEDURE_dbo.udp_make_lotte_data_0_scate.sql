/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_0_scate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-24 09:57:10.993
 *        Modify: 2018-05-03 17:23:36.133
 *        Backup: 20180521_1737
 ************************************************************************* */

create  proc udp_make_lotte_data_0_scate
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-06-21
	-- ��  �� : �Ե����� ���� ������ �����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	-- �ߺз� ó���� ������ ���̺� ���
	delete from tmp_shop_agg_base where mcate not in ('1481','1459')

	create index tmp_shop_agg_base_mcate on tmp_shop_agg_base(mcate)
	create index tmp_shop_agg_base_scate on tmp_shop_agg_base(scate)

	-- ����ó��
	-- select * from c_scate where cs_lcode = '14' and cs_mcode in ('81', '59') and cs_seqno > 0
	update tmp_shop_agg_base  set scate = '148101' where scate = '148105' -- ��Ÿ �з� ����ó��
	update tmp_shop_agg_base  set scate = '148102' where scate = '148106' -- ��Ÿ �з� ����ó��
	update tmp_shop_agg_base  set scate = '148103' where scate = '148107' -- ��Ÿ �з� ����ó��
	update tmp_shop_agg_base  set scate = '148104' where scate = '148108' -- ��Ÿ �з� ����ó��
