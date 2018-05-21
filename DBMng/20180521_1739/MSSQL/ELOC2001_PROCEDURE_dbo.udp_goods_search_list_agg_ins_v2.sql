/* *************************************************************************
 * NAME : dbo.udp_goods_search_list_agg_ins_v2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-02-28 14:51:11.47
 *        Modify: 2018-05-03 17:23:34.71
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE PROC udp_goods_search_list_agg_ins_v2
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2012-02-28
	-- ��  �� : pricelist ��ǰ��Ī �Ϻ� ��� ����
	--			ó���׷쿩��   : �׷쳻�� �ִ� ��ǰ�� �ѻ�ǰ�̶� ó�� �Ǵ� ������ �׷��� ��
	--			��ó���׷쿩�� : �׷쳻�� �ִ� ��� ��ǰ�� ��ó���� ��� �׷��� ��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2012.08.30		wookki25		����Ʈ����ó�� ��ǰ ��� : �����ڰ� ����Ű���忡 �Է��ϱ����� // ���쿵 ��û
	2013.06.27		wookki25		�����ǰ_�ڵ�_��Ī_�׷� �߰�
	2014.10.21		wookki25		����ð�  pm 11:50 --> pm 06:00
									�ֱ� 7�� ������ ���� --> truncate table tbl_goods_search_list
	*/


	-- ���� ����(12:00) ���� ����ǰ�, ���� ������ ��ϵƴ� �����ʹ� ����.
	-- (= ���� ���迡 ���Եǰ� ������ ������)
	delete from tbl_goods_search_list_daily_back 
	where regdate < cast(convert(varchar(10), getdate(), 120) as datetime)
	and delete_date < dateadd(hh, 12, cast(convert(varchar(10), getdate(), 120) as datetime))


	-- ���賻���� �̹� �ִ� ��� ���� �����Ѵ�.
	delete from tbl_goods_search_list_agg_v2
	where agg_date>= cast(convert(varchar(10), getdate(), 120) as smalldatetime)
	and agg_date <  cast(convert(varchar(10), getdate()+1, 120) as smalldatetime)

	-- ������ ���� : ���� �����ִ� ������ +  ������ ������
	--drop table tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
	if object_id('tmp_worker_1_in_udp_goods_search_list_agg_ins_v2') is not null begin
		drop table tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
	end
	select * into tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
	from 
	(
		-- ������ �ð�(hh:mm)���� ������ ������ �׷���(tmp_group)
		select shop_code, pl_no, ca_mcode, pl_no_group, job_flag, regdate, ca_code, modelno, model_ca_code, order_by, convert(varchar(5), getdate(), 108) tmp_group , goodsnm, goodscode, price, minprice, store_flag
		from tbl_goods_search_list
		union all
		select shop_code, pl_no, ca_mcode, pl_no_group, job_flag, regdate, ca_code, modelno, model_ca_code, order_by, convert(varchar(5), delete_date, 108) tmp_group, goodsnm, goodscode, price, minprice, store_flag
		from tbl_goods_search_list_daily_back
		where delete_date >= cast(convert(char(10), getdate(), 120)  as smalldatetime)
	) all_day_data


	-- �ӽ�
