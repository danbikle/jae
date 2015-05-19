~/jae/readme.txt

This repo shows some of the scripts I use to automate trading of forex 
and forex futures.

Everything flows from this script:

bin/nnow_sync.bash


I make two connections to IB.

I use the first connection to get prices:

bin/now_getcp.bash
bin/getcsv05m.r
bin/getcsv01m.r

That first connectionn depends on IBrokers API which is R based.

From the prices I calculate predictions.

After the predictions are ready,

I use ibapi to connect to IB in this script:

bin/actonit_nia.bash

The actual JS code is in this script:

js/fx_fut_order_node.js

The main feature I need from ibapi is a field in the order object:

myorder.account       = "DU93930";

IBrokers API does not provide access to this field.

