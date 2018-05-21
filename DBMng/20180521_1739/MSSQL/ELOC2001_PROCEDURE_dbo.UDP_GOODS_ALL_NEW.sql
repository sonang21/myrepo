/* *************************************************************************
 * NAME : dbo.UDP_GOODS_ALL_NEW
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.543
 *        Modify: 2015-05-15 03:31:33.767
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE     PROCEDURE UDP_GOODS_ALL_NEW   
AS  
BEGIN  
 SET NOCOUNT ON  
 SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
  UPDATE GOODS SET g_minprice =isnull((  
   SELECT MIN(pl_price)  
   FROM PRICELIST (nolock)  
   WHERE g_modelno= pl_modelno  
   AND pl_status <= '2' and pl_srvflag = '0' --and pl_flag = '0'  
   ),0)  
  UPDATE GOODS SET g_avgprice   =isnull((  
   SELECT AVG(pl_price)  
   FROM PRICELIST (nolock)  
   WHERE g_modelno= pl_modelno  
   AND pl_status <= '2' and pl_srvflag = '0'  
   ),0)  
  UPDATE GOODS SET g_maxprice   =isnull((  
   SELECT MAX(pl_price)  
   FROM PRICELIST (nolock)  
   WHERE g_modelno= pl_modelno  
   AND pl_status <= '2' and pl_srvflag = '0'  
   ),0)  
  UPDATE GOODS SET g_mallcnt   =isnull((  
   SELECT COUNT( pl_vcode)  
   FROM PRICELIST (nolock)  
   WHERE g_modelno= pl_modelno  
   AND pl_status <= '2' and pl_srvflag = '0'  
   ),0)  
END  
  
