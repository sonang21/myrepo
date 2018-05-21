/* *************************************************************************
 * NAME : dbo.UDP_LIMIT_MINPRICE_CHECK
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-12-09 16:50:59.067
 *        Modify: 2018-05-03 17:23:35.353
 *        Backup: 20180521_1737
 ************************************************************************* */






CREATE PROCEDURE [dbo].[UDP_LIMIT_MINPRICE_CHECK]
AS
BEGIN
	-- ----------------------------------------------------------------------------------
	-- 작성자 : sung35 / 2008.12.09 
	-- 설  명 : 최저가 제한보다 낮은 가격이면 해당 그룹 다른모델로 번호매칭
	--          Agent에서 1시간 주기로 실행
    
	
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	

	-- 제한가 입력한 경우, 가격이 제한가 미만으로 변경되면 모델번호 -7
	UPDATE PRICELIST SET PL_STATUS = '1', PL_MODELNO = -7
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND PL_PRICE < LIMIT_MINPRICE
		AND PL_CATEGORY LIKE '050110%' 
	)
		
	UPDATE PRICELIST SET PL_STATUS = '1', PL_MODELNO = -7
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND PL_PRICE < LIMIT_MINPRICE
		AND PL_CATEGORY LIKE '050106%' 
	)




	--. 에어컨 (2401)
	--. 프로젝터,스크린(0211)
	--. 정수기,냉온수기(0610)
	-- 제한가 입력한 경우, 가격이 제한가 미만으로 변경되면 서비스 중지(단종 코드 P로 변경) / 제한가 이상으로 변경되면 서비스 (단종 0으로 변경)
	UPDATE PRICELIST SET PL_STATUS = '1', PL_SRVFLAG = (case when PL_SRVFLAG = '0' then 'P' else '0' end)
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND ((PL_SRVFLAG = 'P' AND PL_PRICE >= LIMIT_MINPRICE) or (PL_SRVFLAG = '0' AND PL_PRICE < LIMIT_MINPRICE))
		AND PL_CATEGORY LIKE '2401%' 
	)

	UPDATE PRICELIST SET PL_STATUS = '1', PL_SRVFLAG = (case when PL_SRVFLAG = '0' then 'P' else '0' end)
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND ((PL_SRVFLAG = 'P' AND PL_PRICE >= LIMIT_MINPRICE) or (PL_SRVFLAG = '0' AND PL_PRICE < LIMIT_MINPRICE))
		AND PL_CATEGORY LIKE '0211%' 
	)

	UPDATE PRICELIST SET PL_STATUS = '1', PL_SRVFLAG = (case when PL_SRVFLAG = '0' then 'P' else '0' end)
	WHERE PL_NO IN (
		SELECT PL_NO
		FROM PRICELIST WITH(READUNCOMMITTED)
		INNER JOIN TBL_LIMIT_MINPRICE
		ON PL_MODELNO = G_MODELNO
		WHERE PL_STATUS IN ('0','1') 
		--AND pl_date > dateadd(mi, -65,getdate()) 
		AND ((PL_SRVFLAG = 'P' AND PL_PRICE >= LIMIT_MINPRICE) or (PL_SRVFLAG = '0' AND PL_PRICE < LIMIT_MINPRICE))
		AND PL_CATEGORY LIKE '0610%' 
	)

	
END










