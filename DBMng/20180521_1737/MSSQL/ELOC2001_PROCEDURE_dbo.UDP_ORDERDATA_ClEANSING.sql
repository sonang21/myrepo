/* *************************************************************************
 * NAME : dbo.UDP_ORDERDATA_ClEANSING
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-01-12 09:22:43.36
 *        Modify: 2018-05-03 17:23:34.49
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [DBO].[UDP_ORDERDATA_CLEANSING]
	@FLAG	VARCHAR(5)
AS
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2009.12.14
	-- ��  �� : �ֹ� Raw �����Ϳ� �ߺ�����
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	-- ��ü����
	declare @shop_vcode int
	select top 1 @shop_vcode = shop_vcode from tbl_orderdata_worker

	-- �ֹ���ȣ ���� ���� : �ֹ���+####(������ �Ϸù�ȣ
	update tbl_orderdata_worker set od_id = convert(varchar(8), od_regdate, 112) +'_'+ right('0000'+cast(seq as varchar(10)), 4) where od_id is null


	-- ���� ���,��ǰ,Ŭ����, ��� ��ǰ ����
	IF @SHOP_VCODE = 55 	begin
		delete tbl_orderdata_worker 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker a inner join tbl_orderdata_worker b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode and a.shop_vcode = b.shop_vcode
					and a.od_price = b.od_price -- ������ ��� �κ� ��Ұ����ϹǷ� ���ݱ��� ���� ��츸 ����
			where	a.od_comment <> b.od_comment
			and		(	b.od_comment like '%���%' or b.od_comment like '%��ǰ%' 
					or	b.od_comment like '%Ŭ����%' or b.od_comment like '%����%'
					or	b.od_comment like '%cancel%' or b.od_comment like '%ȸ��%'
					or	b.od_comment like '%ȯ��%' or b.od_comment like '%����%'
					or	b.od_comment like '%ǰ��%' 
					)
		)

	end else  begin
		delete tbl_orderdata_worker 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker a inner join tbl_orderdata_worker b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode and a.shop_vcode = b.shop_vcode
			where	a.od_comment <> b.od_comment
			and		(	b.od_comment like '%���%' or b.od_comment like '%��ǰ%' 
					or	b.od_comment like '%Ŭ����%' or b.od_comment like '%����%'
					or	b.od_comment like '%cancel%' or b.od_comment like '%ȸ��%'
					or	b.od_comment like '%ȯ��%' or b.od_comment like '%����%'
					or	b.od_comment like '%ǰ��%' 
					)
		)
	end

	-- ���,��ǰ,Ŭ����, ��� ��ǰ ����.2
	delete b from tbl_orderdata_worker b 
	where		(	b.od_comment like '%���%' or b.od_comment like '%��ǰ%' 
				or	b.od_comment like '%Ŭ����%' or b.od_comment like '%����%'
				or	b.od_comment like '%cancel%' or b.od_comment like '%ȸ��%'
				or	b.od_comment like '%ȯ��%'	or b.od_comment like '%����%'
				or	b.od_comment like '%ǰ��%'
				)
	and b.od_comment not like '%öȸ%'

	delete tbl_orderdata_worker where  od_price <=0  

	-- ���������� ��ȯ��Ű�� �𵨸� ó��
	update tbl_orderdata_worker
	set od_goodsnm =replace(replace(replace(replace(replace(replace(
	replace(replace(replace(replace(replace(replace(replace(replace(
	replace(replace(replace(replace(od_goodsnm,'��','-'),'��','-'),'��','-')
	,'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-')
	,'��','-'),'��','-'),'��','-'),'��','-'),'��','-'),'��','-')
	,'��','-'),'<b>','-'),'��','-')


	-- ��ü������� : �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ/���� ��ۻ��� �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
	if @shop_vcode <> 6361 begin -- Ȩ�÷���
		
		select od_id, od_goodscode, od_comment, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
		into #tmp_worker
		from tbl_orderdata_worker 
		group by od_id, od_goodscode, od_comment, convert(varchar(10), od_regdate, 112) having count(*) > 1

		update	tbl_orderdata_worker
		set		od_cnt = b.sum_cnt
		,		od_price = b.sum_price
		from	tbl_orderdata_worker a inner join #tmp_worker b 
		on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
		and		a.od_comment = b.od_comment and a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd

		delete	tbl_orderdata_worker 
		from	tbl_orderdata_worker a inner join #tmp_worker b 
		on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
		and		a.od_comment = b.od_comment and a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	end


	

	-- ��ü�� �ֹ������� ���� ó��
	-- ������ũ
	--IF @SHOP_VCODE = 55 
	--BEGIN
	--	If @FLAG = 'DLV' -- ���
	--	BEGIN
	--		-- ���� ���⸶�� ��ҵ� ���⸶���ֹ� ����
	--		DELETE TBL_ORDERDATA_WORKER 
	--		WHERE SEQ IN 
	--		(
	--			SELECT	A.SEQ
	--			FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--					ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--			WHERE	A.OD_COMMENT = '���⸶���ֹ�'
	--			AND		B.OD_COMMENT = '���⸶�����'
	--		)
	--	END
	--	ELSE If @FLAG = 'ORD' -- ü��
	--	BEGIN
	--		DELETE TBL_ORDERDATA_WORKER 
	--		WHERE SEQ IN 
	--		(
	--			SELECT	A.SEQ
	--			FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--					ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--			WHERE	A.OD_COMMENT = '�ǸŸ����ֹ�'
	--			AND		B.OD_COMMENT = '�ǸŸ������'
	--		)
	--	END
	--END
	-- G����
	--ELSE IF @SHOP_VCODE = 536
	--BEGIN
	--	-- ��ǰ ȯ��ó�� ����
	--	DELETE FROM TBL_ORDERDATA_WORKER WHERE OD_COMMENT='��ǰ' or OD_CNT < 0

	
	--	-- ���� ��� ��ǰ ����
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> '�ֹ����'
	--		AND		B.OD_COMMENT = '�ֹ����'
	--	)

	--END
	-- GSSHOP
	--ELSE 
	IF @SHOP_VCODE = 75
	BEGIN
		-- ��ۺ� ����
		DELETE	TBL_ORDERDATA_WORKER WHERE	OD_GOODSNM  LIKE '��ۺ�'

		---- ���� ��� ��ǰ ����
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '�ֹ����'
		--	AND		B.OD_COMMENT = '�ֹ����'
		--)
		

		-- �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
		-- �ֹ� ������°� �޶� 1�� ��ǰ���� ó��
		SELECT OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) YYYYMMDD, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_75
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_75 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_75 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD


	END
	else if @shop_vcode = 4027
	begin
		delete tbl_orderdata_worker from tbl_orderdata_worker where od_goodscode like 'bn%'
	end
	-- �����
	--ELSE IF @SHOP_VCODE = 974
	--BEGIN
	--	-- ���� ��� ��ǰ ����
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> '�ֹ����'
	--		AND		B.OD_COMMENT = '�ֹ����'
	--	)
	--END
	-- QOOK TV����
	--ELSE IF @SHOP_VCODE = 241
	--BEGIN
	--	-- ���� ��� ��ǰ ����
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> '�ֹ����'
	--		AND		B.OD_COMMENT = '�ֹ����'
	--	)
	--END
	-- �ż���� , �̸�Ʈ
	ELSE IF @SHOP_VCODE in ( 47, 374 )
	BEGIN
		---- ���� ��� ��ǰ ����
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '�ֹ����'
		--	AND		B.OD_COMMENT = '�ֹ����'
		--)

		---- ���� ��ǰ ��ǰ ����
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '��ǰ'
		--	AND		B.OD_COMMENT = '��ǰ'
		--)

		delete b from tbl_orderdata_worker b where	b.od_comment = '�Աݴ��'


		-- �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
		-- �ֹ� ������°� �޶� 1�� ��ǰ���� ó��
		SELECT OD_ID, OD_GOODSCODE, SHOP_VCODE, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_47
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE, SHOP_VCODE 
		HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_47 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ and a.SHOP_VCODE = b.SHOP_VCODE

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_47 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ and a.SHOP_VCODE = b.SHOP_VCODE
	END
	-- �Ե�Ȩ����
	ELSE IF @SHOP_VCODE = 663
	BEGIN
		-- ���� ��ۺ� ����
		DELETE	TBL_ORDERDATA_WORKER WHERE	OD_GOODSNM  = '��ۺ�'

		---- ���� ��� ��ǰ ����
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT not like '���:%'
		--	AND		B.OD_COMMENT like '���:%'
		--)

		---- ���� ��ǰ ���� ����
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT not like '��ǰ:%'
		--	AND		B.OD_COMMENT like '��ǰ:%'
		--)

		-- �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
		-- �ֹ� ������°� �޶� 1�� ��ǰ���� ó��
		SELECT OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) YYYYMMDD, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_663
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE, CONVERT(VARCHAR(10), OD_REGDATE, 112) HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_663 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_663 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ AND CONVERT(VARCHAR(10), A.OD_REGDATE, 112) = B.YYYYMMDD
	END
	-- ���̸�Ʈ���θ� : 
	ELSE IF @SHOP_VCODE = 6252
	BEGIN
		-- ���� ��� ��ǰ ����
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
		--	WHERE	A.OD_COMMENT <> '�ֹ����'
		--	AND		B.OD_COMMENT = '�ֹ����'
		--)

		-- �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
		-- �ֹ� ������°� �޶� 1�� ��ǰ���� ó��
		SELECT OD_ID, OD_GOODSCODE, MIN(SEQ) MIN_SEQ, SUM(OD_CNT) SUM_CNT, SUM(OD_PRICE) SUM_PRICE, COUNT(*) CNT
		INTO #TMP_WORKER_6252
		FROM TBL_ORDERDATA_WORKER 
		GROUP BY OD_ID, OD_GOODSCODE HAVING COUNT(*) > 1

		UPDATE	TBL_ORDERDATA_WORKER
		SET		OD_CNT = B.SUM_CNT
		,		OD_PRICE = B.SUM_PRICE
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_6252 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ = B.MIN_SEQ

		DELETE	TBL_ORDERDATA_WORKER 
		FROM	TBL_ORDERDATA_WORKER A INNER JOIN #TMP_WORKER_6252 B 
		ON		A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE 
		AND		A.SEQ > B.MIN_SEQ
	END
	-- Ȩ�÷��� : 
	ELSE IF @SHOP_VCODE = 6361
	BEGIN
		---- ���� ��� ��ǰ ����
		--DELETE TBL_ORDERDATA_WORKER 
		--WHERE SEQ IN 
		--(
		--	SELECT	A.SEQ
		--	FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
		--			ON A.OD_ID = B.OD_ID AND isnull(A.OD_GOODSCODE,'1') = isnull(B.OD_GOODSCODE,'1')
		--	WHERE	A.OD_COMMENT <> b.od_comment
		--	AND		B.OD_COMMENT like '%���%'
		--)

		-- ���ǰ
		delete from TBL_ORDERDATA_WORKER where od_comment = 'y'
	END
	-- Qoo10
	ELSE IF @SHOP_VCODE = 7857
	BEGIN
		-- $�� ��ȭ�� ȯ�� // http://58.234.199.100/redmine/issues/18007
		update tbl_orderdata_worker set od_price = od_price * 1100
	END
	-- ��ü������ : 
	--ELSE IF @SHOP_VCODE = 5438
	--BEGIN
	--	-- ���� ��� ��ǰ ����
	--	DELETE TBL_ORDERDATA_WORKER 
	--	WHERE SEQ IN 
	--	(
	--		SELECT	A.SEQ
	--		FROM	TBL_ORDERDATA_WORKER A INNER JOIN TBL_ORDERDATA_WORKER B
	--				ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	--		WHERE	A.OD_COMMENT <> b.od_comment
	--		AND		B.OD_COMMENT like '%���%'
	--	)
	--END


	-- ��ü������� : �����Ϻ� �ɼǻ�ǰ/���ϻ�ǰ �ߺ� �ֹ� �׷�ó���� 1�� ��ǰ���� �����
	-- �ֹ� ������°� �޶� 1�� ��ǰ���� ó��
	select shop_vcode, od_id, od_goodscode, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
	into #tmp_worker_result
	from tbl_orderdata_worker 
	group by od_id, od_goodscode, convert(varchar(10), od_regdate, 112), shop_vcode
	having count(*) > 1

	update	tbl_orderdata_worker
	set		od_cnt = b.sum_cnt
	,		od_price = b.sum_price
	from	tbl_orderdata_worker a inner join #tmp_worker_result b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.SHOP_VCODE = b.SHOP_VCODE

	delete	tbl_orderdata_worker 
	from	tbl_orderdata_worker a inner join #tmp_worker_result b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.SHOP_VCODE = b.SHOP_VCODE


	-- �ܰ����
	update tbl_orderdata_worker	set od_unit_price = od_price/od_cnt


	delete tbl_orderdata_worker where  od_price <=0 

