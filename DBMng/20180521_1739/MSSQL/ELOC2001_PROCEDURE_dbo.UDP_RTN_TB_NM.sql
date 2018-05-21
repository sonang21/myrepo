/* *************************************************************************
 * NAME : dbo.UDP_RTN_TB_NM
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-12-23 14:14:40.567
 *        Modify: 2018-05-03 17:23:34.167
 *        Backup: 20180521_1739
 ************************************************************************* */


Create procedure UDP_RTN_TB_NM
 @Target_STR  varchar(8000),  -- 테이블명이 들어있는 문자열
 @strFind_s varchar(100),  -- 찾는 문자열 시작점
 @strFind_e varchar(100),   -- 찾는 문자열 종료점
 @strTrxType char(1) -- 유형 
as 

begin 

 Declare @sPoint int,@ePoint int

  --if (@strTrxType = 'D') -- delete를 찾을때는 from을 모두 제거한다.
  --  set @Target_STR =  replace(@Target_STR,'from','')

  set @ePoint = 0 
  Create table #js_temp 
  (t_name varchar(1000), Trx_type char(1))
   
  while not (SELECT CHARINDEX(@strFind_s,@Target_STR,@ePoint))=0 
  begin 

   set @sPoint = CHARINDEX(@strFind_s,@Target_STR,@ePoint)+datalength(@strFind_s)
   set @ePoint = CHARINDEX(@strFind_e,@Target_STR,@sPoint)
   
   if (@ePoint<@sPoint) -- space없이 끝난경우
    set @ePoint = len(@Target_STR)


  --// 미리 생성한 임시테이블에 테이블명 저장하고 리턴...
   insert into #js_temp
   select substring(@Target_STR,@sPoint,@ePoint-@sPoint), @strTrxType
  end

  -- 유효하지 않은 이름들을 버린다.
  delete #js_temp where t_name like '#%' 
 -- delete #js_temp where t_name like '%(%' -- 유저디파인함수나 서브쿼리의 경우 삭제. 어떻게?;;

 select * from #js_temp

end




-- UDP_RTN_USE_TB_NM 'UDP_NURIBOT_DELETE'


