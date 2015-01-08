use distribution

select top 100 *
from dbo.MSrepl_errors
order by time desc

exec sp_browsereplcmds 
	@xact_seqno_start = '0x000001C1000168A500E000000000', 
	@xact_seqno_end = '0x000001C1000168A500E000000000'	
	--,@publisher_database_id = 1
	--,@article_id =
	--,@command_id = 
	
