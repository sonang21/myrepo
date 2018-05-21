/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_raw_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-01-07 18:13:58.7
 *        Modify: 2018-05-03 17:23:35.857
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_raw_ins
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
	*/
	-- ���� ���̺�� ����
	if object_id('tbl_monitoring_target_raw_old') is not null begin
--		insert into tbl_monitoring_target_raw_back  
--		(pl_no, pl_vcode, pl_modelno, pl_category, pl_price, pl_deliveryinfo, pl_status, pl_call_plan, pl_tag_price, pl_goodsnm, pl_goodsnm_old, comp_order, chg_type, g_modelnm, g_category, regdate, pl_goodsnm_regexp, pl_goodsnm_old_regexp)
--		select 
--		pl_no, pl_vcode, pl_modelno, pl_category, pl_price, pl_deliveryinfo, pl_status, pl_call_plan, pl_tag_price, pl_goodsnm, pl_goodsnm_old, comp_order, chg_type, g_modelnm, g_category, regdate, pl_goodsnm_regexp, pl_goodsnm_old_regexp
--		from tbl_monitoring_target_raw_old	 where chg_type=1
	
		drop table tbl_monitoring_target_raw_old		
	end
	if object_id('tbl_monitoring_target_raw_new') is not null begin
		exec sp_rename tbl_monitoring_target_raw_new, tbl_monitoring_target_raw_old
	end

--insert into tmp_20150326_runstep select getdate(), 1

	declare @s_rank smallint
	declare @e_rank smallint
	select top 1 @s_rank=top_start, @e_rank=top_end from tbl_mc_manager_set

	-- ����͸� ���� ���� �ð� ������Ʈ : ���� �ݿ��� �ּ� Ǯ��� ��!
	update tbl_mc_manager_set set work_start = getdate(), work_end = null, start = null

	-- �ߺз��� 60�� ��
	select modelno into #p_goods from tbl_mcate_popular_rank where mcate_group_rank between @s_rank and @e_rank

--insert into tmp_20150326_runstep select getdate(), 2


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
	into tbl_monitoring_target_raw_new
	from pricelist  with (readuncommitted) inner join #p_goods on pl_modelno = modelno
	where pl_modelno>0 and pl_status in ('0','1','2','8') and pl_srvflag in ('0','r','l','b','s') and option_flag2 ='0' 
	option (maxdop 1)

--insert into tmp_20150326_runstep select getdate(), 3

	create nonclustered index ncl_monitoring_target_raw on tbl_monitoring_target_raw_new(pl_no, pl_goodsnm)

--insert into tmp_20150326_runstep select getdate(), 4

	-- ��ǰ�� ����.�ϰ� ���� ó��
	update b --tbl_monitoring_target_raw_new
	set pl_goodsnm_regexp =		replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(b.pl_goodsnm, '\[[^\]]+(����|ī��|������|������|��ȭ��)[^\]]*\]', '', 1) 
						, ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'��',''),'=','')
	,	pl_goodsnm_old_regexp = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
						dbo.udf_RegExReplace(a.pl_goodsnm, '\[[^\]]+(����|ī��|������|������|��ȭ��)[^\]]*\]'
				, '', 1), ' ', ''),'+',''),'-',''),'/',''),'_',''),'[',''),']',''),'(',''),')',''),'��',''),'=','')

	,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old a inner join tbl_monitoring_target_raw_new b on a.pl_no = b.pl_no
	where a.pl_goodsnm <> b.pl_goodsnm
	option (maxdop 1) 	
	

--insert into tmp_20150326_runstep select getdate(), 5
	
	-- ���汸��.��ü
	update b --tbl_monitoring_target_raw_new
	set b.comp_order = 
		case 
--			when a.pl_modelno <> b.pl_modelno then 1 
			when b.pl_goodsnm_regexp <> b.pl_goodsnm_old_regexp 
				and  charindex(b.pl_goodsnm_regexp, b.pl_goodsnm_old_regexp) = 0
				and  charindex(b.pl_goodsnm_old_regexp, b.pl_goodsnm_regexp) = 0
			then 2 -- ���Խ� ������ ������ ��ǰ�� ��
			when a.pl_status <> b.pl_status and b.pl_status='8' then 3

