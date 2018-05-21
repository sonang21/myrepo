/* *************************************************************************
 * NAME : dbo.IndexOptimize
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-02-10 15:37:50.977
 *        Modify: 2018-05-03 17:23:35.637
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROCEDURE [dbo].[IndexOptimize]

@Databases nvarchar(max),
@FragmentationHigh_LOB nvarchar(max) = 'INDEX_REBUILD_OFFLINE',
@FragmentationHigh_NonLOB nvarchar(max) = 'INDEX_REBUILD_OFFLINE',
@FragmentationMedium_LOB nvarchar(max) = 'INDEX_REORGANIZE',
@FragmentationMedium_NonLOB nvarchar(max) = 'INDEX_REORGANIZE',
@FragmentationLow_LOB nvarchar(max) = 'NOTHING',
@FragmentationLow_NonLOB nvarchar(max) = 'NOTHING',
@FragmentationLevel1 int = 5,
@FragmentationLevel2 int = 30,
@PageCountLevel int = 1000,
@SortInTempdb nvarchar(max) = 'N',
@MaxDOP int = NULL,
@FillFactor int = NULL,
@LOBCompaction nvarchar(max) = 'Y',
@StatisticsSample int = NULL,
@PartitionLevel nvarchar(max) = 'N',
@TimeLimit int = NULL,
@Execute nvarchar(max) = 'Y'

AS

BEGIN

  ----------------------------------------------------------------------------------------------------
  --// Set options                                                                                //--
  ----------------------------------------------------------------------------------------------------

  SET NOCOUNT ON

  SET LOCK_TIMEOUT 3600000

  ----------------------------------------------------------------------------------------------------
  --// Declare variables                                                                          //--
  ----------------------------------------------------------------------------------------------------

  DECLARE @StartMessage nvarchar(max)
  DECLARE @EndMessage nvarchar(max)
  DECLARE @DatabaseMessage nvarchar(max)
  DECLARE @ErrorMessage nvarchar(max)

  DECLARE @StartTime datetime

  DECLARE @CurrentID int
  DECLARE @CurrentDatabase nvarchar(max)
  DECLARE @CurrentIsDatabaseAccessible bit
  DECLARE @CurrentMirroringRole nvarchar(max)

  DECLARE @CurrentCommandSelect01 nvarchar(max)
  DECLARE @CurrentCommandSelect02 nvarchar(max)
  DECLARE @CurrentCommandSelect03 nvarchar(max)
  DECLARE @CurrentCommandSelect04 nvarchar(max)
  DECLARE @CurrentCommandSelect05 nvarchar(max)

  DECLARE @CurrentCommand01 nvarchar(max)
  DECLARE @CurrentCommand02 nvarchar(max)

  DECLARE @CurrentCommandOutput01 int
  DECLARE @CurrentCommandOutput02 int

  DECLARE @CurrentIxID int
  DECLARE @CurrentSchemaID int
  DECLARE @CurrentSchemaName nvarchar(max)
  DECLARE @CurrentObjectID int
  DECLARE @CurrentObjectName nvarchar(max)
  DECLARE @CurrentObjectType nvarchar(max)
  DECLARE @CurrentIndexID int
  DECLARE @CurrentIndexName nvarchar(max)
  DECLARE @CurrentIndexType int
  DECLARE @CurrentPartitionID bigint
  DECLARE @CurrentPartitionNumber int
  DECLARE @CurrentPartitionCount int
  DECLARE @CurrentIsPartition bit
  DECLARE @CurrentIndexExists bit
  DECLARE @CurrentIsLOB bit
  DECLARE @CurrentAllowPageLocks bit
  DECLARE @CurrentOnReadOnlyFileGroup bit
  DECLARE @CurrentFragmentationLevel float
  DECLARE @CurrentPageCount bigint
  DECLARE @CurrentAction nvarchar(max)
  DECLARE @CurrentComment nvarchar(max)

  DECLARE @tmpDatabases TABLE (ID int IDENTITY PRIMARY KEY,
                               DatabaseName nvarchar(max),
                               Completed bit)

  DECLARE @tmpIndexes TABLE (IxID int IDENTITY PRIMARY KEY,
                             SchemaID int,
                             SchemaName nvarchar(max),
                             ObjectID int,
                             ObjectName nvarchar(max),
                             ObjectType nvarchar(max),
                             IndexID int,
                             IndexName nvarchar(max),
                             IndexType int,
                             PartitionID bigint,
                             PartitionNumber int,
                             PartitionCount int,
                             Selected bit,
                             Completed bit)

  DECLARE @tmpIndexExists TABLE ([Count] int)

  DECLARE @tmpIsLOB TABLE ([Count] int)

  DECLARE @tmpAllowPageLocks TABLE ([Count] int)

  DECLARE @tmpOnReadOnlyFileGroup TABLE ([Count] int)

  DECLARE @Actions TABLE ([Action] nvarchar(max))

  INSERT INTO @Actions([Action]) VALUES('INDEX_REBUILD_ONLINE')
  INSERT INTO @Actions([Action]) VALUES('INDEX_REBUILD_OFFLINE')
  INSERT INTO @Actions([Action]) VALUES('INDEX_REORGANIZE')
  INSERT INTO @Actions([Action]) VALUES('STATISTICS_UPDATE')
  INSERT INTO @Actions([Action]) VALUES('INDEX_REORGANIZE_STATISTICS_UPDATE')
  INSERT INTO @Actions([Action]) VALUES('NOTHING')

  DECLARE @Error int

  SET @Error = 0

  ----------------------------------------------------------------------------------------------------
  --// Log initial information                                                                    //--
  ----------------------------------------------------------------------------------------------------

  SET @StartTime = CONVERT(datetime,CONVERT(nvarchar,GETDATE(),120),120)

  SET @StartMessage = 'DateTime: ' + CONVERT(nvarchar,@StartTime,120) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Procedure: ' + QUOTENAME(DB_NAME(DB_ID())) + '.' + (SELECT QUOTENAME(sys.schemas.name) FROM sys.schemas INNER JOIN sys.objects ON sys.schemas.[schema_id] = sys.objects.[schema_id] WHERE [object_id] = @@PROCID) + '.' 
+ QUOTENAME(OBJECT_NAME(@@PROCID)) + CHAR(13) + CHAR(10)
  SET @StartMessage = @StartMessage + 'Parameters: @Databases = ' + ISNULL('''' + REPLACE(@Databases,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationHigh_LOB = ' + ISNULL('''' + REPLACE(@FragmentationHigh_LOB,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationHigh_NonLOB = ' + ISNULL('''' + REPLACE(@FragmentationHigh_NonLOB,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationMedium_LOB = ' + ISNULL('''' + REPLACE(@FragmentationMedium_LOB,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationMedium_NonLOB = ' + ISNULL('''' + REPLACE(@FragmentationMedium_NonLOB,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationLow_LOB = ' + ISNULL('''' + REPLACE(@FragmentationLow_LOB,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationLow_NonLOB = ' + ISNULL('''' + REPLACE(@FragmentationLow_NonLOB,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationLevel1 = ' + ISNULL(CAST(@FragmentationLevel1 AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @FragmentationLevel2 = ' + ISNULL(CAST(@FragmentationLevel2 AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @PageCountLevel = ' + ISNULL(CAST(@PageCountLevel AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @SortInTempdb = ' + ISNULL('''' + REPLACE(@SortInTempdb,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @MaxDOP = ' + ISNULL(CAST(@MaxDOP AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @FillFactor = ' + ISNULL(CAST(@FillFactor AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @LOBCompaction = ' + ISNULL('''' + REPLACE(@LOBCompaction,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @StatisticsSample = ' + ISNULL(CAST(@StatisticsSample AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @PartitionLevel = ' + ISNULL('''' + REPLACE(@PartitionLevel,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + ', @TimeLimit = ' + ISNULL(CAST(@TimeLimit AS nvarchar),'NULL')
  SET @StartMessage = @StartMessage + ', @Execute = ' + ISNULL('''' + REPLACE(@Execute,'''','''''') + '''','NULL')
  SET @StartMessage = @StartMessage + CHAR(13) + CHAR(10)
  SET @StartMessage = REPLACE(@StartMessage,'%','%%')
  RAISERROR(@StartMessage,10,1) WITH NOWAIT

  ----------------------------------------------------------------------------------------------------
  --// Select databases                                                                           //--
  ----------------------------------------------------------------------------------------------------

  IF @Databases IS NULL OR @Databases = ''
  BEGIN
    SET @ErrorMessage = 'The value for parameter @Databases is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  INSERT INTO @tmpDatabases (DatabaseName, Completed)
  SELECT DatabaseName AS DatabaseName,
         0 AS Completed
  FROM dbo.DatabaseSelect (@Databases)
  ORDER BY DatabaseName ASC

  IF @@ERROR <> 0 OR (@@ROWCOUNT = 0 AND @Databases <> 'USER_DATABASES')
  BEGIN
    SET @ErrorMessage = 'Error selecting databases.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Check input parameters                                                                     //--
  ----------------------------------------------------------------------------------------------------

  IF @FragmentationHigh_LOB NOT IN(SELECT [Action] FROM @Actions WHERE [Action] <> 'INDEX_REBUILD_ONLINE')
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationHigh_LOB is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationHigh_NonLOB NOT IN(SELECT [Action] FROM @Actions WHERE [Action] <> 'INDEX_REBUILD_ONLINE' OR SERVERPROPERTY('EngineEdition') = 3)
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationHigh_NonLOB is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationMedium_LOB NOT IN(SELECT [Action] FROM @Actions WHERE [Action] <> 'INDEX_REBUILD_ONLINE')
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationMedium_LOB is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationMedium_NonLOB NOT IN(SELECT [Action] FROM @Actions WHERE [Action] <> 'INDEX_REBUILD_ONLINE' OR SERVERPROPERTY('EngineEdition') = 3)
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationMedium_NonLOB is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLow_LOB NOT IN(SELECT [Action] FROM @Actions WHERE [Action] <> 'INDEX_REBUILD_ONLINE')
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationLow_LOB is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLow_NonLOB NOT IN(SELECT [Action] FROM @Actions WHERE [Action] <> 'INDEX_REBUILD_ONLINE' OR SERVERPROPERTY('EngineEdition') = 3)
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationLow_NonLOB is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF 'INDEX_REBUILD_ONLINE' IN(@FragmentationHigh_NonLOB, @FragmentationMedium_NonLOB, @FragmentationLow_NonLOB) AND SERVERPROPERTY('EngineEdition') <> 3
  BEGIN
    SET @ErrorMessage = 'Online rebuild is only supported in Enterprise and Developer Edition.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF 'INDEX_REBUILD_ONLINE' IN(@FragmentationHigh_LOB, @FragmentationMedium_LOB, @FragmentationLow_LOB)
  BEGIN
    SET @ErrorMessage = 'Online rebuild is only supported on indexes with no LOB columns.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLevel1 <= 0 OR @FragmentationLevel1 >= 100 OR @FragmentationLevel1 >= @FragmentationLevel2 OR @FragmentationLevel1 IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationLevel1 is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FragmentationLevel2 <= 0 OR @FragmentationLevel2 >= 100 OR @FragmentationLevel2 <= @FragmentationLevel1 OR @FragmentationLevel2 IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FragmentationLevel2 is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PageCountLevel < 0 OR @PageCountLevel IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for parameter @PageCountLevel is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @SortInTempdb NOT IN('Y','N') OR @SortInTempdb IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for parameter @SortInTempdb is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxDOP < 0 OR @MaxDOP > 64 OR @MaxDOP > (SELECT cpu_count FROM sys.dm_os_sys_info) OR (@MaxDOP > 1 AND SERVERPROPERTY('EngineEdition') <> 3)
  BEGIN
    SET @ErrorMessage = 'The value for parameter @MaxDOP is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @MaxDOP > 1 AND SERVERPROPERTY('EngineEdition') <> 3
  BEGIN
    SET @ErrorMessage = 'Parallel index operations are only supported in Enterprise and Developer Edition.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @FillFactor <= 0 OR @FillFactor > 100
  BEGIN
    SET @ErrorMessage = 'The value for parameter @FillFactor is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @LOBCompaction NOT IN('Y','N') OR @LOBCompaction IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for parameter @LOBCompaction is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @StatisticsSample <= 0 OR @StatisticsSample  > 100
  OR (@StatisticsSample IS NOT NULL AND 'INDEX_REORGANIZE_STATISTICS_UPDATE' NOT IN(@FragmentationHigh_LOB, @FragmentationHigh_NonLOB, @FragmentationMedium_LOB, @FragmentationMedium_NonLOB, @FragmentationLow_LOB, @FragmentationLow_NonLOB) AND 'STATISTICS_
UPDATE' NOT IN(@FragmentationHigh_LOB, @FragmentationHigh_NonLOB, @FragmentationMedium_LOB, @FragmentationMedium_NonLOB, @FragmentationLow_LOB, @FragmentationLow_NonLOB))
  BEGIN
    SET @ErrorMessage = 'The value for parameter @StatisticsSample is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PartitionLevel NOT IN('Y','N') OR @PartitionLevel IS NULL OR (@PartitionLevel = 'Y' AND SERVERPROPERTY('EngineEdition') <> 3)
  BEGIN
    SET @ErrorMessage = 'The value for parameter @PartitionLevel is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @PartitionLevel = 'Y' AND SERVERPROPERTY('EngineEdition') <> 3
  BEGIN
    SET @ErrorMessage = 'Table partitioning is only supported in Enterprise and Developer Edition.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @TimeLimit < 0
  BEGIN
    SET @ErrorMessage = 'The value for parameter @TimeLimit is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  IF @Execute NOT IN('Y','N') OR @Execute IS NULL
  BEGIN
    SET @ErrorMessage = 'The value for parameter @Execute is not supported.' + CHAR(13) + CHAR(10)
    RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
    SET @Error = @@ERROR
  END

  ----------------------------------------------------------------------------------------------------
  --// Check error variable                                                                       //--
  ----------------------------------------------------------------------------------------------------

  IF @Error <> 0 GOTO Logging

  ----------------------------------------------------------------------------------------------------
  --// Execute commands                                                                           //--
  ----------------------------------------------------------------------------------------------------

  WHILE EXISTS (SELECT * FROM @tmpDatabases WHERE Completed = 0)
  BEGIN

    SELECT TOP 1 @CurrentID = ID,
                 @CurrentDatabase = DatabaseName
    FROM @tmpDatabases
    WHERE Completed = 0
    ORDER BY ID ASC

    IF EXISTS (SELECT * FROM sys.database_recovery_status WHERE database_id = DB_ID(@CurrentDatabase) AND database_guid IS NOT NULL)
    BEGIN
      SET @CurrentIsDatabaseAccessible = 1
    END
    ELSE
    BEGIN
      SET @CurrentIsDatabaseAccessible = 0
    END

    SELECT @CurrentMirroringRole = mirroring_role_desc
    FROM sys.database_mirroring
    WHERE database_id = DB_ID(@CurrentDatabase)

    -- Set database message
    SET @DatabaseMessage = 'DateTime: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Database: ' + QUOTENAME(@CurrentDatabase) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Status: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabase,'Status') AS nvarchar) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Mirroring role: ' + ISNULL(@CurrentMirroringRole,'None') + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Standby: ' + CASE WHEN DATABASEPROPERTYEX(@CurrentDatabase,'IsInStandBy') = 1 THEN 'Yes' ELSE 'No' END + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Updateability: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabase,'Updateability') AS nvarchar) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'User access: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabase,'UserAccess') AS nvarchar) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Is accessible: ' + CASE WHEN @CurrentIsDatabaseAccessible = 1 THEN 'Yes' ELSE 'No' END + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = @DatabaseMessage + 'Recovery model: ' + CAST(DATABASEPROPERTYEX(@CurrentDatabase,'Recovery') AS nvarchar) + CHAR(13) + CHAR(10)
    SET @DatabaseMessage = REPLACE(@DatabaseMessage,'%','%%')
    RAISERROR(@DatabaseMessage,10,1) WITH NOWAIT

    IF DATABASEPROPERTYEX(@CurrentDatabase,'Status') = 'ONLINE'
    AND NOT (DATABASEPROPERTYEX(@CurrentDatabase,'UserAccess') = 'SINGLE_USER' AND @CurrentIsDatabaseAccessible = 0)
    AND DATABASEPROPERTYEX(@CurrentDatabase,'Updateability') = 'READ_WRITE'
    BEGIN

      -- Select indexes in the current database
      IF @PartitionLevel = 'N' SET @CurrentCommandSelect01 = 'SELECT ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id], ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[name], ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id], ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[name], RTRIM(' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type]), ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id, ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[name], ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type], NULL AS partition_id, NULL AS partition_number, NULL AS partition_count, 0 AS selected, 0 AS completed FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.objects ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas ON ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[schema_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type] IN(''U'',''V'') AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.is_ms_shipped = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type] IN(1,2,3,4) AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_disabled = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_hypothetical = 0 ORDER BY ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] ASC, ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] ASC, ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id ASC'
      IF @PartitionLevel = 'Y' SET @CurrentCommandSelect01 = 'SELECT ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id], ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[name], ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id], ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[name], RTRIM(' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type]), ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id, ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[name], ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type], ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.partition_id, ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.partition_number, IndexPartitions.partition_count, 0 AS selected, 0 AS completed FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.objects ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas ON ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[schema_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] LEFT OUTER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.[object_id] AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.index_id LEFT OUTER JOIN (SELECT [object_id], index_id, COUNT(*) AS partition_count FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions GROUP BY [object_id], index_id) IndexPartitions ON ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.[object_id] = IndexPartitions.[object_id] AND ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.[index_id] = IndexPartitions.[index_id] WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type] IN(''U'',''V'') AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.is_ms_shipped = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type] IN(1,2,3,4) AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_disabled = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_hypothetical = 0 ORDER BY ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] ASC, ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] ASC, ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id ASC, ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.partition_number ASC'
      
	INSERT INTO @tmpIndexes (SchemaID, SchemaName, ObjectID, ObjectName, ObjectType, IndexID, IndexName, IndexType, PartitionID, PartitionNumber, PartitionCount, Selected, Completed)
      EXECUTE(@CurrentCommandSelect01)

      UPDATE @tmpIndexes
      SET Selected = 1
      FROM @tmpIndexes

		-- 예외처리 // wookki25 2011.08.10 최적화 작업에서 제외처리 // 야간에 계속 업데이트하기 때문에
		if @CurrentDatabase = 'eloc2001' begin
			delete from @tmpIndexes where objectname = 'tbl_goods_search_list'
		end

      WHILE EXISTS (SELECT * FROM @tmpIndexes WHERE Selected = 1 AND Completed = 0)
      BEGIN

        SELECT TOP 1 @CurrentIxID = IxID,
                     @CurrentSchemaID = SchemaID,
                     @CurrentSchemaName = SchemaName,
                     @CurrentObjectID = ObjectID,
                     @CurrentObjectName = ObjectName,
                     @CurrentObjectType = ObjectType,
                     @CurrentIndexID = IndexID,
                     @CurrentIndexName = IndexName,
                     @CurrentIndexType = IndexType,
                     @CurrentPartitionID = PartitionID,
                     @CurrentPartitionNumber = PartitionNumber,
                     @CurrentPartitionCount = PartitionCount
        FROM @tmpIndexes
        WHERE Selected = 1
        AND Completed = 0
        ORDER BY IxID ASC

        -- Is the index a partition?
        IF @CurrentPartitionNumber IS NULL OR @CurrentPartitionCount = 1 BEGIN SET @CurrentIsPartition = 0 END ELSE BEGIN SET @CurrentIsPartition = 1 END

        -- Does the index exist?
        IF @CurrentIsPartition = 0 SET @CurrentCommandSelect02 = 'SELECT COUNT(*) FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.objects ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas ON ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[schema_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type] IN(''U'',''V'') AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.is_ms_shipped = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type] IN(1,2,3,4) AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_disabled = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_hypothetical = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] = ' + CAST(@CurrentSchemaID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[name] = N' + QUOTENAME(@CurrentSchemaName,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[name] = N' + QUOTENAME(@CurrentObjectName,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type] = N' + QUOTENAME(@CurrentObjectType,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id = ' + CAST(@CurrentIndexID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[name] = N' + QUOTENAME(@CurrentIndexName,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type] = ' + CAST(@CurrentIndexType AS nvarchar)
        IF @CurrentIsPartition = 1 SET @CurrentCommandSelect02 = 'SELECT COUNT(*) FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.objects ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas ON ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[schema_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.[object_id] AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.index_id WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type] IN(''U'',''V'') AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.is_ms_shipped = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type] IN(1,2,3,4) AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_disabled = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.is_hypothetical = 0 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[schema_id] = ' + CAST(@CurrentSchemaID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.schemas.[name] = N' + QUOTENAME(@CurrentSchemaName,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[name] = N' + QUOTENAME(@CurrentObjectName,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.objects.[type] = N' + QUOTENAME(@CurrentObjectType,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.index_id = ' + CAST(@CurrentIndexID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[name] = N' + QUOTENAME(@CurrentIndexName,'''') + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[type] = ' + CAST(@CurrentIndexType AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.partition_id = ' + CAST(@CurrentPartitionID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.partitions.partition_number = ' + CAST(@CurrentPartitionNumber AS nvarchar)
        
		INSERT INTO @tmpIndexExists ([Count])
        EXECUTE(@CurrentCommandSelect02)

        IF (SELECT [Count] FROM @tmpIndexExists) > 0 BEGIN SET @CurrentIndexExists = 1 END ELSE BEGIN SET @CurrentIndexExists = 0 END

        IF @CurrentIndexExists = 0 GOTO NoAction

        -- Does the index contain a LOB?
        IF @CurrentIndexType = 1 SET @CurrentCommandSelect03 = 'SELECT COUNT(*) FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.columns INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.types ON ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.system_type_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.types.user_type_id OR (' + QUOTENAME(@CurrentDatabase) + '.sys.columns.user_type_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.types.user_type_id AND '+ QUOTENAME(@CurrentDatabase) + '.sys.types.is_assembly_type = 1) WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar) + ' AND (' + QUOTENAME(@CurrentDatabase) + '.sys.types.name IN(''xml'',''image'',''text'',''ntext'') OR (' + QUOTENAME(@CurrentDatabase) + '.sys.types.name IN(''varchar'',''nvarchar'',''varbinary'') AND ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.max_length = -1) OR (' + QUOTENAME(@CurrentDatabase) + '.sys.types.is_assembly_type = 1 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.max_length = -1))'
        IF @CurrentIndexType = 2 SET @CurrentCommandSelect03 = 'SELECT COUNT(*) FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.index_columns INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.columns ON ' + QUOTENAME(@CurrentDatabase) + '.sys.index_columns.[object_id] = ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.[object_id] AND ' + QUOTENAME(@CurrentDatabase) + '.sys.index_columns.column_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.column_id INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.types ON ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.system_type_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.types.user_type_id OR (' + QUOTENAME(@CurrentDatabase) + '.sys.columns.user_type_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.types.user_type_id AND ' + QUOTENAME(@CurrentDatabase) + '.sys.types.is_assembly_type = 1) WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.index_columns.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.index_columns.index_id = ' + CAST(@CurrentIndexID AS nvarchar) + ' AND (' + QUOTENAME(@CurrentDatabase) + '.sys.types.[name] IN(''xml'',''image'',''text'',''ntext'') OR (' + QUOTENAME(@CurrentDatabase) + '.sys.types.[name] IN(''varchar'',''nvarchar'',''varbinary'') AND ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.max_length = -1) OR (' + QUOTENAME(@CurrentDatabase) + '.sys.types.is_assembly_type = 1 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.columns.max_length = -1))'
        IF @CurrentIndexType = 3 SET @CurrentCommandSelect03 = 'SELECT 1'
        IF @CurrentIndexType = 4 SET @CurrentCommandSelect03 = 'SELECT 1'

        INSERT INTO @tmpIsLOB ([Count])
        EXECUTE(@CurrentCommandSelect03)

        IF (SELECT [Count] FROM @tmpIsLOB) > 0 BEGIN SET @CurrentIsLOB = 1 END ELSE BEGIN SET @CurrentIsLOB = 0 END

        -- Is Allow_Page_Locks set to On?
      SET @CurrentCommandSelect04 = 'SELECT COUNT(*) FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[index_id] = ' + CAST(@CurrentIndexID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[allow_page_locks] = 1'

        INSERT INTO @tmpAllowPageLocks ([Count])
        EXECUTE(@CurrentCommandSelect04)

        IF (SELECT [Count] FROM @tmpAllowPageLocks) > 0 BEGIN SET @CurrentAllowPageLocks = 1 END ELSE BEGIN SET @CurrentAllowPageLocks = 0 END

        -- Is the index on a read-only filegroup?
        SET @CurrentCommandSelect05 = 'SELECT COUNT(*) FROM (SELECT ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.data_space_id FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.destination_data_spaces ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.data_space_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.destination_data_spaces.partition_scheme_id INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups ON ' + QUOTENAME(@CurrentDatabase) + '.sys.destination_data_spaces.data_space_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.data_space_id WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.is_read_only = 1 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[index_id] = ' + CAST(@CurrentIndexID AS nvarchar)
        IF @CurrentIsPartition = 1 SET @CurrentCommandSelect05 = @CurrentCommandSelect05 + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.destination_data_spaces.destination_id = ' + CAST(@CurrentPartitionNumber AS nvarchar)
        SET @CurrentCommandSelect05 = @CurrentCommandSelect05 + ' UNION SELECT ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.data_space_id FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups ON ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.data_space_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.data_space_id WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.is_read_only = 1 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar) + ' AND ' + QUOTENAME(@CurrentDatabase) + '.sys.indexes.[index_id] = ' + CAST(@CurrentIndexID AS nvarchar)
        IF @CurrentIndexType = 1 SET @CurrentCommandSelect05 = @CurrentCommandSelect05 + ' UNION SELECT ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.data_space_id FROM ' + QUOTENAME(@CurrentDatabase) + '.sys.tables INNER JOIN ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups ON ' + QUOTENAME(@CurrentDatabase) + '.sys.tables.lob_data_space_id = ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.data_space_id WHERE ' + QUOTENAME(@CurrentDatabase) + '.sys.filegroups.is_read_only = 1 AND ' + QUOTENAME(@CurrentDatabase) + '.sys.tables.[object_id] = ' + CAST(@CurrentObjectID AS nvarchar)
        SET @CurrentCommandSelect05 = @CurrentCommandSelect05 + ') ReadOnlyFileGroups'

        INSERT INTO @tmpOnReadOnlyFileGroup ([Count])
        EXECUTE(@CurrentCommandSelect05)

        IF (SELECT [Count] FROM @tmpOnReadOnlyFileGroup) > 0 BEGIN SET @CurrentOnReadOnlyFileGroup = 1 END ELSE BEGIN SET @CurrentOnReadOnlyFileGroup = 0 END

        -- Is the index fragmented?
        SELECT @CurrentFragmentationLevel = MAX(avg_fragmentation_in_percent),
               @CurrentPageCount = SUM(page_count)
        FROM sys.dm_db_index_physical_stats(DB_ID(@CurrentDatabase), @CurrentObjectID, @CurrentIndexID, @CurrentPartitionNumber, 'LIMITED')
        WHERE alloc_unit_type_desc = 'IN_ROW_DATA'
        AND index_level = 0
        SET @Error = @@ERROR
        IF @Error = 1222
        BEGIN
          SET @ErrorMessage = 'The dynamic management view sys.dm_db_index_physical_stats is locked on the index ' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + '.' + QUOTENAME(@CurrentIndexName) + '.' + CHAR(13) + CHAR(10)
          SET @ErrorMessage = REPLACE(@ErrorMessage,'%','%%')
          RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
          GOTO NoAction
        END

        -- Decide action
        SELECT @CurrentAction = CASE
        WHEN (@CurrentIsLOB = 1 OR @CurrentIsPartition = 1) AND @CurrentFragmentationLevel >= @FragmentationLevel2 AND @CurrentPageCount >= @PageCountLevel THEN @FragmentationHigh_LOB
        WHEN (@CurrentIsLOB = 0 AND @CurrentIsPartition = 0) AND @CurrentFragmentationLevel >= @FragmentationLevel2 AND @CurrentPageCount >= @PageCountLevel THEN @FragmentationHigh_NonLOB
        WHEN (@CurrentIsLOB = 1 OR @CurrentIsPartition = 1) AND @CurrentFragmentationLevel >= @FragmentationLevel1 AND @CurrentFragmentationLevel < @FragmentationLevel2 AND @CurrentPageCount >= @PageCountLevel THEN @FragmentationMedium_LOB
        WHEN (@CurrentIsLOB = 0 AND @CurrentIsPartition = 0) AND @CurrentFragmentationLevel >= @FragmentationLevel1 AND @CurrentFragmentationLevel < @FragmentationLevel2 AND @CurrentPageCount >= @PageCountLevel THEN @FragmentationMedium_NonLOB
        WHEN (@CurrentIsLOB = 1 OR @CurrentIsPartition = 1) AND (@CurrentFragmentationLevel < @FragmentationLevel1 OR @CurrentPageCount < @PageCountLevel) THEN @FragmentationLow_LOB
        WHEN (@CurrentIsLOB = 0 AND @CurrentIsPartition = 0) AND (@CurrentFragmentationLevel < @FragmentationLevel1 OR @CurrentPageCount < @PageCountLevel) THEN @FragmentationLow_NonLOB
        END

        -- Reorganizing an index is only allowed if Allow_Page_Locks is set to On
        IF @CurrentAction IN('INDEX_REORGANIZE','INDEX_REORGANIZE_STATISTICS_UPDATE') AND @CurrentAllowPageLocks = 0
        BEGIN
          SELECT @CurrentAction = CASE
          WHEN (@CurrentIsLOB = 0 AND @CurrentIsPartition = 0) AND 'INDEX_REBUILD_ONLINE' IN(@FragmentationHigh_NonLOB, @FragmentationMedium_NonLOB, @FragmentationLow_NonLOB) THEN 'INDEX_REBUILD_ONLINE'
          WHEN (@CurrentIsLOB = 0 AND @CurrentIsPartition = 0) AND 'INDEX_REBUILD_OFFLINE' IN(@FragmentationHigh_NonLOB, @FragmentationMedium_NonLOB, @FragmentationLow_NonLOB) THEN 'INDEX_REBUILD_OFFLINE'
          WHEN (@CurrentIsLOB = 1 OR @CurrentIsPartition = 1) AND 'INDEX_REBUILD_OFFLINE' IN(@FragmentationHigh_LOB, @FragmentationMedium_LOB, @FragmentationLow_LOB) THEN 'INDEX_REBUILD_OFFLINE'
          ELSE 'NOTHING'
          END
        END

        -- Create comment
        SET @CurrentComment = 'ObjectType: ' + CASE WHEN @CurrentObjectType = 'U' THEN 'Table' WHEN @CurrentObjectType = 'V' THEN 'View' ELSE 'N/A' END + ', '
        SET @CurrentComment = @CurrentComment + 'IndexType: ' + CASE WHEN @CurrentIndexType = 1 THEN 'Clustered' WHEN @CurrentIndexType = 2 THEN 'NonClustered' WHEN @CurrentIndexType = 3 THEN 'XML' WHEN @CurrentIndexType = 4 THEN 'Spatial' ELSE 'N/A' END + ', '
        SET @CurrentComment = @CurrentComment + 'LOB: ' + CASE WHEN @CurrentIsLOB = 1 THEN 'Yes' WHEN @CurrentIsLOB = 0 THEN 'No' ELSE 'N/A' END + ', '
        SET @CurrentComment = @CurrentComment + 'AllowPageLocks: ' + CASE WHEN @CurrentAllowPageLocks = 1 THEN 'Yes' WHEN @CurrentAllowPageLocks = 0 THEN 'No' ELSE 'N/A' END + ', '
        SET @CurrentComment = @CurrentComment + 'PageCount: ' + CAST(@CurrentPageCount AS nvarchar) + ', '
        SET @CurrentComment = @CurrentComment + 'Fragmentation: ' + CAST(@CurrentFragmentationLevel AS nvarchar)

        -- Check time limit
        IF GETDATE() >= DATEADD(ss,@TimeLimit,@StartTime)
        BEGIN
          SET @Execute = 'N'
        END

        IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE','INDEX_REORGANIZE','INDEX_REORGANIZE_STATISTICS_UPDATE') AND @CurrentOnReadOnlyFileGroup = 0
        BEGIN
          SET @CurrentCommand01 = 'ALTER INDEX ' + QUOTENAME(@CurrentIndexName) + ' ON ' + QUOTENAME(@CurrentDatabase) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName)

          IF @CurrentAction IN('INDEX_REBUILD_ONLINE','INDEX_REBUILD_OFFLINE')
          BEGIN
            SET @CurrentCommand01 = @CurrentCommand01 + ' REBUILD'
            IF @CurrentIsPartition = 1 SET @CurrentCommand01 = @CurrentCommand01 + ' PARTITION = ' + CAST(@CurrentPartitionNumber AS nvarchar)
            SET @CurrentCommand01 = @CurrentCommand01 + ' WITH ('
            IF @SortInTempdb = 'Y' SET @CurrentCommand01 = @CurrentCommand01 + 'SORT_IN_TEMPDB = ON'
            IF @SortInTempdb = 'N' SET @CurrentCommand01 = @CurrentCommand01 + 'SORT_IN_TEMPDB = OFF'
            IF @CurrentAction = 'INDEX_REBUILD_ONLINE' AND @CurrentIsPartition = 0 SET @CurrentCommand01 = @CurrentCommand01 + ', ONLINE = ON'
            IF @CurrentAction = 'INDEX_REBUILD_OFFLINE' AND @CurrentIsPartition = 0 SET @CurrentCommand01 = @CurrentCommand01 + ', ONLINE = OFF'
            IF @MaxDOP IS NOT NULL SET @CurrentCommand01 = @CurrentCommand01 + ', MAXDOP = ' + CAST(@MaxDOP AS nvarchar)
            IF @FillFactor IS NOT NULL AND @CurrentIsPartition = 0 SET @CurrentCommand01 = @CurrentCommand01 + ', FILLFACTOR = ' + CAST(@FillFactor AS nvarchar)
            SET @CurrentCommand01 = @CurrentCommand01 + ')'
          END

          IF @CurrentAction IN('INDEX_REORGANIZE','INDEX_REORGANIZE_STATISTICS_UPDATE')
          BEGIN
            SET @CurrentCommand01 = @CurrentCommand01 + ' REORGANIZE'
            IF @CurrentIsPartition = 1 SET @CurrentCommand01 = @CurrentCommand01 + ' PARTITION = ' + CAST(@CurrentPartitionNumber AS nvarchar)
            SET @CurrentCommand01 = @CurrentCommand01 + ' WITH ('
            IF @LOBCompaction = 'Y' SET @CurrentCommand01 = @CurrentCommand01 + 'LOB_COMPACTION = ON'
            IF @LOBCompaction = 'N' SET @CurrentCommand01 = @CurrentCommand01 + 'LOB_COMPACTION = OFF'
            SET @CurrentCommand01 = @CurrentCommand01 + ')'
          END

          EXECUTE @CurrentCommandOutput01 = [dbo].[CommandExecute] @CurrentCommand01, @CurrentComment, 2, @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput01 = @Error
        END

        IF @CurrentAction IN('INDEX_REORGANIZE_STATISTICS_UPDATE','STATISTICS_UPDATE') AND @CurrentOnReadOnlyFileGroup = 0 AND @CurrentIndexType IN(1,2) AND @CurrentIsPartition = 0
        BEGIN
          SET @CurrentCommand02 = 'UPDATE STATISTICS ' + QUOTENAME(@CurrentDatabase) + '.' + QUOTENAME(@CurrentSchemaName) + '.' + QUOTENAME(@CurrentObjectName) + ' ' + QUOTENAME(@CurrentIndexName)
          IF @StatisticsSample = 100 SET @CurrentCommand02 = @CurrentCommand02 + ' WITH FULLSCAN'
          IF @StatisticsSample IS NOT NULL AND @StatisticsSample <> 100 SET @CurrentCommand02 = @CurrentCommand02 + ' WITH SAMPLE ' + CAST(@StatisticsSample AS nvarchar) + ' PERCENT'

          EXECUTE @CurrentCommandOutput02 = [dbo].[CommandExecute] @CurrentCommand02, '', 2, @Execute
          SET @Error = @@ERROR
          IF @Error <> 0 SET @CurrentCommandOutput02 = @Error
        END

        NoAction:

        -- Update that the index is completed
        UPDATE @tmpIndexes
        SET Completed = 1
        WHERE IxID = @CurrentIxID

        -- Clear variables
        SET @CurrentCommandSelect02 = NULL
        SET @CurrentCommandSelect03 = NULL
        SET @CurrentCommandSelect04 = NULL
        SET @CurrentCommandSelect05 = NULL

        SET @CurrentCommand01 = NULL
        SET @CurrentCommand02 = NULL

        SET @CurrentCommandOutput01 = NULL
        SET @CurrentCommandOutput02 = NULL

        SET @CurrentIxID = NULL
        SET @CurrentSchemaID = NULL
        SET @CurrentSchemaName = NULL
        SET @CurrentObjectID = NULL
        SET @CurrentObjectName = NULL
        SET @CurrentObjectType = NULL
        SET @CurrentIndexID = NULL
        SET @CurrentIndexName = NULL
        SET @CurrentIndexType = NULL
        SET @CurrentPartitionID = NULL
        SET @CurrentPartitionNumber = NULL
        SET @CurrentPartitionCount = NULL
        SET @CurrentIsPartition = NULL
        SET @CurrentIndexExists = NULL
        SET @CurrentIsLOB = NULL
        SET @CurrentAllowPageLocks = NULL
        SET @CurrentOnReadOnlyFileGroup = NULL
        SET @CurrentFragmentationLevel = NULL
        SET @CurrentPageCount = NULL
        SET @CurrentAction = NULL
        SET @CurrentComment = NULL

        DELETE FROM @tmpIndexExists
        DELETE FROM @tmpIsLOB
        DELETE FROM @tmpAllowPageLocks
        DELETE FROM @tmpOnReadOnlyFileGroup

      END

    END

    -- Update that the database is completed
    UPDATE @tmpDatabases
    SET Completed = 1
    WHERE ID = @CurrentID

    -- Clear variables
    SET @CurrentID = NULL
    SET @CurrentDatabase = NULL
    SET @CurrentIsDatabaseAccessible = NULL
    SET @CurrentMirroringRole = NULL

    SET @CurrentCommandSelect01 = NULL

    DELETE FROM @tmpIndexes

  END

  ----------------------------------------------------------------------------------------------------
  --// Log completing information                                                                 //--
  ----------------------------------------------------------------------------------------------------

  Logging:
  SET @EndMessage = 'DateTime: ' + CONVERT(nvarchar,GETDATE(),120)
  SET @EndMessage = REPLACE(@EndMessage,'%','%%')
  RAISERROR(@EndMessage,10,1) WITH NOWAIT

  ----------------------------------------------------------------------------------------------------

END

