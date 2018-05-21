/* *************************************************************************
 * NAME : dbo.UDP_JCA_VISIT_WAY_STATS_INS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-02-13 15:56:05.533
 *        Modify: 2018-05-03 17:23:35.803
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_VISIT_WAY_STATS_INS]
	@YYYYMM		CHAR(6),
	@DAY		INT,
	@VISIT_WAY	VARCHAR(50),
	@CNT		INT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 // 2009.02.13
	-- ��  �� : ���԰�� ��� �Է�
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- ������:		������:		��������:
	-- ----------------------------------------------------------------------------------
	-- 2008.09.09	wookki25	ó�� : 
	--                          ���� : 
	-- ----------------------------------------------------------------------------------
	IF NOT EXISTS(SELECT TOP 1 * FROM TBL_JCA_VISIT_WAY_STATS WHERE	YYYYMM=@YYYYMM AND VISIT_WAY=@VISIT_WAY)
	BEGIN
		INSERT INTO TBL_JCA_VISIT_WAY_STATS(YYYYMM, VISIT_WAY)
		VALUES (@YYYYMM, @VISIT_WAY)		
	END
	-- �Ϻ� ������ ������Ʈ
	UPDATE	TBL_JCA_VISIT_WAY_STATS
	SET		DAY_1  =  CASE WHEN @DAY = 1 THEN @CNT ELSE DAY_1  END,
			DAY_2  =  CASE WHEN @DAY = 2 THEN @CNT ELSE DAY_2 END,
			DAY_3  =  CASE WHEN @DAY = 3 THEN @CNT ELSE DAY_3 END,
			DAY_4  =  CASE WHEN @DAY = 4 THEN @CNT ELSE DAY_4 END,
			DAY_5  =  CASE WHEN @DAY = 5 THEN @CNT ELSE DAY_5 END,
			DAY_6  =  CASE WHEN @DAY = 6 THEN @CNT ELSE DAY_6 END,
			DAY_7  =  CASE WHEN @DAY = 7 THEN @CNT ELSE DAY_7 END,
			DAY_8  =  CASE WHEN @DAY = 8 THEN @CNT ELSE DAY_8 END,
			DAY_9  =  CASE WHEN @DAY = 9 THEN @CNT ELSE DAY_9 END,
			DAY_10 =  CASE WHEN @DAY = 10 THEN @CNT ELSE DAY_10 END,
			DAY_11 =  CASE WHEN @DAY = 11 THEN @CNT ELSE DAY_11 END,
			DAY_12 =  CASE WHEN @DAY = 12 THEN @CNT ELSE DAY_12 END,
			DAY_13 =  CASE WHEN @DAY = 13 THEN @CNT ELSE DAY_13 END,
			DAY_14 =  CASE WHEN @DAY = 14 THEN @CNT ELSE DAY_14 END,
			DAY_15 =  CASE WHEN @DAY = 15 THEN @CNT ELSE DAY_15 END,
			DAY_16 =  CASE WHEN @DAY = 16 THEN @CNT ELSE DAY_16 END,
			DAY_17 =  CASE WHEN @DAY = 17 THEN @CNT ELSE DAY_17 END,
			DAY_18 =  CASE WHEN @DAY = 18 THEN @CNT ELSE DAY_18 END,
			DAY_19 =  CASE WHEN @DAY = 19 THEN @CNT ELSE DAY_19 END,
			DAY_20 =  CASE WHEN @DAY = 20 THEN @CNT ELSE DAY_20 END,
			DAY_21 =  CASE WHEN @DAY = 21 THEN @CNT ELSE DAY_21 END,
			DAY_22 =  CASE WHEN @DAY = 22 THEN @CNT ELSE DAY_22 END,
			DAY_23 =  CASE WHEN @DAY = 23 THEN @CNT ELSE DAY_23 END,
			DAY_24 =  CASE WHEN @DAY = 24 THEN @CNT ELSE DAY_24 END,
			DAY_25 =  CASE WHEN @DAY = 25 THEN @CNT ELSE DAY_25 END,
			DAY_26 =  CASE WHEN @DAY = 26 THEN @CNT ELSE DAY_26 END,
			DAY_27 =  CASE WHEN @DAY = 27 THEN @CNT ELSE DAY_27 END,
			DAY_28 =  CASE WHEN @DAY = 28 THEN @CNT ELSE DAY_28 END,
			DAY_29 =  CASE WHEN @DAY = 29 THEN @CNT ELSE DAY_29 END,
			DAY_30 =  CASE WHEN @DAY = 30 THEN @CNT ELSE DAY_30 END,
			DAY_31 =  CASE WHEN @DAY = 31 THEN @CNT ELSE DAY_31 END
	WHERE	YYYYMM=@YYYYMM AND VISIT_WAY=@VISIT_WAY
