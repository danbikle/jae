#!/bin/bash

# ~/nia10/bin/actonit_nia.bash

# This script should act on the last entry of a prediction csv file.
# It acts by a buy/sell of a fx-future 

# Demo:
# ./actonit_nia.bash eur_usd 11 7426

cd ~/nia10/bin/

if [ $# -lt 3 ]
then
  echo You need to supply 3 params: pair idib port
  echo Demo:
  echo $0 ' $pair $ibid $port'
  exit 1
fi

# I should pattern off this script:
# ~/fx10/actonit.bash
set -x

pair=$1
ibid=$2
port=$3
size=1

# I should get the file which has the prediction
pred2_csv=${HOME}/tmp/${pair}_pred2.csv
# The above file was created by: ~/nia10/ml/predict.bash

# I should get most recent line in the file
        /usr/bin/tail -1 $pred2_csv
        /usr/bin/tail -1 $pred2_csv|/usr/bin/awk  -F, '{print $3}'
mypred=`/usr/bin/tail -1 $pred2_csv|/usr/bin/awk  -F, '{print $3}'`

# I should see a prediction above/below zero
         /bin/echo $mypred
# I should look for a minus-sign
SELLBUY=`/bin/echo $mypred|/bin/grep -c '-'`
echo $SELLBUY
# If $SELLBUY == 1, I should sell else buy

# I rely on forex mkt to trade eur_gbp:

if [ $pair == eur_gbp ]
then 
  ~/nia10/bin/actonit_nia_fx.bash $1 $2 $3 $SELLBUY
  exit 0
fi

# I should create a state tracker if I have none
if [ -f ~/nia10state_${pair}.csv ]
then
  /bin/ls -l  ~/nia10state_${pair}.csv
else
  echo state > ~/nia10state_${pair}.csv
  echo NEUTRAL >>  ~/nia10state_${pair}.csv
fi

tail -1 ~/nia10state_${pair}.csv

state=`tail -1 ~/nia10state_${pair}.csv`
echo 'state:'
echo $state

# For other pairs I rely on futures market:

if [ $pair == aud_usd ]; then
  halfpair=AUD; buy=BUY; sell=SELL; fi
if [ $pair == eur_usd ]; then
  halfpair=EUR; buy=BUY; sell=SELL; fi
if [ $pair == gbp_usd ]; then
  halfpair=GBP; buy=BUY; sell=SELL; fi
if [ $pair == nzd_usd ]; then
  halfpair=NZD; buy=BUY; sell=SELL; fi

# usd_jpy is different
if [ $pair == usd_jpy ]; then
  halfpair=JPY; buy=SELL; sell=BUY; fi

if [ $state == 'NEUTRAL' ]
then
  echo I can buy or sell
  if [ $SELLBUY == 1 ]
  then
    echo I should $sell
    echo SHORT >>  ~/nia10state_${pair}.csv
    ~/nia10/bin/fx_fut_order_node.bash $sell $size $halfpair $port $ibid
  else
    echo I should $buy
    echo LONG >>  ~/nia10state_${pair}.csv
    ~/nia10/bin/fx_fut_order_node.bash $buy $size $halfpair $port $ibid
  fi
fi

if [ $state == 'SHORT' ]
then
  echo I can $buy
  if [ $SELLBUY == 0 ]
  then
    echo I should $buy
    echo NEUTRAL >>  ~/nia10state_${pair}.csv
    ~/nia10/bin/fx_fut_order_node.bash $buy $size $halfpair $port $ibid
  fi
fi

if [ $state == 'LONG' ]
then
  echo I can $sell
  if [ $SELLBUY == 1 ]
  then
    echo I should $sell
    echo NEUTRAL >>  ~/nia10state_${pair}.csv
    ~/nia10/bin/fx_fut_order_node.bash $sell $size $halfpair $port $ibid
  fi
fi

exit