--	if getdate() < cast( '2013-02-19' as datetime) begin
--		select * into tmp_20130218_wookki25_�׷��Ī_���_����͸�_23�� from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
--	end


	-- ������ ���� : mp���� ������ �ʰ� ó���� ��ǰ ����ó�� //mp���� �׷��ǰ ������ ��ǰ ����ó�� // �׷캰�� ��ǰ�� 1��
	delete a
	from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 a 
			inner join 
	(
		select tmp_group, ca_mcode, pl_no_group 
		from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 
		group by tmp_group, ca_mcode, pl_no_group
		having count(*)=1
	)  b
		on a.tmp_group = b.tmp_group and a.ca_mcode = b.ca_mcode and a.pl_no_group = b.pl_no_group 

	-- �ߺ����� : ������ �׷쿡 ������ pl_no�� ���� Ÿ�ӿ� �־��ٸ� ���� Ÿ�ӿ� �ִ� ������ ����.
	delete a 
	--select a.pl_no, b.pl_no 
	from	tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 a 
				inner join 
			tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 b 
				on a.pl_no_group = b.pl_no_group and a.pl_no = b.pl_no
	where a.regdate < b.regdate


	-- �з��� ���� ����Ʈ���� ó�� ������ ��� : 2012.08.30	-- �ָ�����..�ֱ� ����	insert into tbl_goods_search_list_except_list
	select ca_mcode, goodsnm, goodscode, getdate(), shop_code, a.pl_no
	from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2 a inner join pricelist b on a.pl_no = b.pl_no 
	where job_flag = '2' and pl_modelno = 0 -- ����Ʈ���� // 2012.09.25 // pl_modelno = 0�� �����ͷ� ���� // ���쿵

	-- �׷찳��
	insert into tbl_goods_search_list_agg_v2
	(	category
		,g_raw_t_cnt,g_raw_vm_cnt,g_raw_vm_min_cnt,g_raw_nm_cnt
--		,g_nwork_t_cnt,g_nwork_vm_cnt,g_nwork_nm_cnt
		,g_work_t_cnt,g_work_mm_cnt,g_work_mm_min_cnt,g_work_wm_cnt,g_work_etc_cnt


		,p_raw_t_cnt,p_raw_vm_cnt,p_raw_vm_min_cnt,p_raw_nm_cnt
--		,p_nwork_t_cnt,p_nwork_vm_cnt,p_nwork_nm_cnt
		,p_work_t_cnt,p_work_mm_cnt,p_work_mm_min_cnt,p_work_wm_cnt,p_work_etc_cnt

		,agg_date

		,g_work_auto_cnt,p_work_auto_cnt
		,g_raw_multi_cnt
		--,g_nwork_multi_cnt
		,g_work_multi_cnt,p_raw_multi_cnt
		--,p_nwork_multi_cnt
		,p_work_multi_cnt
		,g_work_auto_m_cnt,p_work_auto_m_cnt
		
		-- ��ȭ��
		,p_raw_s_t_cnt,p_raw_s_vm_cnt,p_raw_s_vm_min_cnt,p_raw_s_nm_cnt
		,p_work_s_t_cnt,p_work_s_mm_cnt,p_work_s_mm_min_cnt,p_work_s_wm_cnt,p_work_s_etc_cnt

		,p_work_s_auto_cnt,p_raw_s_multi_cnt, p_work_s_multi_cnt,p_work_s_auto_m_cnt
	)
	select	[�ߺз��ڵ�] = mcate
	-- �׷캰 ����
		-- �ѱ׷� : �����Ī ������ ����
		,	[����] = count(*)															-- �ѱ׷�_�� ����
		,	[��Ī] = sum(sign([��ǰ��_�����Ī_����]))									-- �ѱ׷�_�����Ī �׷� ����	// �����Ī�� ��ǰ�� 1���� �׷쿡 ������ [��Ī]�� ī����
		,	[��Ī_����] = sum(sign([��ǰ��_�����Ī_����_����������]))						-- �ѱ׷�_�����Ī �׷� ������ ������ �ִ� �׷��	// �����Ī�� ��ǰ�� 1���� �׷쿡 ������ [��Ī]�� ī����
		,	[�߰�] = count(*) - sum(sign([��ǰ��_�����Ī_����])) - sum(sign(��ǰ��_���߸�Ī_����)) -- �ѱ׷�_����̸�Ī �׷� ����	// �׿ܴ� [�߰�]�� ī����

		-- ��ó���׷� : �����Ī ������ ����
