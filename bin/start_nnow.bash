#!/bin/bash

# ~/nia10/bin/start_nnow.bash

echo start_nnow_sync.bash might be better.
echo nnow.bash can be a bit harsh to the laptop.

exit
# This script should get prices, predict future delta, act on predictions.
cd ~/nia10/bin/
date > /tmp/run_nia10bin_start_nnow.txt
while [ -f /tmp/run_nia10bin_start_nnow.txt ]
do
  date
  myts=`date -u +'%Y%m%d_%H_%M_%S'`
  echo "~/nia10/bin/nnow.bash > /tmp/nnow.bash.${myts}.txt 2>&1 &"
  ~/nia10/bin/nnow.bash > /tmp/nnow.bash.${myts}.txt 2>&1 &
  date
  echo sleep 1200
  sleep 1200
done

exit
exit
exit
