/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step1_raw_g0
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-14 17:03:30.74
 *        Modify: 2018-05-03 17:23:35.097
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_step1_raw_g0
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015-01-06
	-- ��  �� : ����͸� ������ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2015.03.23		wookki25		�𵨹�ȣ����, ������ 10% ����, �̻� ����ó��
	2015.12.04		wookki25		18, 19 ������ 50%�̸�, ������ 50~70%�̸� ����
	2016.08.17		wookki25		����1�� ����͸� ������� ó��
	*/
insert into tbl_monitoring_target_run_log(run_step) select '1-s'

	-- ���� ���̺�� ����
	if object_id('tbl_monitoring_target_raw_old_g0') is not null begin
		drop table tbl_monitoring_target_raw_old_g0		
	end

	if object_id('tbl_monitoring_target_raw_new_g0') is not null begin
		exec sp_rename tbl_monitoring_target_raw_new_g0, tbl_monitoring_target_raw_old_g0

		-- ùŸ���� ���ϰ� ������ �ʴ´�.
		if (select top 1 datediff(d, getdate(), regdate) from tbl_monitoring_target_raw_old_g0) < 0 begin
			truncate table tbl_monitoring_target_raw_old_g0
		end
	end

	

insert into tbl_monitoring_target_run_log(run_step) select '2-s'

	set datefirst 1 -- �������� �����Ϻ��� �����ϵ���

	declare @s_rank smallint
	declare @e_rank smallint
	select top 1 @s_rank=s_popular_rank, @e_rank=e_popular_rank from tbl_mc_schedule where group_no = datepart(dw, cast( getdate() as date))

	-- ����͸� ���� ���� �ð� ������Ʈ : ���� �ݿ��� �ּ� Ǯ��� ��!
	update tbl_mc_manager_set set work_start = getdate(), work_end = null, start = null

	-- �ߺз��� n�� ��
	if object_id('tmp_worker_p_goods') is not null begin		
		drop table tmp_worker_p_goods
	end
	select modelno into tmp_worker_p_goods from tbl_mcate_popular_rank where mcate_group_rank between @s_rank and @e_rank

	-- ����1�� ����͸� ������� ó�� : http://58.234.199.100/redmine/issues/17499
	delete a from tmp_worker_p_goods a inner join goods b on a.modelno = b.g_modelno where g_constrain <> '1'



insert into tbl_monitoring_target_run_log(run_step) select '3-s'


	-- ���� ������
	select pl_no, pl_vcode, pl_modelno, pl_category, pl_price, pl_deliveryinfo, pl_status, pl_call_plan, pl_tag_price --pl_price_card, 
	, pl_goodsnm
	, cast('' as nvarchar(200)) pl_goodsnm_old
	, cast(0 as smallint) comp_order	-- ������� �� �켱����
	, cast(0 as smallint) chg_type		-- ������� ����
	, cast('' as nvarchar(70)) as g_modelnm
	, cast('' as char(8)) as g_category
	, getdate() as regdate
	, cast('' as nvarchar(200)) pl_goodsnm_regexp		-- ���Խ� ���� �� ���� ��ǰ��
	, cast('' as nvarchar(200)) pl_goodsnm_old_regexp	-- ���Խ� ���� �� ���� ��ǰ��
	, cast(0 as smallint) comp_order2	-- ������� �� �켱���� : �𵨸� ������ ��츸 2��°
	, cast(0 as smallint) chg_type2		-- ������� ���� : �𵨸� ������ ��츸 2��°
	, cast(0 as bit) is_strangelist		-- strangelist  �Է¿��� : 0 - �Է����� ����, 1 - �Է���
	, getdate() today_first_date			-- ���� ���� �߰���
	into tbl_monitoring_target_raw_new_g0
	from pricelist  with (readuncommitted) inner join tmp_worker_p_goods on pl_modelno = modelno
	where pl_modelno>0 and pl_status in ('0','1','2','8') and pl_srvflag in ('0','r','l','b','s') and option_flag2 ='0' 
	option (maxdop 1)

insert into tbl_monitoring_target_run_log(run_step) select '4-s'

	create nonclustered index ncl_monitoring_target_raw on tbl_monitoring_target_raw_new_g0(pl_no, pl_goodsnm)

insert into tbl_monitoring_target_run_log(run_step) select '5-s'

	-- ��ǰ�� ����.�ϰ� ���� ó��
	update b --tbl_monitoring_target_raw_new_g0
	set pl_goodsnm_regexp =		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(b.pl_goodsnm, '\[[^\]]+(����|ī��|������|������|��ȭ��)[^\]]*\]', '', 1) 
						, ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'��',''),'=',''),',',''),'...','')
	,	pl_goodsnm_old_regexp = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(a.pl_goodsnm, '\[[^\]]+(����|ī��|������|������|��ȭ��)[^\]]*\]'
				, '', 1), ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'��',''),'=',''),',',''),'...','')

	,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old_g0 a inner join tbl_monitoring_target_raw_new_g0 b on a.pl_no = b.pl_no
	where a.pl_goodsnm <> b.pl_goodsnm
	option (maxdop 1) 	
	

