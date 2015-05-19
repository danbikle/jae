--
-- ~/nia10/bin/merge_truefx_ib3.sql
--

-- This script should COPY rows from /tmp/ibfxcp.csv
-- into table: ibfxcp

COPY ibfxcp(
  pair
  ,utime
  ,cp
  ) FROM '/tmp/ibfxcp.csv' WITH csv;

SELECT COUNT(*) FROM ibfxcp;

-- done