--			when a.pl_price <> b.pl_price and b.pl_price>=(a.pl_price*1.1) then 5
--			when a.pl_price <> b.pl_price and b.pl_price<=(a.pl_price*0.9) then 6

			when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) then 5
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 then 6
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.7) and b.pl_price < (a.pl_price)*0.9 then 7

		--	when a.pl_price_card <> b.pl_price_card then 7
			when a.pl_deliveryinfo <> b.pl_deliveryinfo then 8
		--	when a.pl_call_plan <> b.pl_call_plan then 9
		--	when a.pl_tag_price <> b.pl_tag_price then 10
			else 0
		end
	--,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old a inner join tbl_monitoring_target_raw_new b on a.pl_no = b.pl_no
	option (maxdop 1) 	

--insert into tmp_20150326_runstep select getdate(), 6

	-- �ε��� ����
	create nonclustered index ncl_comp_order on tbl_monitoring_target_raw_new(comp_order)

--insert into tmp_20150326_runstep select getdate(), 7

	--���汸��.��ǰ�� ���� ������ ���
	update b --tbl_monitoring_target_raw_new
	set b.comp_order2 = 
		case when a.pl_status <> b.pl_status and b.pl_status='8' then 3
--			when a.pl_price <> b.pl_price and b.pl_price>=(a.pl_price*1.1) then 5
--			when a.pl_price <> b.pl_price and b.pl_price<=(a.pl_price*0.9) then 6
			when a.pl_price <> b.pl_price and b.pl_price <  (a.pl_price*0.5) then 5
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.5) and b.pl_price < (a.pl_price)*0.7 then 6
			when a.pl_price <> b.pl_price and b.pl_price >= (a.pl_price*0.7) and b.pl_price < (a.pl_price)*0.9 then 7
			when a.pl_deliveryinfo <> b.pl_deliveryinfo then 8
			else 0
		end
	--,	pl_goodsnm_old = a.pl_goodsnm
	from tbl_monitoring_target_raw_old a inner join tbl_monitoring_target_raw_new b on a.pl_no = b.pl_no
	where b.comp_order = 2 -- ��ǰ�� ������ ���
	option (maxdop 1) 	

--insert into tmp_20150326_runstep select getdate(), 8


	-- ���� �׸� ����
	-- ����� chg_type�� ����
	-- select  * from tbl_monitoring_team_agg_name
	update tbl_monitoring_target_raw_new
	set chg_type = 
		case comp_order 
--			when 1 then 12	-- ��ȣ
			when 2 then 1	-- ��ǰ��
			when 3 then 8	-- ������
			when 4 then 17	-- �ɼ�����
			when 5 then 18	-- ���� ���� ���� 50% �̸�
			when 6 then 19	-- ���� ���� ���� 50%�̻� 30%�̸�
			when 7 then 20	-- ���� ���� ���� 30%�̻� 10%�̸�
			when 8 then 14	-- ��ۺ�
--			when 9 then 15	-- �����
--			when 10 then 16	-- ����2 
		end
	,	chg_type2 = 
		case comp_order2 
			when 3 then 8	-- ������
			when 4 then 17	-- �ɼ�����
			when 5 then 18	-- ���� ���� ���� 50% �̸�
			when 6 then 19	-- ���� ���� ���� 50%�̻� 30%�̸�
			when 7 then 20	-- ���� ���� ���� 30%�̻� 10%�̸�
			when 8 then 14	-- ��ۺ�
			else 0			-- ���ܻ�Ȳ�� �⺻������ ����
		end
	where comp_order > 0

--insert into tmp_20150326_runstep select getdate(), 9

	-- ������� ���к� ���Ȯ��
	-- select chg_type, count(*) from tbl_monitoring_target_raw_new where chg_type is not  null group by chg_type


	-- ���� ó������ �����Ͱ� ����� �����ͺ��� �켱 ������ ������ ó������ ������ ����
	update a -- tbl_monitoring_target_raw_new
	set chg_type = 0
	,	comp_order = 0
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
	where b.p_status = 'i' and a.comp_order > 0

	-- ���� ó������ �����Ͱ� ����� �����ͺ��� �켱 ������ ������ ����� ������ ����
	delete b --tbl_monitoring_target
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
	where b.p_status = 'i' and a.comp_order > 0

	-- �Է����� pl_no distinct�ϰ� ó�� .. 2015.02.13
	delete b --tbl_monitoring_target
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
	where b.p_status in ('u', 'd') and a.comp_order >0


	-- ��ǰ�� ���� ������ ������ �Է�
	insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type)
	select pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type
	from tbl_monitoring_target_raw_new where comp_order >0 and chg_type not in ('1') -- ��ǰ����

