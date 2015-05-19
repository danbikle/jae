#!/bin/bash

# ~/nia10/ml/predict.bash

# This script should calculate predictions for a pair.

# Demo:
# ~/nia10/ml/predict.bash pair price.csv prediction_count
# ~/nia10/ml/predict.bash aud_usd ${HOME}/vbox/fxcp/u_aud_usd.csv 5500

cd ~/nia10/ml/

if [ $# -lt 4 ]
then
  echo You need to supply 4 params: pair, price.csv, prediction_count ibid
  echo Demo:
  echo "$0 aud_usd ${HOME}/vbox/fxcp/u_aud_usd.csv 5500 11"
  exit 1
fi

mkdir -p ~/tmp/
pair=$1
price_csv=$2
pcount=$3
ibid=$4
port=7426
feat_csv=${HOME}/tmp/${pair}_feat.csv
# I should start by generating features
python gen_feat.py $price_csv $feat_csv

# I should next calculate predictions
pred_csv=${HOME}/tmp/${pair}_pred.csv
python predict.py $pcount $feat_csv $pred_csv 

# I should feed-forward and predict again
pred2_csv=${HOME}/tmp/${pair}_pred2.csv
python predictff.py $pcount $feat_csv $pred_csv $pred2_csv 

# actonit_nia.bash should act on the last entry of $pred2_csv 

~/nia10/bin/actonit_nia.bash $pair $ibid $port

exit
