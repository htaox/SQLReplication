select DATABASEPROPERTYEX ( 'Distribution', 'IsSyncWithBackup' )

exec sp_replicationdboption
	@dbname = 'Distribution',
	@optname = 'sync with backup',
	@value = 'false'

select name, recovery_model_desc, is_sync_with_backup
from sys.databases 
where database_id > 4
