#!/usr/bin/bash

# Adds together the numbers in the "Rewards" (5th) column of a CSV generated from subscan.io
awk -F',' '$NF == "Staking (Rewarded)" { sum += $(NF-1) } END { print sum}' $1
