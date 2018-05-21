/* *************************************************************************
 * NAME : dbo.FN_SEC_TO_HMS
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2018-04-19 10:40:27.047
 *        Modify: 2018-04-19 10:40:27.047
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE FUNCTION [dbo].[FN_SEC_TO_HMS](@second int)
RETURNS VARCHAR(10)
AS 
BEGIN
   DECLARE @ret VARCHAR(10) = '';
   IF @second is not null
   BEGIN 
       SET @ret =  RIGHT('0' + CONVERT(VARCHAR, (@second /60 /60 ) ), 2) + ':'
                   + RIGHT('0' + CONVERT(VARCHAR, (@second /60) % 60 ), 2) + ':'
                   + RIGHT('0' + CONVERT(VARCHAR, (@second    ) % 60 ), 2) 
       ;
   END;
   RETURN @ret;
END;