--insert into tmp_20150326_runstep select getdate(), 10

	-- �ɼ� ������ �Է� : �Ϸ� 1ȸ��
	declare @sdate smalldatetime
	set @sdate = cast(convert(varchar(10), getdate(), 120) as smalldatetime)
	if not exists (select top 1 1 from tbl_monitoring_target with (readuncommitted) where chg_type = 17 and regdate >= @sdate) begin
		select a.pl_no, cast(4 as smallint) comp_order, cast(17 as smallint) chg_type, pl_vcode, pl_category, pl_goodsnm
		into #tbl_monitoring_target_option -- �Է��� ������ �ӽ� ����
		from 
		(
			select pl_no from tbl_pricelist_option_ctu_detail where regdate>=@sdate and regdate < @sdate+1
			union
			select pl_no from tbl_pricelist_option_diff_detail where regdate>=@sdate and regdate < @sdate+1
		) a inner join pricelist b with (readuncommitted)  on a.pl_no = b.pl_no
		where pl_srvflag not in ('O','Z','1') and option_flag2 <> '1'


		-- ���� ó������ �����Ͱ� ����� �����ͺ��� �켱 ������ ������ ó������ ������ ����
		delete a -- tbl_monitoring_target_raw_new
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
		where b.p_status = 'i' and a.comp_order > 0

		-- ���� ó������ �����Ͱ� ����� �����ͺ��� �켱 ������ ������ ����� ������ ����
		delete b --tbl_monitoring_target
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
		where b.p_status = 'i' and a.comp_order > 0

		-- �Է����� pl_no distinct�ϰ� ó�� .. 2015.02.13
		delete b --tbl_monitoring_target
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
		where b.p_status in ('u', 'd') and a.comp_order >0


		-- ��ǰ�� ���� ������ ������ �Է�
		insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type)
		select pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type
		from #tbl_monitoring_target_option
	end

--insert into tmp_20150326_runstep select getdate(), 11

	-- �ε��� ����
	create nonclustered index ncl_chg_type on tbl_monitoring_target_raw_new(chg_type)

--insert into tmp_20150326_runstep select getdate(), 12

	-- 2015.01.23 // �̰汹 ��û // ������ ��ǰ ����͸� ������� �Է� �� ���� �����ʹ� �����ڵ�8���� 1�� �����Ѵ�.
	-- ������ϱ����
--	update pricelist 	
--	set pl_status = '1' 
--	where pl_no in (select top 1000 pl_no from tbl_monitoring_target_raw_new  where chg_type = '8')
--
--	update  tbl_monitoring_target_raw_new  
--	set pl_status = '1' 
--	where chg_type = '8'


--insert into tmp_20150326_runstep select getdate(), 13

	-- new mc���� �ʿ��� goods ������ �Է�
	update a 
	set g_modelnm = b.g_modelnm
	,	g_category = b.g_category
	from tbl_monitoring_target_raw_new a inner join goods b on a.pl_modelno = b.g_modelno
	where chg_type = '1'

	-- new mc�� ����ó�� ���ְ�, ���� �ð� üũ�ؼ� ����ȴ�
	-- new mc ���� �ð� ����: ���� �ݿ��� �ּ� Ǯ��� ��!
	update tbl_mc_manager_set set start = dateadd(mi, 5, getdate())


--insert into tmp_20150326_runstep select getdate(), 14

	-- �Ѱ��� ������Ʈ 
	--	: ���� �ݿ��� �ּ� Ǯ��� ��
	--	: ���� ���ν��� �����ؾ� �� : udp_monitoring_team_agg_target
	--exec udp_monitoring_target_raw_agg

	/*
	delete from tbl_monitoring_team_agg_target 	
	where monitor_no in (12, 1, 8, 2, 3, 14, 15, 16, 17)  and agg_date = cast(convert(char(10), getdate(), 120) as smalldatetime)

	-- ���� �Է�
	insert into tbl_monitoring_team_agg_target (monitor_no, agg_date, category, target_cnt)
	select chg_type
	,	cast(convert(char(10), getdate(), 120) as smalldatetime) agg_date
	,	left(pl_category,2) lcate
	,	count(*) target_cnt
	from tbl_monitoring_target a
	where p_status='i' and exists(select TOP 1 1 from pricelist b where a.pl_no = b.pl_no)
	group by chg_type, left(pl_category,2)
	option (maxdop 1)
	*/

	delete tmp_20150326_runstep where run_date < getdate() - 7


