/* *************************************************************************
 * NAME : dbo.UDP_JCA_VISIT_WAY_REPORT_WEEKLY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-06-29 17:33:51.877
 *        Modify: 2018-05-03 17:23:35.09
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_JCA_VISIT_WAY_REPORT_WEEKLY
	@YYYY CHAR(4)
AS
	-- ----------------------------------------------------------------------------------
	-- ¿€º∫¿⁄ : wookki25 // 2009.06.29
	-- º≥  ∏Ì : ¿Ø¿‘∞Ê∑Œ ≈Î∞Ë_¡÷∞£
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- ºˆ¡§¿œ:		ºˆ¡§¿⁄:		ºˆ¡§≥ªøÎ:
	-- ----------------------------------------------------------------------------------
	-- 2009.06.29	wookki25	√≥∏Æ : ¡÷∞£ ≈Î∞Ë
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	
	DECLARE @COPY_T TABLE (NUM INT)
	INSERT @COPY_T
	SELECT NUMBER FROM MASTER..SPT_VALUES WHERE TYPE = 'P' AND NUMBER BETWEEN 1 AND 31


	SELECT	VISIT_WAY,
			[01], [02], [03], [04], [05], [06], [07], [08], [09], [10],
			[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
			[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], 
			[31], [32], [33], [34], [35], [36], [37], [38], [39], [40], 
			[41], [42], [43], [44], [45], [46], [47], [48], [49], [50], 
			[51], [52], [53],
			[«’∞Ë] = ISNULL([01],0)+ISNULL([02],0)+ISNULL([03],0)+ISNULL([04],0)+ISNULL([05],0)+ISNULL([06],0)+ISNULL([07],0)+ISNULL([08],0)+ISNULL([09],0)+ISNULL([10],0)+
					ISNULL([11],0)+ISNULL([12],0)+ISNULL([13],0)+ISNULL([14],0)+ISNULL([15],0)+ISNULL([16],0)+ISNULL([17],0)+ISNULL([18],0)+ISNULL([19],0)+ISNULL([20],0)+
					ISNULL([21],0)+ISNULL([22],0)+ISNULL([23],0)+ISNULL([24],0)+ISNULL([25],0)+ISNULL([26],0)+ISNULL([27],0)+ISNULL([28],0)+ISNULL([29],0)+ISNULL([30],0)+
					ISNULL([31],0)+ISNULL([32],0)+ISNULL([33],0)+ISNULL([34],0)+ISNULL([35],0)+ISNULL([36],0)+ISNULL([37],0)+ISNULL([38],0)+ISNULL([39],0)+ISNULL([40],0)+
					ISNULL([41],0)+ISNULL([42],0)+ISNULL([43],0)+ISNULL([44],0)+ISNULL([45],0)+ISNULL([46],0)+ISNULL([47],0)+ISNULL([48],0)+ISNULL([49],0)+ISNULL([50],0)+
					ISNULL([51],0)+ISNULL([52],0)+ISNULL([53],0)
	INTO	#VISTI_WAY_WEEK
	FROM
	(
		SELECT 
			VISIT_WAY,
			DATEPART(WW, CAST(YYYY AS VARCHAR(4)) +'-'+	CAST(MM AS VARCHAR(2)) + '-' + 	CAST(NUM AS VARCHAR(2))) AS WEEKOFYEAR,
			SUM(CASE NUM 
				WHEN 1 	THEN DAY_1
				WHEN 2	THEN DAY_2
				WHEN 3	THEN DAY_3
				WHEN 4	THEN DAY_4
				WHEN 5	THEN DAY_5
				WHEN 6	THEN DAY_6
				WHEN 7	THEN DAY_7
				WHEN 8	THEN DAY_8
				WHEN 9	THEN DAY_9
				WHEN 10	THEN DAY_10
				WHEN 11	THEN DAY_11
				WHEN 12	THEN DAY_12
				WHEN 13	THEN DAY_13
				WHEN 14	THEN DAY_14
				WHEN 15	THEN DAY_15
				WHEN 16	THEN DAY_16
				WHEN 17	THEN DAY_17
				WHEN 18	THEN DAY_18
				WHEN 19	THEN DAY_19
				WHEN 20	THEN DAY_20
				WHEN 21	THEN DAY_21
				WHEN 22	THEN DAY_22
				WHEN 23	THEN DAY_23
				WHEN 24	THEN DAY_24
				WHEN 25	THEN DAY_25
				WHEN 26	THEN DAY_26
				WHEN 27	THEN DAY_27
				WHEN 28	THEN DAY_28
				WHEN 29	THEN DAY_29
				WHEN 30	THEN DAY_30
				WHEN 31	THEN DAY_31
			END) AS DAY_SUM
		FROM
		(
			SELECT LEFT(YYYYMM,4) AS YYYY, RIGHT(YYYYMM,2) AS MM, *
			FROM TBL_JCA_VISIT_WAY_STATS
			WHERE YYYYMM LIKE @YYYY+'%'-- and visit_way <> '∏πŸ¿œ'
		) AS TMP_WORK_TBL1
		 CROSS JOIN @COPY_T
		WHERE	CASE NUM 
					WHEN 1 	THEN DAY_1
					WHEN 2	THEN DAY_2
					WHEN 3	THEN DAY_3
					WHEN 4	THEN DAY_4
					WHEN 5	THEN DAY_5
					WHEN 6	THEN DAY_6
					WHEN 7	THEN DAY_7
					WHEN 8	THEN DAY_8
					WHEN 9	THEN DAY_9
					WHEN 10	THEN DAY_10
					WHEN 11	THEN DAY_11
					WHEN 12	THEN DAY_12
					WHEN 13	THEN DAY_13
					WHEN 14	THEN DAY_14
					WHEN 15	THEN DAY_15
					WHEN 16	THEN DAY_16
					WHEN 17	THEN DAY_17
					WHEN 18	THEN DAY_18
					WHEN 19	THEN DAY_19
					WHEN 20	THEN DAY_20
					WHEN 21	THEN DAY_21
					WHEN 22	THEN DAY_22
					WHEN 23	THEN DAY_23
					WHEN 24	THEN DAY_24
					WHEN 25	THEN DAY_25
					WHEN 26	THEN DAY_26
					WHEN 27	THEN DAY_27
					WHEN 28	THEN DAY_28
					WHEN 29	THEN DAY_29
					WHEN 30	THEN DAY_30
					WHEN 31	THEN DAY_31
				END IS NOT NULL
		GROUP BY VISIT_WAY, DATEPART(WW, CAST(YYYY AS VARCHAR(4)) +'-'+	CAST(MM AS VARCHAR(2)) + '-' + 	CAST(NUM AS VARCHAR(2)))
	) TMP_TBL_WORK2
	PIVOT(SUM(DAY_SUM) FOR WEEKOFYEAR IN (
			[01], [02], [03], [04], [05], [06], [07], [08], [09], [10],
			[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
			[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], 
			[31], [32], [33], [34], [35], [36], [37], [38], [39], [40], 
			[41], [42], [43], [44], [45], [46], [47], [48], [49], [50], 
			[51], [52], [53]
	)) AS PVT


	SELECT	'«’∞Ë' as visit_way
	,		SUM([01]) [01], SUM([02]) [02], SUM([03]) [03], SUM([04]) [04], SUM([05]) [05], SUM([06]) [06],SUM([07]) [07], SUM([08]) [08], SUM([09]) [09], SUM([10]) [10]
	, 		SUM([11]) [11], SUM([12]) [12], SUM([13]) [13], SUM([14]) [14], SUM([15]) [15], SUM([16]) [16],SUM([17]) [17], SUM([18]) [18], SUM([19]) [19], SUM([20]) [20]
	, 		SUM([21]) [21], SUM([22]) [22], SUM([23]) [23], SUM([24]) [24], SUM([25]) [25], SUM([26]) [26],SUM([27]) [27], SUM([28]) [28], SUM([29]) [29], SUM([30]) [30]	
	, 		SUM([31]) [31], SUM([32]) [32], SUM([33]) [33], SUM([34]) [34], SUM([35]) [35], SUM([36]) [36],SUM([37]) [37], SUM([38]) [38], SUM([39]) [39], SUM([40]) [40]
	, 		SUM([41]) [41], SUM([42]) [42], SUM([43]) [43], SUM([44]) [44], SUM([45]) [45], SUM([46]) [46],SUM([47]) [47], SUM([48]) [48], SUM([49]) [49], SUM([50]) [50]	
	, 		SUM([51]) [51], SUM([52]) [52], SUM([53]) [53]			 																		 
	
	,		[«’∞Ë] = ISNULL(SUM([01]),0)+ISNULL(SUM([02]),0)+ISNULL(SUM([03]),0)+ISNULL(SUM([04]),0)+ISNULL(SUM([05]),0)+ISNULL(SUM([06]),0)+ISNULL(SUM([07]),0)+ISNULL(SUM([08]),0)+ISNULL(SUM([09]),0)+ISNULL(SUM([10]),0)+
			ISNULL(SUM([11]),0)+ISNULL(SUM([12]),0)+ISNULL(SUM([13]),0)+ISNULL(SUM([14]),0)+ISNULL(SUM([15]),0)+ISNULL(SUM([16]),0)+ISNULL(SUM([17]),0)+ISNULL(SUM([18]),0)+ISNULL(SUM([19]),0)+ISNULL(SUM([20]),0)+
			ISNULL(SUM([21]),0)+ISNULL(SUM([22]),0)+ISNULL(SUM([23]),0)+ISNULL(SUM([24]),0)+ISNULL(SUM([25]),0)+ISNULL(SUM([26]),0)+ISNULL(SUM([27]),0)+ISNULL(SUM([28]),0)+ISNULL(SUM([29]),0)+ISNULL(SUM([30]),0)+
			ISNULL(SUM([31]),0)+ISNULL(SUM([32]),0)+ISNULL(SUM([33]),0)+ISNULL(SUM([34]),0)+ISNULL(SUM([35]),0)+ISNULL(SUM([36]),0)+ISNULL(SUM([37]),0)+ISNULL(SUM([38]),0)+ISNULL(SUM([39]),0)+ISNULL(SUM([40]),0)+
			ISNULL(SUM([41]),0)+ISNULL(SUM([42]),0)+ISNULL(SUM([43]),0)+ISNULL(SUM([44]),0)+ISNULL(SUM([45]),0)+ISNULL(SUM([46]),0)+ISNULL(SUM([47]),0)+ISNULL(SUM([48]),0)+ISNULL(SUM([49]),0)+ISNULL(SUM([50]),0)+
			ISNULL(SUM([51]),0)+ISNULL(SUM([52]),0)+ISNULL(SUM([53]),0)
	into	#sum
	FROM  #VISTI_WAY_WEEK 
	WHERE	visit_way not in ('∏πŸ¿œ', 'ZUM', '∞Ì∫£Ω∫∆Æ')

	
	select VISIT_WAY,
			[01], [02], [03], [04], [05], [06], [07], [08], [09], [10],
			[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
			[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], 
			[31], [32], [33], [34], [35], [36], [37], [38], [39], [40], 
			[41], [42], [43], [44], [45], [46], [47], [48], [49], [50], 
			[51], [52], [53], [«’∞Ë] 
	from
	(
		SELECT *		
		, order_name = case visit_way when '±‚≈∏' then '§æ_±‚≈∏' when '∏πŸ¿œ' then '∆R_1' when 'ZUM' then '∆R_3' when '∞Ì∫£Ω∫∆Æ' then '∆R_4' else visit_way end
		FROM #VISTI_WAY_WEEK

		UNION ALL
		SELECT	* 
		, order_name = '«’∞Ë'
		from #sum

		UNION ALL
		select '¿•πÊπÆºˆ' as visit_way,
			a.[01] - b.[01], a.[02] - b.[02], a.[03] - b.[03], a.[04] - b.[04], a.[05] - b.[05], a.[06] - b.[06], a.[07] - b.[07], a.[08] - b.[08], a.[09] - b.[09], a.[10] - b.[10],
			a.[11] - b.[11], a.[12] - b.[12], a.[13] - b.[13], a.[14] - b.[14], a.[15] - b.[15], a.[16] - b.[16], a.[17] - b.[17], a.[18] - b.[18], a.[19] - b.[19], a.[20] - b.[20],
			a.[21] - b.[21], a.[22] - b.[22], a.[23] - b.[23], a.[24] - b.[24], a.[25] - b.[25], a.[26] - b.[26], a.[27] - b.[27], a.[28] - b.[28], a.[29] - b.[29], a.[30] - b.[30],
			a.[31] - b.[31], a.[32] - b.[32], a.[33] - b.[33], a.[34] - b.[34], a.[35] - b.[35], a.[36] - b.[36], a.[37] - b.[37], a.[38] - b.[38], a.[39] - b.[39], a.[40] - b.[40],
			a.[41] - b.[41], a.[42] - b.[42], a.[43] - b.[43], a.[44] - b.[44], a.[45] - b.[45], a.[46] - b.[46], a.[47] - b.[47], a.[48] - b.[48], a.[49] - b.[49], a.[50] - b.[50],
			a.[51] - b.[51], a.[52] - b.[52], a.[53] - b.[53]
		, [«’∞Ë] = a.[«’∞Ë] - b.[«’∞Ë]
		, order_name = '∆R_2'
		from #sum a cross join (select * from #VISTI_WAY_WEEK where visit_way = '∏πŸ¿œ') b
	) a where [«’∞Ë] > 0
	order by order_name


