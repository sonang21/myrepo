/* *************************************************************************
 * NAME : dbo.UDF_RTN_DELIVERYINFO
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2011-01-05 15:23:17.02
 *        Modify: 2018-05-03 17:23:36.02
 *        Backup: 20180521_1737
 ************************************************************************* */





/***** [UDF_RTN_DELIVERYINFO] 배송정보 처리 *****/
CREATE FUNCTION [dbo].[UDF_RTN_DELIVERYINFO] (@delivery nvarchar(50))
RETURNS nvarchar(50)
AS
BEGIN

	DECLARE  @return varchar(50)
	SET @return = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@delivery,',',''), '만원','0000'),'원',''),' ',''),'구매금액에따른배송비','')
	
	IF (ISNUMERIC(@return) = 1)
		BEGIN
			IF (@return = '0' OR @return = '-1')
				BEGIN
					SET @return = '무료배송'
				END
			ELSE IF (@return = '99999' or @return = '99990' or @return = '99900' or @return = '999900' or @return = '999000')	
				BEGIN
					SET @return = '유무료'	
				END
		END
	ELSE
		BEGIN
			IF (@return = '착불' or @return = '수신자부담(착불)')	
				BEGIN
					SET @return = '착불'	
				END
			ELSE IF (@return = '선불')
				BEGIN
					SET @return = '선불'	
				END
			ELSE IF (@return = '')
				BEGIN
					SET @return = '유무료'	
				END
			ELSE IF (CHARINDEX(@return,'무료,무료배송,배송무료,배송료무료,배송비무료,[기본설치비무료/무료배송],0이상무료') > 0)	
				BEGIN
					SET @return = '무료배송'	
				END
			ELSE IF (CHARINDEX(@return,'유료,유료배송,배송유료,설치비유료') > 0)	
				BEGIN
					SET @return = '유료'
				END
			ELSE IF (CHARINDEX(@return,'유무료,유무료배송,구매액별배송료차등,직접배달,배송비반환') > 0)	
				BEGIN
					SET @return = '유무료'	
				END
			ELSE IF (ISNUMERIC(REPLACE(REPLACE(REPLACE(REPLACE(@return,'유료배송',''),'유료',''),'착불/선결제',''),'착불선결제','')) = 1)
				BEGIN
					SET @return = REPLACE(REPLACE(REPLACE(REPLACE(@return,'유료배송',''),'유료',''),'착불/선결제',''),'착불선결제','')
				END
			ELSE IF (CHARINDEX('유료', @delivery) > 0 and CHARINDEX('원', @delivery) > 0 and CHARINDEX('이상 무료', @delivery) > 0)	
				BEGIN
					SET @return = replace(replace(@delivery,left(replace(@delivery,'이상 무료','원 미만'), charindex('원',replace(@delivery,'이상 무료','원 미만'))),'') + left(replace(@delivery,'이상 무료','원 미만'), charindex('원',replace(@delivery,'이상 무료','원 미만'))),'이상 무료유료','원 미만')
				END		
			ELSE
				BEGIN
					SET @return = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@delivery,',',''),'만원','0000원'),'천원','000원'),'이상 무료','이상무료'),'유료배송착불','착불')
				END

			IF (CHARINDEX('원 미만 원',@delivery) > 0)	
				BEGIN
					SET @return = '유무료'
				END
		END

	RETURN @return 
	
END



























