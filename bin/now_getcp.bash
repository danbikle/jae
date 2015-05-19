#!/bin/bash

# ~/nia10/bin/now_getcp.bash
# Derived from:
# ~/ks/tws/fx/nnow.bash

# This script should get current prices and place them in this folder:
# ~/vbox/fxcp/

cd ${NIA}/bin

mkdir -p              ${HOME}/vbox/fxcp
./getcsv05m.bash 7426 ${HOME}/vbox/fxcp
./getcsv01m.bash 7426 ${HOME}/vbox/fxcp

set -x 

# I should merge 01m-prices with 05m-prices
mkdir -p   /tmp/fxcp/
chmod 1777 /tmp/fxcp/

for pair in aud_usd eur_usd eur_gbp gbp_usd nzd_usd usd_cad usd_jpy
do
  cp ~/vbox/fxcp/u1/${pair}_01m.csv /tmp/fxcp/p01m.csv
  cp ~/vbox/fxcp/u5/${pair}_05m.csv /tmp/fxcp/p05m.csv
  ./psql.bash -f now_getcp.sql
  # I should find csv files from postgres here:
  #  /tmp/fxcp/uniq.csv
  cp /tmp/fxcp/uniq.csv ~/vbox/fxcp/u_${pair}.csv
done

exit
