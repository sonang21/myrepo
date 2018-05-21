/* *************************************************************************
 * NAME : dbo.udp_cpg_ep_minprice_stats_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-03-09 14:13:04.327
 *        Modify: 2018-05-03 17:23:34.933
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cpg_ep_minprice_stats_sel
	@sdate date
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �� �� ��: wookki25 / 2018.03.09
	-- ��    ��: ep_minprice_stats sel
	-- ��    ��: ���� �ۼ��� ������ ����.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:				��������:
	-------------------------------------------------
	*/

	select shop_code [���θ�]
	, category
	, isnull(cl_name, '') + case when ltrim(rtrim(isnull(cm_name, ''))) = '' then '' else ' > ' + isnull(cm_name, '') end [�ߺз�]
	, total_cnt [��ü ��ǰ��]
	, match_cnt [���ݺ� ��ǰ��]
	, min_cnt [������ ��ǰ��]
	, non_match_cnt [�Ϲ� ��ǰ��] 
	from ep_minprice_stats
	inner join c_lcate on substring(category, 1, 2) = cl_lcode
	left join c_mcate on substring(category, 1, 2) = cm_lcode and substring(category, 3, 2) = cm_mcode
	where yyyymmdd = @sdate
	order by yyyymmdd, shop_code, category
	option (maxdop 1)
end 