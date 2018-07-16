-- set sqlcmdpassword=mig1020
-- sqlcmd -S 100.100.100.195 -U migadm -P mig1020 -i sample.sql -o sample.out -e sample.out

select 1, @@version;
go

select 2, @@spid;
go

select 'error' from errorortablexxx
go

declare @var varchar(100) = '$(myval)'
select 4, @var;
go

