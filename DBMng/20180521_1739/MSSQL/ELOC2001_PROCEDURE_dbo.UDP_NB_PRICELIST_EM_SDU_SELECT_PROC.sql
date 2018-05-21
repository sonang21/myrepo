/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_EM_SDU_SELECT_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.903
 *        Modify: 2018-05-03 17:23:35.447
 *        Backup: 20180521_1739
 ************************************************************************* */





-- UDP_NB_PRICELIST_EM_SDU_SELECT_PROC  :   2004.7.22 --
CREATE      PROC UDP_NB_PRICELIST_EM_SDU_SELECT_PROC
	@p_modelno int,
	@p_vcode INT,
	@p_opt  nvarchar(20)
	
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
		IF  @p_opt ='OneAll'
			BEGIN
				SELECT  PL_NO
				FROM PRICELIST WITH(READUNCOMMITTED)
				WHERE PL_MODELNO = @p_modelno AND PL_STATUS < '4' AND PL_STATUS > '0' and 
ELOC2001.dbo.UDF_RTN_SHOP_SERVICE(PL_VCODE) = '0'
			END 
		ELSE IF @p_opt ='SelectAll'
			BEGIN
				SELECT  PL_NO
				FROM PRICELIST WITH(READUNCOMMITTED)
				WHERE PL_VCODE = @p_vcode AND PL_STATUS < '4' and ELOC2001.dbo.UDF_RTN_SHOP_SERVICE
(PL_VCODE) = '0'
			END 
		ELSE IF @p_opt ='SelectMod'
			BEGIN
				SELECT  PL_NO
				FROM PRICELIST WITH(READUNCOMMITTED)
				WHERE PL_VCODE = @p_vcode AND PL_STATUS < '4' AND PL_STATUS > '0' and 
ELOC2001.dbo.UDF_RTN_SHOP_SERVICE(PL_VCODE) = '0'
			END 
		ELSE IF @p_opt ='ModAll'
			BEGIN
				SELECT  PL_NO
				FROM PRICELIST WITH(READUNCOMMITTED)
				WHERE PL_STATUS < '4' AND PL_STATUS > '0' and ELOC2001.dbo.UDF_RTN_SHOP_SERVICE
(PL_VCODE) = '0'
			END		
	SET NOCOUNT OFF




