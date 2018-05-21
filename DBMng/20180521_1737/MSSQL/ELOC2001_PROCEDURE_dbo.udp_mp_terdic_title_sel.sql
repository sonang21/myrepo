/* *************************************************************************
 * NAME : dbo.udp_mp_terdic_title_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-01-07 15:19:02.43
 *        Modify: 2018-05-03 17:23:35.413
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[udp_mp_terdic_title_sel]
	@category varchar(4)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2016.01.07
	-- 설  명 : 용어사전 데이터
	--			망분리로 mp에서 50번 서버 용어사전 데이터 볼 수 있게 처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	declare @qry varchar(3000)

	set @qry  = '
		select ref_kbno, ktt_specsynonym 
		from knowboxdb2.dbo.know_termdic_title with (readuncommitted) 
		inner join knowboxdb2.dbo.know_box with (readuncommitted) on ref_kbno = kb_no 
		where ktt_cate = '''+ @category +''' and ktt_status = ''y'' and ktt_specsynonym is not null and ktt_specsynonym <> '''' and kb_del_flag = ''0'' 
		order by len(ktt_specsynonym) desc, ktt_specsynonym '

	set @qry = 'select * from openquery(mpdb02, '''+replace(@qry, '''','''''')+''')'


	exec (@qry)

	