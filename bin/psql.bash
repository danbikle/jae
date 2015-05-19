#!/bin/bash

# ${HOME}/nia10/bin/psql.bash

# This script should connect to my database as me

psql -a -P pager=no $@

exit
