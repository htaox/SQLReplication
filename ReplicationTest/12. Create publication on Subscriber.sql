use [DBOne]
exec sp_replicationdboption 
	@dbname = N'DBOne', 
	@optname = N'publish', 
	@value = N'true'
GO
-- Adding the transactional publication
use [DBOne]
exec sp_addpublication 
	@publication = N'DBOneReplicaBack', 
	@description = N'Transactional publication of database ''DBOne'' from Publisher ''HYPERINST3''.', 
	@sync_method = N'concurrent', 
	@retention = 0, 
	@allow_push = N'true', 
	@allow_pull = N'true', 
	@allow_anonymous = N'false', 
	@enabled_for_internet = N'false', 
	@snapshot_in_defaultfolder = N'true', 
	@compress_snapshot = N'false', 
	@ftp_port = 21, 
	@ftp_login = N'anonymous', 
	@allow_subscription_copy = N'false', 
	@add_to_active_directory = N'false', 
	@repl_freq = N'continuous', 
	@status = N'active', 
	@independent_agent = N'true', 
	@immediate_sync = N'false', 
	@allow_sync_tran = N'false', 
	@autogen_sync_procs = N'false', 
	@allow_queued_tran = N'false', 
	@allow_dts = N'false', 
	@replicate_ddl = 1, 
	@allow_initialize_from_backup = N'TRUE', 
	@enabled_for_p2p = N'false', 
	@enabled_for_het_sub = N'false'
GO


exec sp_addpublication_snapshot 
	@publication = N'DBOneReplicaBack', 
	@frequency_type = 1, 
	@frequency_interval = 0, 
	@frequency_relative_interval = 0, 
	@frequency_recurrence_factor = 0, 
	@frequency_subday = 0, 
	@frequency_subday_interval = 0, 
	@active_start_time_of_day = 0, 
	@active_end_time_of_day = 235959, 
	@active_start_date = 0, 
	@active_end_date = 0, 
	@job_login = null, 
	@job_password = null, 
	@publisher_security_mode = 1


use [DBOne]
exec sp_addarticle 
	@publication = N'DBOneReplicaBack', 
	@article = N'A', 
	@source_owner = N'dbo', 
	@source_object = N'A', 
	@type = N'logbased', 
	@description = null, 
	@creation_script = null, 
	@pre_creation_cmd = N'drop', 
	@schema_option = 0x000000000803509F, 
	@identityrangemanagementoption = N'manual', 
	@destination_table = N'A', 
	@destination_owner = N'dbo', 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL sp_MSins_dboA', 
	@del_cmd = N'CALL sp_MSdel_dboA', 
	@upd_cmd = N'SCALL sp_MSupd_dboA'
GO




use [DBOne]
exec sp_addarticle 
	@publication = N'DBOneReplicaBack', 
	@article = N'B', 
	@source_owner = N'dbo', 
	@source_object = N'B', 
	@type = N'logbased', 
	@description = null, 
	@creation_script = null, 
	@pre_creation_cmd = N'drop', 
	@schema_option = 0x000000000803509F, 
	@identityrangemanagementoption = N'manual', 
	@destination_table = N'B', 
	@destination_owner = N'dbo', 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL sp_MSins_dboB', 
	@del_cmd = N'CALL sp_MSdel_dboB', 
	@upd_cmd = N'SCALL sp_MSupd_dboB'
GO




use [DBOne]
exec sp_addarticle 
	@publication = N'DBOneReplicaBack', 
	@article = N'C', 
	@source_owner = N'dbo', 
	@source_object = N'C', 
	@type = N'logbased', 
	@description = null, 
	@creation_script = null, 
	@pre_creation_cmd = N'drop', 
	@schema_option = 0x000000000803509F, 
	@identityrangemanagementoption = N'manual', 
	@destination_table = N'C', 
	@destination_owner = N'dbo', 
	@vertical_partition = N'false', 
	@ins_cmd = N'CALL sp_MSins_dboC', 
	@del_cmd = N'CALL sp_MSdel_dboC', 
	@upd_cmd = N'SCALL sp_MSupd_dboC'
GO




