use DBOne
EXEC sp_changepublication 
  @publication = 'DBOneReplica', 
  @property = N'allow_initialize_from_backup', 
  @value = 'false'
GO