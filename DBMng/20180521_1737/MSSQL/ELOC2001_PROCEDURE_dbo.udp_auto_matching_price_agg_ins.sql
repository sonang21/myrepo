/* *************************************************************************
 * NAME : dbo.udp_auto_matching_price_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-25 14:15:05.473
 *        Modify: 2018-05-03 17:23:34.223
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE  PROC udp_auto_matching_price_agg_ins
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-07-25
	-- ��  �� : pricelist ���ϻ�ǰ��  �Ϻ� ��� ����
	--			ó���׷쿩��   : �׷쳻�� �ִ� ��ǰ�� �ѻ�ǰ�̶� ó�� �Ǵ� ������ �׷��� ��
	--			��ó���׷쿩�� : �׷쳻�� �ִ� ��� ��ǰ�� ��ó���� ��� �׷��� ��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	-- ���賻���� �̹� �ִ� ��� ���� �����Ѵ�.
	-- delete from tbl_auto_matching_price_agg
	-- where aggdate>= cast(convert(varchar(10), getdate()-1, 120) as smalldatetime)
	-- and aggdate <  cast(convert(varchar(10), getdate(), 120) as smalldatetime)


	insert into tbl_auto_matching_price_agg
	select cast(convert(varchar(10), getdate()-1, 120) as smalldatetime)
	,	mcate
	,	sum([�׷캰_�Ѱ���])
	,	sum([�׷캰_���߰�_��_ó��_����])
	,	sum([�׷캰_��ȣ��Ī_�ڵ���Ī_����])
	,	sum([�׷캰_��ȣ��Ī_���۾�_����])
	,	sum([�׷캰_��ó��_����])
	,	sum([��ǰ��_�ѻ�ǰ��])
	,	sum([��ǰ��_���߰�_��_ó��_����])
	,	sum([��ǰ��_��ȣ��Ī_�ڵ���Ī_����])
	,	sum([��ǰ��_��ȣ��Ī_���۾�_����])
	,	sum([��ǰ��_��ó��_����])

	,	sum(sign([��ǰ��_�ѻ�ǰ��_����������]))
	,	sum([��ǰ��_�ѻ�ǰ��_����������])

	,	sum(sign([��ǰ��_��ȣ��Ī_���۾�_����������]))
	,	sum([��ǰ��_��ȣ��Ī_���۾�_����������])
	,	min(s_regdate)
	,	max(e_regdate)		
	from
	(
		select	pl_no2,	left(max(model_ca_code),4) as mcate
				,	[�׷캰_�Ѱ���] =  1
				,	[�׷캰_���߰�_��_ó��_����] = (case when max(job_flag) = '3' then 1 else 0 end)
				,	[�׷캰_��ȣ��Ī_�ڵ���Ī_����] = (case when max(job_flag) = '6' then 1 else 0 end)
				,	[�׷캰_��ȣ��Ī_���۾�_����] = (case when max(job_flag) = '4' then 1 else 0 end)
				,	[�׷캰_��ó��_����] = (case when max(job_flag) = '0' then 1 else 0 end)

				-- ��ǰ�� ����
				,	[��ǰ��_�ѻ�ǰ��] = count(*)
				,	[��ǰ��_���߰�_��_ó��_����] = sum(case when job_flag = '3' then 1 else 0 end)
				,	[��ǰ��_��ȣ��Ī_�ڵ���Ī_����] = sum(case when job_flag = '6' then 1 else 0 end)
				,	[��ǰ��_��ȣ��Ī_���۾�_����] = sum(case when job_flag = '4' then 1 else 0 end)
				,	[��ǰ��_��ó��_����] = sum(case when job_flag in( '0', '1' ) then 1 else 0 end)

				-- ��ǰ�� ������ ����
				,	[��ǰ��_�ѻ�ǰ��_����������] = sum(case when price <= minprice then 1 else 0 end)
				,	[��ǰ��_��ȣ��Ī_���۾�_����������] = sum(case when job_flag = '4' and  price <= minprice then 1 else 0 end)

				,	min(regdate) s_regdate
				,	max(regdate) e_regdate
		from tbl_auto_matching_price
		group by	pl_no2
	) a
	group by mcate
	option (maxdop 1)


	if @@rowcount>0  begin
		-- �ֱ� 6���� ������ �����Ѵ�.
		delete from tbl_auto_matching_price_agg 
		where aggdate < cast(convert(char(8), dateadd(m, -6, getdate()),112) as smalldatetime)
	end

	delete from tbl_auto_matching_price_back where regdate<getdate()-7
	
	insert into tbl_auto_matching_price_back(pl_no,price,goodsnm,ca_code,modelno,pl_no2,minprice,regdate,job_flag)
	select pl_no,price,goodsnm,ca_code,modelno,pl_no2,minprice,regdate,job_flag from tbl_auto_matching_price


