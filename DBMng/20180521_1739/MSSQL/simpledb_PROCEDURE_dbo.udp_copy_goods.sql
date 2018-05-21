/* *************************************************************************
 * NAME : dbo.udp_copy_goods
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-16 17:44:35.887
 *        Modify: 2018-05-16 17:44:35.887
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_copy_goods
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-03-23
	-- ��  �� : simpledb.goods 188���� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/
	if object_id('goods_new') is not null
		drop table goods_new
	
	-- ���̺� ����
	create table goods_new
	(
		g_modelno	int	primary key	not null
	,	g_category	char(8)
	,	g_factory	nvarchar(50)
	,	g_modelnm	nvarchar(70)
	,	g_jobcode	varchar(3)
	,	g_mallcnt	int
	,	g_date		smalldatetime
	,	g_minprice	money
	,	g_maxprice	money
	,	g_imgchk	char(1)
	,	g_partcode	varchar(3)
	,	is_instant_spec bit default(0) -- ��ü��� �𵨿��� �Ǵ� (��� ���� ���� ��࿡ �з� ������ ����.. ��)TV > ����ƮTV > �Ｚ
	,	g_spec2		nvarchar(2000)
	,	g_modelno_group int
	,	g_brand		nvarchar(50)
	)
	insert into simpledb..goods_new(g_modelno, g_category, g_factory, g_modelnm, g_jobcode, g_mallcnt, g_date, g_minprice, g_maxprice, g_imgchk,g_partcode,is_instant_spec,g_spec2,g_modelno_group,g_brand)
	select *
	/*
		g_modelno, g_category, g_factory, g_modelnm, g_jobcode, g_mallcnt, g_date, g_minprice, g_maxprice, g_imgchk,g_partcode,
		case when charindex('  /  ', g_spec) > 0 then 1 else 0 end as is_instant_spec,g_spec2
		,g_modelno_group
		,g_brand
	*/
	from openquery(eloc188, 'select top 1 
	a.g_modelno, g_category, g_factory, g_modelnm, g_jobcode, g_mallcnt, g_date, g_minprice, g_maxprice, g_imgchk,g_partcode,
		case when charindex(''  /  '', g_spec) > 0 then 1 else 0 end as is_instant_spec,g_spec2
		,g_modelno_group
		,g_brand
	from eloc2001.dbo.goods a with (readuncommitted)
        inner join 
        eloc2001.dbo.goods_sum b with (readuncommitted) on a.g_modelno = b.g_modelno
    
    ')




	if @@rowcount > 0
	begin

		-- �ε��� ����
		declare @sql_index1 nvarchar(1000)
		declare @sql_index2 nvarchar(1000)
		set @sql_index1 = N'create index ncl_1_'+ convert(varchar(8),getdate(),112) +' on goods_new(g_category, g_factory)'
		set @sql_index2 = N'create index ncl_2_'+ convert(varchar(8),getdate(),112) +' on goods_new(g_factory, g_modelno, g_category, g_jobcode, g_mallcnt)'
		exec(@sql_index1)
		exec(@sql_index2)

		exec sp_rename goods, goods_old		
		exec sp_rename goods_new, goods

		drop table goods_old
		
	end



