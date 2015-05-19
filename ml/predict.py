#
# ~/nia10/ml/predict.py
# 

# This script should generate predictions from a CSV file full of features

# Demo:
# python predict.py 100 $feat_csv $pred_csv

import pandas as pd
import numpy  as np
import pdb
import datetime

# I should check cmd line arg
import sys

print('hello, from '+ sys.argv[0])

#  len(sys.argv) should == 4
if len(sys.argv) < 4:
  print('I need a proper command line.')
  print('Demo:')
  print('python '+sys.argv[0]+' 100 $feat_csv $pred_csv')
  print('Try again. bye.')
  sys.exit()

pcount1     = int(sys.argv[1])
feat_csv    =     sys.argv[2]
pred_csv    =     sys.argv[3]
train_count = 5000
pcount      = pcount1 + 5300

# I should load the csv into a DataFrame
df1 = pd.read_csv(feat_csv)

# How many observations have I?
obs_count = len(df1)
print('I have this many observations: '+str(obs_count))

if pcount + train_count > obs_count:
  print('I dont have enough observations.')
  print('You want too many predictions.')
  sys.exit()

if pcount < train_count + 200 :
  print('You need to ask for more predictions so I can feed-forward.')
  print('You need at least this many:')
  print(train_count + 300)

# I should get some training data from df1.
# I should put it in NumPy Arrays.

# I should declare some integers to help me navigate the Arrays.
pair_i    = 0
utime_i   = 1
cp_i      = 2
cdate_i   = 3
minp_i    = 4
actual_i  = 5
piplead_i = 6
x1_i      = 7
plot_data_l   = []
train_oos_gap = 10
from sklearn import linear_model
model  = linear_model.LogisticRegression()
wide_a = np.array(df1)
x_a    = wide_a[:,x1_i:    ]
y_a    = wide_a[:,piplead_i]
yc_a   = y_a > 0
train_start = len(x_a)-1
# I should count backwards so I always predict most recent observation.
for oos_i in range(train_start, train_start-pcount, -1):
  xtrain2  = oos_i   - train_oos_gap
  xtrain1  = xtrain2 - train_count
  x_train  = x_a[ xtrain1:xtrain2,:]
  yc_train = yc_a[xtrain1:xtrain2  ]
  x_oos    = x_a[ oos_i,:]
  model.fit(x_train, yc_train )
  cdate       = wide_a[oos_i,cdate_i]
  cp          = wide_a[oos_i,cp_i   ]
  ip    = model.predict_proba(x_oos.astype(float))[0,1]
  ipadj = ip - 0.5
  piplead = wide_a[oos_i,piplead_i]
  actual  = wide_a[oos_i,actual_i]
  presult = np.sign(ipadj) * actual
  plot_data_l.append([cdate,cp,ipadj,actual,presult])

prdf1         = pd.DataFrame(plot_data_l)
prdf1.columns = ['cdate','cp','ipadj','actual','presult']
prdf = prdf1.sort(['cdate'])
# I should save my work
prdf.to_csv(pred_csv, float_format='%4.4f', index=False)
print('I have saved predictions in: '+pred_csv)

# I should work towards a plot.
cdate_l = [elm for elm in np.array(prdf['cdate'])]


# matplotlib likes dates:
import datetime
cdate_l = [datetime.datetime.strptime(elm, "%Y-%m-%d %H:%M:%S") for elm in np.array(prdf['cdate'])]

cp_l    = [elm for elm in np.array(prdf['cp'])   ]

# green_l should start at same price as cp_l
greenp  = cp_l[0]
green_l = [greenp]
for gdelta in  np.array(prdf['presult']):
  greenp += gdelta
  green_l.append(greenp)
# I should ignore the last gdelta. I dont know it yet.
green_l = green_l[:-1]

import matplotlib
# http://matplotlib.org/faq/howto_faq.html#generate-images-without-having-a-window-appear
matplotlib.use('Agg')
# Order is important here.
# Do not move the next import:
import matplotlib.pyplot as plt

# Get current size
fig_size = plt.rcParams["figure.figsize"]

# Prints: [8.0, 6.0]
print("Current size:", fig_size)

# Set figure width to 12 and height to 9
fig_size[0] = 12
fig_size[1] = 9
plt.rcParams["figure.figsize"] = fig_size

plt.plot(cdate_l, cp_l, 'b-', cdate_l, green_l, 'g-')
plotf = pred_csv+'.png'
plt.savefig(plotf)
plt.close()

print('I made a plot for you: '+plotf)

'bye'
