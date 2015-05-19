# getcsv05m.r

options("scipen"=11)

# I use this script to copy price data out of IB-API into a CSV file.
# Demo:

# R -f getcsv05m.r AUD USD "${mytsu}" ${csvd}/aud_usd_${myts}_05m.csv $port 
# R -f getcsv05m.r AUD USD "${mytsu}" ${HOME}/vbox/fxcp/aud_usd_${myts}_05m.csv 7426

args = commandArgs()
print(args)
print(args[4])
print(args[5])
print(args[6])
print(args[7])
print(args[8])
print(args[9])
mysymbol   = args[4]
mycurrency = args[5]
myday  = args[6]
myhr   = args[7]
myfile = args[8]
myport = as.integer(args[9])
my_endDateTime = sprintf("%s %s GMT", myday, myhr)
print(my_endDateTime)

# Now I make use of the IBrokers package.
# Syntax to install it:
# install.packages("IBrokers", lib="rpkgs", repos="http://cran.us.r-project.org")
# Once I install it, I see it in a folder named rpackages/

# Next, tell this script where IBrokers resides:
.libPaths("rpkgs")

# Now I can use IBrokers R Package:

library(IBrokers)
tws <- twsConnect(clientId=9, port=myport)
reqCurrentTime(tws)

mycurr = twsContract(symbol=mysymbol,
currency=mycurrency,
exch='IDEALPRO',
sectype='CASH',
primary='',
expiry='',
strike='0.0',
right='',
local='',
multiplier='',
combo_legs_desc='',
comboleg='',
include_expired='0',
conId=0)

reqHistoricalData(tws,mycurr,
endDateTime = sprintf("%s %s GMT", myday, myhr),
barSize = '5 mins',
duration = '4 D',
useRTH = '0',
whatToShow = 'MIDPOINT',
timeFormat = '1',
file = myfile
)

twsDisconnect(tws)
