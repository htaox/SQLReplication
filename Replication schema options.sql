--Source http://www.englishtosql.com/english-to-sql-blog/2010/9/9/calculating-replication-schema-options.html

/* PROVIDES THE REPLICATION OPTIONS ENABLED FOR A GIVEN @SCHEMA_OPTION IN SYSARTICLES */
declare @schema_option varbinary(8) = 0x0000000000007F55, --0x0000000000007F55 --< PUT YOUR SCHEMA_OPTION HERE
		@NonClusteredIndex	bigint = cast(0x40 as bigint),
		@TableStatistics	bigint = cast(0x200000 as bigint),
		@FTIndex			bigint = cast(0x1000000 as bigint),
		@XMLIndex			bigint = cast(0x4000000 as bigint),
		@FilteredIndex		bigint = cast(0x4000000000 as bigint),
		@GeoIndex			bigint = cast(0x10000000000 as bigint)

select @schema_option

--disable next options
if cast(@schema_option as bigint) & @NonClusteredIndex  <> 0
	set @schema_option ^= @NonClusteredIndex  

if cast(@schema_option as bigint) & @FilteredIndex <> 0
	set @schema_option ^= @FilteredIndex  

if cast(@schema_option as bigint) & @TableStatistics <> 0
	set @schema_option ^= @TableStatistics

if cast(@schema_option as bigint) & @FTIndex <> 0
	set @schema_option ^= @FTIndex

if cast(@schema_option as bigint) & @XMLIndex <> 0
	set @schema_option ^= @XMLIndex

if cast(@schema_option as bigint) & @XMLIndex <> 0
	set @schema_option ^= @GeoIndex

select @schema_option

set nocount on
declare @OptionTable table ( HexValue varbinary(8), IntValue as cast(HexValue as bigint), OptionDescription varchar(255))

insert into @OptionTable (HexValue, OptionDescription) values
	(0x01 ,			'Generates object creation script'),
	(0x02 ,			'Generates procs that propogate changes for the article'),
	(0x04 ,			'Identity columns are scripted using the IDENTITY property'),
	(0x08 ,			'Replicate timestamp columns (if not set timestamps are replicated as binary)'),
	(0x10 ,			'Generates corresponding clustered index'),
	(0x20 ,			'Converts UDT to base data types'),
	(0x40 ,			'Create corresponding nonclustered indexes'),
	(0x80 ,			'Replicate pk constraints'),
	(0x100 ,		'Replicates user triggers'),
	(0x200 ,		'Replicates foreign key constraints'),
	(0x400 ,		'Replicates check constraints'),
	(0x800  ,		'Replicates defaults'),
	(0x1000 ,		'Replicates column-level collation'),
	(0x2000 ,		'Replicates extended properties'),
	(0x4000 ,		'Replicates UNIQUE constraints'),
	(0x8000 ,		'Not valid'),
	(0x10000 ,		'Replicates CHECK constraints as NOT FOR REPLICATION so are not enforced during sync'),
	(0x20000 ,		'Replicates FOREIGN KEY constraints as NOT FOR REPLICATION so are not enforced during sync'),
	(0x40000 ,		'Replicates filegroups'),
	(0x80000 ,		'Replicates partition scheme for partitioned table'),
	(0x100000 ,		'Replicates partition scheme for partitioned index'),
	(0x200000 ,		'Replicates table statistics'),
	(0x400000 ,		'Default bindings'),
	(0x800000 ,		'Rule bindings'),
	(0x1000000 ,	'Full text index'),
	(0x2000000 ,	'XML schema collections bound to xml columns not replicated'),
	(0x4000000 ,	'Replicates indexes on xml columns'),
	(0x8000000 ,	'Creates schemas not present on subscriber'),
	(0x10000000 ,	'Converts xml columns to ntext'),
	(0x20000000 ,	'Converts (max) data types to text/image'),
	(0x40000000 ,	'Replicates permissions'),
	(0x80000000 ,	'Drop dependencies to objects not part of publication'),
	(0x100000000 ,	'Replicate FILESTREAM attribute (2008 only)'),
	(0x200000000 ,	'Converts date & time data types to earlier versions'),
	(0x400000000 ,	'Replicates compression option for data & indexes'),
	(0x800000000  ,	'Store FILESTREAM data on its own filegroup at subscriber'),
	(0x1000000000 ,	'Converts CLR UDTs larger than 8000 bytes to varbinary(max)'),
	(0x2000000000 ,	'Converts hierarchyid to varbinary(max)'),
	(0x4000000000 ,	'Replicates filtered indexes'),
	(0x8000000000,	'Converts geography, geometry to varbinary(max)'),
	(0x10000000000 ,'Replicates geography, geometry indexes'),
	(0x20000000000 ,'Replicates SPARSE attribute ')
				  

