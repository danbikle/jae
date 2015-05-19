#!/bin/bash

# ~/nia10/ml/predictions.bash

# This script should calculate many predictions

cd ~/nia10/ml/

declare -i idib
idib=10
for pair in aud_usd
do
  idib=idib+1
  echo ~/nia10/ml/predict.bash $pair ${HOME}/vbox/fxcp/u_${pair}.csv 999 $idib
done

exit
