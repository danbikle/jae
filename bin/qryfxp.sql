--
-- ~/nia10/bin/qryfxp.sql
--

select * from fxp
where ttime = (select max(ttime) from fxp);

select * from fxp
where ttime + interval '1 hour' > (select max(ttime) from fxp)
order by pair,ttime;

