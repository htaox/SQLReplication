--This stored procedure is executed at the Distributor on any database.

exec sp_changedistpublisher 
		@publisher = 'Publisher', 
		@property = 'working_directory', 
		@value = 'D:\SQLEngine\ReplData' 

select	name, 
		working_directory 
from msdb.dbo.MSdistpublishers