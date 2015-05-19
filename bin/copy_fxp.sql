--
-- copy_fxp.sql
--

-- This script should copy fxp table to /tmp/fxp.csv
-- fxp.csv should be sorted by pair then date
-- The pair-symbols should be of the form: aud_usd, eur_usd, ...

SELECT COUNT(*) FROM fxp;
SELECT pair, COUNT(*) FROM fxp GROUP BY pair;

UPDATE fxp SET pair = 'aud_usd' WHERE pair = 'AUD/USD';
UPDATE fxp SET pair = 'eur_usd' WHERE pair = 'EUR/USD';
UPDATE fxp SET pair = 'gbp_usd' WHERE pair = 'GBP/USD';
UPDATE fxp SET pair = 'nzd_usd' WHERE pair = 'NZD/USD';
UPDATE fxp SET pair = 'usd_cad' WHERE pair = 'USD/CAD';
UPDATE fxp SET pair = 'usd_jpy' WHERE pair = 'USD/JPY';
UPDATE fxp SET pair = 'eur_gbp' WHERE pair = 'EUR/GBP';

COPY(SELECT pair,ttime,bid cp FROM fxp ORDER BY pair,ttime)TO '/tmp/fxp.csv' csv header;

-- done

