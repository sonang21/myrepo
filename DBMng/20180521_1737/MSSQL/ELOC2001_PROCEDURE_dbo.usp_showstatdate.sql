/* *************************************************************************
 * NAME : dbo.usp_showstatdate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-01-05 19:18:05.483
 *        Modify: 2018-05-03 17:23:35.81
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc usp_showstatdate
@tabmask sysname ='%'
,@indmask sysname='%'
as

select
left(cast(user_name(uid)+'.'+o.name as sysname), 30) as tablename,
left(i.name,30) as indexname,
case when indexproperty(o.id, i.name, 'IsAutoStatistics') = 1 then 'AutoStaticstics'
when indexproperty(o.id, i.name,'IsStatistics') = 1 then 'Statistics'
else 'Index'
end as Type,
stats_date(o.id, i.indid) as statsUpdated,
rowcnt,
rowmodctr,
isnull(cast(rowmodctr/cast(nullif(rowcnt,0) as decimal (20,2)) * 100 as int), 0)
as percentmodifiedRows,
case i.status & 0x1000000
when 0 then 'No'
else 'Yes'
end As [norecompute?],
i.status

from dbo.sysobjects o join dbo.sysindexes i on (o.id = i.id)
where o.name like @tabmask
and i.name like @indmask
and objectproperty(o.id, 'IsUserTable') = 1
and i.indid between 1 and 254
order by tableName, Indexname
