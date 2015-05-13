--On Subscriber
restore database DBOne
from disk = '\\HYPERINST2\Backup\DBOne_20140114.full'
with file = 1,
	--move 'DBOne' to 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DBTwo.mdf',
	--move 'DBOne_Log' to 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DBTwo_log.ldf',	
	stats= 2,			
	checksum