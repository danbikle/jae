--
-- ~/nia10/bin/now_getcp.sql
--

-- This script should merge data from these two files:
--  /tmp/fxcp:
--  -rw-rw-r--  1 dan  dan  37253 May  6 19:44 p01m.csv
--  -rw-rw-r--  1 dan  dan  31017 May  6 19:44 p05m.csv
-- Then it should COPY the rows into: /tmp/fxcp/uniq.csv

CREATE TABLE IF NOT EXISTS p01m(
  pair   VARCHAR
  ,utime NUMERIC
  ,cp    NUMERIC);

CREATE TABLE IF NOT EXISTS p05m(
  pair   VARCHAR
  ,utime NUMERIC
  ,cp    NUMERIC);

CREATE TABLE IF NOT EXISTS uniqp(
  pair   VARCHAR
  ,utime NUMERIC
  ,cp    NUMERIC);

TRUNCATE TABLE p01m;
TRUNCATE TABLE p05m;
TRUNCATE TABLE uniqp;

COPY p01m(
  pair
  ,utime
  ,cp
  ) FROM '/tmp/fxcp/p01m.csv' WITH csv;

COPY p05m(
  pair
  ,utime
  ,cp
  ) FROM '/tmp/fxcp/p05m.csv' WITH csv;

-- rpt
select count(*) from p01m;
select count(*) from p05m;

INSERT INTO uniqp (pair,utime,cp)
SELECT p01m.pair,p01m.utime,p01m.cp
FROM p01m, p05m
WHERE p01m.utime = p05m.utime
AND   p01m.pair  = p05m.pair
;

INSERT INTO uniqp (pair,utime,cp)
SELECT pair,utime,cp
FROM p05m
WHERE pair||utime NOT IN (SELECT pair||utime FROM p01m)
;

COPY(SELECT pair,utime,AVG(cp) cp FROM uniqp GROUP BY pair,utime ORDER BY pair,utime)TO '/tmp/fxcp/uniq.csv' csv;

-- done
