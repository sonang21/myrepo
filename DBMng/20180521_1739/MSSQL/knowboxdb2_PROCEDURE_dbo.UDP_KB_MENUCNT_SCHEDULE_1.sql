/* *************************************************************************
 * NAME : dbo.UDP_KB_MENUCNT_SCHEDULE_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-16 18:20:11.617
 *        Modify: 2018-05-16 18:20:11.617
 *        Backup: 20180521_1739
 ************************************************************************* */

--exec UDP_KB_MENUCNT_SCHEDULE_1

CREATE     PROC UDP_KB_MENUCNT_SCHEDULE_1
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRAN
		TRUNCATE TABLE KNOW_MENU1_CNT_1
		TRUNCATE TABLE KNOW_MENU2_CNT_1
		TRUNCATE TABLE KNOW_MENU3_CNT_1

		--전체지식.
		INSERT INTO KNOW_MENU1_CNT_1 (MCATE, KK_CODE, CNT)
		SELECT LEFT(G_CATEGORY,4)  AS CA_CODE,  KK_CODE, COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND G_CATEGORY NOT LIKE '9701%'
			AND G_CATEGORY NOT LIKE '9702%'	
		GROUP BY LEFT(G_CATEGORY,4), KK_CODE
		ORDER BY CA_CODE, KK_CODE
		IF @@ERROR <> 0 GOTO ERROR_HANDLER
		
		--새로운글
			--1) 1주미만글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT LEFT(G_CATEGORY,4)  AS CA_CODE, '1', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KB_REGDATE > DATEADD(D,-7,GETDATE())
			AND G_CATEGORY NOT LIKE '9701%'
			AND G_CATEGORY NOT LIKE '9702%'
		GROUP BY LEFT(G_CATEGORY,4)
		ORDER BY CA_CODE
		IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
			--2) 미답변글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT LEFT(G_CATEGORY,4)  AS CA_CODE,  '2', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KB_TAIL_FLAG='0'
			AND KK_CODE='01'
			AND G_CATEGORY NOT LIKE '9701%'
			AND G_CATEGORY NOT LIKE '9702%'
		GROUP BY LEFT(G_CATEGORY,4)
		ORDER BY CA_CODE
		IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
			--3)최근답변글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT LEFT(G_CATEGORY,4)  AS CA_CODE, '3', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KK_CODE='01'
			AND KB_REGDATE > DATEADD(DD, -7, GETDATE()) 
			AND DBO.UDF_TAIL_DATE(KB_NO) > GETDATE()-7
			AND G_CATEGORY NOT LIKE '9701%'
			AND G_CATEGORY NOT LIKE '9702%'
		GROUP BY LEFT(G_CATEGORY,4)
		ORDER BY CA_CODE
		IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
		--BEST
		INSERT INTO KNOW_MENU3_CNT_1 (MCATE, KK_CODE, CNT)
		SELECT LEFT(G_CATEGORY,4)  AS CA_CODE,  KK_CODE, COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND (KB_BEST_FLAG='3' OR KB_RECOMMEND_FLAG='1')
			AND G_CATEGORY NOT LIKE '9701%'
			AND G_CATEGORY NOT LIKE '9702%'
		GROUP BY LEFT(G_CATEGORY,4), KK_CODE
		ORDER BY CA_CODE, KK_CODE
		IF @@ERROR <> 0 GOTO ERROR_HANDLER

	IF @@ERROR<>0
	BEGIN
		ERROR_HANDLER:
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		COMMIT TRAN
	END


		/*
		9701 예외카테고리 갯수.
		*/
		--전체지식.
		INSERT INTO KNOW_MENU1_CNT_1 (MCATE, KK_CODE, CNT)
		SELECT '9701'  AS CA_CODE,  KK_CODE, COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND (G_CATEGORY LIKE '9701%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9701%'' '
						)
					)
				)
		GROUP BY  KK_CODE
		ORDER BY  KK_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
		
		--새로운글
			--1) 1주미만글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT  '9701'  AS CA_CODE, '1', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KB_REGDATE > DATEADD(D,-7,GETDATE())
			AND (G_CATEGORY LIKE '9701%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9701%'' '
						)
					)
				)
		--GROUP BY LEFT(G_CATEGORY,4)
		--ORDER BY CA_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
			--2) 미답변글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT  '9701'  AS CA_CODE,  '2', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KB_TAIL_FLAG='0'
			AND KK_CODE='01'
			AND (G_CATEGORY LIKE '9701%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9701%'''
						)
					)
				)
		--GROUP BY LEFT(G_CATEGORY,4)
		--ORDER BY CA_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
			--3)최근답변글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT '9701'  AS CA_CODE, '3', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KK_CODE='01'
			AND KB_REGDATE > DATEADD(DD, -7, GETDATE()) 
			AND DBO.UDF_TAIL_DATE(KB_NO) > GETDATE()-7
			AND (G_CATEGORY LIKE '9701%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9701%'''
						)
					)
				)
		--GROUP BY LEFT(G_CATEGORY,4)
		--ORDER BY CA_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
		--BEST
		INSERT INTO KNOW_MENU3_CNT_1 (MCATE, KK_CODE, CNT)
		SELECT '9701'  AS CA_CODE,  KK_CODE, COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND (KB_BEST_FLAG='3' OR KB_RECOMMEND_FLAG='1')
			AND (G_CATEGORY LIKE '9701%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9701%'' '
						)
					)
				)
		GROUP BY  KK_CODE
		ORDER BY  KK_CODE
		--GROUP BY LEFT(G_CATEGORY,4), KK_CODE
		--ORDER BY CA_CODE, KK_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER



		/*
		9702  예외카테고리 갯수.
		*/
		--전체지식.
		INSERT INTO KNOW_MENU1_CNT_1 (MCATE, KK_CODE, CNT)
		SELECT '9702'  AS CA_CODE,  KK_CODE, COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND (G_CATEGORY LIKE '9702%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9702%'' '
						)
					)
				)
		GROUP BY  KK_CODE
		ORDER BY  KK_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
		
		--새로운글
			--1) 1주미만글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT  '9702'  AS CA_CODE, '1', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KB_REGDATE > DATEADD(D,-7,GETDATE())
			AND (G_CATEGORY LIKE '9702%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select  distinct  c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9702%'' '
						)
					)
				)
		--GROUP BY LEFT(G_CATEGORY,4)
		--ORDER BY CA_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
			--2) 미답변글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT  '9702'  AS CA_CODE,  '2', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KB_TAIL_FLAG='0'
			AND KK_CODE='01'
			AND (G_CATEGORY LIKE '9702%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9702%'' '
						)
					)
				)
		--GROUP BY LEFT(G_CATEGORY,4)
		--ORDER BY CA_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
			--3)최근답변글
		INSERT INTO KNOW_MENU2_CNT_1 (MCATE, SUBMENU, CNT)
		SELECT '9702'  AS CA_CODE, '3', COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND KB_PARENT_NO IS NULL
			AND KK_CODE='01'
			AND KB_REGDATE > DATEADD(DD, -7, GETDATE()) 
			AND DBO.UDF_TAIL_DATE(KB_NO) > GETDATE()-7
			AND (G_CATEGORY LIKE '9702%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9702%'' '
						)
					)
				)
		--GROUP BY LEFT(G_CATEGORY,4)
		--ORDER BY CA_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER
	
		--BEST
		INSERT INTO KNOW_MENU3_CNT_1 (MCATE, KK_CODE, CNT)
		SELECT '9702'  AS CA_CODE,  KK_CODE, COUNT(LEFT(G_CATEGORY,4)) AS CNT
		FROM KNOW_BOX (NOLOCK)
		WHERE KB_DEL_FLAG='0'
			AND (KB_BEST_FLAG='3' OR KB_RECOMMEND_FLAG='1')
			AND (G_CATEGORY LIKE '9702%' OR
			         G_MODELNO IN (SELECT  MODELNO 
						FROM OPENQUERY(ORADB, 
						'select distinct c.modelno 
                         from tbl_goods a 
                              inner join tbl_cate_goods c on a.modelno = c.modelno
                         where c.ca_code like ''9702%'' '
						)
					)
				)
		GROUP BY  KK_CODE
		ORDER BY  KK_CODE
		--GROUP BY LEFT(G_CATEGORY,4), KK_CODE
		--ORDER BY CA_CODE, KK_CODE
		--IF @@ERROR <> 0 GOTO ERROR_HANDLER

	
	

END





