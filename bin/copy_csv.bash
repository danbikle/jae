#!/bin/bash

# ${HOME}/nia10/bin/copy_csv.bash

# This script should aggregate sub-second forex-price observations
# into 1 hour price observations.

cd ${HOME}/nia10/bin/

# I should create some empty tables
./psql.bash -f crtrunc.sql

set -x

for pair in AUDUSD EURUSD EURGBP GBPUSD USDJPY # NZDUSD USDCAD 
do
  for yr in 2009 2010 2011 2012 2013 2014 2015
  do
    for mn in 01 02 03 04 05 06 07 08 09 10 11 12
    do
      unzip -p ~/vbox/fxcsv/${pair}-${yr}-${mn}.zip > /tmp/fx.csv
      ./psql.bash -f copy_csv.sql
    done
  done
done


exit
