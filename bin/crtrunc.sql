--
-- ${HOME}/nia10/bin/crtrunc.sql
--

-- This script should CREATE   stage1,2,3 if it not exists.
-- This script should TRUNCATE stage1,2,3.

CREATE TABLE IF NOT EXISTS stage1(
  pair   VARCHAR
  ,ttime TIMESTAMP
  ,bid   NUMERIC
  ,ask   NUMERIC);

CREATE TABLE IF NOT EXISTS stage2(
  pair   VARCHAR
  ,ttime TIMESTAMP
  ,bid   NUMERIC
  ,ask   NUMERIC);

CREATE TABLE IF NOT EXISTS fxp(
  pair   VARCHAR
  ,ttime TIMESTAMP
  ,bid   NUMERIC
  ,ask   NUMERIC);

-- fxp will be full when I am done.
-- At this point fxp should be empty:
TRUNCATE TABLE fxp;
