--PULL 
--On Publisher
use DBOne
exec sp_addsubscription 
	@publication = N'DBOneReplica', 
	@subscriber = N'HYPERINST3', 
	@destination_db = N'DBOne', 
	@sync_type = N'initialize with backup', 
	@backupdevicetype = 'disk', 
	@backupdevicename = '\\HYPERINST2\Backup\DBOne_20140113.full', 
	@subscription_type = N'pull', 
	@update_mode = N'read only'
GO