select	HexValue,
		OptionDescription as 'Schema Options Enabled', 
		(cast(@schema_option as bigint) & cast(HexValue as bigint)) as Bit
from @OptionTable 
where (cast(@schema_option as bigint) & cast(HexValue as bigint)) <> 0





/* PROVIDES A VALUE FOR @SCHEMA_OPTION BASED UPON YOUR REPLICATION REQUIREMENTS

	 There are varying defaults for replication depending upon the type of object being
	 replicated and the replication type.
	 
	 The default values for transactional logbased replication are already uncommented per BOL
	 is 0x30F3 (this is the value that would be used were no schema options provided).
	 
	 I have found when setting up transactional replication in SQL 2008 using the GUI that the
	 schema option used is 0x000000000803509F if no changes are made. This schema option is what is 
	 reflected in the already uncommented and marked DEFAULT lines below.
	 
	 Uncomment the rows for any extra schema options and run the query to get the schema option you
	 should use in sp_addarticle (see BOL for full description)
*/
select cast(
  cast(0x01 AS BIGINT) --DEFAULT Generates object creation script
| cast(0x02 AS BIGINT) --DEFAULT Generates procs that propogate changes for the article
| cast(0x04 AS BIGINT) --Identity columns are scripted using the IDENTITY property
| cast(0x08 AS BIGINT) --DEFAULT Replicate timestamp columns (if not set timestamps are replicated as binary)
| cast(0x10 AS BIGINT) --DEFAULT Generates corresponding clustered index
--| cast(0x20 AS BIGINT) --Converts UDT to base data types
--| cast(0x40 AS BIGINT) --Create corresponding nonclustered indexes
| cast(0x80 AS BIGINT) --DEFAULT Replicate pk constraints
--| cast(0x100 AS BIGINT) --Replicates user triggers
--| cast(0x200 AS BIGINT) --Replicates foreign key constraints
--| cast(0x400 AS BIGINT) --Replicates check constraints
--| cast(0x800 AS BIGINT)  --Replicates defaults
| cast(0x1000 AS BIGINT) --DEFAULT Replicates column-level collation
--| cast(0x2000 AS BIGINT) --Replicates extended properties
| cast(0x4000 AS BIGINT) --DEFAULT Replicates UNIQUE constraints
--| cast(0x8000 AS BIGINT) --Not valid
| cast(0x10000 AS BIGINT) --DEFAULT Replicates CHECK constraints as NOT FOR REPLICATION so are not enforced during sync
| cast(0x20000 AS BIGINT) --DEFAULT Replicates FOREIGN KEY constraints as NOT FOR REPLICATION so are not enforced during sync
--| cast(0x40000 AS BIGINT) --Replicates filegroups (filegroups must already exist on subscriber)
--| cast(0x80000 AS BIGINT) --Replicates partition scheme for partitioned table
--| cast(0x100000 AS BIGINT) --Replicates partition scheme for partitioned index
--| cast(0x200000 AS BIGINT) --Replicates table statistics
--| cast(0x400000 AS BIGINT) --Default bindings
--| cast(0x800000 AS BIGINT) --Rule bindings
--| cast(0x1000000 AS BIGINT) --Full text index
--| cast(0x2000000 AS BIGINT) --XML schema collections bound to xml columns not replicated
--| cast(0x4000000 AS BIGINT) --Replicates indexes on xml columns
| cast(0x8000000 AS BIGINT) --DEFAULT Creates schemas not present on subscriber
--| cast(0x10000000 AS BIGINT) --Converts xml columns to ntext
--| cast(0x20000000 AS BIGINT) --Converts (max) data types to text/image
--| cast(0x40000000 AS BIGINT) --Replicates permissions
--| cast(0x80000000 AS BIGINT) --Drop dependencies to objects not part of publication
--| cast(0x100000000 AS BIGINT) --Replicate FILESTREAM attribute (2008 only)
--| cast(0x200000000 AS BIGINT) --Converts date & time data types to earlier versions
--| cast(0x400000000 AS BIGINT) --Replicates compression option for data & indexes
--| cast(0x800000000 AS BIGINT)  --Store FILESTREAM data on its own filegroup at subscriber
--| cast(0x1000000000 AS BIGINT) --Converts CLR UDTs larger than 8000 bytes to varbinary(max)
--| cast(0x2000000000 AS BIGINT) --Converts hierarchyid to varbinary(max)
--| cast(0x4000000000 AS BIGINT) --Replicates filtered indexes
--| cast(0x8000000000 AS BIGINT) --Converts geography, geometry to varbinary(max)
--| cast(0x10000000000 AS BIGINT) --Replicates geography, geometry indexes
--| cast(0x20000000000 AS BIGINT) --Replicates SPARSE attribute 
AS BINARY(8)) as Schema_Option



