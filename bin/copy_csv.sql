--
-- copy_csv.sql
--

-- Demo:
-- ${HOME}/nia10/bin/psql.bash -f copy_csv.sql

-- This script should copy CSV data into table: fxp

-- These tables contain temp data:
TRUNCATE TABLE stage1;
COPY stage1(
  pair
  ,ttime
  ,bid
  ,ask
  ) FROM '/tmp/fx.csv' WITH csv;

-- I should group by 5min intervals:

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 0
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 5
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '5 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 10
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '10 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 15
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '15 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 20
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '20 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 25
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '25 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 30
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '30 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 35
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '35 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 40
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '40 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 45
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '45 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 50
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '50 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;

TRUNCATE TABLE stage2;
INSERT INTO stage2(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,date_trunc('hour',ttime) ttime
  ,bid
  ,ask
  FROM stage1 
  -- A spread > 10 pips is bad data:
  WHERE (ask-bid)/ask < 0.0010
  AND ROUND(date_part('minute',ttime)) = 55
  AND ROUND(date_part('second',ttime)) < 15
  ORDER BY pair,ttime;
INSERT INTO fxp(
  pair
  ,ttime
  ,bid
  ,ask
  )
  SELECT 
  pair
  ,ttime + INTERVAL '55 min'
  ,ROUND(AVG(bid)::NUMERIC,4) bid
  ,ROUND(AVG(ask)::NUMERIC,4) ask
  FROM stage2 GROUP BY pair,ttime ORDER BY pair,ttime;
