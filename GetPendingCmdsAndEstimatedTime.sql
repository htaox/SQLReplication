use distribution

exec sp_replmonitorsubscriptionpendingcmds 
	@publisher = 'Publisher',
	@publisher_db = 'Publisher',
	@publication = 'Publication',
	@subscriber = 'Subscriber',
	@subscriber_db = 'Subscriber',
	@subscription_type = '0' -- 0 - Push, 1 - Pull