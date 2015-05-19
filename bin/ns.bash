#!/bin/bash

# ~/nia10/bin/nnow_sync.bash

# This script should get prices, predict future delta, act on predictions.
echo $0 is now working on work.
  
echo I should calculate predictions now.
echo 'The predictions should appear here: ~/tmp/pair*pred*.csv'

declare -i idib
idib=10
for pair in aud_usd eur_gbp eur_usd gbp_usd nzd_usd usd_jpy  # usd_cad
do
  if [ -f /tmp/run_nia10bin_start_nnow.txt ]
  then
    cd ~/nia10/bin/
#    ~/nia10/bin/now_getcp.bash > /tmp/now_getcp_bash.txt 2>&1
    idib=idib+1
    cd ~/nia10/ml/
    ~/nia10/ml/p2.bash $pair ${HOME}/vbox/fxcp/u_${pair}.csv 999 $idib > /tmp/predict_${pair}_bash.txt 2>&1
  fi
done

exit


