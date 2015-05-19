#!/bin/bash

# ~/nia10/bin/merge_truefx_ib.bash

# This script should merge truefx with ib into: allp.csv

# The truefx data is in this CSV file:
# ~/vbox/fxp.csv
# The above file was created from these scripts:
# ~/nia10/bin/wget_truefx.bash
# ~/nia10/bin/copy_csv.bash
# ~/nia10/bin/copy_fxp.bash

# The ib data is in this folder:
# ${HOME}/vbox/fxcp/
# The ib data is created by these scripts:
# ~/nia10/bin/getcsv05m.bash
# ~/nia10/bin/getcsv01m.bash
# ~/nia10/bin/now_getcp.bash

# Although I probably have my truefx data loaded into this table: fxp,
# I should assume that it might be missing.
# So, I should assume my truefx data is in this CSV: ~/vbox/fxp.csv

# Now,
# I should COPY ~/vbox/fxp.csv into table: truefx

set -x

grep 1 ~/vbox/fxp.csv > /tmp/fxp2.csv
./psql.bash -f merge_truefx_ib1.sql

# I should load the ib data now

./psql.bash -f merge_truefx_ib2.sql

rm -f /tmp/ibfxcp.csv

grep 1 ~/vbox/fxcp/u_aud_usd.csv >> /tmp/ibfxcp.csv
grep 1 ~/vbox/fxcp/u_eur_gbp.csv >> /tmp/ibfxcp.csv
grep 1 ~/vbox/fxcp/u_eur_usd.csv >> /tmp/ibfxcp.csv
grep 1 ~/vbox/fxcp/u_gbp_usd.csv >> /tmp/ibfxcp.csv
grep 1 ~/vbox/fxcp/u_nzd_usd.csv >> /tmp/ibfxcp.csv
grep 1 ~/vbox/fxcp/u_usd_cad.csv >> /tmp/ibfxcp.csv
grep 1 ~/vbox/fxcp/u_usd_jpy.csv >> /tmp/ibfxcp.csv

./psql.bash -f merge_truefx_ib3.sql

# I should merge the data into table allp now
./psql.bash -f merge_truefx_ib4.sql

# I should get a copy of the csv file:
cp /tmp/allp.csv ~/vbox/fxcp/

exit
exit
exit

# Useful syntax:
cd ~/vbox/fxcp/
head         allp.csv   u5/aud_usd_05m.csv
grep aud_usd allp.csv > u5/aud_usd_05m.csv
grep eur_gbp allp.csv > u5/eur_gbp_05m.csv
grep eur_usd allp.csv > u5/eur_usd_05m.csv
grep gbp_usd allp.csv > u5/gbp_usd_05m.csv
grep nzd_usd allp.csv > u5/nzd_usd_05m.csv
grep usd_cad allp.csv > u5/usd_cad_05m.csv
grep usd_jpy allp.csv > u5/usd_jpy_05m.csv