insert into tbl_monitoring_target_run_log(run_step) select '6-s'
	
	-- ���汸��.��ü
	-- select * from tbl_monitoring_team_agg_name where is_use = 1
	update b --tbl_monitoring_target_raw_new_g0
	set b.chg_type = 
		case 
			when b.pl_goodsnm_regexp <> b.pl_goodsnm_old_regexp 
				and  charindex(b.pl_goodsnm_regexp, b.pl_goodsnm_old_regexp) = 0
				and  charindex(b.pl_goodsnm_old_regexp, b.pl_goodsnm_regexp) = 0
				and  left(b.pl_goodsnm_old_regexp, 17) <> LEFT(b.pl_goodsnm_regexp, 17) -- 2017.05.31 // ��û:�̰汹
					then 1 -- ��ǰ�� ����
			when a.pl_status <> b.pl_status and b.pl_status='8' 
					then 8 -- ������ �α�
			--when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) 
			--		then 18 -- ������ 50%�̸�
			--when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 
			--		then 19 -- ������ 50~70%�̸�
			--when a.pl_deliveryinfo <> b.pl_deliveryinfo 
			--		then 14 -- ��ۺ� ����
			else 0
		end
	from tbl_monitoring_target_raw_old_g0 a inner join tbl_monitoring_target_raw_new_g0 b on a.pl_no = b.pl_no
	option (maxdop 1) 	

insert into tbl_monitoring_target_run_log(run_step) select '7-s'

	-- �ε��� ����
	create nonclustered index ncl_chg_type on tbl_monitoring_target_raw_new_g0(chg_type, pl_vcode)
	

insert into tbl_monitoring_target_run_log(run_step) select '8-s'

	--���汸��.��ǰ�� ���� �������� ��� �켱 ���� 2�ܰ� (comp_order2) ����
	update b --tbl_monitoring_target_raw_new_g0
	set b.chg_type2 = 
		case when a.pl_status <> b.pl_status and b.pl_status='8' 
					then 8 -- ������ �α�
			--when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) 
			--		then 18 -- ������ 50%�̸�
			--when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 
			--		then 19 -- ������ 50~70%�̸�
			--when a.pl_deliveryinfo <> b.pl_deliveryinfo 
			--		then 14 -- ��ۺ� ����
			else 0
		end
	from tbl_monitoring_target_raw_old_g0 a inner join tbl_monitoring_target_raw_new_g0 b on a.pl_no = b.pl_no
	where b.chg_type = 1 -- ��ǰ�� ������ ���
	option (maxdop 1) 	


	-- new mc���� �ʿ��� goods ������ �Է�
	update a 
	set g_modelnm = b.g_modelnm
	,	g_category = b.g_category
	from tbl_monitoring_target_raw_new_g0 a inner join goods b on a.pl_modelno = b.g_modelno
	where chg_type = 1 -- ��ǰ�� ������ ���


insert into tbl_monitoring_target_run_log(run_step) select '9-s'


	update a set a.comp_order = b.comp_order 	from tbl_monitoring_target_raw_new_g0 a inner join tbl_monitoring_team_agg_name b  on a.chg_type = b.monitor_no
	update a set a.comp_order2 = b.comp_order 	from tbl_monitoring_target_raw_new_g0 a inner join tbl_monitoring_team_agg_name b  on a.chg_type2 = b.monitor_no


insert into tbl_monitoring_target_run_log(run_step) select '10-s'

	-- ���̺� ��ȯ
	-- ���� ���̺�� ����
	if object_id('tbl_monitoring_target_raw_old') is not null begin
		drop table tbl_monitoring_target_raw_old		
	end
	if object_id('tbl_monitoring_target_raw_new') is not null begin
		exec sp_rename tbl_monitoring_target_raw_new, tbl_monitoring_target_raw_old
	end

	-- ���̺� �Է�

	--if cast(getdate() as date)  between cast('2015-10-08' as date) and cast('2015-10-11' as date) begin

	--	select *
	--	into tbl_monitoring_target_raw_new
	--	from tbl_monitoring_target_raw_new_g0 with (nolock)
	--	where pl_vcode = 4027 and chg_type = 1
	--	option (maxdop 1)

	--end else begin

insert into tbl_monitoring_target_run_log(run_step) select '11-s'

		select * 
		into tbl_monitoring_target_raw_new
		from tbl_monitoring_target_raw_new_g0

	--end



insert into tbl_monitoring_target_run_log(run_step) select '12-s'

	-- �ε��� ����
	create nonclustered index ncl_chg_type on tbl_monitoring_target_raw_new(chg_type)

--insert into tbl_monitoring_target_run_log select getdate(), 12

	-- new mc�� ����ó�� ���ְ�, ���� �ð� üũ�ؼ� ����ȴ�
	-- new mc ���� �ð� ����: ���� �ݿ��� �ּ� Ǯ��� ��!
	update tbl_mc_manager_set set start = dateadd(mi, 5, getdate())

insert into tbl_monitoring_target_run_log(run_step) select '12-e'

-- �ӽ� : http://58.234.199.100/redmine/issues/22697
/*
insert into [tbl_monitoring_target_raw_new_g0_history](
pl_no,pl_vcode,pl_modelno,pl_category,pl_price,pl_deliveryinfo,pl_status,pl_call_plan,pl_tag_price,pl_goodsnm
,pl_goodsnm_old,comp_order,chg_type,g_modelnm,g_category,regdate,pl_goodsnm_regexp,pl_goodsnm_old_regexp
,comp_order2,chg_type2,is_strangelist,today_first_date
)
select pl_no,pl_vcode,pl_modelno,pl_category,pl_price,pl_deliveryinfo,pl_status,pl_call_plan,pl_tag_price,pl_goodsnm
,pl_goodsnm_old,comp_order,chg_type,g_modelnm,g_category,regdate,pl_goodsnm_regexp,pl_goodsnm_old_regexp
,comp_order2,chg_type2,is_strangelist,today_first_date 
from [tbl_monitoring_target_raw_new_g0]
where pl_goodsnm_regexp <>''
*/


drop table tmp_worker_p_goods
