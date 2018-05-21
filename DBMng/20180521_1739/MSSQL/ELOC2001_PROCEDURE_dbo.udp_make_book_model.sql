/* *************************************************************************
 * NAME : dbo.udp_make_book_model
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-03-14 17:11:06.193
 *        Modify: 2018-05-03 17:23:35.483
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc [dbo].[udp_make_book_model]
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-03-14
	-- 설  명 : 도서 모델번호 생성
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2011.04.04		wookki25		isbn 13자리만 모델번호 생성
									author = 'null' 공백처리
	2011.12.02		wookki25		도서전문몰 상품만 goods에 모델을 만든게 처리
									도서전문몰외의 상품은 도서명에 잡다한 내용(카드할인,특가...)이 들어가기 때문
	2013.02.04		wooki25			도서 일괄입력 건 바이 건으로 처리
									and a.pl_status in ('0','1','2')
	*/

	-- 모델을 만들어야 하는 놈 - isbn 없는
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
	and a.pl_vcode in (3367, 4858, 4859, 4861, 6367, 6368, 6378) -- 도서 전문몰만 대상으로한다.
	and a.pl_status in ('0','1','2')
	
	-- 출판일 잘못된 데이터 삭제
	delete #new_book
	where isdate(publish_day) = 0
	or publish_day > '2079-01-06'
	or publish_day < '1900-01-01'

	-- isbn 13자리가 아닌놈은 모델번호 따지 말자..
	delete #new_book
	where len(isbn) <> 13
	
	-- 출판일 미래인 자료 오늘로 변경
	update #new_book set publish_day = convert(varchar(10), getdate(), 120)
	where publish_day > convert(varchar(10), getdate(), 120)
	
	-- 제외키워드
	update #new_book set modelnm = replace(replace(modelnm, '[무료배송] ',''),'[무료배송]','')
	where modelnm like '%무료배송%'
	update #new_book set modelnm = replace(replace(modelnm, '[반값할인] ',''),'[반값할인]','')
	where modelnm like '%반값할인%'
	update #new_book set modelnm = replace(replace(modelnm, '[예약판매] ',''),'[예약판매]','')
	where modelnm like '%예약판매%'

	-- author가 null인놈은 ''으로 변경한다.(요약설명앞 '도서 > ' 추가)
	update #new_book
	set author = case when author is null then '' else '도서 > ' + author end


	declare @s_seq int
	declare @e_seq int
	select @s_seq=min(seq), @e_seq=max(seq) from #new_book
	while @s_seq <= @e_seq begin		

		select @g_modelno_max = max(g_modelno)+1 from goods

		insert	into goods(g_modelno, g_modelnm, g_spec2, g_factory, g_date, g_flag, g_category, g_imgchk, g_jobcode)
		select	@g_modelno_max, modelnm, author, factory, publish_day , '0', '93010000', '8', '1' --g_imgchk=8 : 쇼핑몰 이미지, g_jobcode=1 : 완료
		from	#new_book
		where	seq = @s_seq

		insert into goods_book(g_modelno, isbn)
		select @g_modelno_max, isbn
		from	#new_book
		where	seq = @s_seq

		set @s_seq = @s_seq + 1

	end

