#!/bin/bash

declare -i ii

ii=10

echo $ii

ii=ii+1

echo $ii

for pair in aud_usd eur_usd
do
  ii=ii+1
  echo $ii
done
