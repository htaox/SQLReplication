EXEC PublisherDB.sys.sp_dropsubscription 
    @publication = N'Pulication',
    @article = N'Article',
    @subscriber = N'Subscriber',
    @destination_db = N'DestinationDB' ;
GO

EXEC PublisherDB.sys.sp_droparticle 
    @publication = N'Pulication',
    @article = N'Article'
GO