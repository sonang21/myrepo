/* *************************************************************************
 * NAME : dbo.UDP_GOODS_FACTORY_FIRSTINPUT_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.623
 *        Modify: 2018-05-04 17:29:44.207
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_goods_factory_firstinput_list
	@category	varchar(8)
,	@sdate		varchar(10)
,	@edate		varchar(10)
as
begin
	-- --------------------------------------------
	-- 수정자 : wokki25 / 2007.12.28
	-- 설  명 : 제조사 최초등록일 조회
	-- --------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted
	
	select g_factory_new
	from
	( 
		select distinct g_factory as g_factory_new
		  from goods a inner join goods_sum b on a.g_modelno = b.g_modelno
	 	 where g_category like @category + '%'
		   and g_factory<>''
		   and b.g_mallcnt>0
		   and g_constrain='1'
		   and g_jobcode>'0'		
		   and g_date>=@sdate and g_date<@edate
		   and g_category not like '9%'
		   and g_category not like '89%'
        		
	) aaa
	where not exists ( select 1 
				         from goods 
				        where g_category like @category + '%' and g_factory=g_factory_new and g_date < @sdate
				          and g_category not like '9%'
				          and g_category not like '89%' )
	order by g_factory_new
	option (maxdop 1)
	
end


