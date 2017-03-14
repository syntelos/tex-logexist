#!/bin/bash

for term in $* 
do
  for page in $(egrep "${term}" *.tex | sed 's/:.*//' | sort -u )
  do
    less ${page}
  done
done
