--PUSH
--On Publisher
use [DBOne]
exec sp_addsubscription 
	@publication = N'DBOneReplica', 
	@subscriber = N'HYPERINST3', 
	@destination_db = N'DBOne', 
	@sync_type = N'initialize with backup', 
	@backupdevicetype = 'disk', 
	@backupdevicename = '\\HYPERINST2\Backup\DBOne_20140114.full', 
	@subscription_type = N'PUSH', 
	@update_mode = N'read only'
go

exec sp_addpushsubscription_agent 
	@publication = N'DBOneReplica', 
	@subscriber = N'HYPERINST3', 
	@subscriber_db = N'DBOne', 
	@job_login = null, 
	@job_password = null, 
	@subscriber_security_mode = 1, 
	@frequency_type = 64, 
	@frequency_interval = 0, 
	@frequency_relative_interval = 0, 
	@frequency_recurrence_factor = 0, 
	@frequency_subday = 0, 
	@frequency_subday_interval = 0, 
	@active_start_time_of_day = 0, 
	@active_end_time_of_day = 235959, 
	@active_start_date = 20140113, 
	@active_end_date = 99991231, 
	@enabled_for_syncmgr = N'False'
	
GO
