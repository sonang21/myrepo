/* *************************************************************************
 * NAME : dbo.UDP_JCA_VISIT_WAY_REPORT_MONTHLY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-06-29 16:03:04.627
 *        Modify: 2018-05-03 17:23:35.06
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_JCA_VISIT_WAY_REPORT_MONTHLY
	@YYYY CHAR(4)
AS
	-- ----------------------------------------------------------------------------------
	-- ÀÛ¼ºÀÚ : wookki25 // 2009.06.29
	-- ¼³  ¸í : À¯ÀÔ°æ·Î Åë°è_¿ù°£
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- ¼öÁ¤ÀÏ:		¼öÁ¤ÀÚ:		¼öÁ¤³»¿ë:
	-- ----------------------------------------------------------------------------------
	-- 2009.06.29	wookki25	Ã³¸® : ¿ù°£ Åë°è
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	
	-- °³º°¸®½ºÆ®
	SELECT	VISIT_WAY,
			[01], [02], [03], [04], [05], [06], 
			[07], [08], [09], [10], [11], [12], 
			[ÇÕ°è] = ISNULL([01],0)+ISNULL([02],0)+ISNULL([03],0)+ISNULL([04],0)+ISNULL([05],0)+
			ISNULL([06],0)+ISNULL([07],0)+ISNULL([08],0)+ISNULL([09],0)+ISNULL([10],0)+
			ISNULL([11],0)+ISNULL([12],0)
	INTO	#VISTI_WAY_MONTH
	FROM 
	(
		SELECT RIGHT(YYYYMM,2) AS YYYY, VISIT_WAY, DAY_SUM
		FROM TBL_JCA_VISIT_WAY_STATS
		WHERE YYYYMM LIKE @YYYY+'%'
	) TMP_WORK_TBL
	PIVOT(SUM(DAY_SUM) FOR YYYY IN ([01], [02], [03], [04], [05], [06], [07], [08], [09], [10], [11], [12])) AS PVT
	

	-- ÇÕ°è
	SELECT	'ÇÕ°è' as visit_way
	,		SUM([01]) [01], SUM([02]) [02], SUM([03]) [03]
	,		SUM([04]) [04], SUM([05]) [05], SUM([06]) [06]
	,		SUM([07]) [07], SUM([08]) [08], SUM([09]) [09]
	,		SUM([10]) [10], SUM([11]) [11], SUM([12]) [12]
	,		[ÇÕ°è] = ISNULL(SUM([01]),0)+ISNULL(SUM([02]),0)+ISNULL(SUM([03]),0)
			+ ISNULL(SUM([04]),0)+ISNULL(SUM([05]),0)+ISNULL(SUM([06]),0)
			+ ISNULL(SUM([07]),0)+ISNULL(SUM([08]),0)+ISNULL(SUM([09]),0)
			+ ISNULL(SUM([10]),0)+ISNULL(SUM([11]),0)+ISNULL(SUM([12]),0)
	into	#sum
	FROM	#VISTI_WAY_MONTH 
	WHERE	visit_way not in ('¸ğ¹ÙÀÏ', 'ZUM', '°íº£½ºÆ®')
	

	-- ÀüÃ¼¸®Æ®½º : °³º° + ÇÕ°è
	select VISIT_WAY,
			[01], [02], [03], [04], [05], [06], 
			[07], [08], [09], [10], [11], [12],
			[ÇÕ°è]
	from
	(
		SELECT * 
		, order_name = case visit_way when '±âÅ¸' then '¤¾_±âÅ¸' when '¸ğ¹ÙÀÏ' then 'ÆR_1' when 'ZUM' then 'ÆR_3' when '°íº£½ºÆ®' then 'ÆR_4' else visit_way end
		FROM #VISTI_WAY_MONTH

		UNION ALL		
		select *
		, [order_name]='ÇÕ°è'
		from #sum

		UNION ALL
		select 'À¥¹æ¹®¼ö' as visit_way,
				a.[01] - b.[01], a.[02] - b.[02], a.[03] - b.[03], a.[04] - b.[04], a.[05] - b.[05], 
				a.[06] - b.[06], a.[07] - b.[07], a.[08] - b.[08], a.[09] - b.[09], a.[10] - b.[10],
				a.[11] - b.[11], a.[12] - b.[12] 
		, [ÇÕ°è] = a.[ÇÕ°è] - b.[ÇÕ°è]
		, [order_name] = 'ÆR_2'
		from #sum a cross join (select * from #VISTI_WAY_MONTH where visit_way = '¸ğ¹ÙÀÏ') b
	) c where [ÇÕ°è] >0 
	order by order_name


