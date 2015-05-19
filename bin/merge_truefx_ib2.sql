--
-- ~/nia10/bin/merge_truefx_ib2.sql
--

-- This script should load CSV data which I have in these files:
--  /home/dan/vbox/fxcp:
--  -rw-r--r-- 1 dan dan 4253113 May  6 21:24 u_aud_usd.csv
--  -rw-r--r-- 1 dan dan   84059 May  6 21:24 u_eur_gbp.csv
--  -rw-r--r-- 1 dan dan 4281206 May  6 21:24 u_eur_usd.csv
--  -rw-r--r-- 1 dan dan 4221882 May  6 21:24 u_gbp_usd.csv
--  -rw-r--r-- 1 dan dan  308641 May  6 21:24 u_nzd_usd.csv
--  -rw-r--r-- 1 dan dan  305638 May  6 21:24 u_usd_cad.csv
--  -rw-r--r-- 1 dan dan 4572132 May  6 21:24 u_usd_jpy.csv

CREATE TABLE IF NOT EXISTS ibfxcp(
  pair   VARCHAR
  ,utime NUMERIC
  ,cp    NUMERIC);

TRUNCATE TABLE ibfxcp;
