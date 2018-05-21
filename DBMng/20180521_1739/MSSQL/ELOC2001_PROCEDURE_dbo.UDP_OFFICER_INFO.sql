/* *************************************************************************
 * NAME : dbo.UDP_OFFICER_INFO
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.78
 *        Modify: 2018-05-03 17:23:35.677
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UP_OFFICER_INFO    스크립트 날짜: 2004-10-23 오전 11:05:29 ******/
CREATE  PROC UDP_OFFICER_INFO
	@CATEGORY VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	IF @CATEGORY<>''
	BEGIN
		SELECT mm_sawonno, mm_id , mm_nm , 
			max(Left(mmc_category,2)) as category ,
			max(cl_name) as cl_name 
		From MM_ENURI WITH (ReadUncommitted) 
		LEFT JOIN MM_CATEGORY WITH (ReadUncommitted) 
		ON mm_id = mmc_id 
		LEFT JOIN C_LCATE WITH (ReadUncommitted) 
		ON Left(mmc_category,2) = cl_lcode 
		WHERE cl_seqno > 0 
			and Left(mm_sawonno, 2) <> 'XN' 
			AND Left(mmc_category,2) = LEFT(@CATEGORY,2)				
		GROUP BY mm_sawonno, mm_id ,mm_nm , cl_seqno, cl_name Order By mm_nm asc
	END
	ELSE
	BEGIN
		SELECT mm_sawonno, mm_id , mm_nm , 
			max(Left(mmc_category,2)) as category ,
			max(cl_name) as cl_name 
		From MM_ENURI WITH (ReadUncommitted) 
		LEFT JOIN MM_CATEGORY WITH (ReadUncommitted) 
		ON mm_id = mmc_id 
		LEFT JOIN C_LCATE WITH (ReadUncommitted) 
		ON Left(mmc_category,2) = cl_lcode 
		WHERE cl_seqno > 0 
			and Left(mm_sawonno, 2) <> 'XN' 
		GROUP BY mm_sawonno, mm_id ,mm_nm , cl_seqno, cl_name Order By mm_nm asc
	END
END

SELECT * FROM MM_ENURI
SELECT * FROM MM_CATEGORY


