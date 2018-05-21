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

    -- 공백제거
    update @tmp_table
    set txt = ltrim(rtrim(txt))

	--// 모든 구분자 값을 space로 변경하는 작업 수행 
    update @tmp_table	set txt = replace(txt,char(10),' ')
    update @tmp_table	set txt = replace(txt,char(13),' ')
    update @tmp_table	set txt = replace(txt,char(9),' ') -- tab ->space
    update @tmp_table	set txt = replace(txt,'''',' ') -- '' -> space

     --// 결과값 리턴하는 임시테이블 생성
	 if object_id('tempdb.dbo.#js_temp_result') is not null
	 drop table #js_temp_result

	 Create table #js_temp_result 
		(tableName varchar(1000), trxType varchar(1) ,objectid int default null) 

    --반복
    set @idxcnt = 1
	WHILE @idxcnt <= @TotalCnt
    Begin  
                   
         set @tmp_STR = ''

         select @tmp_STR = txt
         from @tmp_table
         where IDX = @idxcnt

		 -- space 2개는 space 1개로 줄여준다.
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


 -- 콤마로 표기하는 조인을 위해 넣어보았는데, 문제 발생. 테이블명에 공백이 들어가면 잡지 못한다. & select 리스트의 콤마도 구분하지 못함.
 --insert into #js_temp_result (tablename) 
 --exec Credit.dbo.rtn_tablename @Target_STR = @tmp_STR,@strFind_s= ', ',@strFind_e = ' '

 --select * from #js_temp_result

 --// 해당 테이블이 존재하는지 확인한다. null 값인 것은 없는 것으로 간주. 
 --   문제점 : 함수 및 링크드서버는 잡아내지 못하거나 null로 나온다...(커서의 경우도 마찬가지)
 update #js_temp_result set objectid =  object_id(tablename)

 select tablename, trxType, objectid, @req_ProcName as spname
 from  #js_temp_result 
 where tablename not like '@%' and tablename not like '(s%'
 group by tablename, trxType, objectid
 order by tablename, trxType, objectid
 
 --where objectid is null 
end


--// 해당 프로시저들을 시스템 저장 프로시저로 변경하자
--sp_MS_marksystemobject UDP_RTN_TB_NM 
--sp_MS_marksystemobject UDP_RTN_USE_TB_NM 



--use MASTER


-- UDP_RTN_USE_TB_NM 'UDP_NURIBOT_DELETE'


--select object_id('TBL_DATA_TOTAL_536')


