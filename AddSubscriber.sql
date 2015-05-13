--Add PUSH subscriber

use PublisherDB
exec sp_addsubscription 
    @publication = N'Publication_Name', 
    @subscriber = N'SubscriberInstance', 
    @destination_db = N'DestinationDB', 
    @sync_type = N'initialize with backup', 
    @backupdevicetype = 'disk', 
    @backupdevicename = '\\path\to\log.trn', 
    @subscription_type = N'PUSH', 
    @update_mode = N'read only'
go

exec sp_addpushsubscription_agent 
    @publication = N'Publication_Name', 
    @subscriber = N'SubscriberInstance', 
    @subscriber_db = N'DestinationDB', 
    @job_login = null, 
    @job_password = null, 
    @subscriber_security_mode = 1, 
    @frequency_type = 4, 
    @frequency_interval = 1, 
    @frequency_relative_interval = 0,	
    @frequency_recurrence_factor = 0, 
    @frequency_subday = 8, 
    @frequency_subday_interval = 2, 
    @active_start_time_of_day = 090000, 
    @active_end_time_of_day = 235959, 
    @active_start_date = 20140113, 
    @active_end_date = 99991231, 
    @enabled_for_syncmgr = N'False'