/*
		,	[����] = sum([�׷캰_��ó��_����])+sum([�׷캰_���߸�Ī_��ó��_����] * sign([��ǰ��_���߸�Ī_����]))															-- ��ó�� �׷캰_�� ����
		,	[��Ī] = sum([�׷캰_��ó��_����] * sign([��ǰ��_�����Ī_����]))							-- ��ó�� �׷캰_�����Ī �׷� ����
		,	[�߰�] = sum([�׷캰_��ó��_����]) - sum([�׷캰_��ó��_����]*sign([��ǰ��_�����Ī_����]))	-- ��ó�� �׷캰_����̸�Ī �׷� ����
*/

		-- ó���׷� : ��ȣ�۾� ������ ���� , �����Ī ������ ����.
		,	[����] = sum([�׷캰_ó��_����])+sum([�׷캰_���߸�Ī_��ȣ���۾�_ó��_����])-- ó���׷�_�� ����
		,	[��Ī] = sum([�׷캰_��ȣ���۾�_ó��_����])									-- ó���׷�_���� ��ǰ ��ȣ�۾��� �׷� ����\
		,	[��Ī_����] = sum(sign([�׷캰_��ȣ���۾�_ó��_����_����������]))						-- �ѱ׷�_�����Ī �׷� ������ ������ �ִ� �׷��	// �����Ī�� ��ǰ�� 1���� �׷쿡 ������ [��Ī]�� ī����
		,	[�߰�] = sum([�׷캰_����ǰ�߰�_ó��_����])									-- ó���׷�_����ǰ�߰� �� ��ȣ�۾��� �׷� ����
		,	[��Ÿ] = sum([�׷캰_��ȣ�۾���_ó��_����]+[�׷캰_����Ʈ����_ó��_����])	-- ó���׷�_��ȣ�۾��� �׷� ���� + ����Ʈ���� �׷� ����

	-- ��ǰ�� ����
		-- �ѻ�ǰ
		,	[����] = sum([��ǰ��_�ѻ�ǰ��])+sum([��ǰ��_���߸�Ī_�ѻ�ǰ��])
		,	[��Ī] = sum([��ǰ��_�����Ī_����])
		,	[��Ī_����] = sum([��ǰ��_�����Ī_����_����������])
		,	[�߰�] = sum([��ǰ��_�ѻ�ǰ��]) - sum([��ǰ��_�����Ī_����]) -- �߰� = ���� - ��Ī

		-- ��ó�� ��ǰ
/*
		,	[����] = sum([��ǰ��_��ó��_����]) + sum([��ǰ��_���߸�Ī_��ó��_����])
		,	[��Ī] = sum([��ǰ��_��ó��_�����Ī_����])
		,	[�߰�] = sum([��ǰ��_��ó��_����]) - sum([��ǰ��_��ó��_�����Ī_����]) -- �߰� = ���� - ��Ī
*/
		-- ó����ǰ
		,	[����] = sum([��ǰ��_ó��_����])+sum([��ǰ��_���߸�Ī_ó��_����])	
		,	[��Ī] = sum([��ǰ��_��ȣ���۾�_ó��_����])		
		,	[��Ī_����] = sum([��ǰ��_��ȣ���۾�_ó��_����_����������])		
		,	[�߰�] = sum([��ǰ��_����ǰ�߰�_ó��_����])
		,	[��Ÿ] = sum([��ǰ��_��ȣ�۾���_ó��_����]+[��ǰ��_����Ʈ����_ó��_����])

	
	-- ������
		,	[������] = getdate()

	-- �����ǰ �� �߰��� �ڵ� ��Ī ó������
		,	[�����ǰ_�߰���_�ڵ�_��Ī_�׷�] = sum([�׷캰_��ȣ�����ǰ_ó��_����])
		,	[�����ǰ_�߰���_�ڵ�_��Ī_��ǰ] = sum([��ǰ��_��ȣ�����ǰ_ó��_����])

	-- ���߸�Ī
		,	[���߸�Ī_�ѱ׷�]= sum(sign(��ǰ��_���߸�Ī_����))
/*
		,	[���߸�Ī_��ó���׷�] = sum([�׷캰_���߸�Ī_��ó��_����] * sign([��ǰ��_���߸�Ī_����]))
*/

		,	[���߸�Ī_ó���׷�] = sum([�׷캰_���߸�Ī_��ȣ���۾�_ó��_����])
		,	[���߸�Ī_�ѻ�ǰ] = sum([��ǰ��_���߸�Ī_�ѻ�ǰ��])
