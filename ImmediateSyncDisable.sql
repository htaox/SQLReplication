exec sp_changepublication
	@publication = 'Publication',
	@property = 'allow_anonymous',
	@value = 'false'

exec sp_changepublication
	@publication = 'Publication',
	@property = 'immediate_sync',
	@value = 'false'

