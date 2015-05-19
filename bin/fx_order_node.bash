#!/bin/bash

# ~/nia10/bin/fx_order_node.bash

# This script should order an fx future.

# Demo:
# ~/nia10/bin/fx_order_node.bash BUY  100000 EUR GBP 7426 22
# ~/nia10/bin/fx_order_node.bash SELL 100000 EUR GBP 7426 22

if [ $# -lt 6 ]
then
  echo You need to give 6 parameters
  echo Demo: 
  echo $0 SELL 100000 EUR GBP 7426 11
  exit 1
fi

set -x

cd ~/nia10/js/
myts=`date -u +'%Y%m%d_%H_%M_%S'`

buysell=$1
size=$2
symbol=$3
currency=$4
port=$5
ibid=$6

( node fx_order_node.js $buysell $size $symbol $currency $port $ibid) &
sleep 5
# I should kill node
kill $!

exit
