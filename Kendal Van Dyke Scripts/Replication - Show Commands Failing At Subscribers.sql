/*********************************************************************************************
Replication - Find Failing Replication Commands v1.00 (2010-11-01)
(C) 2010, Kendal Van Dyke

Feedback: mailto:kendal.vandyke@gmail.com

License: 
	This query is free to download and use for personal, educational, and internal 
	corporate purposes, provided that this header is preserved. Redistribution or sale 
	of this query, in whole or in part, is prohibited without the author's express 
	written consent.
	
Note: 
	This query will help find the commands that are failing due to "row not found at subscriber" or a PK violation
	Execute this query on the DISTRIBUTOR

*********************************************************************************************/

--USE distribution	-- Change this if your distribution database has a different name
GO

-- Step 1) Use Replication Monitor to view details for distribution agent throwing errors, or use sp_helpsubscriptionerrors. 
EXEC sp_helpsubscriptionerrors @publisher = 'Publisher'
        , @publisher_db = 'Publisher_db' 
        , @publication = 'Publication' 
        , @subscriber = 'Subscriber' 
        , @subscriber_db = 'Subscriber_db'
        
        
-- Step 2) Use this query to retrieve the publisher_database_id for the publisher\publication\subscriber combination
SELECT  DISTINCT
        subscriptions.publisher_database_id
FROM    sys.servers AS [publishers]
        INNER JOIN dbo.MSpublications AS [publications] ON publishers.server_id = publications.publisher_id
        INNER JOIN dbo.MSarticles AS [articles] ON publications.publication_id = articles.publication_id
        INNER JOIN dbo.MSsubscriptions AS [subscriptions] ON articles.article_id = subscriptions.article_id
                                                             AND articles.publication_id = subscriptions.publication_id
                                                             AND articles.publisher_db = subscriptions.publisher_db
                                                             AND articles.publisher_id = subscriptions.publisher_id
        INNER JOIN sys.servers AS [subscribers] ON subscriptions.subscriber_id = subscribers.server_id
WHERE   publishers.name = 'publisher'
        AND publications.publication = 'publication'
        AND subscribers.name = 'subscriber'


-- Step 3) Plug values from step 1 (@xact_seqno_end and @command_id) and step 2 (@publisher_database_id) into query below and run on distributor
EXEC sp_browsereplcmds @xact_seqno_start = '0x000562790001E635005800000000'
    , @xact_seqno_end = '0x000562790001E635005800000000'
    , @publisher_database_id = 63
    , @command_id = 2