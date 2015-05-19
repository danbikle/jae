#
# ~/nia10/ml/gen_feat.py
#

# This script should generate features from forex prices.

# I should assume the prices are in a CSV file like this:
# ${HOME}/vbox/fxcp/u_aud_usd.csv
# I should assume the prices are ordered by ascending date.

# Demo:
# python gen_feat.py ${HOME}/vbox/fxcp/u_aud_usd.csv ${HOME}/tmp/aud_usd_feat.csv

import pandas as pd
import numpy  as np
import pdb
import datetime

# I should check cmd line arg
import sys

print('hello, from '+ sys.argv[0])

#  len(sys.argv) should == 3
if len(sys.argv) < 3:
  print('I need a proper command line.')
  print('Demo:')
  print('python '+sys.argv[0]+' ${HOME}/vbox/fxcp/u_aud_usd.csv ${HOME}/tmp/aud_usd_feat.csv')
  print('Try again. bye.')
  sys.exit()

price_csv = sys.argv[1]
feat_csv  = sys.argv[2]

# I should load the csv into a DataFrame
df1 = pd.read_csv(price_csv)

df1.columns = ['pair','utime','cp']

# I should generate a time-based column from utime which is just a simple integer
utime_l = [elm for elm in np.array(df1['utime'])]

# I should convert utime to datetime
d1970   = datetime.datetime.strptime( '1970-01-01', '%Y-%m-%d' )
cdate_l = [d1970 + datetime.timedelta(seconds=int(utime)) for utime in utime_l]

# I should convert datetime to str

cdates_l = [datetime.datetime.strftime(elm, '%Y-%m-%d %H:%M:%S') for elm in cdate_l]

minp_l = [datetime.datetime.strftime(elm, '%M') for elm in cdate_l]

df1['cdate'] = cdates_l
df1['minp']  = minp_l

# I should get the last minute value
lastminv = minp_l[-1]
predicate = (df1['minp'] == lastminv)

df2 = df1[['pair','utime','cp','cdate','minp']][predicate]

# I should get cp_l from df2
cp_a = np.array(df2['cp'])
cp_l = [elm for elm in cp_a]

# cp_l[0]  is the oldest      price.
# cp_l[-1] is the most recent price.
# From the right, I should push the column left by 1 price:
cplead_l = cp_l + cp_l[-1:]
# From the left, I should push the column right by 1 price:
cplag1_l = cp_l[:1] + cp_l
# I should get more lag columns
cplag2_l  = cp_l[:2]  + cp_l
cplag4_l  = cp_l[:4]  + cp_l
cplag8_l  = cp_l[:8]  + cp_l
cplag16_l = cp_l[:16] + cp_l
cplag32_l = cp_l[:32] + cp_l
# I should snip off ends so new columns as long as cp_l:
cplead_l = cplead_l[1:]

cplag1_l  = cplag1_l[:-1]
cplag2_l  = cplag2_l[:-2]
cplag4_l  = cplag4_l[:-4]
cplag8_l  = cplag8_l[:-8]
cplag16_l = cplag16_l[:-16]
cplag32_l = cplag32_l[:-32]


# NumPy allows me to do arithmetic on its Arrays.
# I should convert my lists to Arrays:
cp_a      = np.array(cp_l)
cplead_a  = np.array(cplead_l)
cplag1_a  = np.array(cplag1_l)
cplag2_a  = np.array(cplag2_l)
cplag4_a  = np.array(cplag4_l)
cplag8_a  = np.array(cplag8_l)
cplag16_a = np.array(cplag16_l)
cplag32_a = np.array(cplag32_l)
# I should calculate pip-deltas:
piplead_a  = 100.0 * 100.0 * (cplead_a - cp_a) /cp_a
piplag1_a  = 100.0 * 100.0 * (cp_a - cplag1_a) /cplag1_a
piplag2_a  = 100.0 * 100.0 * (cp_a - cplag2_a) /cplag2_a
piplag4_a  = 100.0 * 100.0 * (cp_a - cplag4_a) /cplag4_a
piplag8_a  = 100.0 * 100.0 * (cp_a - cplag8_a) /cplag8_a
piplag16_a = 100.0 * 100.0 * (cp_a - cplag16_a)/cplag16_a
piplag32_a = 100.0 * 100.0 * (cp_a - cplag32_a)/cplag32_a

# I am done doing calculations.
# I should put my new columns into my DataFrame.

df2['actual']   = cplead_a - cp_a # needed for plotting
df2['piplead']  = piplead_a 
df2['piplag1']  = piplag1_a 
df2['piplag2']  = piplag2_a 
df2['piplag4']  = piplag4_a 
df2['piplag8']  = piplag8_a 
df2['piplag16'] = piplag16_a
df2['piplag32'] = piplag32_a

# I should save my work:
df2.to_csv(feat_csv, float_format='%4.4f', index=False)
print('features generated and saved: '+feat_csv)

'bye'
