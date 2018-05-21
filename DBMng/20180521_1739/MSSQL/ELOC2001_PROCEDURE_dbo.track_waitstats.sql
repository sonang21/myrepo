/* *************************************************************************
 * NAME : dbo.track_waitstats
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2006-01-06 21:26:51.513
 *        Modify: 2018-05-03 17:23:35.817
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc track_waitstats (@num_samples int=10,@delaynum int=1,@delaytype 

  nvarchar(10)='minutes')

AS

 

-- This stored procedure is provided AS IS with no warranties and confers 

-- no rights.

-- Use of included script samples are subject to the terms specified at

-- http://www.microsoft.com/info/cpyright.htm.

 

-- @num_samples is the number of times to capture waitstats; default is 10 times.

-- @delaynum is the delay interval; can be in minutes or seconds; default is 

-- 1 minute.

-- @delaytype is the time specified. Values are "minutes" or "seconds."

-- Create waitstats table if it doesn't exist; otherwise truncate.

 

SET nocount ON

IF NOT EXISTS (SELECT 1 FROM sysobjects WHERE name = 'waitstats')

   CREATE table waitstats ([wait type] varchar(80),

      requests numeric(20,1),

               [wait time] numeric (20,1),

               [signal wait time] numeric(20,1),

               now datetime default getdate())

ELSE    truncate table waitstats

dbcc sqlperf (waitstats,clear)                            -- Clear out waitstats.

DECLARE @i int,@delay varchar(8),@dt varchar(3),@now datetime,

   @totalwait numeric(20,1),@endtime datetime,@begintime datetime,@hr int,   @min int,@sec int

SELECT @i = 1

SELECT @dt = case lower(@delaytype)

   WHEN 'minutes' THEN 'm'

   WHEN 'minute' THEN 'm'

   WHEN 'min' THEN 'm'

   WHEN 'mm' THEN 'm'

   WHEN 'mi' THEN 'm'

   WHEN 'm' THEN 'm'

   WHEN 'seconds' THEN 's'

   WHEN 'second' THEN 's'

   WHEN 'sec' THEN 's'

   WHEN 'ss' THEN 's'

   WHEN 's' THEN 's'

   ELSE @delaytype

END

IF @dt NOT IN ('s','m')

BEGIN

   PRINT 'please supply delay type e.g. seconds or minutes'

   RETURN

END

IF @dt = 's'

BEGIN

   SELECT @sec = @delaynum % 60

   SELECT @min = cast((@delaynum / 60) AS int)

   SELECT @hr = cast((@min / 60) AS int)

   SELECT @min = @min % 60

END

IF @dt = 'm'

BEGIN

   SELECT @sec = 0

   SELECT @min = @delaynum % 60

   SELECT @hr = cast((@delaynum / 60) AS int)

END

SELECT @delay= right('0'+ convert(varchar(2),@hr),2) + ':' +

   + right('0'+convert(varchar(2),@min),2) + ':' +

   + right('0'+convert(varchar(2),@sec),2)

IF @hr > 23 or @min > 59 or @sec > 59

BEGIN

   SELECT 'hh:mm:ss delay time cannot > 23:59:59'

   SELECT 'delay interval and type: ' + convert (varchar(10),@delaynum) + ',' + 

     @delaytype + ' converts to ' + @delay

   RETURN

END

WHILE (@i <= @num_samples)

BEGIN

             INSERT INTO waitstats ([wait type], requests, [wait time],[signal wait time])

   EXEC ('dbcc sqlperf(waitstats)')

   SELECT @i = @i + 1

   waitfor delay @delay

END

