--
-- ~/nia10/bin/merge_truefx_ib4.sql
--

-- Demo:
-- ./psql.bash -f merge_truefx_ib4.sql

-- This script should merge data from 2 tables:
-- truefx
-- ibfxcp
-- into:
-- allp

CREATE TABLE IF NOT EXISTS allp(
  pair   VARCHAR
  ,utime NUMERIC
  ,cp    NUMERIC);

TRUNCATE TABLE allp;

-- In postgres how to convert TIMESTAMP into unix time?
-- EXTRACT(EPOCH FROM ydate)::INT AS unixtime

SELECT MAX(ttime) FROM truefx WHERE pair='aud_usd';
SELECT MIN(utime) FROM ibfxcp WHERE pair='aud_usd';

SELECT MAX(EXTRACT(EPOCH FROM ttime)::INT) FROM truefx WHERE pair='aud_usd';
SELECT MIN(EXTRACT(EPOCH FROM ttime)::INT) FROM truefx WHERE pair='aud_usd';

SELECT MAX(EXTRACT(EPOCH FROM ttime)::INT) FROM truefx WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='aud_usd') AND pair='aud_usd';

INSERT INTO allp(pair,utime,cp)
SELECT pair,EXTRACT(EPOCH FROM ttime)::INT,cp
FROM truefx
WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='aud_usd')
AND pair='aud_usd';

INSERT INTO allp(pair,utime,cp)
SELECT pair,EXTRACT(EPOCH FROM ttime)::INT,cp
FROM truefx
WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='eur_usd')
AND pair='eur_usd';

INSERT INTO allp(pair,utime,cp)
SELECT pair,EXTRACT(EPOCH FROM ttime)::INT,cp
FROM truefx
WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='eur_gbp')
AND pair='eur_gbp';

INSERT INTO allp(pair,utime,cp)
SELECT pair,EXTRACT(EPOCH FROM ttime)::INT,cp
FROM truefx
WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='gbp_usd')
AND pair='gbp_usd';

INSERT INTO allp(pair,utime,cp)
SELECT pair,EXTRACT(EPOCH FROM ttime)::INT,cp
FROM truefx
WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='nzd_usd')
AND pair='nzd_usd';

INSERT INTO allp(pair,utime,cp)
SELECT pair,EXTRACT(EPOCH FROM ttime)::INT,cp
FROM truefx
WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='usd_cad')
AND pair='usd_cad';

INSERT INTO allp(pair,utime,cp)
SELECT pair,EXTRACT(EPOCH FROM ttime)::INT,cp
FROM truefx
WHERE EXTRACT(EPOCH FROM ttime)::INT < (SELECT MIN(utime) FROM ibfxcp WHERE pair='usd_jpy')
AND pair='usd_jpy';

-- Now I should get the IB data:
INSERT INTO allp(pair,utime,cp) SELECT pair,utime,cp FROM ibfxcp;

-- rpt
SELECT pair, MIN(utime),COUNT(utime),MAX(utime) FROM allp GROUP BY pair ORDER BY pair;

-- I should get a CSV file
COPY(SELECT pair,utime,cp FROM allp ORDER BY pair,utime)TO '/tmp/allp.csv' csv header;

-- done

