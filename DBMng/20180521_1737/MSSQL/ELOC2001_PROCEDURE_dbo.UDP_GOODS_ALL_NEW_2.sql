/* *************************************************************************
 * NAME : dbo.UDP_GOODS_ALL_NEW_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2006-05-08 11:12:00.913
 *        Modify: 2015-05-15 03:31:33.343
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROCEDURE [dbo].[UDP_GOODS_ALL_NEW_2] 
AS
BEGIN
	--핸드폰 카테고리의 경우 
	--+NVL(subside,0)*10000)추가
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		UPDATE GOODS SET
			g_minprice = CASE LEFT(G_CATEGORY,4) 
					WHEN '0304' THEN
						(SELECT ISNULL(	MIN( pl_price + ISNULL(PL_SUBSIDE,0)*10000 ),0)
						FROM PRICELIST (nolock)
						WHERE	pl_modelno= g_modelno
							AND pl_status in ('0','1','2', '8','9') and pl_esstockflag='0'  and isnull(option_flag2,'0')='0'  and pl_srvflag in ('0', 'r','l'))-- and pl_flag = '0')
					ELSE 
						(SELECT	ISNULL(MIN( pl_price),0)
						FROM PRICELIST (nolock)
						WHERE	g_modelno= pl_modelno
							AND pl_status in ('0','1','2', '8','9') and pl_esstockflag='0'  and isnull(option_flag2,'0')='0'  and pl_srvflag in ('0', 'r','l'))-- and pl_flag = '0')
				END
			,g_avgprice   = (
				SELECT	ISNULL(AVG(ISNULL(pl_price,0)),0)
				FROM PRICELIST (nolock)
				WHERE	g_modelno= pl_modelno
				AND pl_status in ('0','1','2', '8','9') and pl_esstockflag='0'  and isnull(option_flag2,'0')='0'  and pl_srvflag in ('0', 'r','l')
				)
			,g_maxprice   =(
				SELECT	ISNULL(MAX(ISNULL(pl_price,0)),0)
				FROM PRICELIST (nolock)
				WHERE	g_modelno= pl_modelno
				AND pl_status in ('0','1','2', '8','9') and pl_esstockflag='0'  and isnull(option_flag2,'0')='0'  and pl_srvflag in ('0', 'r','l')
				)
			,g_mallcnt   =(
				SELECT	COUNT(*)
				FROM PRICELIST (nolock)
				WHERE	g_modelno= pl_modelno
				AND pl_status in ('0','1','2', '8','9') and pl_esstockflag='0'  and isnull(option_flag2,'0')='0'  and pl_srvflag in ('0', 'r','l')
			)

		-- g_mallcnt 수행된 후에 처리되어야한다..
		UPDATE GOODS 
			SET  g_work = 
					( 
					CASE 
						WHEN G_WORK='0' AND G_MALLCNT>0 AND G_JOBCODE='0' THEN '9'
						WHEN G_WORK='9' AND (G_JOBCODE='1' OR G_MALLCNT=0) THEN '0'
					ELSE G_WORK
					END)
		WHERE G_WORK IN ('0', '9')
END



