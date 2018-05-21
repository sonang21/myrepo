/* *************************************************************************
 * NAME : dbo.UDP_GOODS_BRAND_FIRSTINPUT_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-09-22 15:56:42.373
 *        Modify: 2018-05-04 17:26:37.353
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_goods_brand_firstinput_list
	@category	varchar(8)
,	@sdate		varchar(10)
,	@edate		varchar(10)
as
begin
	-- --------------------------------------------
	-- 수정자 : wokki25 / 2011.09.22
	-- 설    명 : 브랜드 최초등록일 조회
	-- --------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted

	select	distinct g_brand	
	into	#brand
	from	goods 
	where	g_category like @category + '%' and g_date< @sdate
	option (maxdop 1)
		
	create clustered index cl_brand on #brand(g_brand)
	
	select g_brand_new
	from
	(
		select	distinct g_brand as g_brand_new
		from	goods a inner join goods_sum b on a.g_modelno = b.g_modelno
		where	g_category like @category + '%'
		and		g_brand<>''
		and		b.g_mallcnt>0
		and		g_constrain='1'
		and		g_jobcode>'0'		
		and		g_date>=@sdate and g_date<@edate
	) aaa
	where not exists (select 1 from #brand where g_brand=g_brand_new)
	order by g_brand_new
	option (maxdop 1)

end



