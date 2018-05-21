/* *************************************************************************
 * NAME : dbo.UDP_GOODS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.39
 *        Modify: 2018-05-03 17:23:35.153
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** ��ü: ���� ���ν��� dbo.spGoods    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:19:53 ******/
CREATE  PROCEDURE UDP_GOODS 
@modelno int, 
@opt varchar(20)  
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	If  @opt = 'minprice'
		BEGIN
			UPDATE GOODS_STAT SET gs_minprice =(
				SELECT	MIN(p_price) as minPrice
				FROM	PLIST
				WITH (ReadUncommitted)
				WHERE	p_modelno = @modelno
				AND	p_status <= '2')
			WHERE gs_modelno = @modelno
		END
	ELSE IF @opt = 'aminprice' 
		BEGIN
			UPDATE GOODS_STAT SET gs_aminprice =(
				SELECT	MIN(p_price) as aminPrice
				FROM	PLIST
				WITH (ReadUncommitted)
				WHERE	p_modelno = @modelno
				AND	p_status <= '2')
			WHERE gs_modelno = @modelno
		END
	ELSE IF @opt = 'avgprice' 
		BEGIN
			UPDATE GOODS_STAT SET gs_avgprice =(
				SELECT	AVG(p_price) as avgPrice
				FROM	PLIST
				WITH (ReadUncommitted)
				WHERE	p_modelno = @modelno
				AND	p_status <= '2')
			WHERE gs_modelno = @modelno
		END
	ELSE IF @opt = 'maxprice' 
		BEGIN
			UPDATE GOODS_STAT SET gs_maxprice =(
				SELECT	MAX(p_price) as maxPrice
				FROM	PLIST
				WITH (ReadUncommitted)
				WHERE	p_modelno = @modelno
				AND	p_status <= '2')
			WHERE gs_modelno = @modelno
		END
	ELSE IF @opt = 'mallcnt' 
		BEGIN
			UPDATE GOODS_STAT SET gs_mallcnt =(
				SELECT	COUNT(*) as mallcnt
				FROM	PLIST
				WITH (ReadUncommitted)
				WHERE	p_modelno = @modelno
				AND	p_status <= '2')
			WHERE gs_modelno = @modelno
		END
END


