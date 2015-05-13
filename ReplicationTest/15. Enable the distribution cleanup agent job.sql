exec msdb.dbo.sp_update_job 
	@job_name = 'Distribution clean up: distribution', 
	@enabled = 1