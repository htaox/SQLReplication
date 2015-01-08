--Replication Map

use distribution

select	distinct
		S.srvname as [Publisher], 
		P.publisher_db as [Publisher DB],
		P.publication as [Publication],
		A.source_owner + '.' + A.source_object as [Source Article],
		' >>>> ' as [To],
		SS.srvname as [Subscriber],
		SBC.subscriber_db as [Subscriber DB],
		isnull(A.destination_owner,'') + '.' + A.destination_object as [Destination Article]
from dbo.MSarticles A with(nolock)
	join dbo.MSpublications P with(nolock) on P.publication_id = A.publication_id and P.publisher_id = A.publisher_id
	join sys.sysservers S with(nolock) ON S.srvid = P.publisher_id
	left join dbo.MSsubscriptions SBC with(nolock) on SBC.publication_id = P.publication_id and SBC.publisher_id = P.publisher_id and SBC.subscriber_id >= 0
	left join sys.sysservers SS with(nolock) ON SS.srvid = SBC.subscriber_id
order by	[Publisher],
			[Subscriber],
			[Publisher DB],
			[Publication],
			[Subscriber DB],
			[Source Article],			
			[Destination Article]



