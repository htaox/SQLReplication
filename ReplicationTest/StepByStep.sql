/*

0. Create database 
1. Setup Distributer and Publisher	
2. Create publication. DON'T use snapshop for init. 
	a. Publication property 'initialize from backup' must equal TRUE.
3. Disable the distribution cleanup agent job.
4. Create full backup of publisher database.
	4a. Add Test data on Publisher
5. Restore database on subscriber.

6. Add subscribtion (sp_addsubscription) on publisher

	For PUSH subscription:
		6. Add PUSH agent on publisher (sp_addpushsubscription_agent)

	For PULL subscription:
		7. Add PULL subscribtion on subscriber (ONLY FOR PULL)
			a. sp_addpullsubscription - add subscription 
			b. sp_addpullsubscription_agent - add pull agent, which will pull data from publisher

To this time wa have a working subscriber.  !!! Wait for full sync.!!!
8. Change publication property 'initialize from backup' to FALSE.
 
9. TEST SUBSCRIPTION.

--Setup back subscription

10. Setup Distributer and Publisher on Subscriber
11. New DBCC CHECKIDENT for all tables 
12. Create publication. 	
13. Create back Subscription without init. (replication support only)

14. TEST SUBSCRIPTION.

15. Enable the distribution cleanup agent job.

*/