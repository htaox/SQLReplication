use distribution

select 
	(case mdh.runstatus	
		when 1 then 'Start - 1'
		when 2 then 'Succeed - 2'
		when 3 then 'InProgress - 3'
		when 4 then 'Idle - 4'
		when 5 then 'Retry - 5'
		when 6 then 'Fail - 6'
		else 'Unknown - ' + cast(mdh.runstatus as varchar)
	end) as [Run Status], 
	sp.srvname as [Publisher],
	mda.publication as [Publication],
	mda.publisher_db + ' (id: '+ cast(mda.publisher_database_id as varchar) + ')' as [Publisher DB],
	ss.srvname as [Subscriber],
	mda.subscriber_db as [Subscriber DB], 
	convert(varchar(100), mdh.[time], 104) + ' '  + convert(varchar(100), mdh.[time], 108) as [LastSynchronized],
	und.UndelivCmdsInDistDB as [UndistCmds], 
	mdh.comments [Comments], 
	--mdh.xact_seqno [SEQ_NO],
	(case mda.subscription_type
		when 0 then 'Push' 
		when 1 then 'Pull' 
		when 2 then 'Anonymous' 
		else cast(mda.subscription_type as varchar)		
	end) as [Subscribtion Type],
	mda.name [Publisher - DB - Publication - SUB - AgentID]
from dbo.MSdistribution_agents mda with(nolock)
	left join sys.sysservers sp on sp.srvid = mda.publisher_id
	left join sys.sysservers ss on ss.srvid = mda.subscriber_id
	left join dbo.MSdistribution_history mdh with(nolock) on mdh.agent_id = mda.id 
	join (	select	s.agent_id, 
					MaxAgentValue.[time], 
					sum(case when xact_seqno > MaxAgentValue.maxseq then 1 else 0 end) as UndelivCmdsInDistDB 
			from dbo.MSrepl_commands t (nolock)  
				join dbo.MSsubscriptions as s (nolock) on (t.article_id = s.article_id and t.publisher_database_id=s.publisher_database_id ) 
				join (	select	hist.agent_id, 
								max(hist.[time]) as [time], 
								h.maxseq	  
						from dbo.MSdistribution_history hist (nolock) 
							join (	select	agent_id,
											isnull(max(xact_seqno),0x0) as maxseq 
									from dbo.MSdistribution_history (nolock)  
									group by agent_id) as h on (hist.agent_id=h.agent_id and h.maxseq=hist.xact_seqno) 
						group by hist.agent_id, h.maxseq 
					) as MaxAgentValue on MaxAgentValue.agent_id = s.agent_id 
			group by s.agent_id, MaxAgentValue.[time] 
		) und on mda.id = und.agent_id and und.[time] = mdh.[time] 
where mda.subscriber_id >= 0
order by [Publication], [Subscriber DB]
