/* *************************************************************************
 * NAME : dbo.UDP_RTN_TB_NM
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-12-23 14:14:40.567
 *        Modify: 2018-05-03 17:23:34.167
 *        Backup: 20180521_1739
 ************************************************************************* */


Create procedure UDP_RTN_TB_NM
 @Target_STR  varchar(8000),  -- ���̺���� ����ִ� ���ڿ�
 @strFind_s varchar(100),  -- ã�� ���ڿ� ������
 @strFind_e varchar(100),   -- ã�� ���ڿ� ������
 @strTrxType char(1) -- ���� 
as 

begin 

 Declare @sPoint int,@ePoint int

  --if (@strTrxType = 'D') -- delete�� ã������ from�� ��� �����Ѵ�.
  --  set @Target_STR =  replace(@Target_STR,'from','')

  set @ePoint = 0 
  Create table #js_temp 
  (t_name varchar(1000), Trx_type char(1))
   
  while not (SELECT CHARINDEX(@strFind_s,@Target_STR,@ePoint))=0 
  begin 

   set @sPoint = CHARINDEX(@strFind_s,@Target_STR,@ePoint)+datalength(@strFind_s)
   set @ePoint = CHARINDEX(@strFind_e,@Target_STR,@sPoint)
   
   if (@ePoint<@sPoint) -- space���� �������
    set @ePoint = len(@Target_STR)


  --// �̸� ������ �ӽ����̺� ���̺�� �����ϰ� ����...
   insert into #js_temp
   select substring(@Target_STR,@sPoint,@ePoint-@sPoint), @strTrxType
  end

  -- ��ȿ���� ���� �̸����� ������.
  delete #js_temp where t_name like '#%' 
 -- delete #js_temp where t_name like '%(%' -- �����������Լ��� ���������� ��� ����. ���?;;

 select * from #js_temp

end




-- UDP_RTN_USE_TB_NM 'UDP_NURIBOT_DELETE'


