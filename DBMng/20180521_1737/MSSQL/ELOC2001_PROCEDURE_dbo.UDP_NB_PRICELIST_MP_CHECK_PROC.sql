/* *************************************************************************
 * NAME : dbo.UDP_NB_PRICELIST_MP_CHECK_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.39
 *        Modify: 2015-05-15 03:31:33.943
 *        Backup: 20180521_1737
 ************************************************************************* */




/****** 개체: 저장 프로시저 dbo.UP_NB_PRICELIST_MP_CHECK_PROC    스크립트 날짜: 2004-10-23 오전 11:04:05 ******/


-- UP_NB_PRICELIST_MP_CHECK_PROC  :   2004.7.20 --
CREATE          PROC UDP_NB_PRICELIST_MP_CHECK_PROC
	@p_no int
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
		SELECT PL_NO, IsNull(PL_MODELNO, -100) ,PL_VCODE ,IsNull(PL_CATEGORY, '00') ,IsNull(PL_GOODSNM, ''),IsNull(PL_PRICE, 0)
			 ,IsNull(PL_URL, '') ,PL_SRVFLAG ,PL_STATUS ,IsNull(PL_ETC, '') ,IsNull(PL_AUTHFLAG, '0'),PL_AUTHDATE 
			,IsNull(PL_SOLDOUTFLAG, 0) ,PL_SOLDOUTDATE ,IsNull(PL_RIGHTNLEFT, '0') ,PL_FLAG ,isNull(PL_MULTIFLAG, 'N')  ,isNull(PL_MULTICOMMENT, '') ,IsNull(PL_IMGURL, ''), IsNull(PL_COUPON, '')
		FROM PRICELIST WITH(READUNCOMMITTED)
		WHERE PL_NO = @p_no
	
	SET NOCOUNT OFF





