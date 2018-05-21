/* *************************************************************************
 * NAME : dbo.UDP_LIMIT_MINPRICE_CHECK
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-12-09 16:50:59.067
 *        Modify: 2018-05-03 17:23:35.353
 *        Backup: 20180521_1737
 ************************************************************************* */






CREATE PROCEDURE [dbo].[UDP_LIMIT_MINPRICE_CHECK]
AS
BEGIN
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : sung35 / 2008.12.09 
	-- ��  �� : ������ ���Ѻ��� ���� �����̸� �ش� �׷� �ٸ��𵨷� ��ȣ��Ī
	--          Agent���� 1�ð� �ֱ�� ����
    
	
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	

	-- ���Ѱ� �Է��� ���, ������ ���Ѱ� �̸����� ����Ǹ� �𵨹�ȣ -7
	UPDATE PRICELIST SET PL_STATUS = '1', PL_MODELNO = -7
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND PL_PRICE < LIMIT_MINPRICE
		AND PL_CATEGORY LIKE '050110%' 
	)
		
	UPDATE PRICELIST SET PL_STATUS = '1', PL_MODELNO = -7
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND PL_PRICE < LIMIT_MINPRICE
		AND PL_CATEGORY LIKE '050106%' 
	)




	--. ������ (2401)
	--. ��������,��ũ��(0211)
	--. ������,�ÿ¼���(0610)
	-- ���Ѱ� �Է��� ���, ������ ���Ѱ� �̸����� ����Ǹ� ���� ����(���� �ڵ� P�� ����) / ���Ѱ� �̻����� ����Ǹ� ���� (���� 0���� ����)
	UPDATE PRICELIST SET PL_STATUS = '1', PL_SRVFLAG = (case when PL_SRVFLAG = '0' then 'P' else '0' end)
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND ((PL_SRVFLAG = 'P' AND PL_PRICE >= LIMIT_MINPRICE) or (PL_SRVFLAG = '0' AND PL_PRICE < LIMIT_MINPRICE))
		AND PL_CATEGORY LIKE '2401%' 
	)

	UPDATE PRICELIST SET PL_STATUS = '1', PL_SRVFLAG = (case when PL_SRVFLAG = '0' then 'P' else '0' end)
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND ((PL_SRVFLAG = 'P' AND PL_PRICE >= LIMIT_MINPRICE) or (PL_SRVFLAG = '0' AND PL_PRICE < LIMIT_MINPRICE))
		AND PL_CATEGORY LIKE '0211%' 
	)

	UPDATE PRICELIST SET PL_STATUS = '1', PL_SRVFLAG = (case when PL_SRVFLAG = '0' then 'P' else '0' end)
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND ((PL_SRVFLAG = 'P' AND PL_PRICE >= LIMIT_MINPRICE) or (PL_SRVFLAG = '0' AND PL_PRICE < LIMIT_MINPRICE))
		AND PL_CATEGORY LIKE '0610%' 
	)

	
END










