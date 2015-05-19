#!/bin/bash

# ~/nia10/bin/nnow.bash

echo nnow_sync.bash might be better.
echo nnow.bash can be a bit harsh to the laptop.

exit

# This script should get prices, predict future delta, act on predictions.
echo $0 is now working on work.
set -x
date
cd ~/nia10/bin/
   ~/nia10/bin/now_getcp.bash

echo I should calculate predictions now.
echo 'The predictions should appear here: ~/tmp/pair*pred*.csv'
~/nia10/ml/predictions.bash

echo $0 is done
date
exit

