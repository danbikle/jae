#!/bin/bash

# ~/nia10/bin/wget_truefx1m.bash

# I use this script to get zip files from truefx.com

mkdir -p ~/vbox/fxcsv/
cd       ~/vbox/fxcsv/


wget \
--user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36' \
--load-cookies=/tmp/truefx_cookies.txt \
--save-cookies=/tmp/truefx_cookies.txt \
--keep-session-cookies \
truefx.com/?page=logina
sleep 2

wget \
--user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36' \
--load-cookies=/tmp/truefx_cookies.txt \
--save-cookies=/tmp/truefx_cookies.txt \
--keep-session-cookies \
--post-data='page=loginz&USERNAME=ann411&PASSWORD=annwasher3' \
truefx.com
sleep 2

for pair in AUDUSD EURUSD EURGBP GBPUSD NZDUSD USDCAD USDJPY
do
  for yr in 2015
  do
    for month in  04
    do
      namemonth=`date --date="${yr}-${month}-01" '+%B'`
      upmonth=${namemonth^^}
      zipurl="truefx.com/dev/data/${yr}/${upmonth}-${yr}/${pair}-${yr}-${month}.zip"
      wget --user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36' $zipurl
      sleep 2
    done
  done
done

wget \
--user-agent='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36' \
--load-cookies=/tmp/truefx_cookies.txt \
--save-cookies=/tmp/truefx_cookies.txt \
--keep-session-cookies \
truefx.com/?page=logout

exit
