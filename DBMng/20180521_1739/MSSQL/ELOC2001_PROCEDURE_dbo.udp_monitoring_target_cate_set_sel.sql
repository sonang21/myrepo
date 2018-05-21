/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_cate_set_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-06-22 14:49:34.757
 *        Modify: 2018-05-03 17:23:34.697
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_monitoring_target_cate_set_sel
	@category varchar(12)
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2016.06.22
	-- ��  �� : ���ݸ���͸�.�ǽð� ����͸� �з��� �α���� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/
	select a.category, cl_name, cm_name, b.pop_s_rank, b.pop_e_rank
	from 
	(
		select cm_lcode+cm_mcode category, cl_name, cm_name 
		from c_lcate a 
				inner join  c_mcate b on cm_lcode = cl_lcode
		where cl_lcode like substring(isnull(nullif(@category,''),'%'), 1,2) and cm_lcode like substring(isnull(nullif(@category,''),'%'), 1,2) 
		--and cl_flag = '1'
		and cm_flag = '1'
	) a left outer join tbl_monitoring_target_cate_set b on a.category = b.category
	order by 1
