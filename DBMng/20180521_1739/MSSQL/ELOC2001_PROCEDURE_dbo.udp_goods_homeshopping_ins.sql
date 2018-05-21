/* *************************************************************************
 * NAME : dbo.udp_goods_homeshopping_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-12-02 11:11:27.05
 *        Modify: 2018-05-03 17:23:35.123
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_goods_homeshopping_ins
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookkii25 / 2010-12-02
	-- ��  �� : Ȩ���� ��ǰ / agent���� �����۾����� 1�� 1ȸ ����
	/*
	* �۾��� : wookki25 / 2010.12.02
	* ��û�� : ������
	* ��   �� : ���������� pricelist�� ������ Ȩ���� ��ǰ �� 
				  ����Ʈ���� ���� ���� �ʴ� ��ǰ�� �����ϵ��� ó��
				  jca���� ����ڰ� �ش� ��ǰ Ȯ���ϰ� ����Ŭ�� �ִ� 
				  Ȩ���� ��ǰ ���� ���̺� ����ϵ��� ó���ϴµ� ���
	*/
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2015.11.06		wookki25		and g_imgchk in ('1','4','5','6','7','9') ���ǻ���
									delete from tbl_goods_homeshopping where category like '1[45]%' and g_imgchk = '4' ����
									and g_date >= dateadd(m, -1, getdate()) -- �ֱ� 1������ ���� �߰�
									< 3. �̹� ��ϵ� �� ���� > ��� ����
									http://jca.enuri.com/board/redirect.asp?bt=1&bn=387&cn=507280
	*/

	-- 0. ���� �ڷ� ó��
	select modelno
	into #exception_modelno
	from tbl_goods_homeshopping where is_exception = '1'

	truncate table tbl_goods_homeshopping
	

	-- 1. ����Ŭ���� �̹� ��ϵ� Ȩ���� ��ǰ ��������
	/*
	select cast(modelno as int) as pre_reg_modelno
	into #tmp_pre_reg_modelno
	from openquery(oradb, 'select to_char(modelno) as modelno from tbl_home_shop')
	*/

	-- 2. ���������� ������ Ȩ���� ��ǰ ����
	select distinct pl_modelno as target_modelno, '0' as is_exception
	into #tmp_target_modelno
	from pricelist
	where pl_vcode in (57,75,663,806,974,6588)
	and pl_homeflag = 'y'
	and pl_status in ('0', '1','2')
	and pl_modelno > 0


	-- select top 10 pl_homeflag * from pricelist where pl_vcode = 2285


	-- 3. �̹� ��ϵ� �� ����
	/*
	delete #tmp_target_modelno 
	from #tmp_target_modelno inner join #tmp_pre_reg_modelno on pre_reg_modelno = target_modelno
	*/


	-- 4. goods ����	
	insert into tbl_goods_homeshopping(modelno, category, modelnm, regdate, g_imgchk)
	select g_modelno, g_category, g_modelnm, g_date, g_imgchk
	from goods inner join  #tmp_target_modelno on g_modelno = target_modelno
	where g_jobcode >'0' --and g_imgchk in ('1','4','5','6','7','9')
	and g_date >= dateadd(m, -1, getdate()) -- �ֱ� 1������



	-- ��ǰ. �м� ��з� �̹����ڵ� 4 ����
	--delete from tbl_goods_homeshopping where category like '1[45]%' and g_imgchk = '4'

	-- �м� ��з��� �ֱ� 7��
	delete from tbl_goods_homeshopping where category like '14%' and regdate < dateadd(d, -7, getdate()) -- �ֱ� ��ġ��

	-- 5. ���� ����ó�� ����
	update tbl_goods_homeshopping
	set is_exception = '1'
	from tbl_goods_homeshopping a inner join #exception_modelno b on a.modelno = b.modelno	


