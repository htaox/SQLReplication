alter table TableName add vat_sum decimal(19,4) null 
exec sp_register_custom_scripting 'CUSTOM_SCRIPT', '\\HYPERINST2\ReplData\alter.sql', 'Replica', 'TableName'
exec sp_register_custom_scripting 'insert', 'ReplicaProc_for_Insert', 'Replica', 'TableName'
exec sp_register_custom_scripting 'update', 'ReplicaProc_for_Update', 'Replica', 'TableName'