--
-- ~/nia10/bin/merge_truefx_ib1.sql
--

-- this script should COPY  ~/vbox/fxp.csv into table: truefx

CREATE TABLE IF NOT EXISTS truefx (
  pair   VARCHAR
  ,ttime TIMESTAMP
  ,cp    NUMERIC);

TRUNCATE TABLE truefx;

COPY truefx (pair,ttime,cp) FROM '/tmp/fxp2.csv' WITH csv;

-- rpt
SELECT COUNT(*) FROM truefx;

-- done
