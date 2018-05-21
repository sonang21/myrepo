/* *************************************************************************
 * NAME : dbo.UDP_JCA_VISIT_WAY_REPORT_DAILY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-02-13 14:05:58.783
 *        Modify: 2018-05-03 17:23:35.783
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_JCA_VISIT_WAY_REPORT_DAILY
	@YYYYMM CHAR(6)
AS
	-- ----------------------------------------------------------------------------------
	-- ÀÛ¼ºÀÚ : wookki25 // 2009.02.13
	-- ¼³  ¸í : À¯ÀÔ°æ·Î Åë°è
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- ¼öÁ¤ÀÏ:		¼öÁ¤ÀÚ:		¼öÁ¤³»¿ë:
	-- ----------------------------------------------------------------------------------
	-- 2008.09.09	wookki25	Ã³¸® : 
	--                          »çÀ¯ : 
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED


	SELECT	VISIT_WAY,DAY_1,DAY_2,DAY_3,DAY_4,DAY_5,DAY_6,DAY_7
		,DAY_8,DAY_9,DAY_10,DAY_11,DAY_12,DAY_13,DAY_14
		,DAY_15,DAY_16,DAY_17,DAY_18,DAY_19,DAY_20,DAY_21,DAY_22
		,DAY_23,DAY_24,DAY_25,DAY_26,DAY_27,DAY_28,DAY_29,DAY_30,DAY_31,
		ISNULL(DAY_1,0)+ ISNULL(DAY_2,0)+ ISNULL(DAY_3,0)+ ISNULL(DAY_4,0)+ ISNULL(DAY_5,0)
		+ ISNULL(DAY_6,0)+ ISNULL(DAY_7,0)+ ISNULL(DAY_8,0)+ ISNULL(DAY_9,0)+ ISNULL(DAY_10,0)
		+ ISNULL(DAY_11,0)+ ISNULL(DAY_12,0)+ ISNULL(DAY_13,0)+ ISNULL(DAY_14,0)+ ISNULL(DAY_15,0)
		+ ISNULL(DAY_16,0)+ ISNULL(DAY_17,0)+ ISNULL(DAY_18,0)+ ISNULL(DAY_19,0)+ ISNULL(DAY_20,0)
		+ ISNULL(DAY_21,0)+ ISNULL(DAY_22,0)+ ISNULL(DAY_23,0)+ ISNULL(DAY_24,0)+ ISNULL(DAY_25,0)
		+ ISNULL(DAY_26,0)+ ISNULL(DAY_27,0)+ ISNULL(DAY_28,0)+ ISNULL(DAY_29,0)+ ISNULL(DAY_30,0)
		+ ISNULL(DAY_31,0) AS [ÇÕ°è]
	into	#VISTI_WAY_DAY	
	FROM	TBL_JCA_VISIT_WAY_STATS
	WHERE	YYYYMM =@YYYYMM
	

	SELECT	'ÇÕ°è' as VISIT_WAY
		,SUM(DAY_1) d1,SUM(DAY_2) d2,SUM(DAY_3) d3,SUM(DAY_4) d4,SUM(DAY_5) d5
		,SUM(DAY_6) d6,SUM(DAY_7) d7,SUM(DAY_8) d8,SUM(DAY_9) d9,SUM(DAY_10) d10
		,SUM(DAY_11) d11,SUM(DAY_12) d12,SUM(DAY_13) d13,SUM(DAY_14) d14,SUM(DAY_15) d15
		,SUM(DAY_16) d16,SUM(DAY_17) d17,SUM(DAY_18) d18,SUM(DAY_19) d19,SUM(DAY_20) d20
		,SUM(DAY_21) d21,SUM(DAY_22) d22,SUM(DAY_23) d23,SUM(DAY_24) d24,SUM(DAY_25) d25
		,SUM(DAY_26) d26,SUM(DAY_27) d27,SUM(DAY_28) d28,SUM(DAY_29) d29,SUM(DAY_30) d30
		,SUM(DAY_31) d31
		,[ÇÕ°è]=ISNULL(SUM(DAY_1),0)+ISNULL(SUM(DAY_2),0)+ISNULL(SUM(DAY_3),0)+ISNULL(SUM(DAY_4),0)+ISNULL(SUM(DAY_5),0)
		+ISNULL(SUM(DAY_6),0)+ISNULL(SUM(DAY_7),0)+ISNULL(SUM(DAY_8),0)+ISNULL(SUM(DAY_9),0)+ISNULL(SUM(DAY_10),0)
		+ISNULL(SUM(DAY_11),0)+ISNULL(SUM(DAY_12),0)+ISNULL(SUM(DAY_13),0)+ISNULL(SUM(DAY_14),0)
		+ISNULL(SUM(DAY_15),0)+ISNULL(SUM(DAY_16),0)+ISNULL(SUM(DAY_17),0)+ISNULL(SUM(DAY_18),0)
		+ISNULL(SUM(DAY_19),0)+ISNULL(SUM(DAY_20),0)+ISNULL(SUM(DAY_21),0)+ISNULL(SUM(DAY_22),0)
		+ISNULL(SUM(DAY_23),0)+ISNULL(SUM(DAY_24),0)+ISNULL(SUM(DAY_25),0)+ISNULL(SUM(DAY_26),0)
		+ISNULL(SUM(DAY_27),0)+ISNULL(SUM(DAY_28),0)+ISNULL(SUM(DAY_29),0)+ISNULL(SUM(DAY_30),0)
		+ISNULL(SUM(DAY_31),0) 
	into	#sum
	FROM	#VISTI_WAY_DAY
	WHERE	visit_way not in ('¸ð¹ÙÀÏ', 'ZUM', '°íº£½ºÆ®')

	
	SELECT	VISIT_WAY,DAY_1,DAY_2,DAY_3,DAY_4,DAY_5,DAY_6,DAY_7
		,DAY_8,DAY_9,DAY_10,DAY_11,DAY_12,DAY_13,DAY_14
		,DAY_15,DAY_16,DAY_17,DAY_18,DAY_19,DAY_20,DAY_21,DAY_22
		,DAY_23,DAY_24,DAY_25,DAY_26,DAY_27,DAY_28,DAY_29,DAY_30,DAY_31
		,[ÇÕ°è]
	from 
	(
		SELECT	*
		, order_name = case visit_way when '±âÅ¸' then '¤¾_±âÅ¸' when '¸ð¹ÙÀÏ' then 'ÆR_1' when 'ZUM' then 'ÆR_3' when '°íº£½ºÆ®' then 'ÆR_4' else visit_way end
		FROM #VISTI_WAY_DAY
		
		UNION ALL	

		select * 
		,	order_name = 'ÇÕ°è'
		from #sum

		union all

		select 'À¥¹æ¹®¼ö' as visit_way
			, a.d1 - b.DAY_1, a.d2 - b.DAY_2, a.d3 - b.DAY_3, a.d4 - b.DAY_4, a.d5 - b.DAY_5
			, a.d6 - b.DAY_6, a.d7 - b.DAY_7, a.d8 - b.DAY_8, a.d9 - b.DAY_9, a.d10 - b.DAY_10
			, a.d11 - b.DAY_11, a.d12 - b.DAY_12, a.d13 - b.DAY_13, a.d14 - b.DAY_14, a.d15 - b.DAY_15
			, a.d16 - b.DAY_16, a.d17 - b.DAY_17, a.d18 - b.DAY_18, a.d19 - b.DAY_19, a.d20 - b.DAY_20
			, a.d21 - b.DAY_21, a.d22 - b.DAY_22, a.d23 - b.DAY_23, a.d24 - b.DAY_24, a.d25 - b.DAY_25
			, a.d26 - b.DAY_26, a.d27 - b.DAY_27, a.d28 - b.DAY_28, a.d29 - b.DAY_29, a.d30 - b.DAY_30
			, a.d31 - b.DAY_31, a.[ÇÕ°è] - b.[ÇÕ°è] 
			, order_name = 'ÆR_2'
		FROM #sum a cross join (select * from #VISTI_WAY_DAY WHERE visit_way = '¸ð¹ÙÀÏ') b

	) c
	order by order_name


