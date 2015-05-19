#!/bin/bash

# ~/nia10/bin/getcsv01m.bash

# This script should get ib prices spaced at 1min intervals.

# Demo:
# ./getcsv01m.bash 7426 ${HOME}/vbox/fxcp/

# I should check command line args
if [ $# -lt 2 ]
then
  echo You called $0 incorrectly.
  echo Demo:
  echo $0 7426 ${HOME}/vbox/fxcp
  exit 1
fi

if [ -z $NIA ]
then
  echo 'I should have $NIA env var set in .bashrc'
  exit 1
fi

echo NIA:
echo $NIA

set -x

port=$1
csvd=$2

mkdir -p $csvd ${csvd}/u1/ ${csvd}/done/
cd ${NIA}

mytsu=`date -u +'%Y%m%d %H:%M:%S'`
myts=`date -u +'%Y%m%d_%H_%M_%S'`
echo $mytsu
echo $myts

R -f bin/getcsv01m.r AUD USD "${mytsu}" ${csvd}/aud_usd_${myts}_01m.csv $port
R -f bin/getcsv01m.r EUR USD "${mytsu}" ${csvd}/eur_usd_${myts}_01m.csv $port
R -f bin/getcsv01m.r EUR GBP "${mytsu}" ${csvd}/eur_gbp_${myts}_01m.csv $port
R -f bin/getcsv01m.r GBP USD "${mytsu}" ${csvd}/gbp_usd_${myts}_01m.csv $port
R -f bin/getcsv01m.r NZD USD "${mytsu}" ${csvd}/nzd_usd_${myts}_01m.csv $port
R -f bin/getcsv01m.r USD CAD "${mytsu}" ${csvd}/usd_cad_${myts}_01m.csv $port
R -f bin/getcsv01m.r USD JPY "${mytsu}" ${csvd}/usd_jpy_${myts}_01m.csv $port

cd $csvd

cat aud_usd_${myts}_01m.csv | awk -F, '{print "aud_usd,"$1","$5}' >> u1/aud_usd_01m.csv
cat eur_usd_${myts}_01m.csv | awk -F, '{print "eur_usd,"$1","$5}' >> u1/eur_usd_01m.csv
cat eur_gbp_${myts}_01m.csv | awk -F, '{print "eur_gbp,"$1","$5}' >> u1/eur_gbp_01m.csv
cat gbp_usd_${myts}_01m.csv | awk -F, '{print "gbp_usd,"$1","$5}' >> u1/gbp_usd_01m.csv
cat nzd_usd_${myts}_01m.csv | awk -F, '{print "nzd_usd,"$1","$5}' >> u1/nzd_usd_01m.csv
cat usd_cad_${myts}_01m.csv | awk -F, '{print "usd_cad,"$1","$5}' >> u1/usd_cad_01m.csv
cat usd_jpy_${myts}_01m.csv | awk -F, '{print "usd_jpy,"$1","$5}' >> u1/usd_jpy_01m.csv

mkdir -p done
mv *u*${myts}_01m.csv done/

# Use sort to remove most duplicate rows:

mkdir -p /tmp/u1/
for pair in aud_usd eur_usd eur_gbp gbp_usd nzd_usd usd_cad usd_jpy
do
  sort -u u1/${pair}_01m.csv > /tmp/u1/${pair}_01m.csv
  # Most of the dups should be gone.
  # I should use sql later to de-dup everything.
  cp /tmp/u1/${pair}_01m.csv u1/${pair}_01m.csv
done

exit
