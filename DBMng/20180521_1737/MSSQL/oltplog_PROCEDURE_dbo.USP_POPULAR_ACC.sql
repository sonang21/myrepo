/* *************************************************************************
 * NAME : dbo.USP_POPULAR_ACC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:40:59.903
 *        Modify: 2018-05-10 15:43:07.663
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[USP_POPULAR_ACC]
	@DTE_IN SMALLDATETIME=''
AS
BEGIN
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : ssauravy
	-- ��  �� : �α⵵ ���
	-- ��  �� : USP_POPULAR_CHANGE_1 : ������ �α⵵ ���� ó�� ���ν���
    --          udp_rocket_sales_agg : �Ǹŷ� �޻�� ó�� ���ν���
	--			2013.11.28 .. �α����� �ִ� ���� 70���� ������ ��ü ���� �α⵵ �ʱ�ȭ �� �α⵵ ������Ʈ�Ѵ�.
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- ������:		������:		��������:
	-- ----------------------------------------------------------------------------------
	-- 2008.09.09	wookki25	ó�� : G_MALLCNT > 0 ���� ���� (����:������, ������)
	--                          ���� : ��ü���� ����ÿ��� �α����� ���� �ݿ�
	-- ----------------------------------------------------------------------------------
	-- 2008.09.29	wookki25	ó�� : ���� Ư�� �̺з� �α⵵ ����� ����(����:���Ľ�)
	--							���� : http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=177658
	--                          ���� : ������ ��ǰ�� ��� �ֹ������� ����ġ�� ���� �ֹ� �Ǽ��� �α⵵ ó��
	-- ----------------------------------------------------------------------------------
	-- 2008.10.13	wookki25	ó�� : ���� Ư�� �̺з� �α⵵ ����� ���� �߰�(����:���Ľ�), 12030200, �Һз��� �ִ� ī�װ�
	--							���� : http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=179199
	--                          ���� : ������ ��ǰ�� ��� �ֹ������� ����ġ�� ���� �ֹ� �Ǽ��� �α⵵ ó��	
	-- ----------------------------------------------------------------------------------	
	-- 2009.06.17	wookki25	ó�� : ������ ����ġ ī�װ��� ���� ��� �߰�
	--							���� : http://jca.enuri.com/board/eNuriBoard.asp?cmd=board_read&regno=210333&board_code=509&page=1&cmd1=&keyword=&strOption=BoardSubject
	--                          ���� : ī�װ��� ����ġ ���� ��� �ʿ�!
	-- ----------------------------------------------------------------------------------
	-- 2010.01.18	wookki25	ó�� : �ֹ����� 2.5�� -> 2��
	--							���� : ����� �̻�� ��û
	-- ----------------------------------------------------------------------------------
	-- 2010.09.08	wookki25	ó�� : �ֹ����� 2�� -> 3��
	--							���� : ����� �̻�� ��û
	-- ----------------------------------------------------------------------------------
	-- 2010.11.02	wookki25	ó�� : ���� �����̵��� 3�� ó��
	--							���� : ����� �̻�� ��û
	-- ----------------------------------------------------------------------------------
	-- 2011.01.27	wookki25	ó�� : ���� �����̵��� 3�� ó�� ���
	--							���� : ������ ���� ��û
	-- ----------------------------------------------------------------------------------
	-- 2011.09.06	wookki25	ó�� : �����ֹ�����. �����ֹ�����*3 -> �����ֹ�����*2
	--							���� : http://jca.enuri.com/board/redirect.asp?bt=2&bn=7&cn=76100
	-- ----------------------------------------------------------------------------------
	-- 2011.09.06	wookki25	ó�� : �����ֹ����� �Ⱓ����. ���� ���� ����~���Ϻ��� ���� �Ѵ�	
	--							���� : ����� ��û. �α⵵�� �ֹ����� ���̰� Ŀ��..
	-- ----------------------------------------------------------------------------------
	-- 2011.09.19	wookki25	ó�� : �˽�����,�����Ǿ�,�ƽ��� �� �ֹ����� �ݿ� ����: ��ü ī�װ�����  ��ž(0401) ī�װ��� ����
	--							���� : ����� ��û. ��Ʈ�� �ֹ������� �ʹ� ����.
	-- ----------------------------------------------------------------------------------
	-- 2011.09.26	wookki25	ó�� : ���θ� �α��ǰ ������ �α⵵�� �߰� ���� ����
	--							���� : ������ ��û
	-- ----------------------------------------------------------------------------------	
	-- 2011.11.03	wookki25	ó�� : �����ֹ����� 1���� -> 3����
	--							���� : ������ ��û
	-- ----------------------------------------------------------------------------------
	-- 2011.11.03	wookki25	ó�� : �����α⵵ ����� ����.
	--							���� : ��Ƹ� ��û, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=350598
	-- ----------------------------------------------------------------------------------
	-- 2012.04.26	wookki25	ó�� : ���� �α⵵ �̹ݿ�
	--							���� : �ּ��� ��û, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=352546
	-- ----------------------------------------------------------------------------------
	-- ----------------------------------------------------------------------------------
	-- 2012.05.04	wookki25	ó�� : ���� �α⵵ �̹ݿ����� ����ó��
	--								   ���ǵ������߿� ����pc��ü �����ʹ� �α⵵�� �ݿ��Ѵ�.
	--							���� : �ּ��� ��û, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=353301
	-- ----------------------------------------------------------------------------------
 	-- ----------------------------------------------------------------------------------
	-- 2014.04.21	wookki25	ó�� : 11���� ü�� ������ �α⵵�� �߰�..
	--							���� : ������ ��û, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=433327
	-- ----------------------------------------------------------------------------------
 	-- ----------------------------------------------------------------------------------
	-- 2014.04.21	wookki25	ó�� : 11���� ü�� ������ �����ֹ������� �߰�..
	-- ----------------------------------------------------------------------------------
 	-- ----------------------------------------------------------------------------------
	-- 2014.04.24	wookki25	ó�� : ���� ������ �α⵵�� �ݿ�.
	--							���� : �ּ�����û, http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=434184
	-- ----------------------------------------------------------------------------------
  	-- ----------------------------------------------------------------------------------
	-- 2014.09.12	wookki25	ó�� : ����pc���ֹ� ������ ���� ��� ���̺��� �����ϰ� ����
	--							���� : elocdb ������ ���� �߻��� ��� ������ �� �ֵ���.
	-- ----------------------------------------------------------------------------------
	-- ----------------------------------------------------------------------------------
	-- 2015.04.13	wookki25	ó�� : ����PC,�ؽ�PC �� �ֹ����� �ݿ� ����: ��ü ī�װ�����  ��ž(0401) ī�װ��� ����
	-- ----------------------------------------------------------------------------------
	-- 2016.06.30	wookki25	ó�� : ������, ���� ��۵����� ���� -> ü�ᵥ���� ����
	--							���� : �ź��� ��û
	-- ----------------------------------------------------------------------------------
	-- 2016.08.23	wookki25	ó�� : ����� ������ ���� ( �ֹ�, clickout, vip )
	--							���� : �ź��� ��û
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @DTECHKDAY AS SMALLDATETIME
	IF @DTE_IN = ''
		SET @DTECHKDAY = DATEADD(D, -1, GETDATE())
	ELSE
		SET @DTECHKDAY = @DTE_IN
	SET @DTECHKDAY = CONVERT(VARCHAR(8), @DTECHKDAY, 112)


	-- �̹� �ԷµǾ��ִٸ�? �ش� ���� �α⵵ ����
	DELETE TBL_GOODS_POPULAR_ACC WHERE GPA_DATE >=  @DTECHKDAY AND GPA_DATE < DATEADD(D, 1, @DTECHKDAY)


insert tbl_popular_acc_step_log(step) values('�α⵵ ���_s')

	-- ���� �α⵵ �Է�
	insert tbl_goods_popular_acc
	(gpa_date, g_modelno, g_category, g_modelnm, gpa_model_uhit, gpa_model_hit,  gpa_move_uhit, gpa_move_hit, gpa_od_cnt
	, gpa_od_vcnt, gpa_price, gpa_po_point, gpa_po_model_point, gpa_po_move_point, gpa_po_od_cnt_point
	, gpa_po_od_price_point,gpa_po_shop_popular_point)
	select
		@dtechkday as yyyymmdd,
		e.g_modelno,
		isnull(g.g_category,'00') as g_category,
		isnull(g.g_modelnm,'') as g_modelnm,
		gpa_model_uhit,
		gpa_model_hit,
		gpa_move_uhit,
		gpa_move_hit,
		gpa_od_cnt,
		case when
			ceiling(2*isnull(gpa_od_vcnt,0)-(convert(tinyint, (round((rand((datepart(mm, getdate()) * 100000 ) + (datepart(ss, getdate()) * 1000 ) + datepart(ms, getdate())+e.g_modelno % 100000 )*100), 0)))%3))>0
			then ceiling(2*isnull(gpa_od_vcnt,0)-(convert(tinyint, (round((rand((datepart(mm, getdate()) * 100000 ) + (datepart(ss, getdate()) * 1000 ) + datepart(ms, getdate())+e.g_modelno % 100000 )*100), 0)))%3))
			else gpa_od_vcnt end as
		gpa_od_vcnt,
		gpa_price,
		ceiling(gpa_po_point) as gpa_po_point,
		gpa_model_point,
		gpa_move_point,
		gpa_od_cnt_point,
		gpa_od_price_point	
	,	shop_popular_point	
	from
	(
		select	g_modelno
		,	sum(gpa_model_uhit) as gpa_model_uhit
		,	sum(gpa_model_hit) as gpa_model_hit
		,	sum(gpa_move_uhit) as gpa_move_uhit
		,	sum(gpa_move_hit) as gpa_move_hit
		,	sum(gpa_model_point+gpa_move_point+gpa_od_cnt_point+gpa_od_price_point+shop_popular_point) as gpa_po_point
		,	sum(gpa_od_cnt) as gpa_od_cnt
		,	sum(gpa_price) as gpa_price
		,	sum(od_vcnt) as gpa_od_vcnt
		,	sum(gpa_model_point) as gpa_model_point
		,	sum(gpa_move_point) as gpa_move_point
		,	sum(gpa_od_cnt_point) as gpa_od_cnt_point
		,	sum(gpa_od_price_point) as gpa_od_price_point
		,	sum(shop_popular_point) as shop_popular_point
		from
		(
			select
				g_modelno
			,	sum(gpa_model_uhit) as gpa_model_uhit
			,	sum(gpa_model_hit) as gpa_model_hit
			,	sum(gpa_move_uhit) as gpa_move_uhit
			,	sum(gpa_move_hit) as gpa_move_hit
			--	sum(gpa_model_uhit)*1 + sum(gpa_move_uhit)*3 + sum(gpa_od_cnt)*15 + ceiling(sum(gpa_price)/100000.0)*15 as gpa_point_pre,
			,	sum(gpa_model_point)*1 as gpa_model_point
			,	sum(gpa_move_point)*3 as  gpa_move_point
			,	sum(gpa_od_cnt*gpa_ratio)*15 as gpa_od_cnt_point
			,	ceiling(sum(gpa_price*gpa_ratio)/100000.0)*15 as gpa_od_price_point
			,	sum(gpa_od_cnt) as gpa_od_cnt
			,	sum(gpa_price) as gpa_price
			,	0 as od_vcnt
			,	0 as shop_popular_point
			from
			(
				select d.g_modelno
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then md_uhit else 0 end) as gpa_model_uhit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then md_hit else 0 end ) as gpa_model_hit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then md_point else 0 end) as gpa_model_point
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then mh_uhit else 0 end) as gpa_move_uhit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then mh_hit else 0 end) as gpa_move_hit
				,	sum(case when yyyymmdd >= convert(char(8),dateadd(d, -7, @dtechkday),112) then mh_point else 0 end) as gpa_move_point
				,	sum(od_cnt) as gpa_od_cnt
				,	sum(od_price*od_cnt) as gpa_price -- wookki25 2007.05.22 �ܰ�*���� ����ó��
				,	case when sum(md_uhit + mh_uhit) > 0 and sum(md_point*1.0 + mh_point*3.0) > 0 then sum(md_point*1.0 + mh_point*3.0)/sum(md_uhit*1.0+mh_uhit*3.0) else 1 end as gpa_ratio
				from
				(
					--��ǰâ �α�(�Ϻ� -7��ġ)
					select
						convert(char(8), md_dd, 112)  as yyyymmdd,
						g_modelno,
						-----------------
						md_dup_hit as md_uhit,
						md_hit,
						case when isnull(point,md_dup_hit) = md_dup_hit then md_dup_hit*1.2 else point end  md_point,
						
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when convert(char(8), md_dd, 112)>= convert(char(8),dateadd(d, -7, @dtechkday),112) then 1 else 0 end) as is_include
					from tbl_model_dhit
					where md_dd>= convert(char(8),dateadd(d, -10, @dtechkday),112)
						and md_dd < convert(char(8), dateadd(d, 1, @dtechkday),112)

					--��ǰâ �α�(�Ϻ� -7��ġ) // �����
					union all
					select
						convert(char(8), regdate, 112)  as yyyymmdd,
						modelno,
						-----------------
						uhit as md_uhit,
						mhit,
						case when isnull(point,uhit) = uhit then uhit*1.2 else point end  md_point,
						
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when regdate>= dateadd(d, -7, @dtechkday) then 1 else 0 end) as is_include
					from tbl_model_log_mobile_agg_day
					where regdate>= dateadd(d, -10, @dtechkday)
						and regdate < dateadd(d, 1, @dtechkday)
					and modelno > 0

					--�����̵� �α�(�Ϻ� -7��ġ)
					union all

					select
						convert(char(8), mh_date, 112) as yyyymmdd,
						g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0 as md_point,
						-----------------
						mh_uhit,
						mh_hit,
						case when isnull(point,mh_uhit) = mh_uhit then mh_uhit*1.2 else point end  mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when convert(char(8), mh_date, 112)>= convert(char(8),dateadd(d, -7, @dtechkday),112) then 1 else 0 end) as is_include
					from tbl_move_hit
					where mh_date >=  dateadd(d, -10, @dtechkday)
						and mh_date < dateadd(d, 1, @dtechkday)


					--�����̵� �α�(�Ϻ� -7��ġ) / mobile
					union all

					select
						convert(char(8), regdate, 112) as yyyymmdd,
						modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0 as md_point,
						-----------------
						uhit,
						mhit,
						case when isnull(point,uhit) = uhit then uhit*1.2 else point end  mh_point,
						-----------------
						0 as od_cnt,
						0 as od_price,
						(case when convert(char(8), regdate, 112)>= convert(char(8),dateadd(d, -7, @dtechkday),112) then 1 else 0 end) as is_include
					from tbl_move_log_mobile_agg_day_by_modelno
					where regdate >=  dateadd(d, -10, @dtechkday)
						and regdate < dateadd(d, 1, @dtechkday)
					and modelno > 0




					--�ֹ����� (�Ϻ� -10��ġ)
					union all
					select
						convert(char(8), od_date, 112) as yyyymmdd,
						pl_modelno as g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0*1.0 as md_point,
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						od_cnt as od_cnt,
						od_price as od_price,
						1 as is_include
					from tbl_orderdata
					where pl_modelno > 0
						and od_date >= dateadd(d, -10, @dtechkday)
						and od_date < @dtechkday
						and shop_vcode not in (5910, 4027, 55, 536) -- 2016.06.30 // ��۵����� ������� ����
					union all
					select
						convert(char(8), od_date, 112) as yyyymmdd,
						pl_modelno as g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0*1.0 as md_point,
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						od_cnt as od_cnt,
						od_price as od_price,
						1 as is_include
					from tbl_orderdata_gmarket_auction
					where pl_modelno > 0
						and od_date >= dateadd(d, -10, @dtechkday)
						and od_date < @dtechkday
						--and shop_vcode in (5910, 4027) -- 11���� ü�� ������ ����

					--�ֹ����� (�Ϻ� -10��ġ) / �����
					union all
					select
						convert(char(8), od_date, 112) as yyyymmdd,
						pl_modelno as g_modelno,
						-----------------
						0 as md_dup_hit,
						0 as md_hit,
						0*1.0 as md_point,
						-----------------
						0 as mh_uhit,
						0 as mh_hit,
						0 as mh_point,
						-----------------
						od_cnt as od_cnt,
						od_price as od_price,
						1 as is_include
					from tbl_orderdata_ord_mobile
					where pl_modelno > 0
						and od_date >= dateadd(d, -10, @dtechkday)
						and od_date < @dtechkday
						




				) d
				group by d.yyyymmdd, d.g_modelno
				having(sum(is_include)>0)

			) f
			group by g_modelno



			-- �����ֹ�����
			UNION ALL
			SELECT
				PL_MODELNO AS G_MODELNO,
				0 AS GPA_MODEL_UHIT,
				0 AS GPA_MODEL_HIT,
				0 AS GPA_MOVE_UHIT,
				0 AS GPA_MOVE_HIT,
				0 AS GPA_MODEL_POINT,
				0 AS  GPA_MOVE_POINT,
				0 AS GPA_OD_CNT_POINT,
				0 AS GPA_OD_PRICE_POINT,
				0 AS GPA_OD_CNT,
				0 AS GPA_PRICE,
				OD_CNT AS OD_VCNT
			,	0 AS shop_popular_point
			FROM TBL_ORDERDATA
			WHERE PL_MODELNO > 0
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				and shop_vcode not in (5910, 4027, 55, 536)

			UNION ALL

			SELECT
				PL_MODELNO AS G_MODELNO,
				0 AS GPA_MODEL_UHIT,
				0 AS GPA_MODEL_HIT,
				0 AS GPA_MOVE_UHIT,
				0 AS GPA_MOVE_HIT,
				0 AS GPA_MODEL_POINT,
				0 AS  GPA_MOVE_POINT,
				0 AS GPA_OD_CNT_POINT,
				0 AS GPA_OD_PRICE_POINT,
				0 AS GPA_OD_CNT,
				0 AS GPA_PRICE,
				OD_CNT AS OD_VCNT
			,	0 AS shop_popular_point
			FROM TBL_ORDERDATA_gmarket_auction
			WHERE PL_MODELNO > 0
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				--and shop_vcode in (5910, 4027)

			union all

			-- �����
			SELECT
				PL_MODELNO AS G_MODELNO,
				0 AS GPA_MODEL_UHIT,
				0 AS GPA_MODEL_HIT,
				0 AS GPA_MOVE_UHIT,
				0 AS GPA_MOVE_HIT,
				0 AS GPA_MODEL_POINT,
				0 AS  GPA_MOVE_POINT,
				0 AS GPA_OD_CNT_POINT,
				0 AS GPA_OD_PRICE_POINT,
				0 AS GPA_OD_CNT,
				0 AS GPA_PRICE,
				OD_CNT AS OD_VCNT
			,	0 AS shop_popular_point
			FROM tbl_orderdata_ord_mobile
			WHERE PL_MODELNO > 0
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				--and shop_vcode in (5910, 4027)


			
			-- ���θ� �α��ǰ �α⵵
			UNION ALL
			select	g_modelno
			,	0 AS GPA_MODEL_UHIT
			,	0 AS GPA_MODEL_HIT
			,	0 AS GPA_MOVE_UHIT
			,	0 AS GPA_MOVE_HIT
			,	0 AS GPA_MODEL_POINT
			,	0 AS  GPA_MOVE_POINT
			,	0 AS GPA_OD_CNT_POINT
			,	0 AS GPA_OD_PRICE_POINT
			,	0 AS GPA_OD_CNT
			,	0 AS GPA_PRICE
			,	0 AS OD_VCNT
			,	isnull(sum(popular_point),0) AS shop_popular_point
			from	goods_popular_weight_shop_popular
			where	regdate=@dtechkday
			group by g_modelno

		) A
		GROUP BY G_MODELNO
	) E
	LEFT JOIN analstore.DBO.GOODS G
	ON E.G_MODELNO=G.G_MODELNO


insert tbl_popular_acc_step_log(step) values('�α⵵ ���_e')


insert tbl_popular_acc_step_log(step) values('������ ����_s')
	-- -----------------------
	-- ���� �ݿ��� ������ �Է�
	-- -----------------------
	TRUNCATE TABLE GOODS_POPULAR

	INSERT INTO GOODS_POPULAR (GP_MODELNO, GP_CATEGORY, GP_SUM_POINT, GP_ODA_VCNT, GP_FACTORY)
	SELECT	G.G_MODELNO,
			G.G_CATEGORY,
			ISNULL(GPA_PO_POINT,0) AS GP_SUM_POINT,
			ISNULL(P.GPA_OD_VCNT,0) AS GP_ODA_VCNT,
			G.G_FACTORY
	FROM analstore.DBO.GOODS G
		INNER JOIN TBL_GOODS_POPULAR_ACC P
			ON G.G_MODELNO=P.G_MODELNO AND P.GPA_DATE>=@DTECHKDAY AND P.GPA_DATE<DATEADD(D, 1, @DTECHKDAY)
	WHERE G_JOBCODE <> '0' -- �ʱ��ǰ ����
	-- AND G_MALLCNT > 0 -- ����ó�� wookki25 2008.09.09 -- ���� ���� ���涧�� 
	ORDER BY GP_SUM_POINT DESC
insert tbl_popular_acc_step_log(step) values('������ ����_e')

insert tbl_popular_acc_step_log(step) values('����ġ ����_s')	
	
	-- ������ ����ġ ����
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = CEILING(GP_SUM_POINT*P_WEIGHT) 
	FROM	GOODS_POPULAR A 
				INNER JOIN 
			GOODS_POPULAR_WEIGHT_FACTORY B
				ON A.GP_FACTORY = B.G_FACTORY
	WHERE	B.USE_FLAG = 1
	AND LEFT(GP_CATEGORY, LEN(B.G_CATEGORY)) = B.G_CATEGORY

	--�� ����ġ ����
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = CEILING(GP_SUM_POINT*P_WEIGHT) 	 	
	FROM	GOODS_POPULAR A 
				INNER JOIN 
			GOODS_POPULAR_WEIGHT_MODELNO B
				ON A.GP_MODELNO = B.G_MODELNO
	WHERE	B.USE_FLAG = 1


	-- ī�װ��� ����ġ
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = CEILING(GP_SUM_POINT*P_WEIGHT) 	
	FROM	GOODS_POPULAR A
				INNER JOIN 
			GOODS_POPULAR_WEIGHT_CATEGORY B
				ON A.GP_CATEGORY LIKE B.G_CATEGORY + '%'
	WHERE	B.USE_FLAG = 1

insert tbl_popular_acc_step_log(step) values('����ġ ����_e')


insert tbl_popular_acc_step_log(step) values('������ ����_s')
	-- Ư����ǰ �α⵵ �ֹ����� ����ȭ
	-- ������ ��ǰ �����ϱ����� �����ؾ� ��!!
	-- EXEC UDP_SYNC_POPULAR_INFO

	-- ������ ��ǰ �α⵵ ���� ó�� wookki25 2009.09.14
	-- USP_POPULAR_CHANGE_1 ������ ó������ �ʴ´�. 
	-- EDATE +1 : ���� ������ �����ð����� �����ϵ��� ó��. ���� ������ ���� �ð��� �������� �����ϴ�.
	UPDATE	GOODS_POPULAR
	SET		GP_SUM_POINT = P_WEIGHT 
	FROM	GOODS_POPULAR A
				INNER JOIN
			GOODS_POPULAR_WEIGHT_SPONSOR  B
				ON A.GP_MODELNO = B.G_MODELNO
	WHERE	USE_FLAG = 1 
	AND		SDATE <= CAST(CONVERT(VARCHAR(10), GETDATE(), 120) AS SMALLDATETIME)
	AND		EDATE+1 >= CAST(CONVERT(VARCHAR(10), GETDATE(), 120) AS SMALLDATETIME)

	-- �߰���ǰ ������ ó�� ������ ���� ���� �ٸ� �𵨹�ȣ�� ����� ��� 
	-- �α⵵�� �ֹ����� �����ش�. 
	-- 2013.08.12
	-- http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=411285
	-- http://jca.enuri.com/board/redirect.asp?bt=1&bn=509&cn=419955 
	--http://58.234.199.100/redmine/issues/2492
/*
	declare @sp_sum_point int
	declare @sp_oda_vcnt int
	select @sp_sum_point = sum(gp_sum_point), @sp_oda_vcnt = sum(gp_oda_vcnt) from GOODS_POPULAR 
	where gp_modelno in (11397242, 11649863)

--	select @sp_sum_point, @sp_oda_vcnt
	update GOODS_POPULAR 
	set gp_sum_point = @sp_sum_point
	,	gp_oda_vcnt  = @sp_oda_vcnt
	where gp_modelno in (11397242, 11649863)
*/

	-- -�α⵵ 0��ó��
	update goods_popular set gp_sum_point=0 from goods_popular where gp_sum_point < 0
