/* *************************************************************************
 * NAME : dbo.udp_make_book_model
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-03-14 17:11:06.193
 *        Modify: 2018-05-03 17:23:35.483
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc [dbo].[udp_make_book_model]
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-03-14
	-- ��  �� : ���� �𵨹�ȣ ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	2011.04.04		wookki25		isbn 13�ڸ��� �𵨹�ȣ ����
									author = 'null' ����ó��
	2011.12.02		wookki25		���������� ��ǰ�� goods�� ���� ����� ó��
									�������������� ��ǰ�� ������ ����� ����(ī������,Ư��...)�� ���� ����
	2013.02.04		wooki25			���� �ϰ��Է� �� ���� ������ ó��
									and a.pl_status in ('0','1','2')
	*/

	-- ���� ������ �ϴ� �� - isbn ����
	declare @g_modelno_max int
	select @g_modelno_max = max(g_modelno) from goods

	select
		identity(int, 1,1) seq
	,	@g_modelno_max as max_modelno
	,	isbn
	,	case when len(pl_goodsnm)>70 then
			case
			when charindex('-', left(pl_goodsnm,70)) > 0 then
				rtrim(ltrim(left(pl_goodsnm, 70-charindex('-', reverse(left(pl_goodsnm,70)),0))))
			when charindex(' ', left(pl_goodsnm,70)) > 0 then
				rtrim(ltrim(left(pl_goodsnm, 70-charindex(' ', reverse(left(pl_goodsnm,70)),0))))
			else
				rtrim(ltrim(left(pl_goodsnm,70)))
			end
		else
			rtrim(ltrim(pl_goodsnm))
		end as modelnm
	,	author as author
	,	pl_goodsfactory as factory
	,	publish_day
	into #new_book
	from pricelist a
			inner join
	(
		select * 
		from 
		(
			select	isbn, max(pl_no) pl_no, max(publish_day) publish_day, max(author) author
			from	pricelist_book pb1
			where	regdate >= cast(convert(varchar(10), getdate()-1, 120) as datetime)
			--where	regdate >= cast(convert(varchar(10), '2011-04-13', 120) as datetime)
			and		regdate <  cast(convert(varchar(10), getdate()+0, 120) as datetime)
			group by isbn
		)  pb
		where not exists (select 1 from goods_book gb where gb.isbn = pb.isbn)
	) b
			on a.pl_no = b.pl_no
	where a.pl_modelno=0
	and a.pl_vcode in (3367, 4858, 4859, 4861, 6367, 6368, 6378) -- ���� �������� ��������Ѵ�.
	and a.pl_status in ('0','1','2')
	
	-- ������ �߸��� ������ ����
	delete #new_book
	where isdate(publish_day) = 0
	or publish_day > '2079-01-06'
	or publish_day < '1900-01-01'

	-- isbn 13�ڸ��� �ƴѳ��� �𵨹�ȣ ���� ����..
	delete #new_book
	where len(isbn) <> 13
	
	-- ������ �̷��� �ڷ� ���÷� ����
	update #new_book set publish_day = convert(varchar(10), getdate(), 120)
	where publish_day > convert(varchar(10), getdate(), 120)
	
	-- ����Ű����
	update #new_book set modelnm = replace(replace(modelnm, '[������] ',''),'[������]','')
	where modelnm like '%������%'
	update #new_book set modelnm = replace(replace(modelnm, '[�ݰ�����] ',''),'[�ݰ�����]','')
	where modelnm like '%�ݰ�����%'
	update #new_book set modelnm = replace(replace(modelnm, '[�����Ǹ�] ',''),'[�����Ǹ�]','')
	where modelnm like '%�����Ǹ�%'

	-- author�� null�γ��� ''���� �����Ѵ�.(��༳��� '���� > ' �߰�)
	update #new_book
	set author = case when author is null then '' else '���� > ' + author end


	declare @s_seq int
	declare @e_seq int
	select @s_seq=min(seq), @e_seq=max(seq) from #new_book
	while @s_seq <= @e_seq begin		

		select @g_modelno_max = max(g_modelno)+1 from goods

		insert	into goods(g_modelno, g_modelnm, g_spec2, g_factory, g_date, g_flag, g_category, g_imgchk, g_jobcode)
		select	@g_modelno_max, modelnm, author, factory, publish_day , '0', '93010000', '8', '1' --g_imgchk=8 : ���θ� �̹���, g_jobcode=1 : �Ϸ�
		from	#new_book
		where	seq = @s_seq

		insert into goods_book(g_modelno, isbn)
		select @g_modelno_max, isbn
		from	#new_book
		where	seq = @s_seq

		set @s_seq = @s_seq + 1

	end

