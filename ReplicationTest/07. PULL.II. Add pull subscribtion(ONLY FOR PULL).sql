--PULL 
--On Subscriber
use DBOne
exec sp_addpullsubscription 
	@publisher = N'HYPERINST2', 
	@publication = N'DBOneReplica', 
	@publisher_db = N'DBOne', 
	@independent_agent = N'True', 
	@subscription_type = N'pull', 
	@description = N'', 
	@update_mode = N'read only', 
	@immediate_sync = 0

exec sp_addpullsubscription_agent 
	@publisher = N'HYPERINST2', 
	@publisher_db = N'DBOne', 
	@publication = N'DBOneReplica', 
	@distributor = N'HYPERINST2', 
	@distributor_security_mode = 1, 
	@enabled_for_syncmgr = N'False', 
	@frequency_type = 64, 
	@frequency_interval = 0, 
	@frequency_relative_interval = 0, 
	@frequency_recurrence_factor = 0, 
	@frequency_subday = 0, 
	@frequency_subday_interval = 0, 
	@active_start_time_of_day = 0, 
	@active_end_time_of_day = 235959, 
	@active_start_date = 20090902, 
	@active_end_date = 99991231, 
	@alt_snapshot_folder = N'',			
	@working_directory = N'', 
	@use_ftp = N'False', 
	@job_login = null, 
	@job_password = null, 
	@publication_type = 0
GO


