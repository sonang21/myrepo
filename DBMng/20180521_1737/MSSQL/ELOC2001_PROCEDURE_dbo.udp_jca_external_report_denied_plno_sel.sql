/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_denied_plno_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-22 17:15:06.33
 *        Modify: 2018-05-03 17:23:35.07
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_external_report_denied_plno_sel
	@shop_code int
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.02.22
	-- ��   �� :  ��Ī�Ұ� ������ �ٿ�ε�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/
	select yyyymmdd
	,	isnull(cl_name,'') cl_name
	,	isnull(cm_name,'') cm_name
	,	isnull(cs_name,'')  cs_name
	,	pl_goodscode
	,	pl_goodsnm
	,	pl_note 
	from tbl_external_denied_plno   a 
		left outer join c_lcate b on substring(a.pl_category,1,2) = b.cl_lcode and  len(a.pl_category) >= 2
		left outer join c_mcate c on substring(a.pl_category,1,2) = c.cm_lcode and substring(a.pl_category,3,2) = c.cm_mcode and len(a.pl_category) >= 4
		left outer join c_scate d on substring(a.pl_category,1,2) = d.cs_lcode and substring(a.pl_category,3,2) = d.cs_mcode  and substring(a.pl_category,5,2) = d.cs_scode and len(a.pl_category) >= 6
	where shop_code = @shop_code
	and replace(isnull(pl_note, ''),' ','') <> '' -- ���� �߰� : ���� �Է��� �����͸� �ٿ�ε� ���� // 2017.03.08
end
