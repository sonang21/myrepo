/* *************************************************************************
 * NAME : dbo.udp_model_img_last_upload_date_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 20:23:19.017
 *        Modify: 2018-05-13 20:24:11.833
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_model_img_last_upload_date_ins
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013.10.18
	-- ��  �� : ���ε�� ��¥�� ū�̹����� �ٳ���  �̹������� ����.. 
		-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2014.03.17		wookki25		alter table tbl_model_img_last_upload_date add g_imgchk char(1) null
	2014.03.21		wookki25		log2004.dbo.tbl_model_img_log where img_kind = ''big'' --> where img_kind = ''big_logox''
									�Ϲ� ū �̹����� ���������� ������ ����� ��� �ø� �� �־
									���������� �ø� �� �ִ� �ΰ���� �̹����� �������� ����
	*/
	-- ��� ������

	-- big img
	insert into tbl_model_img_last_upload_date(g_modelno, g_category, g_modelnm, img_kind, regdate, g_imgchk)
	select g_modelno, g_category, g_modelnm, img_kind, regdate, g_imgchk
	from openquery(ELOC188,
		'select b.g_modelno, b.g_category, b.g_modelnm, ''big'' as img_kind, cast(convert(varchar(10), getdate()-1, 120) as smalldatetime) as regdate,g_imgchk
		from 
		(select distinct g_modelno from mpdb02.log2004.dbo.tbl_model_img_log where img_kind = ''big_logox'' and action_kind = ''m'') a
		inner join 
		eloc2001.dbo.goods b
		on a.g_modelno = b.g_modelno 
		'
	)
	-- where b.g_imgchk = ''1''


	-- 500 size ebay �̹���
	insert into tbl_model_img_last_upload_date(g_modelno, g_category, g_modelnm, img_kind, regdate, g_imgchk)
	select g_modelno, g_category, g_modelnm, img_kind, regdate, g_imgchk
	from openquery(ELOC188,
		'select b.g_modelno, b.g_category, b.g_modelnm, ''middle'' as img_kind, cast(convert(varchar(10), getdate()-1, 120) as smalldatetime) as regdate,g_imgchk
		from 
		(select distinct g_modelno from mpdb02.log2004.dbo.tbl_model_img_log where img_kind = ''middle'' and action_kind = ''m'') a
		inner join 
		eloc2001.dbo.goods b
		on a.g_modelno = b.g_modelno 
		'
	)
	-- where b.g_imgchk = ''9''

	-- ���� ������ �ѹ��� üũ
	update 	a 
	set g_imgchk = b.g_imgchk 
	from tbl_model_img_last_upload_date a inner join simpledb.dbo.goods b on a.g_modelno = b.g_modelno
	where regdate = cast(convert(varchar(10), getdate()-2, 120) as smalldatetime)
	and img_kind = 'big'
	and a.g_imgchk <> '2'
	and b.g_imgchk = '2'

	update 	a 
	set g_imgchk = b.g_imgchk 
	from tbl_model_img_last_upload_date a inner join simpledb.dbo.goods b on a.g_modelno = b.g_modelno
	where regdate = cast(convert(varchar(10), getdate()-2, 120) as smalldatetime)
	and img_kind = 'big'
	and a.g_imgchk <> '1'
	and b.g_imgchk = '1'


	update 	a 
	set g_imgchk = b.g_imgchk 
	from tbl_model_img_last_upload_date a inner join simpledb.dbo.goods b on a.g_modelno = b.g_modelno
	where regdate = cast(convert(varchar(10), getdate()-2, 120) as smalldatetime)
	and img_kind = 'middle'
	and a.g_imgchk <> '9'
	and b.g_imgchk = '9'

	
	delete a
	from tbl_model_img_last_upload_date a
	where g_imgchk = '9'
	and exists (
		select top 1  1 from tbl_model_img_last_upload_date b 
		where g_imgchk in ('1', '2') and a.g_modelno = b.g_modelno
		and regdate = cast(convert(varchar(10), getdate()-2, 120) as smalldatetime)
	)
	and regdate = cast(convert(varchar(10), getdate()-2, 120) as smalldatetime)


	-- �����Ͽ��� �ݿ��� �����͵� �ѹ��� üũ
	if datepart(dw, getdate()) = 2 begin -- �����ϸ�
		update 	a 
		set g_imgchk = b.g_imgchk 
		from tbl_model_img_last_upload_date a inner join simpledb.dbo.goods b on a.g_modelno = b.g_modelno
		where regdate = cast(convert(varchar(10), getdate()-3, 120) as smalldatetime)
		and img_kind = 'big'
		and a.g_imgchk <> '2'
		and b.g_imgchk = '2'

		update 	a 
		set g_imgchk = b.g_imgchk 
		from tbl_model_img_last_upload_date a inner join simpledb.dbo.goods b on a.g_modelno = b.g_modelno
		where regdate = cast(convert(varchar(10), getdate()-3, 120) as smalldatetime)
		and img_kind = 'big'
		and a.g_imgchk <> '1'
		and b.g_imgchk = '1'


		update 	a 
		set g_imgchk = b.g_imgchk 
		from tbl_model_img_last_upload_date a inner join simpledb.dbo.goods b on a.g_modelno = b.g_modelno
		where regdate = cast(convert(varchar(10), getdate()-3, 120) as smalldatetime)
		and img_kind = 'middle'
		and a.g_imgchk <> '9'
		and b.g_imgchk = '9'

		
		delete a
		from tbl_model_img_last_upload_date a
		where g_imgchk = '9'
		and exists (
			select top 1  1 from tbl_model_img_last_upload_date b 
			where g_imgchk in ('1', '2') and a.g_modelno = b.g_modelno
			and regdate = cast(convert(varchar(10), getdate()-3, 120) as smalldatetime)
		)
		and regdate = cast(convert(varchar(10), getdate()-3, 120) as smalldatetime)

	end


	-- �ֱ� 3������ ������ ����.
	delete tbl_model_img_last_upload_date
	where regdate < dateadd(m, -12, getdate())

