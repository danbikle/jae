#!/bin/bash

# ~/nia10/ml/predictions.bash

# This script should calculate many predictions

cd ~/nia10/ml/

declare -i idib
idib=10
for pair in aud_usd eur_gbp eur_usd gbp_usd nzd_usd usd_jpy  # usd_cad
do
  idib=idib+1
  ~/nia10/ml/predict.bash $pair ${HOME}/vbox/fxcp/u_${pair}.csv 999 $idib > /tmp/predict_${pair}_bash.txt  2>&1 &
done

exit
