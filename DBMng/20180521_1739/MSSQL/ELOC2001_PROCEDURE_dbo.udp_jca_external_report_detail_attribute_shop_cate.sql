/* *************************************************************************
 * NAME : dbo.udp_jca_external_report_detail_attribute_shop_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-23 12:53:25.603
 *        Modify: 2018-05-03 17:23:34.343
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_jca_external_report_detail_attribute_shop_cate
	@shop_code int
,	@sdate char(8)
,	@category varchar(12)
as  begin 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.02.21
	-- 설  명 :  상세리포트 : 속성입력사항
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------

	*/
	-- 리스트
	select [분류]			= a.category
		 , [입력 속성수]		= isnull(attribute_cnt, 0)
		 , [전체 속성수]		= isnull(max_attribute_cnt , 0) 
		 , [속성입력률]		= isnull(case when (max_attribute_cnt ) = 0 then 0 else attribute_cnt * 100.0 / (max_attribute_cnt ) end, 0)
		 , 0 ord
	from tbl_external_stats_gs  a 
	where model_cnt > 0 and shop_code = @shop_code and yyyymmdd = @sdate and a.category like @category+'%'

	union all
	-- 합계
	select '합계'
	,	isnull(sum(attribute_cnt), 0)
	,	isnull(sum(max_attribute_cnt ), 0)
	,	isnull(case when (sum(max_attribute_cnt )) = 0 then 0 else sum(attribute_cnt) * 100.0 / (sum(max_attribute_cnt )) end, 0)
	,	1 ord
	from tbl_external_stats_gs a
	where model_cnt > 0 and shop_code = @shop_code and yyyymmdd = @sdate and a.category like @category+'%'
	order by ord, category

end

