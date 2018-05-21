/* *************************************************************************
 * NAME : dbo.UDP_DBA_COLUMN_CMT_INS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-05-30 18:07:55.79
 *        Modify: 2008-05-30 18:07:55.79
 *        Backup: 20180521_1739
 ************************************************************************* */

	
CREATE PROC UDP_DBA_COLUMN_CMT_INS
	@TABLE_NAME		NVARCHAR(128),	
	@COLUMN_NAME	NVARCHAR(128),	
	@CMT			NVARCHAR(1000)
AS
	SET NOCOUNT ON
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.05.30
	-- 설  명 : 테이블 컬럼 코멘트 추가
	-- 실  행 : UDP_DBA_COLUMN_CMT_INS 'GOODS', 'G_MODELNO', '모델번호'
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	EXEC SYS.SP_ADDEXTENDEDPROPERTY N'MS_DESCRIPTION', @CMT, N'SCHEMA',N'DBO', N'TABLE',@TABLE_NAME, N'COLUMN',@COLUMN_NAME