insert tbl_popular_acc_step_log(step) values('������ ����_e')



insert tbl_popular_acc_step_log(step) values('���ֹ� ����_s')

	-- �ƽ��� �����ֹ����� �����ֹ����� ����
	-- 2008.03.17 wookki25 ��â�ƾ� ��û
	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA
			WHERE	PL_MODELNO > 0 
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY) AND
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
				AND	SHOP_VCODE = 1506
				and OD_CATEGORY like '0401%'
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO


	-- �˽����� ��ž ī�װ� �����ֹ����� �����ֹ����� ����
	select distinct pl_modelno as modelno into #tbl_948_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 948 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_948_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0 
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO


	-- ������ǻ�� �����ֹ����� �����ֹ����� ����
	select distinct pl_modelno as modelno into #tbl_6174_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 6174 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_6174_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO



	-- ���ǵ��� �����ֹ����� �����ֹ����� ����
	select distinct pl_modelno as modelno into #tbl_6534_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 6534 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_6534_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO

	-- �����Ǿ� �����ֹ����� �����ֹ����� ����
	select distinct pl_modelno as modelno into #tbl_7653_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 7653 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_7653_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO


	-- �ؽ��Ǿ� �����ֹ����� �����ֹ����� ����
	select distinct pl_modelno as modelno into #tbl_7644_goods 
	from ELOC188.eloc2001.dbo.pricelist 
	where pl_vcode = 7644 and pl_modelno>0 and pl_category like '0401%'

	UPDATE	goods_popular
	SET		gp_oda_vcnt = ORD.OD_CNT
	FROM	goods_popular
				INNER JOIN 
			(
			SELECT	PL_MODELNO, SUM(OD_CNT) AS OD_CNT
			FROM	TBL_ORDERDATA inner join #tbl_7644_goods on modelno = pl_modelno
			WHERE	PL_MODELNO > 0
			--		OD_DATE >= DATEADD(MM, -1, DATEADD(D, -5, @DTECHKDAY)) AND
			--		OD_DATE < DATEADD(D, -5, @DTECHKDAY)
				AND OD_DATE >= DATEADD(MM, -3, @DTECHKDAY)+1
				AND OD_DATE < DATEADD(D, 1, @DTECHKDAY)
			GROUP BY PL_MODELNO
			) ORD
				ON gp_modelno = PL_MODELNO
	

insert tbl_popular_acc_step_log(step) values('���ֹ� ����_e')


-- ���� ���� ó��  // 2016.05.18
update GOODS_POPULAR 
set gp_sum_point = 0
where gp_factory ='����'



END