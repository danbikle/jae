#!/bin/bash

# ~/nia10/bin/fx_fut_order_node.bash

# This script should order an fx future.

# Demo:
# ~/nia10/bin/fx_fut_order_node.bash BUY  1 AUD 7426 11
# ~/nia10/bin/fx_fut_order_node.bash SELL 1 AUD 7426 11

# hardcode:
expiry=201506

if [ $# -lt 5 ]
then
  echo You need to give 5 parameters
  echo Demo: 
  echo $0 BUY 1 AUD 7426 11 201512
  exit 1
fi

cd ~/nia10/js/
myts=`date -u +'%Y%m%d_%H_%M_%S'`

buysell=$1
size=$2
symbol=$3
port=$4
ibid=$5


set -x

( node fx_fut_order_node.js $buysell $size $symbol $port $ibid $expiry) &
sleep 5
# I should kill node
kill $!

exit
