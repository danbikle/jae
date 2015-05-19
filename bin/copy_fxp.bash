#!/bin/bash

# ${HOME}/nia10/bin/copy_fxp.bash

# This script should copy fxp table to ~/vbox/fxp.csv
# fxp.csv should be sorted by pair then date
# The pair-symbols should be of the form: aud_usd, eur_usd, ...

cd ${HOME}/nia10/bin/
./psql.bash -f copy_fxp.sql
cp /tmp/fxp.csv ~/vbox/

exit

