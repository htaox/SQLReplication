--MSDN https://msdn.microsoft.com/en-us/library/ms188413.aspx
USE PublisherDB
go
EXEC sp_changepublication 
  @publication = 'Publication', 
  @property = N'<option_name>', 
  @value = 0
  
go
