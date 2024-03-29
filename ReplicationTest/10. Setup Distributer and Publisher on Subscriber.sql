--On Subscriber
use master
exec sp_adddistributor 
	@distributor = N'HYPERINST3', 
	@password = null
GO
exec sp_adddistributiondb 
	@database = N'distribution', 
	@data_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data', 
	@log_folder = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data', 
	@log_file_size = 2, 
	@min_distretention = 0, 
	@max_distretention = 72, 
	@history_retention = 48, 
	@security_mode = 1
GO

use [distribution] 
if (not exists (select * from sysobjects where name = 'UIProperties' and type = 'U ')) 
	create table UIProperties(id int) 
if (exists (select * from ::fn_listextendedproperty('SnapshotFolder', 'user', 'dbo', 'table', 'UIProperties', null, null))) 
	EXEC sp_updateextendedproperty N'SnapshotFolder', N'\\HYPERINST3\ReplData', 'user', dbo, 'table', 'UIProperties' 
else 
	EXEC sp_addextendedproperty N'SnapshotFolder', N'\\HYPERINST3\ReplData', 'user', dbo, 'table', 'UIProperties'
GO

exec sp_adddistpublisher 
	@publisher = N'HYPERINST3', 
	@distribution_db = N'distribution', 
	@security_mode = 1, 
	@working_directory = N'\\HYPERINST3\ReplData', 
	@trusted = N'false', 
	@thirdparty_flag = 0, 
	@publisher_type = N'MSSQLSERVER'
GO
