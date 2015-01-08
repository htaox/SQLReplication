use distribution	

exec sp_replmonitorhelpsubscription   
	@publisher = null,
	@publisher_db = null,
	@publication = null,
	@publication_type = 0,
	@mode = 0,
	@topnum = null,
	@exclude_anonymous = null,
	@refreshpolicy = 0
