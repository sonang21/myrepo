/* *************************************************************************
 * NAME : dbo.udp_pricelist_danawa_auto_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-03-26 17:46:35.48
 *        Modify: 2018-05-03 17:23:35.71
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[udp_pricelist_danawa_auto_ins]
AS 
	SET NOCOUNT ON 
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012.03.26
	-- ��  �� : ������ǰ(=pricelist.pl_srvflag='m') : �����ڵ�
	-- (= ep�� �Ѿ���� ���� ��ǰ�� ����ڰ� ������ �߰��Ѵ�.)
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2012.04.03		wookki25		pl_stauts='5' ó��
	*/
	--	-------------------
	-- oracle ó�� : pl_status = '5'�� ������ ����
	--	-------------------
	-- delete openquery(oradb, 'select * from tbl_pricelist_danawa a where exists (select 1 from tbl_pricelist b where a.shop_code=b.shop_code and a.goodscode = b.goodscode group by b.shop_code having max(status) = ''5'')')

	-- -------------------
	-- eloc ó��
	-- -------------------
	/*
		-- ��ɻ��� : http://58.234.199.100/redmine/issues/26410
		-- �ʱ�ȭ
		truncate table pricelist_danawa

		-- ����Ŭ ������ ����
		insert into pricelist_danawa(pl_vcode, pl_goodscode)
		select shop_code, goodscode
		from openquery(ORADB,'select to_char(shop_code) shop_code, goodscode from tbl_pricelist_danawa where flag in (''0'',''1'')')
		-- flag : 0 - ������ǰ or jca �Է��� ������
		--        1 - �̴Ϻ�,ctu 15ȸ �̻� ������ ������
		--		  2 - ǰ�� ������
		
		-- ������ų ������ select
		select pl_vcode, pl_goodscode
		into #tmp_work
		from pricelist a with (Readuncommitted)
		where pl_srvflag = 'm' and pl_status <> '5' -- ����(pl_status='5' == �����ȵ�����)
		and not exists (select pl_vcode from pricelist_danawa b where b.pl_vcode = a.pl_vcode and b.pl_goodscode = a.pl_goodscode and b.pl_goodscode_cs = a.pl_goodscode_cs)
		and pl_goodscode is not null

		-- ���� ������ �Է�
		insert into pricelist_danawa(pl_vcode, pl_goodscode)
		select pl_vcode, pl_goodscode from #tmp_work
	*/
	--	-------------------
	-- oracle ó��
	--	-------------------
	/*
		-- ���������� �Է�
		-- ��ɻ��� : http://58.234.199.100/redmine/issues/26410
		insert openquery (oradb, 'select shop_code, goodscode from tbl_pricelist_danawa')
		select pl_vcode, pl_goodscode from #tmp_work
	*/

		--�����߰� ��ǰ �Է� (��ǰ�ڵ� ����, pl_no �Է�)
		--�۾��� : �輺ȣ // �Ҽ� ���� �߰��� ��ǰ ����Ŭ�� ���� & �̴Ϻ����� �ش� ��ǰ ũ�Ѹ�
		select T2.PL_VCODE as VCODE, T2.PL_NO as PLNO
		into #tmp_PD
		FROM PRICELIST_COMPULSION AS T1 WITH(READUNCOMMITTED)
		LEFT OUTER JOIN PRICELIST AS T2 WITH(READUNCOMMITTED)
		ON T1.PL_NO = T2.PL_NO
		WHERE PL_VCODE = 6641 AND PL_MODELNO > 0 AND PL_STATUS = '0'
		--AND T1.PL_NO NOT IN (SELECT PL_GOODSCODE FROM PRICELIST_DANAWA WHERE PL_VCODE = 6641)
		AND T1.PL_NO NOT IN (select GOODSCODE from OPENQUERY (ORADB, 'SELECT GOODSCODE FROM TBL_PRICELIST_DANAWA where shop_code = 6641'))
	
		INSERT OPENQUERY (ORADB, 'SELECT SHOP_CODE, GOODSCODE, FLAG FROM TBL_PRICELIST_DANAWA')
		SELECT VCODE, PLNO, '4' FROM #tmp_PD  
