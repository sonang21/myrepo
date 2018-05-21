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
	-- �ۼ��� : wookki25 / 2016.01.07
	-- ��  �� : ������ ������
	--			���и��� mp���� 50�� ���� ������ ������ �� �� �ְ� ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
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

	