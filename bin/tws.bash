#!/bin/bash

# ~/nia10/bin/tws.bash

cd ${NIA}/IBJts/

java -cp jts.jar:total.2013.jar -Xmx512M -XX:MaxPermSize=256M jclient.LoginFrame . &

exit