/*
		,	[���߸�Ī_��ó����ǰ] =  sum([��ǰ��_���߸�Ī_��ó��_����])
*/
		,	[���߸�Ī_ó����ǰ] = sum([��ǰ��_���߸�Ī_ó��_����])

	-- �����ǰ �̹� �����ϴ� �𵨿� ��Ī ó������
		,	[�����ǰ_�ڵ�_��Ī_�׷�] = sum([�׷캰_��ȣ�����ǰ_�ڵ���Ī_ó��_����])
		,	[�����ǰ_�ڵ�_��Ī_��ǰ] = sum([��ǰ��_��ȣ�����ǰ_�ڵ���Ī_ó��_����])


		-- �ѻ�ǰ(��ȭ��)
		,	[����_��ȭ��] = sum([��ǰ��_�ѻ�ǰ��_��ȭ��])+sum([��ǰ��_���߸�Ī_�ѻ�ǰ��_��ȭ��])
		,	[��Ī_��ȭ��] = sum([��ǰ��_�����Ī_����_��ȭ��])
		,	[��Ī_����_��ȭ��_��ȭ��] = sum([��ǰ��_�����Ī_����_����������_��ȭ��])
		,	[�߰�_��ȭ��] = sum([��ǰ��_�ѻ�ǰ��_��ȭ��]) - sum([��ǰ��_�����Ī_����_��ȭ��]) -- �߰� = ���� - ��Ī


		,	[����_��ȭ��] = sum([��ǰ��_ó��_����_��ȭ��])+sum([��ǰ��_���߸�Ī_ó��_����_��ȭ��])	
		,	[��Ī_��ȭ��] = sum([��ǰ��_��ȣ���۾�_ó��_����_��ȭ��])		
		,	[��Ī_����_��ȭ��] = sum([��ǰ��_��ȣ���۾�_ó��_����_����������_��ȭ��])		
		,	[�߰�_��ȭ��] = sum([��ǰ��_����ǰ�߰�_ó��_����_��ȭ��])
		,	[��Ÿ_��ȭ��] = sum([��ǰ��_��ȣ�۾���_ó��_����_��ȭ��]+[��ǰ��_����Ʈ����_ó��_����_��ȭ��])


		,	[�����ǰ_�߰���_�ڵ�_��Ī_��ǰ_��ȭ��] = sum([��ǰ��_��ȣ�����ǰ_ó��_����_��ȭ��])
		,	[���߸�Ī_�ѻ�ǰ_��ȭ��] = sum([��ǰ��_���߸�Ī_�ѻ�ǰ��_��ȭ��])
		,	[���߸�Ī_ó����ǰ_��ȭ��] = sum([��ǰ��_���߸�Ī_ó��_����_��ȭ��])
		,	[�����ǰ_�ڵ�_��Ī_��ǰ_��ȭ��] = sum([��ǰ��_��ȣ�����ǰ_�ڵ���Ī_ó��_����_��ȭ��])


	from
	(
			select	pl_no_group,	max(ca_mcode) as mcate
			-- �׷캰 ����
			--,	[�׷캰_�����Ī_����] = sign([��ǰ��_�����Ī_����]) = (case when max(modelno) > 0 and patindex(max(ca_mcode)+'%', max(model_ca_code))=1 then 1 else 0 end)
			--,	[�׷캰_��ó��_����] = (case when max(job_flag) = '0' then 1 else 0 end)
			,	[�׷캰_ó��_����] = (case when max(job_flag) <> '0' then 1 else 0 end)
			,	[�׷캰_��ȣ�۾���_ó��_����] = (case when max(job_flag) in ('1', '2') and sum(case when job_flag = '1' then 1 else 0 end) >= 1 then 1 else 0 end)	-- ��ȣ��Ī �̿� pricelist ����
			,	[�׷캰_����Ʈ����_ó��_����] = (case when max(job_flag) = '2' and sum(case when job_flag = '1' then 1 else 0 end) = 0 then 1 else 0 end)		-- ����Ʈ����
			,	[�׷캰_����ǰ�߰�_ó��_����] = (case when max(job_flag) = '3' then 1 else 0 end)								-- ����ǰ �߰� �� pricelist ��ȣ��Ī

			,	[�׷캰_��ȣ���۾�_ó��_����] = (case when max(job_flag) = '4' then 1 else 0 end)								-- ������ǰ pricelist ��ȣ��Ī
			,	[�׷캰_��ȣ���۾�_ó��_����_����������] = (case when max(job_flag) = '4' and min(price) <= min(minprice) then 1 else 0 end)								-- ������ǰ pricelist ��ȣ��Ī

			,	[�׷캰_��ȣ�����ǰ_ó��_����] = (case when max(job_flag) = '5' then 1 else 0 end)								-- �����ǰ �� �߰��� �ڵ� ��Ī ó������
			,	[�׷캰_��ȣ�����ǰ_�ڵ���Ī_ó��_����] = (case when max(job_flag) = '6' then 1 else 0 end)					-- �����ǰ �̹� �����ϴ� �𵨿� ��Ī ó������

			

			-- ��ǰ�� ����
			,	[��ǰ��_�ѻ�ǰ��] = count(*)

			,	[��ǰ��_�����Ī_����] = sum(case when modelno > 0 then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
			,	[��ǰ��_�����Ī_����_����������] = sum(case when modelno > 0 and price <= minprice then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1

			--,	[��ǰ��_��ó��_����] = sum(case when job_flag = '0' then 1 else 0 end)

/*
			,	[��ǰ��_��ó��_�����Ī_����] = sum(case when job_flag = '0' and modelno > 0 then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
*/			


			,	[��ǰ��_ó��_����] = sum(case when job_flag <> '0' then 1 else 0 end)
			,	[��ǰ��_��ȣ�۾���_ó��_����] = sum(case when job_flag = '1' then 1 else 0 end)
			,	[��ǰ��_����Ʈ����_ó��_����] = sum(case when job_flag = '2' then 1 else 0 end)
			,	[��ǰ��_����ǰ�߰�_ó��_����] = sum(case when job_flag = '3' then 1 else 0 end)

			,	[��ǰ��_��ȣ���۾�_ó��_����] = sum(case when job_flag = '4' then 1 else 0 end)
			,	[��ǰ��_��ȣ���۾�_ó��_����_����������] = sum(case when job_flag = '4' and price <= minprice then 1 else 0 end)

			,	[��ǰ��_��ȣ�����ǰ_ó��_����] = sum(case when job_flag = '5' then 1 else 0 end)
			,	[��ǰ��_��ȣ�����ǰ_�ڵ���Ī_ó��_����] = sum(case when job_flag = '6' then 1 else 0 end)
/*
			,	[�׷캰_���߸�Ī_��ó��_����] =0
*/
			,	[�׷캰_���߸�Ī_��ȣ���۾�_ó��_����] = 0
			,	[��ǰ��_���߸�Ī_�ѻ�ǰ��] =0
			,	[��ǰ��_���߸�Ī_����] = 0
			
/*
			,	[��ǰ��_���߸�Ī_��ó��_����] = 0
*/
			,	[��ǰ��_���߸�Ī_ó��_����] = 0

			-- ��ȭ�� ��ǰ�� ����
			,	[��ǰ��_�ѻ�ǰ��_��ȭ��] = sum(case when store_flag='1' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_�����Ī_����_��ȭ��] = sum(case when modelno > 0 and store_flag='1' then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
			,	[��ǰ��_�����Ī_����_����������_��ȭ��] = sum(case when modelno > 0 and price <= minprice and store_flag='1' then 1 else 0 end) --and patindex(ca_mcode+'%', model_ca_code)=1
			,	[��ǰ��_ó��_����_��ȭ��] = sum(case when job_flag <> '0' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_��ȣ�۾���_ó��_����_��ȭ��] = sum(case when job_flag = '1' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_����Ʈ����_ó��_����_��ȭ��] = sum(case when job_flag = '2' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_����ǰ�߰�_ó��_����_��ȭ��] = sum(case when job_flag = '3' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_��ȣ���۾�_ó��_����_��ȭ��] = sum(case when job_flag = '4' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_��ȣ���۾�_ó��_����_����������_��ȭ��] = sum(case when job_flag = '4' and price <= minprice and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_��ȣ�����ǰ_ó��_����_��ȭ��] = sum(case when job_flag = '5' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_��ȣ�����ǰ_�ڵ���Ī_ó��_����_��ȭ��] = sum(case when job_flag = '6' and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_���߸�Ī_�ѻ�ǰ��_��ȭ��] =0
			,	[��ǰ��_���߸�Ī_����_��ȭ��] = 0
			,	[��ǰ��_���߸�Ī_ó��_����_��ȭ��] = 0



			from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
			where modelno <> -1 -- ���߸�Ī ����
			group by	tmp_group, pl_no_group

			union all

			-- ���߸�Ī ���� ó��
			select	pl_no_group,	max(ca_mcode) as mcate
			,0,0,0,0,0,0,0,0,0,0
			,0,0,0,0,0,0,0,0,0
			-- �׷캰 ����
/*
			,	[�׷캰_���߸�Ī_��ó��_����] = (case when max(job_flag) = '0' then 1 else 0 end)
*/
			,	[�׷캰_���߸�Ī_��ȣ���۾�_ó��_����] = (case when max(job_flag) = '4' then 1 else 0 end)
			,	[��ǰ��_���߸�Ī_�ѻ�ǰ��] = count(*)
			,	[��ǰ��_���߸�Ī_����] = sum(case when modelno = -1 then 1 else 0 end)
/*
			,	[��ǰ��_���߸�Ī_��ó��_����] = sum(case when job_flag = '0' then 1 else 0 end)
*/
			,	[��ǰ��_���߸�Ī_ó��_����] = sum(case when job_flag <> '0' then 1 else 0 end)

			-- ��ȭ��
			,	0,0,0,0,0,0,0,0,0,0,0
			,	[��ǰ��_���߸�Ī_�ѻ�ǰ��_��ȭ��] = sum(case when store_flag='1' then 1 else 0 end)
			,	[��ǰ��_���߸�Ī_����_��ȭ��] = sum(case when modelno = -1 and store_flag='1' then 1 else 0 end)
			,	[��ǰ��_���߸�Ī_ó��_����_��ȭ��] = sum(case when job_flag <> '0' and store_flag='1' then 1 else 0 end)
			from tmp_worker_1_in_udp_goods_search_list_agg_ins_v2
			where modelno = -1
			group by	tmp_group, pl_no_group


	) aa
	group by	mcate
	option (maxdop 1)

	
	if @@rowcount>0  begin
		-- �ֱ� 10�ϰ��� ������ �����Ѵ�.
		delete from tbl_goods_search_list_agg_v2 
		where agg_date < cast(convert(char(8), dateadd(dd, -9, getdate()),112) as smalldatetime)

		-- �ֱ� 10�ϰ��� ������ �����Ѵ�.
		delete from tbl_goods_search_list_except_list
		where agg_date < cast(convert(char(8), dateadd(dd, -9, getdate()),112) as smalldatetime)

		-- ������ 1��ġ ��� : ���� Ȯ�ο�
		-- ���� Ȯ�� �Ŀ��� ������ ����.. 2014.11.05
		if object_id('tbl_goods_search_list_bak_1day') is not null begin
			drop table tbl_goods_search_list_bak_1day
		end
		select * into tbl_goods_search_list_bak_1day  from tbl_goods_search_list


		-- tbl_goods_search_list truncate ó��
		truncate table tbl_goods_search_list
	end
	
	-- ��Ŀ���̺� ����
	drop table tmp_worker_1_in_udp_goods_search_list_agg_ins_v2

