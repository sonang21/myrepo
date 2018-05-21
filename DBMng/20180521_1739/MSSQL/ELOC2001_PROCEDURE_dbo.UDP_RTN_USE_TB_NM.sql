/* *************************************************************************
 * NAME : dbo.UDP_RTN_USE_TB_NM
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-12-23 14:11:47.85
 *        Modify: 2018-05-03 17:23:34.067
 *        Backup: 20180521_1739
 ************************************************************************* */


Create  procedure UDP_RTN_USE_TB_NM
 @req_ProcName varchar(100) 
as 
begin
 Declare @tmp_STR varchar(8000)
 declare @TotalCnt int 
 declare @idxcnt int

 set nocount on 

	DECLARE @tmp_table TABLE
	(
		IDX INT IDENTITY(1,1) PRIMARY KEY,
		txt varchar(8000)
	)

	insert into @tmp_table(txt) 
    select b.text
	from sysobjects as a inner join syscomments as b on (a.id = b.id)
	where a.xtype = 'P'
	and a.name = @req_ProcName

	Set @TotalCnt = @@rowcount

    -- ��������
    update @tmp_table
    set txt = ltrim(rtrim(txt))

	--// ��� ������ ���� space�� �����ϴ� �۾� ���� 
    update @tmp_table	set txt = replace(txt,char(10),' ')
    update @tmp_table	set txt = replace(txt,char(13),' ')
    update @tmp_table	set txt = replace(txt,char(9),' ') -- tab ->space
    update @tmp_table	set txt = replace(txt,'''',' ') -- '' -> space

     --// ����� �����ϴ� �ӽ����̺� ����
	 if object_id('tempdb.dbo.#js_temp_result') is not null
	 drop table #js_temp_result

	 Create table #js_temp_result 
		(tableName varchar(1000), trxType varchar(1) ,objectid int default null) 

    --�ݺ�
    set @idxcnt = 1
	WHILE @idxcnt <= @TotalCnt
    Begin  
                   
         set @tmp_STR = ''

         select @tmp_STR = txt
         from @tmp_table
         where IDX = @idxcnt

		 -- space 2���� space 1���� �ٿ��ش�.
		 while not CHARINDEX('  ',@tmp_STR) = 0 
		 begin 
		     -- print @tmp_STR
		     set @tmp_STR = replace(@tmp_STR,'  ',' ') 
		 end

print @idxcnt

		insert into #js_temp_result (tablename,trxType ) 
		exec UDP_RTN_TB_NM @Target_STR = @tmp_STR,@strFind_s= 'from ',@strFind_e = ' ', @strTrxType = 'R'

		insert into #js_temp_result (tablename,trxType) 
		exec UDP_RTN_TB_NM @Target_STR = @tmp_STR,@strFind_s= 'join ',@strFind_e = ' ', @strTrxType = 'R'

		insert into #js_temp_result (tablename,trxType) 
		exec UDP_RTN_TB_NM @Target_STR = @tmp_STR,@strFind_s= 'insert into ',@strFind_e = ' ', @strTrxType = 'C'

		insert into #js_temp_result (tablename,trxType) 
		exec UDP_RTN_TB_NM @Target_STR = @tmp_STR,@strFind_s= 'update ',@strFind_e = ' ', @strTrxType = 'U'

		insert into #js_temp_result (tablename,trxType) 
		exec UDP_RTN_TB_NM @Target_STR = @tmp_STR,@strFind_s= 'delete ',@strFind_e = ' ', @strTrxType = 'D'

		--insert into #js_temp_result (tablename,trxType) 
		--exec UDP_RTN_TB_NM @Target_STR = @tmp_STR,@strFind_s= 'delete from ',@strFind_e = ' ', @strTrxType = 'D'

        set @idxcnt = @idxcnt+1
     end


 -- �޸��� ǥ���ϴ� ������ ���� �־�Ҵµ�, ���� �߻�. ���̺�� ������ ���� ���� ���Ѵ�. & select ����Ʈ�� �޸��� �������� ����.
 --insert into #js_temp_result (tablename) 
 --exec Credit.dbo.rtn_tablename @Target_STR = @tmp_STR,@strFind_s= ', ',@strFind_e = ' '

 --select * from #js_temp_result

 --// �ش� ���̺��� �����ϴ��� Ȯ���Ѵ�. null ���� ���� ���� ������ ����. 
 --   ������ : �Լ� �� ��ũ�弭���� ��Ƴ��� ���ϰų� null�� ���´�...(Ŀ���� ��쵵 ��������)
 update #js_temp_result set objectid =  object_id(tablename)

 select tablename, trxType, objectid, @req_ProcName as spname
 from  #js_temp_result 
 where tablename not like '@%' and tablename not like '(s%'
 group by tablename, trxType, objectid
 order by tablename, trxType, objectid
 
 --where objectid is null 
end


--// �ش� ���ν������� �ý��� ���� ���ν����� ��������
--sp_MS_marksystemobject UDP_RTN_TB_NM 
--sp_MS_marksystemobject UDP_RTN_USE_TB_NM 



--use MASTER


-- UDP_RTN_USE_TB_NM 'UDP_NURIBOT_DELETE'


--select object_id('TBL_DATA_TOTAL_536')


