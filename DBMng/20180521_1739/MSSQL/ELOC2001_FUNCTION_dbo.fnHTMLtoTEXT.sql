/* *************************************************************************
 * NAME : dbo.fnHTMLtoTEXT
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2014-02-12 13:35:54.537
 *        Modify: 2018-05-03 17:23:34.1
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE   function fnHTMLtoTEXT (@str nvarchar(2000))
returns varchar(8000)
as
begin
declare  @nLen int,@st int,@ed int,@ds nvarchar(2000),@sf nvarchar(2000),@i int
set @nLen = Len(@str)
set @sf = @str
set @i = 0
WHILE @i <= @nLen
BEGIN
set @st = dbo.INSTR(@i,@str,'<')
set @ed = dbo.INSTR(@st+1,@str,'>')
IF @st > 0 And @ed > 0
BEGIN
set @ds = substring(@str,@st,(@ed+1)-@st)
set @sf = replace(@sf,@ds,'')
set @i = @ed
END
set @i = @i + 1
END
return replace(@sf,' ','')
end
