select 'USE ' + QUOTENAME(a.publisher_db) + '
EXEC sp_changearticle 
  @publication = ''' + p.publication +''',
  @article = ''' + a.article + ''', 
  @property = N''schema_option'', 
  @value = ''0x000000010A030097'',
  @force_reinit_subscription = 1,
  @force_invalidate_snapshot = 1', *
from dbo.MSarticles a
	join dbo.MSpublications P with(nolock) on P.publication_id = A.publication_id and P.publisher_id = A.publisher_id
where P.publication in ('pub1', 'pub2')